return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			vim.keymap.set("n", "<leader>e", ":Neotree focus<CR>", { desc = "Focus Neo-tree" })
			vim.keymap.set("n", "<leader>ge", ":Neotree git_status<CR>", { desc = "Neo-tree git status" })
			vim.keymap.set("n", "<leader>be", ":Neotree buffers<CR>", { desc = "Neo-tree buffers" })

			require("neo-tree").setup({
				close_if_last_window = true,
				popup_border_style = "rounded",
				enable_git_status = true,
				enable_diagnostics = true,
				use_popups_for_input = false,
				use_default_mappings = false,
				enable_cursor_hijack = true,
				use_libuv_file_watcher = true,
				sources = { "filesystem", "buffers", "git_status" },
				default_component_configs = {
					indent = {
						with_markers = true,
						indent_size = 2,
						padding = 1,
					},
					icon = {
						folder_closed = "",
						folder_open = "",
						folder_empty = "",
					},
					git_status = {
						symbols = {
							added = "✚",
							modified = "",
							deleted = "✖",
							renamed = "➜",
							untracked = "★",
							ignored = "◌",
							unstaged = "✗",
							staged = "✓",
							conflict = "",
						},
					},
				},
				window = {
					position = "float",
					width = 50,
					height = 20,
					popup = {
						position = { col = "50%", row = "50%" },
						size = {
							width = "50%",
							height = "80%",
						},
					},
					mappings = {
						["<space>"] = "toggle_node",
						["<cr>"] = "open",
						["S"] = "split_with_window_picker",
						["V"] = "vsplit_with_window_picker",
						["t"] = "open_tabnew",
						["C"] = "close_node",
						["a"] = {
							"add",
							config = {
								show_path = "relative", -- "none", "relative", "absolute"
							},
						},
						["d"] = "delete",
						["r"] = "rename",
						["c"] = "copy",
						["m"] = "move",
						["q"] = "close_window",
						["p"] = {
							"toggle_preview",
							config = { use_float = true },
						},
						["o"] = {
							"show_help",
							nowait = false,
							config = { title = "Order by", prefix_key = "o" },
						},
						["oc"] = { "order_by_created", nowait = false },
						["od"] = { "order_by_diagnostics", nowait = false },
						["og"] = { "order_by_git_status", nowait = false },
						["om"] = { "order_by_modified", nowait = false },
						["on"] = { "order_by_name", nowait = false },
						["os"] = { "order_by_size", nowait = false },
						["ot"] = { "order_by_type", nowait = false },
					},
				},
				filesystem = {
					filtered_items = {
						visible = false,
						hide_dotfiles = true,
						hide_gitignored = true,
						never_show = { ".DS_Store", "thumbs.db" },
					},
					use_libuv_file_watcher = true,
					follow_current_file = {
						enabled = true,
					},
					window = {
						mappings = {
							["H"] = "toggle_hidden",
						},
					},
				},
				buffers = {
					follow_current_file = {
						enabled = true,
					},
					window = {
						mappings = {
							["x"] = "buffer_delete",
						},
					},
				},
			})
		end,
	},
}
