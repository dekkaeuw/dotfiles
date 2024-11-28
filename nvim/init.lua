-- hello worldHelper function to safely load Lua modules
local function safe_require(module)
    local ok, err = pcall(require, module)
    if not ok then
        vim.notify("Error loading module: " .. module .. "\n" .. err, vim.log.levels.ERROR)
    end
end

-- Load the main dekka module
safe_require("dekka")

-- Function to load all Lua files from a directory
local function load_lua_files_from_dir(dir)
    local path = vim.fn.stdpath("config") .. "/" .. dir
    local files = vim.fn.glob(path .. "/*.lua", false, true)
    for _, file in ipairs(files) do
        dofile(file)
    end
end

-- Load all files in the after/plugin directory
load_lua_files_from_dir("after/plugin")
print("goodwork?!")
