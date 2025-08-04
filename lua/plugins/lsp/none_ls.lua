return {
	"nvimtools/none-ls.nvim",
	event = vim.g.open_file_evt,
	config = function()
		local null_ls_status_ok, null_ls = pcall(require, "null-ls")
		if not null_ls_status_ok then
			return
		end

		local formatting = null_ls.builtins.formatting

		null_ls.setup({
			debug = false,
			sources = {
				formatting.biome,
			},
		})
	end,
}
