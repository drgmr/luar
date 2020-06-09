local write = print
local block = {
	name = "anonymous block",
	chunk = arg[#arg]
}

local function debug(text)
	local first = true

	for line in text:gmatch('[^\n]*') do
		if first then
			print(string.format([[echo -debug %%@luar: %s@]], line))
			first = false
		else
			print(string.format([[echo -debug %%@    %s@]], line))
		end
	end
end

local function parseargs()
	local newarg = {}
	local i = 0

	while i <= #arg - 1 do
		if arg[i] == "-debug" then
			write = debug

		elseif arg[i] == "-name" then
			block.name = string.format("block “%s”", arg[i+1])
			i = i + 1

		elseif arg[i] == "true" then
			newarg[#newarg+1] = true

		elseif arg[i] == "false" then
			newarg[#newarg+1] = false

		else
			newarg[#newarg+1] = tonumber(arg[i]) or arg[i]
		end

		i = i + 1
	end

	arg = newarg
end

local kak = setmetatable({}, {
	__index = function(t, command)
		local name = command:gsub("_", "-")
		t[command] = function(...)
			local words = { name }

			for _, v in ipairs {...} do
				words[#words + 1] = string.format("'%s'", v)
			end

			write(table.concat(words, " "))
		end

		return t[command]
	end
})

local function args() return table.unpack(arg) end

local function evalfennel(chunk)
	local fennel = require "fennel"
	local ok, options = pcall(require, "fennelfriend") -- `pcall` needed for Fennel < 0.5.0
	if not ok then options = {} end

	options.filename = "fennel " .. block.name
	return { pcall(fennel.eval, chunk, options) }
end

return {
	parseargs = parseargs,
	debug = debug,
	kak = kak,
	args = args,
	block = block,
	eval = evalfennel
}
