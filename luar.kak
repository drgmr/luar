declare-option -hidden str luar_path %sh{ dirname $kak_source }

define-command lua -params 1.. -docstring %{
    lua [<switches>] [args...] code: Execute provided Lua code as an anonymous function whose arguments are the args list.
    Switches:
        -debug Print Kakoune commands to *debug* buffer instead of executing them.
} %{ eval %sh{
    lua $kak_opt_luar_path/luar.lua "$kak_quoted_$@"
}}

require-module kak
require-module lua

add-highlighter shared/kakrc/lua1 region -recurse '\{' '(^|\h)\K%?lua([\s{}\w@%/"])* %\{' '\}' ref lua
add-highlighter shared/kakrc/lua2 region -recurse '\(' '(^|\h)\K%?lua([\s{}\w@%/"])* %\(' '\)' ref lua
add-highlighter shared/kakrc/lua3 region -recurse '\[' '(^|\h)\K%?lua([\s{}\w@%/"])* %\[' '\]' ref lua
add-highlighter shared/kakrc/lua4 region -recurse '<' '(^|\h)\K%?lua([\s{}\w@%/"])* %<' '>' ref lua
