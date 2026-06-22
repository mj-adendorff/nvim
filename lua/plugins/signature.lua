return {
	"ray-x/lsp_signature.nvim",
	event = "LspAttach",
	opts = {
		bind = true,
		handler_opts = {
			border = "rounded",
		},
		hint_enable = true,
		hint_prefix = " ",
		hint_scheme = "Comment",
		hi_parameter = "LspSignatureActiveParameter",
		max_height = 12,
		max_width = 80,
		wrap = true,
		floating_window = true,
		floating_window_above_cur_line = true,
		toggle_key = "<C-s>",
		toggle_key_flip_floatwin_setting = true,
	},
}
