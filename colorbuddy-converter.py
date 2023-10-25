import sys

LUA_NEW_COLOR = '\t\tColor.new(\'{0}\', \'{1}\')'
LUA_NEW_GROUP = '\t\tGroup.new(\'{0}\', colors.{1}, colors.{2}, styles.{3})'
OUTPUT_FILE_TEMPLATE = '''
    local Color, colors, Group, groups, styles = require("colorbuddy").setup()

    return {{
        use = function()
            {0}
        end,
    }}
    '''


def read_input(filepath: str):
    input_lines = []
    with open(filepath, 'r', encoding='utf-8') as fi:
        input_lines = fi.read().split('\n')
    input_lines = [' '.join(x.split()) for x in input_lines]
    return input_lines


def main():
    args = sys.argv[1:]

    if len(args) == 2:
        filepath = args[0]
        output_path = args[1]

        input_lines = read_input(filepath)

        output_lines = []
        for line in input_lines:
            elems = line.split(' ')
            if elems[0] == 'hi':
                group_name = elems[1]
                gui_fg = elems[6].split('=')[1]
                gui_bg = elems[7].split('=')[1]
                style = elems[4].split('=')[1]

                GROUP_STYLE = 'NONE'

                output_lines.append('')
                if gui_fg != 'NONE':
                    output_lines.append(LUA_NEW_COLOR.format(
                        group_name + 'FG', gui_fg))
                    gui_fg = group_name + 'FG'
                if gui_bg != 'NONE':
                    output_lines.append(LUA_NEW_COLOR.format(
                        group_name + 'BG', gui_bg))
                    gui_bg = group_name + 'BG'

                output_lines.append(LUA_NEW_GROUP.format(
                    group_name, gui_fg, gui_bg, GROUP_STYLE))

        THEME_LINES = '\n'.join(output_lines)
        OUTPUT_DATA = OUTPUT_FILE_TEMPLATE.format(THEME_LINES)
        with open(output_path, 'w', encoding='utf-8') as fo:
            fo.write(OUTPUT_DATA)

    else:
        print('usage: colorbuddy-converter.py <vim-colorschemefile> <output-file>')


if __name__ == '__main__':
    main()
