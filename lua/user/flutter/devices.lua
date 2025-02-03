local M = {
  is_fetching = false,
}

M.cached_devices = {}

function M.fetch(callback)
  if (M.is_fetching) then
    vim.notify('Devices are being fetched. Please wait.')
    return
  end

  M.is_fetching = true
  vim.system({ 'flutter', 'devices', '--machine' }, { text = true }, function(obj)
    if obj.code == 0 then
      local ok, devices = pcall(vim.json.decode, obj.stdout)
      if ok then
        M.cached_devices = devices or {}
        if callback then callback(devices) end
      end
    end
    M.is_fetching = false
  end)
end

function M.get_devices()
  return M.cached_devices
end

return M
