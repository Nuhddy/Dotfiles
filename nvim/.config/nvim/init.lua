local impatient_ok, impatient = pcall(require, "impatient")
if impatient_ok then impatient.enable_profile() end

if not vim.g.vscode then
    for _, source in ipairs {
        "options",
        "autocmds",
        "mappings",
        "plugins",
    } do
        source = "core." .. source
        local status_ok, fault = pcall(require, source)
        if not status_ok then
            vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. fault)
        end
    end
end
