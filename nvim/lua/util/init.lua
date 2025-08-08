local M = {}

function M.is_windows()
  return vim.uv.os_uname().sysname:find('Windows') ~= nil
end

function M.get_plugin(name)
  return require('lazy.core.config').spec.plugins[name]
end

function M.opts(name)
  local plugin = M.get_plugin(name)
  if not plugin then return {} end
  local p = require('lazy.core.plugin')
  return p.values(plugin, "opts", false)
end

function M.is_loaded(name)
  local cfg = require('lazy.core.config')
  return cfg.plugins[name] and cfg.plugins[name]._.loaded
end

return M
