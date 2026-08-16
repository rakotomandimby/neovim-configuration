local config = require("configs.window_blink.config")

local M = {}

local is_blinking = false
local last_blink_time = 0

local function get_window_border_positions(win)
  return {
    row = vim.api.nvim_win_get_position(win)[1],
    col = vim.api.nvim_win_get_position(win)[2],
    width = vim.api.nvim_win_get_width(win),
    height = vim.api.nvim_win_get_height(win),
  }
end

local function create_blink_borders(win)
  local pos = get_window_border_positions(win)
  local borders = { wins = {}, bufs = {} }

  local win_opts = {
    relative = "editor",
    style = "minimal",
    focusable = false,
    zindex = 100,
  }

  local highlight_val = "Normal:" .. config.options.highlight_group

  local function add_border(key, row, col, width, height)
    local buf = vim.api.nvim_create_buf(false, true)
    local opts = vim.tbl_deep_extend("force", win_opts, {
      row = row,
      col = col,
      width = width,
      height = height,
    })
    local win_id = vim.api.nvim_open_win(buf, false, opts)
    vim.api.nvim_set_option_value("winhighlight", highlight_val, { win = win_id })

    borders.wins[key] = win_id
    table.insert(borders.bufs, buf)
  end

  add_border("top", pos.row > 0 and pos.row - 1 or 0, pos.col, pos.width, 1)
  add_border("bottom", pos.row + pos.height, pos.col, pos.width, 1)

  if pos.col > 0 then
    add_border("left", pos.row, pos.col - 1, 1, pos.height)
  end

  add_border("right", pos.row, pos.col + pos.width, 1, pos.height)

  return borders
end

local function close_borders(borders)
  if not borders then
    return
  end

  for _, win in pairs(borders.wins or {}) do
    if win and vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end

  for _, buf in ipairs(borders.bufs or {}) do
    if buf and vim.api.nvim_buf_is_valid(buf) then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
end

function M.blink_window()
  local now = vim.uv.now()
  if is_blinking or (now - last_blink_time < config.options.debounce_interval) then
    return
  end

  local win = vim.api.nvim_get_current_win()

  local win_cfg = vim.api.nvim_win_get_config(win)
  if win_cfg.relative ~= "" then
    return
  end

  local buftype = vim.bo[vim.api.nvim_win_get_buf(win)].buftype
  if buftype == "nofile" or buftype == "terminal" or buftype == "prompt" then
    return
  end

  is_blinking = true
  last_blink_time = now

  local borders = nil
  local blinks_left = config.options.blink_count * 2

  local function blink_step()
    if blinks_left <= 0 then
      if borders then
        close_borders(borders)
      end
      is_blinking = false
      return
    end

    if blinks_left % 2 == 0 then
      borders = create_blink_borders(win)
    else
      if borders then
        close_borders(borders)
        borders = nil
      end
    end

    blinks_left = blinks_left - 1

    local timer = vim.uv.new_timer()
    if timer then
      timer:start(config.options.blink_duration, 0, vim.schedule_wrap(function()
        blink_step()
        timer:close()
      end))
    else
      if borders then
        close_borders(borders)
      end
      is_blinking = false
    end
  end

  blink_step()
end

return M

