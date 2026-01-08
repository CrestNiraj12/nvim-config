local lsp_keymaps = {}

lsp_keymaps.setup = function()
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
      local opts = { buffer = event.buf }

      -- Basic LSP mappings
      vim.keymap.set('n', '<leader>.', function() vim.lsp.buf.code_action() end, opts)
      vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
      vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
      vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
      vim.keymap.set('n', '<leader>e', function() vim.diagnostic.open_float() end, opts)
      vim.keymap.set('n', '[d', function()
        vim.diagnostic.jump({ count = -1 })
      end, opts)

      vim.keymap.set('n', ']d', function()
        vim.diagnostic.jump({ count = 1 })
      end, opts)
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
          vim.wait(100)
          return
        end

        -- FORMAT with LSP (sync)
        vim.lsp.buf.format({ async = false })

        -- ORGANIZE IMPORTS via LSP codeAction (correct param shape: range + context)
        local bufnr = vim.api.nvim_get_current_buf()
        local clients = vim.lsp.get_clients({ bufnr = bufnr, method = "textDocument/codeAction" })
        if #clients == 0 then return end

        local win = vim.api.nvim_get_current_win()
        local encoding = clients[1].offset_encoding or 'utf-16'

        -- make_range_params expects (win, offset_encoding)
        local range_params = vim.lsp.util.make_range_params(win, encoding)

        -- Build CodeActionParams explicitly to avoid LuaLS "inject-field" warning
        local params = {
          textDocument = range_params.textDocument,
          range = range_params.range,
          context = { diagnostics = vim.diagnostic.get(bufnr) },
        }

        local results = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params)
        if not results then return end

        for _, res in pairs(results) do
          for _, action in pairs(res.result or {}) do
            if action.kind == "source.organizeImports" then
              vim.lsp.buf.code_action({
                apply = true,
                context = { diagnostics = {}, only = { "source.organizeImports" } },
              })
              vim.wait(100)
              return
            end
          end
        end
      end

      local function organize_and_format()
        format_and_organize_imports(vim.bo.filetype)
      end

      vim.keymap.set('n', '<C-s>', organize_and_format, { buffer = event.buf, desc = 'Format and Organize Imports' })

      vim.api.nvim_create_autocmd('BufWritePre', {
        callback = organize_and_format,
        buffer = event.buf,
      })
    end
  })
end

return lsp_keymaps
