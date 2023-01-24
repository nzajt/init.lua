local fn = vim.fn

function run()
  local dir = fn.expand('<afile>:p:h')

  if fn.isdirectory(dir) == 0 then
    fn.mkdir(dir, 'p')
  end
end

vim.cmd([[
  augroup MkdirRun
  autocmd!
  autocmd BufWritePre * lua run()
  augroup END
]])
