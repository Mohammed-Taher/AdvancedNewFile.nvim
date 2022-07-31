local has_notify, notify = pcall(require, "notify")
local fn = vim.fn
local M = {}

local function notify_level(level)
	return function(msg)
		vim.schedule(function()
			if has_notify then
				notify(msg, level, { title = "Advanced New File" })
			else
				vim.notify("[Advanced New File] " .. msg, level)
			end
		end)
	end
end

M.notify = {}
M.notify.warn = notify_level(vim.log.levels.WARN)
M.notify.error = notify_level(vim.log.levels.ERROR)
M.notify.info = notify_level(vim.log.levels.INFO)
M.notify.debug = notify_level(vim.log.levels.DEBUG)

--- @param path string path to file or directory
--- @return boolean
function M.file_exists(path)
	local _, error = vim.loop.fs_stat(path)
	return error == nil
end

function M.clear_prompt()
	if vim.opt.cmdheight._value ~= 0 then
		vim.cmd("normal! :")
	end
end

function M.create_file(value)
	local uv = vim.loop
	local dir = fn.expand("%:p:h")
	local file = uv.fs_open(value, "w", 420)
	uv.fs_close(file)
	return value
end

return M
