package.path = table.concat {package.path, ";", arg[1], "/?.lua"}
table.remove(arg, 1) -- Remove plugin path

local lib = require "lib"

kak = lib.kak
args = lib.args

lib.parseargs()

local function abort(action, err)
	err = err:match('%[string "luar"%]:(.+)')
	local message = "error while %s lua %s:\n\nline %s\n"
	lib.debug(message:format(action, lib.block.name, err))
	os.exit(1)
end

local fn, err = load(lib.block.chunk, "luar")
if not fn then abort("parsing", err) end

local results = { pcall(fn) }
if not results[1] then abort("executing", results[2]) end

if #results > 1 then
	table.remove(results, 1)
	print("echo " .. table.concat(results, "\t"))
end
