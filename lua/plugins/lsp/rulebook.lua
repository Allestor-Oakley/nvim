return {
    "chrisgrieser/nvim-rulebook",
    event = "LspAttach",
    keys = {
        { "<leader>lR",  "",                                                      desc = "+Rulebook" },
        { "<leader>lRi", function() require("rulebook").ignoreRule() end,         desc = "LSP: Rulebook Ignore" },
        { "<leader>lRl", function() require("rulebook").lookupRule() end,         desc = "LSP: Rulebook Lookup" },
        { "<leader>lRy", function() require("rulebook").yankDiagnosticCode() end, desc = "LSP: Rulebook Yank" },
        { "<leader>lRf", function() require("rulebook").suppressFormatter() end,  desc = "LSP: Rulebook Supress Format" },
    }
}
