local actions = require("telescope.actions")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local conf = require("telescope.config").values
local entry_display = require("telescope.pickers.entry_display")
local action_state = require("telescope.actions.state")

---@class Glyph
---@field name string
---@field value string
---@field category string
---@field description string
---@type Glyph[]
local glyphs = {}
---@param glyph Glyph
---@return nil
local function action(glyph)
	vim.fn.setreg("*", glyph.value)
	print([[Press p or "*p to paste this glyph]] .. glyph.value)
end

local function search(opts)
	local displayer = entry_display.create({
		separator = " ",
		items = {
			{ width = 40 },
			{ width = 18 },
			{ remaining = true },
		},
	})
	local make_display = function(entry)
		return displayer({
			entry.value .. " " .. entry.name,
			entry.category,
			entry.description,
		})
	end

	pickers
		.new(opts, {
			prompt_title = "Glyphs",
			sorter = conf.generic_sorter(opts),
			finder = finders.new_table({
				results = glyphs,
				entry_maker = function(glyph)
					return {
						ordinal = glyph.name
							.. glyph.category
							.. glyph.description,
						display = make_display,

						name = glyph.name,
						value = glyph.value,
						category = glyph.category,
						description = glyph.description,
					}
				end,
			}),
			attach_mappings = function(prompt_bufnr)
				actions.select_default:replace(function()
					local glyph = action_state.get_selected_entry()
					actions.close(prompt_bufnr)
					action(glyph)
				end)
				return true
			end,
		})
		:find()
end

return require("telescope").register_extension({
	---@class Config
	---@field base_glyphs boolean Append base glyphs
	---@field base_emoji boolean Append base emoji
	---@field glyphs (Glyph[] | nil) Set of [Glyph](lua://Glyph)
	---@field action (nil | fun(glyph:Glyph):nil) Function that will be called after choosing glyph
	---@param config Config
	setup = function(config)
		action = config.action or action
		if config.base_glyphs ~= false then
			---@module "teleglyphs.glyphs"
			glyphs = require("teleglyphs.glyphs")
		end
		if config.base_emoji ~= false then
			glyphs = vim.tbl_deep_extend(
				"force",
				glyphs,
				require("teleglyphs.emoji")
			)
		end
		if config.glyphs ~= nil then
			glyphs = vim.tbl_deep_extend("force", glyphs, glyphs)
		end
	end,
	exports = { glyph = search },
})
