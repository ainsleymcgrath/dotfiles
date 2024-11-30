vim.g.mapleader = ' '

-- normal
vim.keymap.set('n', '<leader>ff', "<Cmd>lua require('vscode').call('workbench.action.quickOpen')<CR>")
vim.keymap.set('n', '<leader>lr', "<Cmd>lua require('vscode').call('editor.action.rename')<CR>")
vim.keymap.set('n', 'K', "<Cmd>lua require('vscode').call('editor.action.showHover')<CR>")
vim.keymap.set('n', '<leader>e', "<Cmd>lua require('vscode').call('workbench.files.action.focusFilesExplorer')<CR>")
vim.keymap.set('n', ']a', "<Cmd>lua require('vscode').call('editor.action.marker.next')<CR>")
vim.keymap.set('n', '[a', "<Cmd>lua require('vscode').call('editor.action.marker.prev')<CR>")
vim.keymap.set('n', ']c', "<Cmd>lua require('vscode').call('workbench.action.editor.nextChange')<CR>")
vim.keymap.set('n', '[c', "<Cmd>lua require('vscode').call('workbench.action.editor.previousChange')<CR>")
vim.keymap.set('n', '<leader>gy', "<Cmd>lua require('vscode').call('extension.openInGitHub')<CR>")
vim.keymap.set('n', '<leader>gg', "<Cmd>lua require('vscode').call('workbench.scm.focus')<CR>")
vim.keymap.set('n', '<leader>h', "<Cmd>:nohl<CR>")
vim.keymap.set('n', '<leader>gr', "<Cmd>lua require('vscode').call('git.revertSelectedRanges')<CR>")
vim.keymap.set('n', '<leader>gs', "<Cmd>lua require('vscode').call('git.stageSelectedRanges')<CR>")
vim.keymap.set('n', '<leader>gl', "<Cmd>lua require('vs'code').call('gitlens.toggleLineBlame')<CR>")

-- visual
vim.keymap.set('v', '<leader>gr', "<Cmd>lua require('vscode').call('git.revertSelectedRanges')<CR>")
vim.keymap.set('v', '<leader>gs', "<Cmd>lua require('vscode').call('git.stageSelectedRanges')<CR>")
vim.keymap.set('v', '<leader>gy', "<Cmd>lua require('vscode').call('extension.openInGitHub')<CR>")

-- insert
vim.keymap.set('i', 'jj', '<Esc>')
