return {
    adapters = function(callback, _) -- _ = config
        local cmd = "C:/Users/Redbeard/AppData/Local/nvim-data/mason/packages/codelldb/extension/adapter/codelldb"
        local tcp = vim.loop.new_tcp()
        tcp:bind('127.0.0.1', 0)
        local port = tcp:getsockname().port
        tcp:shutdown()
        tcp:close()

        -- Start codelldb with the port
        local stdout = vim.loop.new_pipe(false)
        local stderr = vim.loop.new_pipe(false)
        local opts = {
            stdio = {nil, stdout, stderr},
            args = {'--port', tostring(port)},
        }
        local handle
        local pid_or_err
        handle, pid_or_err = vim.loop.spawn(cmd, opts, function(code)
            stdout:close()
            stderr:close()
            handle:close()
            if code ~= 0 then
                print("codelldb exited with code", code)
            end
        end)
        if not handle then
            vim.notify("Error running codelldb: " .. tostring(pid_or_err), vim.log.levels.ERROR)
            stdout:close()
            stderr:close()
            return
        end
        vim.notify('codelldb started.' .. pid_or_err)
        stderr:read_start(function(err, chunk)
            assert(not err, err)
            if chunk then
                vim.schedule(function()
                    require("dap.repl").append(chunk)
                end)
            end
        end)
        -- Wait for delve to start
        vim.defer_fn(
            function()
                callback({type = "server", host = "127.0.0.1", port = port})
            end,
            500
        )
    end,
    configurations = {
        {
            type = "c",
            name = "Launch file",
            request = "launch",
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
        },

    }

}
