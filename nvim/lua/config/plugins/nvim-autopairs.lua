local npairs_ok, cmp_autopairs = pcall(require, 'nvim-autopairs.completion.cmp')
if not npairs_ok then
  vim.notify('error')
  return
end

local cmp_ok, cmp = pcall(require, 'cmp')
if not cmp_ok then
  vim.notify('error')
  return
end

cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
