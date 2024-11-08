-- NOTE: Utilities
local M = {}

M.git = function()
	local status_ok, _ = pcall(require, "toggleterm")
	if not status_ok then
		return vim.notify("toggleterm.nvim isn't installed!!!")
	end

	local Terminal = require("toggleterm.terminal").Terminal
	local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
	lazygit:toggle()
end

return M
