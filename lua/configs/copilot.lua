local copilot_config = function()
  vim.keymap.set('i', '<M-CR>',       'copilot#Accept("\\<CR>")', {expr = true,replace_keycodes = false})
  vim.keymap.set('i', '<M-Right>',    'copilot#AcceptWord()',     {expr = true,replace_keycodes = false})
  vim.keymap.set('i', '<M-Down>',     'copilot#AcceptLine()',     {expr = true,replace_keycodes = false})
  vim.keymap.set('i', '<M-Esc>',      'copilot#Suggest()',        {expr = true,replace_keycodes = false})
  vim.keymap.set('i', '<M-PageUp>',   'copilot#Previous()',       {expr = true,replace_keycodes = false})
  vim.keymap.set('i', '<M-PageDown>', 'copilot#Next()',           {expr = true,replace_keycodes = false})
  vim.g.copilot_no_tab_map = true
end

return copilot_config



