local core = {}

local aug_filename_strip = vim.api.nvim_create_augroup('FilenameStrip' , {})

function core.add_autocommand(autocmd)
	vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
		group = aug_filename_strip,
		callback = function (ev)
			local root
			if autocmd.root then
				local found_root = vim.fs.find(autocmd.root, {
					limit = 1,
					upward = true,
				})

				if #found_root == 0 then
					return
				end

				if autocmd.relative_to_root then
					root = vim.fs.dirname(found_root[1]) .. "/"
				end
			end

			if root == nil then
				root = ""
			end

			local filename = ev.file

			-- if file exist just return
			if not autocmd.strip_first then
				if vim.fn.filereadable(filename) == 1  then
					return
				end
			end

			if not autocmd.repl then
				autocmd.repl = ""
			end

			--else try to strip pattern and open the buffer
			filename, x = filename:gsub(autocmd.pattern, autocmd.repl , 1)
			if x ~= 0 then
				pcall(vim.cmd, "edit " .. root .. filename)
				pcall(vim.cmd, "bd#")
			end

		end
	})
end

return core

-- vim: expandtab:ts=4:sw=4:smartindent
