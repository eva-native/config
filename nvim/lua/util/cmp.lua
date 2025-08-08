local M = {}

M.actions = {
  snippet_forward = function()
    if vim.snippet.active({ direction = 1 }) then
      vim.schedule(function ()
        vim.snippet.jump(1)
      end)
    end
  end,
  snippet_stop = function ()
    if vim.snippet then
      vim.snippet.stop()
    end
  end
}

function M.map(actions, fallback)
  return function ()
    for _, name in ipairs(actions) do
      if M.actions[name] and M.actions[name]() then
        return true;
      end
    end
    return type(fallback) == 'function' and fallback() or fallback
  end
end

return M
