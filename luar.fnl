(set package.path (table.concat [package.path ";" (. arg 1) "/?.lua"]))
(table.remove arg 1)

(local lib (require :lib))

(global kak lib.kak)
(global args lib.args)

(lib.parseargs)

(fn abort [err]
  (lib.debug (err:gsub ":(%d+)" ": line %1" 1))
  (os.exit 1))

(let [results (lib.eval lib.block.chunk)]
  (when (not (. results 1)) (abort (. results 2)))
  (when (> (length results) 1)
    (table.remove results 1)
    (print (.. "echo " (table.concat results "\t")))))
