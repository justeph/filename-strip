local M = {
	config = {},
}

local git_strip = {
	pattern = "^[a,b]/",
	root_dir = ".git",
	relative_to_root = true,
}

local default_config = {
	autocmd = {
	},
	enable_git_strip = true
}

function M.setup(opts)
	opts = opts or {}

	M.config = vim.tbl_deep_extend('force', default_config, opts)
	if M.config.enable_git_strip then
		table.insert(M.config.autocmd, git_strip)
	end
end

function M.get()
	return M.config
end

return M

-- vim: expandtab:ts=4:sw=4:smartindent
