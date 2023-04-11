local M = {}

local config = require('filename-strip.config')
local core = require('filename-strip.core')

function M.setup(opt)
	config.setup(opt)
	local cfg = config.get()
	for number, autocmd in pairs(cfg.autocmd) do
		core.add_autocommand(autocmd)
	end
end

return M

-- vim: expandtab:ts=4:sw=4:smartindent
