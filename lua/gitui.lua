local M = {}

M.state = {
  is_open = false,
}

-- Default options
M.config = {
  -- Command Options
  command = {
    -- Enable :Gitui command
    -- @type: bool
    enable = true,
  },
  -- Path to binary
  -- @type: string
  binary = "gitui",
  -- Argumens to gitui
  -- @type: table of string
  args = {},
  -- WIndow Options
  window = {
    options = {
      -- Width window in %
      -- @type: number
      width = 90,
      -- Height window in %
      -- @type: number
      height = 80,
      -- Border Style
      -- Enum: "none", "single", "rounded", "solid" or "shadow"
      -- @type: string
      border = "rounded",
    },
  },
}

M.setup = function(overrides)
  M.config = vim.tbl_deep_extend("force", M.config, overrides or {})

  if M.config.command.enable then
    vim.cmd([[
      command! Gitui :lua require"gitui".open()
    ]])
  end
end

M.open = function()
  if M.state.is_open then
    return
  end

  assert(vim.fn.executable(M.config.binary) == 1, M.config.binary .. " not a executable")

  local bufnr = vim.api.nvim_create_buf(false, true)

  local width = vim.api.nvim_get_option("columns")
  local height = vim.api.nvim_get_option("lines")
  local win_height = math.ceil(height * (M.config.window.options.height / 100))
  local win_width = math.ceil(width * (M.config.window.options.width / 100))
  local row = math.ceil((height - win_height) / 2)
  local col = math.ceil((width - win_width) / 2)

  local window_options = {
    style = "minimal",
    relative = "editor",
    width = win_width,
    height = win_height,
    row = row,
    col = col,
    border = M.config.window.options.border,
    noautocmd = true,
  }

  vim.api.nvim_open_win(bufnr, true, window_options)

  vim.fn.termopen(table.concat(vim.tbl_flatten({ M.config.binary, M.config.args }), " "), {
    on_exit = function()
      -- vim.api.nvim_win_close(winr, true)
      -- vim.cmd([[silent! :q]])
      vim.api.nvim_buf_delete(bufnr, { force = true })
      M.state.is_open = false
    end,
  })
  vim.cmd([[startinsert!]])
  M.state.is_open = true
end

return M
