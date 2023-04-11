if vim.g.load_filename_strip_nvim then
	return
end
vim.g.load_filename_strip_nvim = true

if not vim.api.nvim_create_autocmd then
	vim.notify_once('file-name-strip.nvim requires nvim 0.7.0+.', vim.log.levels.ERROR, { title = 'filename-strip.nvim' })
	return
end

-- vim: expandtab:ts=4:sw=4:smartindent
