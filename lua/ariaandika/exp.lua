function Show()
  local ns = vim.api.nvim_create_namespace('deez')
  vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)


  local win_info = vim.fn.getwininfo(vim.fn.win_getid())[1]
  local x = win_info.topline

  vim.api.nvim_buf_set_extmark(0, ns, x, 0, {
    virt_text = {{'Deez','DiagnosticFloatingError'}},
    virt_text_pos = "right_align",
    virt_lines_above = true,
    strict = false
  })
end

-- do something when mouse hold / stop moving
local function expermenmint()
  local function print_diagnostics(opts, bufnr, line_nr, client_id)
    bufnr = bufnr or 0
    line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)
    opts = opts or {['lnum'] = line_nr}

    local line_diagnostics = vim.diagnostic.get(bufnr, opts)
    if vim.tbl_isempty(line_diagnostics) then return end

    local diagnostic_message = ""
    for i, diagnostic in ipairs(line_diagnostics) do
      diagnostic_message = diagnostic_message .. string.format("%d: %s", i, diagnostic.message or "")
      print(diagnostic_message)
      if i ~= #line_diagnostics then
        diagnostic_message = diagnostic_message .. "\n"
      end
    end
    vim.api.nvim_echo({{diagnostic_message, "Normal"}}, false, {})
  end

  vim.api.nvim_create_autocmd("CursorHold", {
    group = vim.api.nvim_create_augroup("print_diagnostics", { clear = true }),
    callback = print_diagnostics
  })
end

-- deez + 123

local err_map = {
  "DiagnosticFloatingError",
  "DiagnosticFloatingWarn",
  "DiagnosticFloatingInfo",
  "DiagnosticFloatingHint",
}

local function expermenmint3()
  local ns = vim.api.nvim_create_namespace('deez')
  local extid = nil

  local function clear_diagnostics()
    if extid ~= nil then
      vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
      extid = nil
    end
  end

  local function print_diagnostics(opts, bufnr, line_nr)
    bufnr = bufnr or 0
    line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)
    opts = opts or {['lnum'] = line_nr}

    clear_diagnostics()

    local line_diagnostics = vim.diagnostic.get(bufnr, opts)
    if vim.tbl_isempty(line_diagnostics) then return end

    local win_info = vim.fn.getwininfo(vim.fn.win_getid())[1]
    local x = win_info.topline

    for i, diagnostic in ipairs(line_diagnostics) do
      extid = vim.api.nvim_buf_set_extmark(bufnr, ns, x + i, 0, {
        virt_text = {{diagnostic.lnum .. '-' .. diagnostic.end_lnum .. ': ' .. diagnostic.message, err_map[diagnostic.severity]}},
        virt_text_pos = "right_align",
      })
    end
  end

  vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI"  }, {
    group = vim.api.nvim_create_augroup("clear_diagnostics", { clear = true }),
    callback = clear_diagnostics
  })

  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    group = vim.api.nvim_create_augroup("print_diagnostics", { clear = true }),
    callback = print_diagnostics
  })

end

-- expermenmint3()
