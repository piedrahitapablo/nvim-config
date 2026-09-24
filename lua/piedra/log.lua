local M = {}

function M.prune_lsp()
    local path = vim.fn.stdpath("state") .. "/lsp.log"
    local stat = vim.uv.fs_stat(path)
    if stat == nil then
        return
    end

    local source = io.open(path, "rb")
    if source == nil then
        return
    end

    local max_size = 50 * 1024 * 1024
    if stat.size > max_size then
        source:seek("set", stat.size - max_size)
        source:read("*l")
    end

    local temp_path = path .. ".tmp"
    local target = io.open(temp_path, "wb")
    if target == nil then
        source:close()
        return
    end

    local cutoff = os.date("%Y-%m-%d", os.time() - 7 * 24 * 60 * 60)
    for line in source:lines() do
        local date = line:match("^%[[A-Z]+%]%[(%d%d%d%d%-%d%d%-%d%d)")
        if date == nil or date >= cutoff then
            target:write(line, "\n")
        end
    end

    source:close()
    target:close()
    os.rename(temp_path, path)
end

return M
