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
		ft = { "python", "c", "cpp" },
		keys = {
			{ "<leader>db", desc = "Debug: Toggle breakpoint" },
			{ "<leader>dt", desc = "Debug: Run test method" },
			{ "<leader>dc", desc = "Debug: Continue/Start" },
			{ "<leader>do", desc = "Debug: Step over" },
			{ "<leader>di", desc = "Debug: Step into" },
			{ "<leader>dO", desc = "Debug: Step out" },
			{ "<leader>dq", desc = "Debug: Terminate" },
			{ "<leader>du", desc = "Debug: Toggle DAP UI" },
		},
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
							REDIS_HOST = "localhost",
							TASKS_EMULATOR_HOST = "localhost:8123",
							DATASTORE_DATASET = "quicklysign-python3-dev",
							DATASTORE_EMULATOR_HOST = "localhost:8081",
							DATASTORE_EMULATOR_HOST_PATH = "localhost:8081/datastore",
							DATASTORE_HOST = "http://localhost:8081",
							DATASTORE_PROJECT_ID = "quicklysign-python3-dev",
						},
					},
				},
			}

			virtual_text.setup({
				commented = true, -- Show virtual text alongside comment
			})

			-- Resolve the interpreter that runs the debuggee (e.g. main.py) to the
			-- project's poetry venv, since it lives outside the repo and won't be
			-- found by dap-python's default venv/.venv lookup.
			dap_python.resolve_python = function()
				local venv = vim.fn.trim(vim.fn.system("poetry env info --path"))
				if vim.v.shell_error == 0 and venv ~= "" then
					return venv .. "/bin/python"
				end
				return nil
			end

			-- Run the debugpy adapter via the interpreter mason installed it into,
			-- instead of bare "python" on $PATH (a pyenv shim with no debugpy
			-- installed) which would silently override the working adapter
			-- mason_dap just configured above.
			dap_python.setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python")

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
					-- [1] Vertical sidebar: only opened for real debug sessions.
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
						position = "right",
					},
					-- [2] Console: opened for both debug and test sessions.
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
			-- dap-python's test_method/test_class set config.module to the test
			-- runner name (pytest/unittest/django); plain launches use `program`
			-- instead and leave `module` nil, so this reliably tells tests apart
			-- from a normal debug session.
			local TEST_RUNNER_MODULES = { pytest = true, unittest = true, django = true }

			dap.listeners.after.event_initialized["dapui_config"] = function(session)
				local is_test = session.config.module and TEST_RUNNER_MODULES[session.config.module]
				if not is_test then
					dapui.open({ layout = 1 }) -- sidebar: scopes/breakpoints/stacks/watches
				end
				dapui.open({ layout = 2 }) -- console, always
			end

			local function opts(desc)
				return { noremap = true, silent = true, desc = desc }
			end

			-- Toggle breakpoint
			vim.keymap.set("n", "<leader>db", function()
				dap.toggle_breakpoint()
			end, opts("Debug: Toggle breakpoint"))

			-- test
			vim.keymap.set("n", "<leader>dt", function()
				dap_python.test_method()
			end, opts("Debug: Run test method"))

			-- Continue / Start
			vim.keymap.set("n", "<leader>dc", function()
				dap.continue()
			end, opts("Debug: Continue/Start"))

			-- Step Over
			vim.keymap.set("n", "<leader>do", function()
				dap.step_over()
			end, opts("Debug: Step over"))

			-- Step Into
			vim.keymap.set("n", "<leader>di", function()
				dap.step_into()
			end, opts("Debug: Step into"))

			-- Step Out
			vim.keymap.set("n", "<leader>dO", function()
				dap.step_out()
			end, opts("Debug: Step out"))

			-- Keymap to terminate debugging
			vim.keymap.set("n", "<leader>dq", function()
				require("dap").terminate()
			end, opts("Debug: Terminate"))

			-- Toggle DAP UI
			vim.keymap.set("n", "<leader>du", function()
				dapui.toggle()
			end, opts("Debug: Toggle DAP UI"))
		end,
	},
}
