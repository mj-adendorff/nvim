return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"rcarriga/nvim-dap-ui",
			"mfussenegger/nvim-dap-python",
			"jay-babu/mason-nvim-dap.nvim",
			"theHamsta/nvim-dap-virtual-text",
		},
		enabled = true,
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			local dap_python = require("dap-python")
			local mason_dap = require("mason-nvim-dap")
			local virtual_text = require("nvim-dap-virtual-text")

			mason_dap.setup({
				ensure_installed = { "cppdbg", "debugpy", "codelldb" },
				automatic_installation = true,
				handlers = {
					function(config)
						require("mason-nvim-dap").default_setup(config)
					end,
				},
			})

			dap.configurations = {
				c = {
					{
						{
							name = "Launch file",
							type = "cppdbg",
							request = "launch",
							program = function()
								return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
							end,
							cwd = "${workspaceFolder}",
							stopAtEntry = false,
							MIMode = "lldb",
						},
					},
				},
				python = {
					{
						type = "python",
						request = "launch",
						name = "Launch with emulators",
						program = "${file}",
						console = "integratedTerminal",
						env = {
							DATASTORE_DATASET = "quicklysign-python3-dev",
							DATASTORE_EMULATOR_HOST = "localhost:8081",
							DATASTORE_EMULATOR_HOST_PATH = "localhost:8081/datastore",
							DATASTORE_HOST = "http://localhost:8081",
							DATASTORE_PROJECT_ID = "quicklysign-python3-dev",
						},
					},
				},
			}

			table.insert(dap.configurations.python, {})

			virtual_text.setup({
				commented = true, -- Show virtual text alongside comment
			})

			dap_python.setup("python")

			dapui.setup({
				controls = {
					enabled = true,
					element = "console",
					icons = {
						pause = "",
						play = "",
						step_into = "",
						step_over = "",
						step_out = "",
						step_back = "",
						run_last = "",
						terminate = "",
					},
				},
				layouts = {
					-- Vertical bar.
					{
						elements = {
							{
								id = "watches",
								size = 0.1,
							},
							{
								id = "stacks",
								size = 0.2,
							},
							{
								id = "breakpoints",
								size = 0.2,
							},
							{
								id = "scopes",
								size = 0.5,
							},
						},
						size = 0.15,
						position = "left",
					},
					-- Horizontal bar.
					{
						elements = {
							"console",
						},
						size = 0.2,
						position = "bottom",
					},
				},
			})

			dap_python.test_runner = "pytest"

			vim.fn.sign_define("DapBreakpoint", {
				text = "",
				texthl = "DiagnosticSignError",
				linehl = "",
				numhl = "",
			})

			vim.fn.sign_define("DapBreakpointRejected", {
				text = "", -- or "❌"
				texthl = "DiagnosticSignError",
				linehl = "",
				numhl = "",
			})

			vim.fn.sign_define("DapStopped", {
				text = "", -- or "→"
				texthl = "DiagnosticSignWarn",
				linehl = "Visual",
				numhl = "DiagnosticSignWarn",
			})

			-- Automatically open/close DAP UI
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end

			local opts = { noremap = true, silent = true }

			-- Toggle breakpoint
			vim.keymap.set("n", "<leader>db", function()
				dap.toggle_breakpoint()
			end, opts)

			-- test
			vim.keymap.set("n", "<leader>dt", function()
				dap_python.test_method()
			end, opts)

			-- Continue / Start
			vim.keymap.set("n", "<leader>dc", function()
				dap.continue()
			end, opts)

			-- Step Over
			vim.keymap.set("n", "<leader>do", function()
				dap.step_over()
			end, opts)

			-- Step Into
			vim.keymap.set("n", "<leader>di", function()
				dap.step_into()
			end, opts)

			-- Step Out
			vim.keymap.set("n", "<leader>dO", function()
				dap.step_out()
			end, opts)

			-- Keymap to terminate debugging
			vim.keymap.set("n", "<leader>dq", function()
				require("dap").terminate()
			end, opts)

			-- Toggle DAP UI
			vim.keymap.set("n", "<leader>du", function()
				dapui.toggle()
			end, opts)
		end,
	},
}
