return {
  'saghen/blink.cmp',
  version = '*',
  dependencies = {
    "giuxtaposition/blink-cmp-copilot",
  },
  opts = {
    keymap = {
      preset = 'default',
      ["<C-Space>"] = { 'show', 'fallback' },
      ["<C-k>"] = { 'select_prev', 'fallback' }, -- previous suggestion
      ["<C-j>"] = { 'select_next', 'fallback' }, -- next suggestion
      ["<CR>"] = { 'accept', 'fallback' },
    },
    sources = {
      default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
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
        copilot = {
          name = "copilot",
          module = "blink-cmp-copilot",
          score_offset = 100,
          async = true,
          transform_items = function(_, items)
            local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
            local kind_idx = #CompletionItemKind + 1
            CompletionItemKind[kind_idx] = "Copilot"
            for _, item in ipairs(items) do
              item.kind = kind_idx
            end
            return items
          end,
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
      nerd_font_variant = 'mono',
      kind_icons = {
        Copilot = "",
        Text = '󰉿',
        Method = '󰊕',
        Function = '󰊕',
        Constructor = '󰒓',

        Field = '󰜢',
        Variable = '󰆦',
        Property = '󰖷',

        Class = '󱡠',
        Interface = '󱡠',
        Struct = '󱡠',
        Module = '󰅩',

        Unit = '󰪚',
        Value = '󰦨',
        Enum = '󰦨',
        EnumMember = '󰦨',

        Keyword = '󰻾',
        Constant = '󰏿',

        Snippet = '󱄽',
        Color = '󰏘',
        File = '󰈔',
        Reference = '󰬲',
        Folder = '󰉋',
        Event = '󱐋',
        Operator = '󰪚',
        TypeParameter = '󰬛',
      },
    },
  },
}
