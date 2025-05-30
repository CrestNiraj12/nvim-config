local M = {}
local devices = require('user.flutter.devices')
local actions = require('telescope.actions')

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
      display = string.format("%s (%s)[%s]",
        device.name,
        device.id,
        device.targetPlatform
      ),
      ordinal = device.name,
      device = device
    })
  end

  local mappings = function(prompt_bufnr, map)
    actions.select_default:replace(function()
      local selection = require('telescope.actions.state').get_selected_entry()
      actions.close(prompt_bufnr)
      vim.schedule(function()
        vim.cmd("FlutterRun -d " .. selection.value)
      end)
    end)

    map('n', '<C-r>', function()
      devices.fetch(function()
        require('telescope.actions').close(prompt_bufnr)
        vim.schedule(M.picker)
      end)
    end)

    return true
  end


  require('telescope.pickers').new({}, {
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
