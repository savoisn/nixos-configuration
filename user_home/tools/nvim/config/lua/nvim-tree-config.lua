require 'nvim-tree'.setup {
    disable_netrw       = true,
    hijack_netrw        = true,
    -- open_on_setup       = false,
    --ignore_ft_on_setup  = {},

    hijack_directories  = {
        enable = true,
        auto_open = true,
    },
    git                 = {
        enable = true,
        ignore = false,
        show_on_dirs = true,
        show_on_open_dirs = true,
        disable_for_dirs = {},
        timeout = 400,
    },
    open_on_tab         = false,
    hijack_cursor       = false,
    update_cwd          = false,
    diagnostics         = {
        enable = true,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        }
    },
    update_focused_file = {
        enable      = false,
        update_cwd  = false,
        ignore_list = {}
    },
    system_open         = {
        cmd  = nil,
        args = {}
    },
    view                = {
        width = 25,
        side = 'left'
    },
    actions             = {
        open_file = {
            resize_window = true
        }
    }
}

require('legendary').keymaps({
    { '<leader>tt', ':NvimTreeToggle<cr>',   opts = { silent = true }, description = 'Nvim Tree: Toggle' },
    { '<leader>tr', ':NvimTreeRefresh<cr>',  opts = { silent = true }, description = 'Nvim Tree: Refresh' },
    { '<leader>tf', ':NvimTreeFindFile<cr>', opts = { silent = true }, description = 'Nvim Tree: Find file' }
})
