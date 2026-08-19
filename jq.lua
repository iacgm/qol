-- Config

vim.opt.swapfile = false
vim.g.jq_path = '/tmp/aa_out/*.json'
vim.g.jq_qdir = '/tmp/query.jq'
vim.g.num_lines = 2000

-- Setup

local function create_scratch_buffer()
  local buf = vim.api.nvim_create_buf(false, true)

  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "hide"
  vim.bo[buf].swapfile = false
  vim.bo[buf].filetype = "json"

  vim.api.nvim_cmd({ cmd = "vsplit" }, {})
  vim.api.nvim_win_set_buf(0, buf)
	return buf
end

local query_buf = vim.fn.bufadd(vim.g.jq_qdir)
local qwin = vim.api.nvim_get_current_win()
local out_buf = create_scratch_buffer()

vim.api.nvim_set_current_win(qwin)
vim.api.nvim_set_current_buf(query_buf)

-- Logic

local map = vim.keymap.set
local function set_qdir()
	local curr = vim.g.jq_qdir
	if curr == nil then curr = "" end
	vim.g.jq_qdir = vim.fn.input("Set Query Path: ", curr, "file")
	vim.api.nvim_set_current_win(qwin)
	query_buf = vim.fn.bufadd(vim.g.jq_qdir)
	vim.api.nvim_set_current_buf(query_buf)
	vim.api.nvim_win_set_buf(qwin, query_buf)
end
map("n", "sq", set_qdir)

local function set_dir()
	local curr = vim.g.jq_path
	if curr == nil then curr = "" end
	vim.g.jq_path = vim.fn.input("Set JQ Path: ", curr, "file")
end
map("n", "sd", set_dir)

local function set_num()
	local curr = vim.g.num_lines
	if curr == nil then curr = "" end
	vim.g.num_lines = tonumber(vim.fn.input("Set # of lines: ", curr))
end
map("n", "sn", set_num)

local function update()
	vim.cmd('wa')
	local command = 'jq -s -f ' .. vim.g.jq_qdir .. ' ' .. vim.g.jq_path
	print("Ran @ " .. os.date("%H:%M:%S"))
	local systemlist = vim.fn.systemlist(command)
	if vim.g.num_lines ~= nil then
		systemlist = vim.list_slice(systemlist, 0, vim.g.num_lines)
	end
	vim.api.nvim_buf_set_lines(out_buf, 0, -1, false, systemlist)
	print("End @ " .. os.date("%H:%M:%S"))
end
map("n", "su", update)
