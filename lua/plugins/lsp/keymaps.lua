local lsp_keymaps = {}

lsp_keymaps.setup = function()
  -- One augroup shared across buffers; we clear per-buffer to avoid duplicates
  local save_group = vim.api.nvim_create_augroup("LspOnSave", { clear = false })

  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
      local opts = { buffer = event.buf }

      -- Basic LSP mappings
      vim.keymap.set('n', '<leader>.', function() vim.lsp.buf.code_action() end, opts)
      vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
      vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
      vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
      vim.keymap.set('n', '<leader>e', function() vim.diagnostic.open_float() end, opts)
      vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1 }) end, opts)
      vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1 }) end, opts)
      vim.keymap.set('n', '<leader>dl', function() vim.diagnostic.setqflist() end, opts)
      vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
      vim.keymap.set('n', 'go', function() vim.lsp.buf.type_definition() end, opts)
      vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end, opts)
      vim.keymap.set('n', 'gs', function() vim.lsp.buf.signature_help() end, opts)
      vim.keymap.set('n', 'rn', function() vim.lsp.buf.rename() end, opts)

      -- Your existing ALE mapping
      vim.keymap.set({ 'n', 'x' }, '<leader>f', '<cmd>ALEFix<cr>', opts)

      local ts_js_ft = {
        typescript = true,
        typescriptreact = true,
        javascript = true,
        javascriptreact = true,
      }

      -- Languages that use ALE instead of LSP for formatting
      local ale_only_ft = {
        python = true,
      }

      local function format_and_organize_imports(filetype)
        -- Use ALEFix for ALE-dependent languages
        if ts_js_ft[filetype] or ale_only_ft[filetype] then
          vim.cmd("ALEFix")
          if ts_js_ft[filetype] then
            vim.cmd("TSToolsOrganizeImports")
          end
          return
        end

        local bufnr = vim.api.nvim_get_current_buf()

        -- FORMAT with LSP (sync, but capped so it can't freeze forever)
        vim.lsp.buf.format({
          bufnr = bufnr,
          async = false,
          timeout_ms = 300,
        })

        -- ORGANIZE IMPORTS via LSP codeAction (range + context)
        local clients = vim.lsp.get_clients({ bufnr = bufnr, method = "textDocument/codeAction" })
        if #clients == 0 then return end

        local win = vim.api.nvim_get_current_win()
        local encoding = clients[1].offset_encoding or 'utf-16'
        local range_params = vim.lsp.util.make_range_params(win, encoding)

        local params = {
          textDocument = range_params.textDocument,
          range = range_params.range,
          context = { diagnostics = vim.diagnostic.get(bufnr) },
        }

        local results = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, 200)
        if not results then return end

        for _, res in pairs(results) do
          for _, action in pairs(res.result or {}) do
            if action.kind == "source.organizeImports" then
              vim.lsp.buf.code_action({
                apply = true,
                context = { diagnostics = {}, only = { "source.organizeImports" } },
              })
              return
            end
          end
        end
      end

      local function organize_and_format()
        local ft = vim.bo.filetype
        local bufnr = vim.api.nvim_get_current_buf()

        -- Go: don't do codeAction imports on save; just format with gopls (with a real timeout)
        if ft == "go" then
          vim.lsp.buf.format({
            bufnr = bufnr,
            async = false,
            timeout_ms = 1500,
            filter = function(client) return client.name == "gopls" end,
          })
          return
        end

        -- Lua doesn't have "imports" like TS/Go; keep saves fast and simple.
        if ft == "lua" then
          vim.lsp.buf.format({
            bufnr = bufnr,
            async = false,
            timeout_ms = 200,
            filter = function(client) return client.name == "lua_ls" end,
          })
          return
        end

        format_and_organize_imports(ft)
      end

      vim.keymap.set('n', '<C-s>', organize_and_format, {
        buffer = event.buf,
        desc = 'Format and Organize Imports',
      })

      -- IMPORTANT: prevent duplicate autocmds per buffer
      vim.api.nvim_clear_autocmds({ group = save_group, buffer = event.buf })
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = save_group,
        callback = organize_and_format,
        buffer = event.buf,
      })
    end
  })
end

return lsp_keymaps
