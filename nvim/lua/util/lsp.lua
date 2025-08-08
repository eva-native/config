local M = {}

M._supports_method = {}

function M._check_methods(client, bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) then return end
  if not vim.bo[bufnr].buflisted then return end
  if vim.bo[bufnr].buftype == 'nofile' then return end

  for m, c in pairs(M._supports_method) do
    c[client] = c[client] or {}
    if not c[client][bufnr] then
      if client.supports_method and client.supports_method(m, { bufnr = bufnr }) then
        c[client][bufnr] = true
        vim.api.nvim_exec_autocmds('User', {
          pattern = 'LspSupportsMethod',
          data = { client_id = client.id, bufnr = bufnr, method = m }
        })
      end
    end
  end
end

function M.setup()
  M.on_attach(M._check_methods)
end

function M.on_supports_method(method, callback)
  M._supports_method[method] = M._supports_method[method] or setmetatable({}, { __mode = 'k' })
  return vim.api.nvim_create_autocmd('User', {
    pattern = 'LspSupportsMethod',
    callback = function (args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      local bufnr = args.data.bufnr
      if client and method == args.data.method then
        return callback(client, bufnr)
      end
    end
  })
end

function M.on_attach(callback)
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function (args)
      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client then
        callback(client, bufnr)
      end
    end
  })
end

return M
