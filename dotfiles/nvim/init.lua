-- Mappings --
vim.g.mapleader = ","

-- Alternate file with Q insted of Ex mode
vim.keymap.set('n', 'Q', '<C-^>')
vim.keymap.set('v', 'Q', '')

-- Exit insert mode with jk
vim.keymap.set('i', 'jk', '<esc>')

-- Move to column on wrapped line
vim.keymap.set({ 'n', 'v' }, 'j', 'gj')
vim.keymap.set({ 'n', 'v' }, 'k', 'gk')

-- Clear highlight
vim.keymap.set('n', '<leader><space>', '<cmd>nohlsearch<cr>')

-- Move visual block while maintaining selection
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Highlight search without moving
vim.keymap.set('n', '*', ':let start_pos = winsaveview()<CR>*:call winrestview(start_pos)<cr>')

-- Close buffer and return to previous buffer
vim.keymap.set('n', '<C-q>', '<C-o> :silent bwipeout #<cr>')

-- Close buffer without closing split
vim.keymap.set('n', '<leader><C-q>', ':bprevious | bwipeout #<cr>')

-- Show diagnostics
vim.keymap.set('n', '<C-k>', '<cmd>lua vim.diagnostic.open_float()<cr>')

-- Move line up/down with Alt-j/k
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==')
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==')

vim.keymap.set('n', '<left>', ':bprevious<CR>')
vim.keymap.set('n', '<right>', ':bnext<CR>')

-- Options --
vim.o.backup = false
vim.o.backupcopy = 'yes'
vim.o.clipboard = 'unnamed'
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.foldlevelstart = 99
vim.o.hidden = true
vim.o.ignorecase = true
vim.o.laststatus = 3
vim.o.lazyredraw = true
vim.o.list = true
vim.o.magic = false
vim.o.number = true
vim.o.relativenumber = true
vim.o.shortmess = 'aIc'
vim.o.signcolumn = 'yes'
vim.o.smartcase = true
vim.o.splitbelow = true
vim.o.splitkeep = "screen"
vim.o.splitright = true
vim.o.swapfile = false
vim.o.termguicolors = true
vim.o.undofile = true
vim.o.updatetime = 250
vim.o.winborder = 'rounded'

vim.opt.listchars = {
  tab = '⎸ ',
  trail = '.',
  nbsp = '.',
}

vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2

vim.wo.spell = true
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'

-- LSP --
vim.lsp.enable({ 'gopls', 'clangd', 'lua_ls', 'nil_ls' })

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    vim.bo[args.buf].formatprg = nil
    vim.bo[args.buf].omnifunc = nil
  end,
})

-- Diagnostics --
vim.diagnostic.config({
  underline = true,
  signs = true,
  virtual_text = false,
  float = {
    source = 'always',
    border = 'rounded',
    focusable = false,
  },
  update_in_insert = true,
  severity_sort = true,
})
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Allow saving with uppercase W so that shift-; for : doesn't accidentally also capitalize w
vim.api.nvim_create_user_command('W', 'w', {})

-- Plugins --
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
  change_detection = {
    notify = false,
  },
  checker = {
    enable = true,
  }
})
