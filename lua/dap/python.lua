-- python3 -m pip install debugpy
local venv = "virtualenvs"
local home = os.getenv "HOME"
return {
    adapters = {
        type = "executable",
        command = home .. string.format("/%s/debugpy/bin/python",venv),
        args = {"-m", "debugpy.adapter"}
    },
    configurations = {
        {
            type = "python",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            pythonPath = function()
                return '/usr/bin/python3'
            end
        }
    }
}
