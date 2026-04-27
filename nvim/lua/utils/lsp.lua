local M = {}

---@param cb fun(client: vim.lsp.Client, bufnr: integer): nil
---@return nil
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
