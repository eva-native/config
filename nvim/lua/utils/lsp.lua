local M = {}

---@param cb function
function M.on_attach(cb)
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function (args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client then
        cb(client, args.buf)
      end
    end
  })
end

return M
