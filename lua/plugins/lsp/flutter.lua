local flutter = {}
local isInitialized = false
local devicesFetched = false

flutter.setup = function()
  local devices = require('user.flutter.devices')
  if (not isInitialized) then
    vim.api.nvim_create_autocmd("LspAttach", {
      pattern = "*.dart",
      callback = function(event)
        local buf = event.buf
        if not devicesFetched then
          devices.fetch(function()
            devicesFetched = true
            vim.notify("Devices fetched!")
          end)
        end
        vim.api.nvim_create_user_command('FlutterDevices', function()
          if vim.tbl_isempty(devices.get_devices()) then
            devices.fetch(function()
              vim.notify("Devices refreshed!\n" .. vim.inspect(devices.get_devices()))
            end)
          else
            print(vim.inspect(devices.get_devices()))
          end
        end, { desc = "Show cached Flutter devices" })
        local flutter_telescope = require('user.flutter.telescope')
        vim.keymap.set('n', '<leader>d', flutter_telescope.picker, {
          buffer = buf,
          desc = "Select Flutter device"
        })
        vim.keymap.set('n', '<leader>fR', function()
          vim.notify("Refreshing devices!")
          devices.fetch(function()
            vim.notify("Devices refreshed!")
          end)
        end, { buffer = buf, desc = "Refresh Flutter devices" })
        isInitialized = true
      end
    })
  end
end

return flutter

