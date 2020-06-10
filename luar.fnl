(set package.path (table.concat [package.path ";" (. arg 1) "/?.lua"]))
(table.remove arg 1)

(local fennel (require :fennel))
(local lib (require :lib))
(lib.parseargs)

(local options (let [(ok friend) (pcall require :fennelfriend) ; `pcall` needed for Fennel < 0.5
                     opt (if ok friend {})]
                 (set opt.filename (.. "fennel " lib.block.name))
                 opt))

(global kak lib.kak)
(global args lib.args)

(fn abort [err]
  (lib.debug (err:gsub ":(%d+)" ": line %1" 1))
  (os.exit 1))

(match [(pcall fennel.eval lib.block.chunk options)]
  [false err] (abort err)
  ([a & b] ? (> (length b) 0)) (print (.. "echo " (table.concat b "\t"))))
