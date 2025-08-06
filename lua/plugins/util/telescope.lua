local function tel_conf()
    local actions = require("telescope.actions")
    require('telescope').setup({
        defaults = {
            layout_config = {
                prompt_position = "top",
                height = vim.g.flsize + 0.055,
                width = vim.g.flsize + 0.01,
            },
            sorting_strategy = "ascending",
            file_ignore_patterns = { "node_modules" },
            mappings = {
                i = {
                    ["<A-k>"] = actions.move_selection_previous,
                    ["<A-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.preview_scrolling_up,
                    ["<C-j>"] = actions.preview_scrolling_down,
                    ["<Esc>"] = actions.close
                }
            },
        },
        extensions = {
            fzf = {}
        },
        pickers = {
            live_grep = {
                additional_args = function(_)
                    return { "--no-require-git" }
                end
            },
        },
    })

    require('telescope').load_extension('fzf')
    require('telescope').load_extension('undo')
    require('telescope').load_extension('possession')
    require("telescope").load_extension('notify')
end

local keymap = require("plugins.components.gen_keymap")("Telescope")

local function find_replace_mapping(_, map)
    map("i", "<s-cr>", function(_prompt_bufnr)
        local actions = require("telescope.actions")
        actions.send_selected_to_qflist(_prompt_bufnr)
        vim.cmd.copen()

        local actions_state = require("telescope.actions.state")
        local sr_prompt = ":cdo s/" ..
            actions_state.get_current_line() .. "//g|update|cclose" .. string.rep("<left>", 16)
        vim.api.nvim_feedkeys(
            vim.api.nvim_replace_termcodes(sr_prompt, true, true, true),
            "n",
            true
        )
    end)
    return true
end

return {
    'nvim-telescope/telescope.nvim',
    version = '0.1.8',
    dependencies = {
        'nvim-lua/plenary.nvim',
        "debugloop/telescope-undo.nvim",
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build =
            'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release -DCMAKE_POLICY_VERSION_MINIMUM=3.5 && cmake --build build --config Release && cmake --install build --prefix build'
        },
        'jedrzejboczar/possession.nvim',
        'rcarriga/nvim-notify',
    },
    cmd = { "Telescope" },
    keys = {
        -- For function keys
        keymap('<F1>', function()
            require("telescope.builtin").help_tags({
                previewer = false,
                layout_config = {
                    width = 0.2,
                    height = 0.3,
                    anchor = "NE"
                }
            })
        end, "Help"),
        keymap('<F3>', function()
            require("telescope.builtin").live_grep({
                prompt_title = "Find (<CR>) & Replace (<S-CR>)",
                results_title = "Results (<Tab> to select)",
                previewer = true,
                layout_strategy = "vertical",
                layout_config = {
                    prompt_position = "top",
                    width = 0.2,
                    height = 0.4,
                    anchor = "NE",
                    preview_height = 0.2
                },
                attach_mappings = find_replace_mapping
            })
        end, "Search"),
        -- Default mapping
        keymap('<leader>ff', function(opts)
            opts = opts or {}
            -- we only want to do it if we have a gitignore and no .git dir
            if vim.fn.filereadable(".gitignore") == 1 and vim.fn.isdirectory(".git/") == 0 then
                opts.find_command = { "rg", "--files", "--ignore-file", ".gitignore" }
                vim.cmd("Telescope find_files find_command=" .. table.concat(opts.find_command, ","))
            else
                vim.cmd("Telescope find_files")
            end
        end, "Find [F]iles"),
        keymap('<leader>ft', ":Telescope<cr>", "[T]elescope"),
        keymap('<leader>fg', function()
            require("telescope.builtin").live_grep({
                prompt_title = "Find (<CR>) & Replace (<S-CR>)",
                results_title = "Results (<Tab> to select)",
                attach_mappings = find_replace_mapping
            })
        end, "Live [G]rep"),
        keymap('<leader>fm', ":Telescope keymaps<cr>", "Key[m]aps"),
        keymap('<leader>fu', ":Telescope undo<cr>", "[U]ndo "),
        keymap('<leader>fs', ":Telescope lsp_document_symbols<cr>", "LSP [S]ymbol"),
        keymap("<leader>fp", ":Telescope possession list<cr>", "[P]ossession"),
        keymap("<leader>fn", ":Telescope notify<cr>", "[N]otifications"),
    },
    config = tel_conf,
}
