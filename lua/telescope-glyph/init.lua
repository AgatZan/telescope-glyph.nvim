local M = {}

--[[ function M.compile(glyphs)
	-- Related https://github.com/NvChad/base46
	local str_comp = "return string.dump(function() return" .. glyphs .. "end,true)"
	local file = io.open(M.cache_path .. "glyphs", "wb")
	if file then
		file:write(loadstring(str_comp)())
		file:close()
	end
end ]]
return M
