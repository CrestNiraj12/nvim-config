return {
  {
    'jose-elias-alvarez/nvim-lsp-ts-utils',
    requires = { 'neovim/nvim-lspconfig', 'nvim-lua/plenary.nvim' },
  },
  {
    'williamboman/mason.nvim',
    lazy = false,
    config = true,
  },
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'williamboman/mason-lspconfig.nvim' },
    },
    config = function()
      -- lsp keybindings
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(event)
          local opts = { buffer = event.buf }

          -- these will be buffer-local keybindings
          -- because they only work if you have an active language server

          vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
          vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
          vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
          vim.keymap.set('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
          vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
          vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
          vim.keymap.set('n', '<leader>dl', '<cmd>lua vim.diagnostic.setqflist()<cr>', opts)
          vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
          vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
          vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
          vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
          vim.keymap.set('n', 'rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
          vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
          vim.keymap.set({ 'n', 'x' }, '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

          -- override defaults from lsp_zero
          vim.keymap.set({ 'n', 'x' }, "<leader>.", '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

          -- Define a function to organize imports and format
          local function organize_and_format_dart()
            -- Request code action to organize imports
            if vim.bo.filetype == 'dart' then
              vim.lsp.buf.code_action({
                context = { only = { "source.organizeImports" } },
                apply = true
              })
            end

            -- Format the buffer
            local _, _ = pcall(function()
              vim.lsp.buf.format({ async = false })
            end)
          end

          -- Bind the organize and format function to <C-s> keymap
          vim.keymap.set('n', '<C-s>', organize_and_format_dart, { desc = 'Format and Organize Imports' })
        end
      })

      -- hover borders
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

      local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

      local on_attach = function(client, bufnr)
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
      end

      local default_setup = function(server)
        require('lspconfig')[server].setup({
          capabilities = lsp_capabilities,
          on_attach = on_attach,
        })
      end

      require('mason-lspconfig').setup({
        ensure_installed = {
          "gopls",
          "jdtls",
          "lua_ls",
          "html",
          "pyright",
          "jsonls",
          "rust_analyzer",
          "taplo",
          "marksman",
          "sourcery",
          "tsserver",
        },
        handlers = {
          default_setup,
          sourcery = function()
            require('lspconfig').sourcery.setup({
              init_options = {
                --- The Sourcery token for authenticating the user.
                --- This is retrieved from the Sourcery website and must be
                --- provided by each user. The extension must provide a
                --- configuration option for the user to provide this value.
                token = os.getenv('SOURCERY_TOKEN'),

                --- The extension's name and version as defined by the extension.
                extension_version = 'vim.lsp',

                --- The editor's name and version as defined by the editor.
                editor_version = 'vim',
              }
            })
          end,
          lua_ls = function()
            require('lspconfig').lua_ls.setup({
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { "vim" },
                  },
                  workspace = {
                    library = {
                      [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                      [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                    },
                  },
                },
              },
            })
          end,
          tsserver = function()
            require('lspconfig').tsserver.setup({
              on_attach = function(client, bufnr)
                local ts_utils = require('nvim-lsp-ts-utils')
                ts_utils.setup({
                  -- specify preferences for import sorting and other options
                  import_all_timeout = 5000, -- milliseconds
                  import_all_priorities = {
                    buffers = 4,             -- loaded buffer names
                    buffer_content = 3,      -- loaded buffer content
                    local_files = 2,         -- git files or files with relative path markers
                    same_file = 1,           -- add to existing import statement
                  },
                  import_all_scan_buffers = 100,
                  import_all_select_source = false,
                  always_organize_imports = true,
                  eslint_enable_diagnostics = true,
                  complete_parens = true,
                  eslint_enable_code_actions = true,
                  enable_formatting = true,
                  formatter = 'prettier',
                  eslint_bin = 'eslint_d',
                })
                ts_utils.setup_client(client)

                local opts = { silent = true }
                vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gs', ':TSLspOrganize<CR>', opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', ':TSLspRenameFile<CR>', opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', 'go', ':TSLspImportAll<CR>', opts)

                -- Auto format on save
                vim.api.nvim_create_autocmd("BufWritePre", {
                  buffer = bufnr,
                  callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr })
                    ts_utils.organize_imports_sync()
                  end,
                })
              end,
            })
          end
        },
        automatic_installation = true,
      })
    end
  }
}
