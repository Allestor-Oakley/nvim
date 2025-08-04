local neotree_opts = {
    sources = {
        "filesystem",
        "git_status",
        "document_symbols"
    },
    source_selector = {
        winbar = true,
        sources = {
            {
                source = "filesystem",
                display_name = " 󰉓 Files"
            },
            {
                source = "git_status",
                display_name = " 󰊢 Git"
            },
            {
                source = "document_symbols",
                display_name = "  Symb"
            },
        },
        highlight_tab = "NeoTreeDotfile",
        highlight_background = "NeoTreeDotfile",
        highlight_separator = "NeoTreeDotfile",
    },
    open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "edgy" },
    default_component_configs = {
        indent = {
            padding = 0,
            expander_highlight = "NeoTreeNormal",
        },
        icon = {
            folder_empty = "",
            folder_empty_open = "",
        },
        git_status = {
            symbols = {
                added     = "",
                modified  = "",
                deleted   = "",
                renamed   = "󰁕",
                -- Status type
                untracked = "",
                ignored   = "󱋭",
                unstaged  = "󰄗",
                staged    = "󰄵",
                conflict  = "",
            },
        },
    },
    filesystem = {
        window = {
            mappings = {
                ["z"] = "expand_all_nodes",
                ["Z"] = "close_all_nodes",
            }
        }
    },
    document_symbols = {
        window = {
            mappings = {
                ["z"] = "expand_all_nodes",
                ["Z"] = "close_all_nodes",
            }
        },
        kinds = {
            File = { icon = "󰈙", hl = "Tag" },
            Namespace = { icon = "󰌗", hl = "Include" },
            Package = { icon = "󰏖", hl = "Label" },
            Class = { icon = "󰌗", hl = "Include" },
            Property = { icon = "󰆧", hl = "@property" },
            Enum = { icon = "󰒻", hl = "@number" },
            Function = { icon = "󰊕", hl = "Function" },
            String = { icon = "󰀬", hl = "String" },
            Number = { icon = "󰎠", hl = "Number" },
            Array = { icon = "󰅪", hl = "Type" },
            Object = { icon = "󰅩", hl = "Type" },
            Key = { icon = "󰌋", hl = "" },
            Struct = { icon = "󰌗", hl = "Type" },
            Operator = { icon = "󰆕", hl = "Operator" },
            TypeParameter = { icon = "󰊄", hl = "Type" },
            StaticMethod = { icon = '󰠄 ', hl = 'Function' },
        }
    },
    window = {
        position = "left",
        width = vim.g.vspsize,
        mappings = {
            ["e"] = "toggle_node",
            ["/"] = "noop",
            ["<F2>"] = "rename",
        }
    }
}

return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    cmd = { 'Neotree' },
    keys = {
        { "<leader>e", ":Neotree toggle<cr><C-w>=", desc = "Neotree: Toggle", silent = true }
    },
    opts = neotree_opts,
    config = function(_, opts)
        vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

        local M = require("neo-tree")
        M.escape_path = function(path)
            local escaped_path = vim.fn.fnameescape(path)
            if M.is_windows then
                escaped_path = escaped_path:gsub("\\", "/")
            end
            return escaped_path
        end

        require("neo-tree").setup(opts)
    end
}
