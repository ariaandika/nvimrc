local so = function(id) vim.opt.rtp:append(PLUGIN_SRC .. id) end

---@diagnostic disable-next-line: undefined-field
local cwd = vim.uv.cwd()

so("plenary.nvim")
so("telescope.nvim")

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local conf = require("telescope.config").values

require("telescope").setup {
  defaults = {
    preview = false,
    mappings = {
      i = { ["<esc>"] = actions.close }
    },
  },
}

local opts = {
  cwd = cwd,
  preview = false,
  entry_maker = make_entry.gen_from_file({ cwd = cwd }),
  attach_mappings = function(_, map)
    map("i", "<esc>", actions.close)
    return true -- map default_mappings
  end,
  -- theme = "ivy",
}

local all_files_cmd = { "rg", "--files", "--color=never" }
local project_files_cmd = { "rg", "--files", "--color=never" }

if IS_RUST then
  table.insert(project_files_cmd, "src")
  table.insert(project_files_cmd, "Cargo.toml")
end

local function all_files()
  pickers.new(opts, {
    prompt_title = "All Files",
    finder = finders.new_oneshot_job(all_files_cmd, opts),
    sorter = conf.file_sorter(opts),
  }):find()
end

local function project_files()
  pickers.new(opts, {
    prompt_title = "Project Files",
    finder = finders.new_oneshot_job(project_files_cmd, opts),
    sorter = conf.file_sorter(opts),
  }):find()
end

local function grep_string()
  local search = vim.fn.input("Grep > ")
  if search == "" then
    return
  end

  local grep_string_cmd = {
    "rg", "-e", search,
    "--color=never", "--no-heading", "--smart-case", "--with-filename", "--column"
  }

  opts.entry_maker = make_entry.gen_from_vimgrep(opts)

  pickers.new(opts, {
    prompt_title = "Grep \"" .. search .. "\"",
    finder = finders.new_oneshot_job(grep_string_cmd, opts),
    previewer = conf.grep_previewer(opts),
    sorter = conf.generic_sorter(opts),
    push_on_cursor_edit = true,
  }):find()
end

vim.keymap.set('n', '<tab>',       builtin.buffers,     { desc = "Telescope: buffer" })
vim.keymap.set('n', '<leader>fd',  builtin.diagnostics, { desc = "Telescope: diagnostic" })
vim.keymap.set('n', '<leader>fp',  builtin.builtin,     { desc = "Telescope: all builtin" })
-- custom
vim.keymap.set('n', '<leader>fa',  all_files,           { desc = "Telescope: all files" })
vim.keymap.set('n', '<leader>fs',  grep_string,         { desc = "Telescope: grep string" })
vim.keymap.set('n', '<leader><tab>', project_files,     { desc = "Telescope: project files" })
