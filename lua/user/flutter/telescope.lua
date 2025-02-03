local M = {}
local devices = require('user.flutter.devices')

function M.picker()
  local c_devices = devices.get_devices();

  if vim.tbl_isempty(c_devices) then
    vim.notify("No devices cached! Fetching devices...")
    devices.fetch(M.picker)
    return
  end

  local entries = {}
  for _, device in ipairs(c_devices) do
    table.insert(entries, {
      value = device.id,
      display = string.format("%s (%s)%s",
        device.name,
        device.targetPlatform,
        device.emulator and " [emulator]" or ""
      ),
      ordinal = device.name,
      device = device
    })
  end

  local mappings = function(prompt_bufnr, map)
    map('i', '<CR>', function()
      local selection = require('telescope.actions.state').get_selected_entry()
      require('telescope.actions').close(prompt_bufnr)
      vim.schedule(function()
        vim.cmd("FlutterRun -d " .. selection.value)
      end)
    end)

    map('i', '<C-r>', function()
      devices.fetch(function()
        require('telescope.actions')._close(prompt_bufnr, true)
        vim.schedule(M.picker)
      end)
    end)

    return true
  end


  require('telescope.pickers').new({
    prompt_title = 'Flutter Devices',
    finder = require('telescope.finders').new_table({
      results = entries,
      entry_maker = function(entry) return entry end
    }),
    sorter = require('telescope.config').values.generic_sorter({}),
    attach_mappings = mappings,
  }):find()
end

return M
