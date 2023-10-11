import sys

LUA_NEW_COLOR = '\t\tColor.new(\'{0}\', \'{1}\')'
LUA_NEW_GROUP = '\t\tGroup.new(\'{0}\', colors.{1}, colors.{2}, styles.{3})'

args = sys.argv[1:]

if len(args) == 2:
    filepath = args[0]
    output_path = args[1]

    lines = open(filepath, 'r').read().split('\n')
    lines = [' '.join(x.split()) for x in lines]

    outlines = []
    outfile = '''
    local Color, colors, Group, groups, styles = require("colorbuddy").setup()

    return {{
        use = function()
            {0}
        end,
    }}
    '''

    for line in lines:
        elems = line.split(' ')
        if elems[0] == 'hi':
            groupname = elems[1]
            guifg = elems[6].split('=')[1]
            guibg = elems[7].split('=')[1]
            style = elems[4].split('=')[1]

            groupfg = 'NONE'
            groupbg = 'NONE'
            groupstyle = 'NONE'

            outlines.append('')
            if guifg != 'NONE':
                outlines.append(LUA_NEW_COLOR.format(groupname + 'FG', guifg))
                guifg = groupname + 'FG'
            if guibg != 'NONE':
                outlines.append(LUA_NEW_COLOR.format(groupname + 'BG', guibg))
                guibg = groupname + 'BG'

            outlines.append(LUA_NEW_GROUP.format(groupname, guifg, guibg, groupstyle))

    trueblock = '\n'.join(outlines)
    outdata = outfile.format(trueblock)
    open(output_path, 'w', encoding='utf-8').write(outdata)

else:
    print('usage: colorbuddy-converter.py <vim-colorschemefile> <output-file>')
