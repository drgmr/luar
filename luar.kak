declare-option -hidden str luar_path %sh{ dirname $kak_source }

define-command lua -params 1.. -docstring %{
    lua [<switches>] [args...] code: Execute provided Lua code as an anonymous function whose arguments are the args list.
    Switches:
        -debug       print Kakoune commands to the *debug* buffer instead of executing them.
        -name <name> give a name to the code block when printing to the *debug* buffer.
} %{ eval %sh{
    lua $kak_opt_luar_path/luar.lua $kak_opt_luar_path "$kak_quoted_$@"
}}

require-module kak
require-module lua

add-highlighter shared/kakrc/lua1 region -recurse '\{' '(^|\h)\K%?lua([\s{}\w@%/"])* %\{' '\}' ref lua
add-highlighter shared/kakrc/lua2 region -recurse '\(' '(^|\h)\K%?lua([\s{}\w@%/"])* %\(' '\)' ref lua
add-highlighter shared/kakrc/lua3 region -recurse '\[' '(^|\h)\K%?lua([\s{}\w@%/"])* %\[' '\]' ref lua
add-highlighter shared/kakrc/lua4 region -recurse '<' '(^|\h)\K%?lua([\s{}\w@%/"])* %<' '>' ref lua

define-command fennel -params 1.. -docstring %{
    fennel [<switches>] [args...] code: Execute provided Fennel code as an anonymous function whose arguments are the args list.
    Switches:
        -debug       print Kakoune commands to the *debug* buffer instead of executing them.
        -name <name> give a name to the code block when printing to the *debug* buffer.
} %{ eval %sh{
    fennel $kak_opt_luar_path/luar.fnl $kak_opt_luar_path "$kak_quoted_$@"
}}
