local lib = require "lib"
local fennel = require "fennel"

local ok, options = pcall(require, "fennelfriend") -- `pcall` nedeed for Fennel < 0.5.0
if not ok then options = {} end

kak = lib.kak
args = lib.args

lib.parseargs()

local function abort(err)
	lib.debug(err:gsub(":(%d+)", ": line %1", 1))
	os.exit(1)
end

options.filename = "fennel " .. lib.block.name
local results = { pcall(fennel.eval, lib.block.chunk, options) }
if not results[1] then abort(results[2]) end

if #results > 1 then
	table.remove(results, 1)
	print("echo " .. table.concat(results, "\t"))
end
