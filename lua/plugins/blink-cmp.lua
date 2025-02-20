return {
  'saghen/blink.cmp',
  dependencies = 'rafamadriz/friendly-snippets',
  version = '*',
  opts = {
    keymap = {
      preset = 'default',
      ["<C-Space>"] = { 'show', 'fallback' },
      ["<C-k>"] = { 'select_prev', 'fallback' },   -- previous suggestion
      ["<C-j>"] = { 'select_next', 'fallback' },   -- next suggestion
      ["<CR>"] = { 'accept', 'fallback' },
    },
    sources = {
      cmdline = {},   -- disable command line completions
    },
    signature = {
      enabled = true,
      window = {
        border = "rounded"
      }
    },
    completion = {
      documentation = {
        auto_show = true,
        window = {
          border = "rounded",
        },
        auto_show_delay_ms = 500,
      },
      menu = {
        border = "rounded",
      },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono'
    },
  },
}
