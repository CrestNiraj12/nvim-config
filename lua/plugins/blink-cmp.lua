return {
  'saghen/blink.cmp',
  dependencies = 'rafamadriz/friendly-snippets',
  version = '*',
  opts = {
    keymap = {
      preset = 'default',
      ["<C-Space>"] = { 'show', 'fallback' },
      ["<C-k>"] = { 'select_prev', 'fallback' }, -- previous suggestion
      ["<C-j>"] = { 'select_next', 'fallback' }, -- next suggestion
      ["<CR>"] = { 'accept', 'fallback' },
    },
    sources = {
      default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
      providers = {
        snippets = {
          opts = {
            search_paths = {
              vim.fn.stdpath("config") .. "/snippets",
              vim.fn.stdpath("data") .. "/lazy/friendly-snippets",
            },
          },
        },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
      },
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
