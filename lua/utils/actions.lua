local M = {}

function M.get_replacement_buffer(current_bufnr)
  for _, b in ipairs(vim.api.nvim_list_bufs()) do
    if b ~= current_bufnr
       and vim.api.nvim_buf_is_loaded(b)
       and vim.bo[b].buflisted
       and vim.bo[b].filetype ~= "NvimTree" then
      return b
    end
  end
  return nil
end

function M.close_buffer()
  local bufnr = vim.api.nvim_get_current_buf()

  if vim.bo[bufnr].modified then
    vim.notify("Buffer has unsaved changes. Save or discard changes before closing.", vim.log.levels.WARN, { title = "Close buffer" })
    return
  end

  local replacement = M.get_replacement_buffer(bufnr)

  if not replacement then
    vim.notify("No other buffers available", vim.log.levels.WARN, { title = "Close buffer" })
    return
  end

  local current_win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(current_win, replacement)
  vim.api.nvim_buf_delete(bufnr, {})
end

function M.yank_file_info(modifier, label, fail_label, title)
  local val = vim.fn.expand(modifier)
  if val and val ~= "" then
    vim.fn.setreg("+", val)
    vim.notify("Copied " .. label .. ": " .. val, vim.log.levels.INFO, { title = title })
  else
    vim.notify("No " .. fail_label .. " to copy", vim.log.levels.WARN, { title = title })
  end
end

function M.delete_current_file()
  local bufnr = vim.api.nvim_get_current_buf()
  local file_path = vim.api.nvim_buf_get_name(bufnr)

  if file_path == "" then
    vim.notify("No file associated with current buffer", vim.log.levels.WARN, { title = "Delete File" })
    return
  end

  if vim.fn.filereadable(file_path) == 0 then
    vim.notify("File does not exist: " .. file_path, vim.log.levels.WARN, { title = "Delete File" })
    return
  end

  vim.ui.input({
    prompt = "Delete file: " .. file_path .. "? (y/n): ",
  }, function(confirmation)
    if confirmation ~= "y" and confirmation ~= "Y" then
      vim.notify("File deletion cancelled", vim.log.levels.INFO, { title = "Delete File" })
      return
    end

    local replacement = M.get_replacement_buffer(bufnr)

    local success = vim.fn.delete(file_path)
    if success ~= 0 then
      vim.notify("Failed to delete file: " .. file_path, vim.log.levels.ERROR, { title = "Delete File" })
      return
    end

    vim.notify("File deleted: " .. file_path, vim.log.levels.INFO, { title = "Delete File" })

    local current_win = vim.api.nvim_get_current_win()

    if replacement then
      vim.api.nvim_win_set_buf(current_win, replacement)
    else
      vim.cmd("bdelete!")

      if #vim.api.nvim_list_wins() == 1 then
        vim.cmd("enew")
      else
        vim.cmd("close")
      end
    end
  end)
end

return M

