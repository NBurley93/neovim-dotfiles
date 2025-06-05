import sys
import argparse
from typing import List, Optional
from pathlib import Path

LUA_NEW_COLOR = "\t\tColor.new('{name}', '{value}')"
LUA_NEW_GROUP = "\t\tGroup.new('{name}', colors.{fg}, colors.{bg}, styles.{style})"
OUTPUT_FILE_TEMPLATE = """local Color, colors, Group, groups, styles = require("colorbuddy").setup()

return {
    use = function()
{content}
    end,
}"""


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Convert colorscheme to colorbuddy format"
    )
    parser.add_argument(
        "input_colorscheme", type=Path, help="Input colorscheme file path"
    )
    parser.add_argument("output_file", type=Path, help="Output lua file path")
    return parser.parse_args()


def read_input(filepath: Path) -> List[str]:
    """Read and normalize input file lines."""
    return [
        " ".join(line.split())
        for line in filepath.read_text(encoding="utf-8").splitlines()
    ]


def parse_highlight_line(line: str) -> Optional[tuple]:
    """Parse a highlight line and return components."""
    parts = line.split()
    if not parts or parts[0] != "hi":
        return None

    try:
        group_name = parts[1]
        gui_fg = parts[6].split("=")[1]
        gui_bg = parts[7].split("=")[1]
        return (group_name, gui_fg, gui_bg)
    except (IndexError, ValueError):
        return None


def process_highlight(group_name: str, gui_fg: str, gui_bg: str) -> List[str]:
    """Process highlight group and generate Lua code."""
    output = []

    if gui_fg != "NONE":
        fg_name = f"{group_name}FG"
        output.append(LUA_NEW_COLOR.format(name=fg_name, value=gui_fg))
    else:
        fg_name = "NONE"

    if gui_bg != "NONE":
        bg_name = f"{group_name}BG"
        output.append(LUA_NEW_COLOR.format(name=bg_name, value=gui_bg))
    else:
        bg_name = "NONE"

    output.append(
        LUA_NEW_GROUP.format(name=group_name, fg=fg_name, bg=bg_name, style="NONE")
    )

    return output


def main() -> None:
    args = parse_args()

    try:
        input_lines = read_input(args.input_colorscheme)
    except (FileNotFoundError, PermissionError) as e:
        print(f"Error reading input file: {e}", file=sys.stderr)
        sys.exit(1)

    output_lines = []
    for line in input_lines:
        parsed = parse_highlight_line(line)
        if parsed:
            group_name, gui_fg, gui_bg = parsed
            output_lines.extend([""] + process_highlight(group_name, gui_fg, gui_bg))

    output_content = "\n".join(output_lines)
    output_data = OUTPUT_FILE_TEMPLATE.format(content=output_content)

    try:
        args.output_file.write_text(output_data, encoding="utf-8")
    except (FileNotFoundError, PermissionError) as e:
        print(f"Error writing output file: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
