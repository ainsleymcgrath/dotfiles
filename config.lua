-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "zenbones"
vim.cmd("set background=light")
vim.cmd("let g:python3_host_prog = expand('~/.config/nvim/neovim_venv/bin/python3')")

-- haha

-- this lets jj work as escape
vim.cmd("set timeoutlen=300")

-- perhaps i am a fool, but doing this in `config` above doesn't seem to work immediately
local function setup_symbols_outline()
	require("symbols-outline").setup({ width = 65, auto_preview = false })
end

-- setup_symbols_outline()

lvim.plugins = {
	{ "mcchrish/zenbones.nvim", requires = "rktjmp/lush.nvim" },
	{
		"folke/trouble.nvim",
	},
	{
		"ibhagwan/fzf-lua",
		requires = {
			"vijaymarupudi/nvim-fzf",
			"kyazdani42/nvim-web-devicons",
		},
	},
	{ "ggandor/lightspeed.nvim" },
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{
		"blackCauldron7/surround.nvim",
		config = function()
			require("surround").setup({ mappings_style = "surround" })
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
		config = setup_symbols_outline,
	},
	{ "windwp/nvim-spectre" },
	{ "romgrk/nvim-treesitter-context" },
	{ "ray-x/lsp_signature.nvim" },
	{ "tpope/vim-repeat" },
}

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
lvim.keys.normal_mode = {
	["<leader>O"] = "<cmd>SymbolsOutline<cr>",
	["<leader>s"] = "",
}

lvim.keys.insert_mode = {
	kj = "",
}

-- fzf/spectre ; text search in general
lvim.builtin.which_key.mappings["f"] = {
	name = "FZF",
	f = { "<cmd>FzfLua git_files<cr>", "Files (git)" },
	F = { "<cmd>FzfLua files<cr>", "Files (all)" },
	G = { "<cmd>FzfLua git_status<cr>", "Files (modified)" },
	l = { "<cmd>FzfLua grep_project<cr>", "Lines" },
	b = { "<cmd>FzfLua buffers<cr>", "Buffers" },
	U = { "<cmd>FzfLua grep_curbuf<cr>", "Current Buffer" },
	w = { "<cmd>FzfLua grep_cword<cr>", "Cursor Word" },
	W = { "<cmd>FzfLua grep_cWORD<cr>", "Cursor WORD" },
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
}

-- get rid of telescope buffer finder -- FZF FTW
lvim.builtin.which_key.mappings["b"]["f"] = { "<cmd>FzfLua buffers<cr>", "Find" }

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
			"<Cmd>lua vim.lsp.diagnostic.goto_next({popup_opts = {border = lvim.lsp.popup_border}})<CR>",
			"Next diagnostic",
		},
		["[a"] = {
			"<Cmd>lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = lvim.lsp.popup_border}})<CR>",
			"Previous diagnostic",
		},
	})
end

-- default mapping steps in front of lightspeed. h8 that.
lvim.builtin.which_key.mappings["s"] = {}

lvim.builtin.dashboard.active = true
lvim.builtin.dashboard.search_handler = "fzf-lua"

lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

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

-- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ exe = "black" },
	{
		exe = "isort",
		args = {
			"--multi-line-output=3",
			"--include-trailing-comma=True",
			"--force-grid-wrap=0",
			"--use-parenthesis=True",
			"--line-length=88",
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
})

-- set additional linters
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{ exe = "flake8" },
	{ exe = "mypy" },
})
