vim.keymap.set("n", " ", "<Nop>", { silent = true, remap = false })

vim.g.mapleader = ' '

vim.opt.termguicolors = true

-- auto change directory to current file
vim.opt.autochdir = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.colorcolumn = "80"
vim.opt.colorcolumn = "80"
vim.opt.signcolumn = "yes"

vim.opt.relativenumber = false
vim.opt.nu = true

vim.opt.wrap = true
vim.opt.smartcase = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir= os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.hidden = true -- Required to keep multiple buffers open multiple buffers

-- " Always show statusline.
vim.opt.laststatus=2
-- Show last command in the status line.
vim.opt.showcmd = true

vim.opt.updatetime=300   --Faster completion
vim.opt.timeoutlen=400   --By default timeoutlen is 1000 ms

vim.opt.clipboard="unnamedplus" --Copy paste between vim and everything else

--  have a fixed column for the diagnostics to appear in
--  this removes the jitter when warnings/errors flow in
vim.opt.signcolumn = "yes"

 -- Set updatetime for CursorHold
 -- 300ms of no cursor movement to trigger CursorHold
vim.opt.updatetime=300

--  Treesitter conf
-- highlight link TSConstBuiltin Constant
-- highlight link TSFuncBuiltin FuncBuiltIn

-- Don't pass messages to |ins-completion-menu|.
vim.opt.shortmess:append("c")

-- Color Scheme Settings
vim.cmd("syntax enable")
vim.opt.background="dark"
vim.g.nord_italic = false
require('nord').set()

vim.api.nvim_set_keymap('n', '<Leader><Leader>', '<C-^>', { noremap = true, silent = true })


local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('n', 'j', 'gj')
map('n', 'k', 'gk')

vim.api.nvim_create_user_command('W', 'w', {})

-- Movement keybinds
local opts = { noremap = true }

require('legendary').keymaps({
    { '<C-h>', '<C-w>h', description = 'Panes: Move left', opts = opts },
    { '<C-j>', '<C-w>j', description = 'Panes: Move down', opts = opts },
    { '<C-k>', '<C-w>k', description = 'Panes: Move up', opts = opts },
    { '<C-l>', '<C-w>l', description = 'Panes: Move right', opts = opts }
})

