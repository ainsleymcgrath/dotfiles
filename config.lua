-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "zenbones"
vim.cmd("set background=light")
vim.cmd("let g:python3_host_prog = expand('~/.config/nvim/neovim_venv/bin/python3')")

-- this lets jj work as escape
vim.cmd("set timeoutlen=300")

lvim.plugins = {
	{ "mcchrish/zenbones.nvim", requires = "rktjmp/lush.nvim" },
	{ "folke/trouble.nvim" },
	{ "ggandor/lightspeed.nvim" },
	{ "windwp/nvim-spectre" },
	{ "romgrk/nvim-treesitter-context" },
	{
		"ray-x/lsp_signature.nvim",
		event = "BufRead",
		config = function()
			require("lsp_signature").on_attach({ floating_window = false, bind = true })
		end,
	},
	{ "tpope/vim-repeat" },
	{ "tpope/vim-surround" },
	{ "metakirby5/codi.vim" },
	{
		"ibhagwan/fzf-lua",
		requires = {
			"vijaymarupudi/nvim-fzf",
			"kyazdani42/nvim-web-devicons",
		},
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{
		"ruifm/gitlinker.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			local gitlinker = require("gitlinker")
			gitlinker.setup({ opts = { action_callback = gitlinker.actions.open_in_browser } })
		end,
	},
	{
		"simrat39/symbols-outline.nvim",
	},
	{ "pantharshit00/vim-prisma" },
	{ "tpope/vim-commentary" },
	{ "kevinhwang91/nvim-bqf" },
}
-- can't configure this the nomral packer-y way.
-- https://github.com/simrat39/symbols-outline.nvim#configuration
vim.g.symbols_outline = { width = 35, auto_preview = false }

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
lvim.keys.normal_mode = {
	["<leader>O"] = "<cmd>SymbolsOutline<cr>",
	["<leader>s"] = "",
	["L"] = "",
	["H"] = "",
}

lvim.keys.insert_mode = {
	-- get rid of lvim defaults
	kj = nil,
	jk = nil,
	-- embrace tradition
	jj = "<Esc>",
}

-- fzf/spectre ; text search in general
lvim.builtin.which_key.mappings["f"] = {
	name = "FZF",
	f = { "<cmd>FzfLua git_files<cr>", "Files (git)" },
	F = { "<cmd>FzfLua files<cr>", "Files (all)" },
	G = { "<cmd>FzfLua git_status<cr>", "Files (modified)" },
	l = { "<cmd>FzfLua live_grep_glob<cr>", "Lines" },
	b = { "<cmd>FzfLua buffers<cr>", "Buffers" },
	U = { "<cmd>FzfLua grep_curbuf<cr>", "Current Buffer" },
	w = { "<cmd>FzfLua grep_cword<cr>", "Cursor Word" },
	W = { "<cmd>FzfLua grep_cWORD<cr>", "Cursor WORD" },
	y = { "<cmd>FzfLua lsp_live_workspace_symbols<cr>", "Workspace Symbols" },
	M = { "<cmd>FzfLua resume<cr>", "Resume" },

	r = { "<cmd> lua require('spectre').open()<cr>", "Find & Replace" },
	s = { "<cmd> lua require('spectre').open_visual({select_word=true})<cr>", "Find & Replace (cursor word)" },
	m = { "<cmd> FzfLua keymaps<cr>", "Keymaps" },

	z = { "<cmd>FzfLua builtin<cr>", "All FZF commands" },
}

--trouble
lvim.builtin.which_key.mappings["t"] = {
	name = "+Trouble",
	r = { "<cmd>Trouble lsp_references<cr>", "References" },
	f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
	d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
	q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
	l = { "<cmd>Trouble loclist<cr>", "LocationList" },
	w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
	c = { "<cmd>TroubleClose<cr>", "Close" },
	t = { "<cmd>TroubleToggle<cr>", "Toggle" },
}

-- get rid of telescope buffer finder -- FZF FTW
lvim.builtin.which_key.mappings["b"]["f"] = { "<cmd>FzfLua buffers<cr>", "Find" }
lvim.builtin.which_key.mappings["b"]["w"] = { "<cmd>BufferKill<cr>", "Kill (Wipeout)" }

-- add LspRestart
lvim.builtin.which_key.mappings["l"]["R"] = { "<cmd>LspRestart<cr>", "Restart" }

-- theme
lvim.builtin.which_key.mappings["m"] = {
	name = "Theme",
	d = { "<cmd>set background=dark<cr>", "Dark" },
	l = { "<cmd>set background=light<cr>", "Light" },
}

--misc, mappings that don't begin with <leader>
lvim.builtin.which_key.on_config_done = function()
	local wk = require("which-key")
	-- classic hunk stuff
	wk.register({
		["]c"] = { "<cmd> lua require('gitsigns').next_hunk()<cr>", "Next change" },
		["[c"] = { "<cmd> lua require('gitsigns').prev_hunk()<cr>", "Previous change" },
	})

	-- diagnostic jumps like the good old days
	wk.register({
		["]a"] = {
			"<Cmd>lua vim.diagnostic.goto_next({popup_opts = {border = lvim.lsp.popup_border}})<CR>",
			"Next diagnostic",
		},
		["[a"] = {
			"<Cmd>lua vim.diagnostic.goto_prev({popup_opts = {border = lvim.lsp.popup_border}})<CR>",
			"Previous diagnostic",
		},
	})
end

-- default mapping steps in front of lightspeed. h8 that.
lvim.builtin.which_key.mappings["s"] = {}

lvim.builtin.dashboard.disable_at_vim_enter = 1
lvim.builtin.alpha.active = false
lvim.builtin.alpha.active = false

lvim.builtin.terminal.active = true
-- lvim.builtin.nvimtree.setup.view.side = "left"
-- lvim.builtin.nvimtree.show_icons.git = 0

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
	-- languages
	"bash",
	"javascript",
	"lua",
	"python",
	"typescript",
	-- markup
	"json",
	"css",
	"yaml",
	"html",
	"scss",
}

lvim.builtin.treesitter.ignore_install = { "haskell", "ruby" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings
lvim.lsp.automatic_servers_installation = false
-- ur killin me, pyright....
-- vim.list_extend(lvim.lsp.override, { "pyright" })

-- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ exe = "black" },
	{
		exe = "isort",
		args = {
			"--profile",
			"black",
		},
	},
	{ exe = "stylua" },
	{
		exe = "prettier",
		filetypes = {
			"typescript",
			"typescriptreact",
			"javascript",
			"javascriptreact",
			"html",
			"scss",
			"css",
			"markdown",
		},
	},
	{
		exe = "eslint",
		filetypes = {
			"typescript",
			"typescriptreact",
			"javascript",
			"javascriptreact",
		},
	},
})

-- set additional linters
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{ exe = "flake8", args = {
		"--extend-ignore",
		"E203",
	} },
	{ exe = "mypy" },
	{ exe = "pylint" },
})
