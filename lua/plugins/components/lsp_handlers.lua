local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true

local function lsp_keymaps(bufnr)
	local keymap = function(keys, action, desc)
		vim.api.nvim_buf_set_keymap(bufnr, "n", keys, action, { noremap = true, silent = true, desc = "LSP: " .. desc })
	end
	-- for consistency
	keymap("<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", "LSP Rename")
	-- default mapping
	keymap("<leader>gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", "Get [D]eclaration")
	keymap("<leader>k", "<cmd>lua vim.lsp.buf.hover({ border = 'rounded' })<CR>", "Hover information")
	keymap("<leader>li", "<cmd>lua vim.lsp.buf.implementation()<CR>", "Get [I]mplementation")
	keymap("<leader>ll", "<cmd>lua vim.diagnostic.open_float()<CR>", "Open diagnostic f[l]oat")
	keymap("<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", "[F]ormat")
	keymap("<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", "Go to next")
	keymap("<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", "Go to prev")
	keymap("<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", "LSP [r]ename")
	keymap("<leader>ls", "<cmd>lua vim.lsp.buf.signature_help({ border = 'rounded' })<CR>", "LSP [s]ignature")
	keymap("<leader>lt", "<cmd>LspRestart<CR>", "LSP Res[t]art")
	-- Telescope
	keymap("<leader>gd", ":Telescope lsp_definitions<CR>", "Go to [d]efinition")
	keymap("<leader>gr", ":Telescope lsp_references<CR>", "Go to [r]eference")
end

local function breadcrumbs(client, bufnr)
	if client.server_capabilities.documentSymbolProvider then
		if client.name == "vue_ls" then
			return
		end
		local navic = require("nvim-navic")
		navic.attach(client, bufnr)
		vim.o.winbar = "%{%v:lua.Navic_FilePath()%}%{%v:lua.require'nvim-navic'.get_location()%}"
	end
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local function autoformat_onsave(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ async = false })
			end,
		})
	end
end

M.on_attach = function(client, bufnr)
	lsp_keymaps(bufnr)
	breadcrumbs(client, bufnr)
	autoformat_onsave(client, bufnr)
end

M.setup = function()
	local config = {
		virtual_text = true,
		signs = {
			active = true,
			text = {
				[vim.diagnostic.severity.ERROR] = "",
				[vim.diagnostic.severity.WARN] = "",
				[vim.diagnostic.severity.INFO] = "",
				[vim.diagnostic.severity.HINT] = "󰌶",
			},
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)
end

return M
