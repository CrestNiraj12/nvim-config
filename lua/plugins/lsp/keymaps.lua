local lsp_keymaps = {}

lsp_keymaps.setup = function()
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
      local opts = { buffer = event.buf }
      vim.keymap.set('n', '<leader>.', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
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
      vim.keymap.set({ 'n', 'x' }, '<leader>f', '<cmd>ALEFix<cr>', opts)

      local ts_js_ft = {
        typescript = true,
        typescriptreact = true,
        javascript = true,
        javascriptreact = true,
      }

      local function format_and_organize_imports(filetype)
        if ts_js_ft[filetype] then
          vim.cmd("TSToolsOrganizeImports")
          vim.wait(100)
          return
        end

        -- FORMAT
        vim.lsp.buf.format({ async = false })

        local bufnr = vim.api.nvim_get_current_buf()
        local clients = vim.lsp.get_clients({ bufnr = bufnr, method = "textDocument/codeAction" })
        if #clients == 0 then return end

        local win = vim.api.nvim_get_current_win()
        local params = opts.params or vim.lsp.util.make_position_params(win, clients[1].offset_encoding or 'utf-16')
        params.context = { diagnostics = vim.diagnostic.get(bufnr) }

        local results = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
        if not results then return end

        -- ORGANIZE IMPORTS
        for _, result in pairs(results) do
          for _, action in pairs(result.result or {}) do
            if action.kind == "source.organizeImports" then
              vim.lsp.buf.code_action({ context = { diagnostics = {}, only = { "source.organizeImports" } }, apply = true })
              vim.wait(100)
            end
          end
        end
      end

      local function organize_and_format()
        format_and_organize_imports(vim.bo.filetype)
      end

      vim.keymap.set('n', '<C-s>', organize_and_format, { desc = 'Format and Organize Imports' })
      vim.api.nvim_create_autocmd('BufWritePre', {
        callback = organize_and_format,
        buffer = event.buf
      })
    end
  })
end

return lsp_keymaps
