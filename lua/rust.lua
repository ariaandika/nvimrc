---@diagnostic disable: undefined-field

IS_RUST = vim.uv.fs_stat("Cargo.toml")

if not IS_RUST then
  return
end

local function get_or_create_buffer(filename)
  if vim.fn.bufexists(filename) == 0 then
    return vim.fn.bufadd(filename)
  else
    return vim.fn.bufnr(filename)
  end
end

local function open_mod()
  local current = vim.fn.expand("%:t")

  if current == "lib.rs" then
    return
  end

  local current_dir = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
  local current_dir_base = vim.fs.basename(current_dir)
  local parent = vim.fs.dirname(current_dir)

  local files = { }

  if current == "mod.rs" then
    table.insert(files, parent .. "/mod.rs")
  else
    table.insert(files, current_dir .. "/mod.rs")
    table.insert(files, parent .. "/" .. current_dir_base .. ".rs")
  end

  table.insert(files, current_dir .. "/lib.rs")
  table.insert(files, parent .. "/lib.rs")

  for _, filename in pairs(files) do
    if vim.uv.fs_stat(filename) then

      local normalized_filename = vim.fs.normalize(filename)
      local buf_id = get_or_create_buffer(normalized_filename)

      vim.api.nvim_set_current_buf(buf_id)

      return
    end
  end

  print("no file opened")
end

vim.keymap.set("n", "-", open_mod)

