local dap = require('dap')

dap.adapters.python = function(cb, config)
  if config.request == 'attach' then
    ---@diagnostic disable-next-line: undefined-field
    local port = (config.connect or config).port
    ---@diagnostic disable-next-line: undefined-field
    local host = (config.connect or config).host or '127.0.0.1'
    cb({
      type = 'server',
      port = assert(port, '`connect.port` is required for a python `attach` configuration'),
      host = host,
      options = {
        source_filetype = 'python',
      },
    })
  else
    cb({
      type = 'executable',
      command = 'python3',
      args = { '-m', 'debugpy.adapter' },
      options = {
        source_filetype = 'python',
      },
    })
  end
end

dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch',
    name = "Launch file",

    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    program = "${file}", -- This configuration will launch the current file if used.
    pythonPath = function()
      -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
      -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
      -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        return cwd .. '/venv/bin/python'
      elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        return cwd .. '/.venv/bin/python'
      else
        return '/usr/bin/python'
      end
    end,
  },
}

dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = '/usr/bin/gdb',
}

dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'cppdbg',
    request = 'launch',
    program = '${file}',
    cwd = '${workspaceFolder}',
    stopOnEntry = true,
    setupCommands = {
      {
        text = '-enable-pretty-printing',
        description = 'Enable pretty printing',
        ignoreFailures = false,
      },
    },
  },
}

dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = { '/home/uzxenvy/.local/opt/js-debug/src/dapDebugServer.js' },
}

dap.configurations.javascript = {
  {
    type = 'node2',
    request = 'launch',
    name = 'Launch file',
    program = '${file}',   -- Запуск текущего файла
    cwd = vim.fn.getcwd(), -- Текущая рабочая директория
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
}

dap.configurations.typescript = {
  {
    type = 'node2',
    request = 'launch',
    name = 'Launch file',
    program = '${file}',   -- Запуск текущего файла
    cwd = vim.fn.getcwd(), -- Текущая рабочая директория
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
    outFiles = { "${workspaceFolder}/dist/**/*.js" } -- Для TypeScript: путь до скомпилированных файлов
  },
}

dap.configurations.javascriptreact = {
  {
    type = 'chrome',
    request = 'launch',
    name = 'Launch Chrome against localhost',
    url = 'http://localhost:3000',  -- Укажи URL локального сервера
    webRoot = '${workspaceFolder}',
  },
}

dap.configurations.typescriptreact = {
  {
    type = 'chrome',
    request = 'launch',
    name = 'Launch Chrome against localhost',
    url = 'http://localhost:3000',
    webRoot = '${workspaceFolder}',
    sourceMaps = true,
    resolveSourceMapLocations = {
      "${workspaceFolder}/dist/**/*.js",
      "${workspaceFolder}/**",
      "!**/node_modules/**"
    }
  },
}

require('keymaps.dap')
