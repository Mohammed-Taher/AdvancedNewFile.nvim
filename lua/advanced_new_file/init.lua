local fn = vim.fn
local utils = require("advanced_new_file.utils")

local M = {
	goto_file = true,
	notify = true,
}

local path_separator = package.config:sub(1, 1)

function M.run()
	vim.ui.input({ prompt = "File:", completion = "file" }, function(new_file_path)
		-- Check if the input was empty
		if new_file_path == nil then
			return
		end

		-- Create directories only
		if string.find(new_file_path, path_separator, -1) then
			if fn.isdirectory(new_file_path) == 0 then
				fn.mkdir(new_file_path, "p")
				if M.notify then
					utils.notify.info("Folder created!")
				end
			else
				utils.clear_prompt()

				if M.notify then
					utils.notify.error("Couldn't create folder " .. new_file_path)
				end
			end
			return
		end

		-- Create the file and the required directories
		if string.find(new_file_path, path_separator) then
			local folder = string.match(new_file_path, "(.-)([^/]-([^%.]+))$")
			if fn.isdirectory(folder) == 0 then
				fn.mkdir(folder, "p")
			end
			utils.create_file(new_file_path)
			return
		end

		-- If all the above conditions fail, then the user wants to create a file only in the root directory
		if utils.file_exists(new_file_path) then
			utils.clear_prompt()
			if M.notify then
				utils.notify.error("File already exists!")
			end
		else
			utils.clear_prompt()
			if M.notify then
				utils.notify.info(new_file_path .. " was created!")
			end
			utils.create_file(new_file_path)
			if M.goto_file then
				vim.api.nvim_command("edit " .. new_file_path)
			end
		end
	end)
end

M.run()
return M
