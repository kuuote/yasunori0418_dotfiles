local M = {}

---@param items table[] DduItem[]
---@param index number
---@return boolean
local function is_dummy(items, index)
    return items[index] and items[index].__sourceName == "dummy"
end

---@param dir number
function M.move_ignore_dummy(dir)
    local items = vim.fn["ddu#ui#get_items"]()
    local index = vim.fn.line(".") + dir

    while is_dummy(items, index) do
        index = index + dir
    end
    if 1 <= index and index <= #items then
        vim.cmd("normal! " .. index .. "gg")
    end
end

---ddu-ui-ff startFilter using input function.
---@param options table # :h ddu-options
---@param after_filter_flag? boolean # Open filter window after `Ddu:uiReady`. default: `false`
---@param completion? # :h command-completion | default: nil
---| "arglist"
---| "augroup"
---| "buffer"
---| "behave"
---| "color"
---| "command"
---| "compiler"
---| "cscope"
---| "dir"
---| "environment"
---| "event"
---| "expression"
---| "file"
---| "file_in_path"
---| "filetype"
---| "function"
---| "help"
---| "highlight"
---| "history"
---| "locale"
---| "mapclear"
---| "mapping"
---| "menu"
---| "messages"
---| "option"
---| "packadd"
---| "shellcmd"
---| "sign"
---| "syntax"
---| "syntime"
---| "tag"
---| "tag_listfiles"
---| "user"
---| "var"
---| nil
function M.start_input_filter(options, after_filter_flag, completion)
    after_filter_flag = after_filter_flag or false
    completion = completion or nil
    if completion then
        options.input = vim.fn.input("Pattern: ", "", completion)
    else
        options.input = vim.fn.input("Pattern: ", "")
    end
    if after_filter_flag then
        vim.api.nvim_create_autocmd("User", {
            pattern = "Ddu:uiReady",
            callback = function()
                vim.fn.timer_start(5, vim.fn["ddu#ui#do_action"]("openFilterWindow"))
            end,
            once = true,
        })
    end
    vim.fn["ddu#start"](options)
end

return M
