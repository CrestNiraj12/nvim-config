require("core-setup")

-- lazy plugin manager setup --
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
-- Disable swap --
vim.opt.swapfile = false

local plugins = {
 { import = "plugins" },
}
require("lazy").setup(plugins)

-- Autosave ehen the window loses focus or buffer is hidden --
vim.cmd [[au FocusLost * silent! wa]]
vim.cmd [[au BufLeave * silent! wa]]
vim.cmd [[au InsertLeave * silent! wa]]

-- Autoreload file changes --
vim.o.autoread = true
vim.o.updatetime = 300
vim.api.nvim_create_autocmd("CursorHold", { pattern = "*", command = "checktime" })

