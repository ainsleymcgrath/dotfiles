lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "neobones"
vim.cmd("let g:python3_host_prog = expand('~/.config/nvim/neovim_venv/bin/python3')")
vim.opt.scrolloff = 0 -- Required so L moves to the last line
vim.opt.showtabline = 0

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
		config = function()
			require("symbols-outline").setup({ width = 35, auto_preview = false })
		end,
	},
	{ "pantharshit00/vim-prisma" },
	{ "tpope/vim-commentary" },
	{ "kevinhwang91/nvim-bqf" },
	{
		"f-person/auto-dark-mode.nvim",
		config = function()
			local auto_dark_mode = require("auto-dark-mode")
			auto_dark_mode.setup({
				update_interval = 1000,
				set_dark_mode = function()
					vim.api.nvim_set_option("background", "dark")
					vim.cmd("colorscheme zenbones")
					lvim.colorscheme = "zenbones"
				end,
				set_light_mode = function()
					vim.api.nvim_set_option("background", "light")
					vim.cmd("colorscheme neobones")
					lvim.colorscheme = "neobones"
				end,
			})
			auto_dark_mode.init()
		end,
	},
	{
		"lukas-reineke/virt-column.nvim",
		config = function()
			require("virt-column").setup({ char = "┊", virtcolumn = "88" })
		end,
		ft = {
			"python",
			"lua",
			"sql",
			"typescript",
			"javascript",
			"typescriptreact",
			"javascriptreact",
			"json",
			"yaml",
			"toml",
			"html",
		},
	},
}

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
lvim.keys.normal_mode = {
	["<leader>O"] = "<cmd>SymbolsOutline<cr>",
	["<leader>s"] = false, -- get rid of all the builtin sneak stuff
	-- ["s"] = "",
	-- L and H cycled buffers for some reason?
	["L"] = false,
	["H"] = false,
	-- these originally aliased the `<C-W>` versions
	["<C-H>"] = false,
	["<C-L>"] = false,
	["<Space><Space><Space>"] = "<cmd>ToggleTerm<cr>",
}

lvim.keys.insert_mode = {
	-- get rid of lvim defaults
	kj = false,
	jk = false,
	-- embrace tradition
	jj = "<Esc>",
}

lvim.keys.term_mode = {
	["<C-L>"] = "clear<cr>", -- emulate regular
	["<Space><Space><Space>"] = "<cmd>ToggleTerm<cr>",
}

-- fzf/spectre ; text search in general
lvim.builtin.which_key.mappings["f"] = {
	name = "FZF",
	f = { "<cmd>FzfLua git_files<cr>", "Files (git)" },
	F = { "<cmd>FzfLua files<cr>", "Files (all)" },
	g = { "<cmd>FzfLua git_status<cr>", "Files (modified)" },
	l = { "<cmd>lua require('fzf-lua').grep({ search = '', })<cr>", "Lines" },
	b = {
		-- "<cmd>lua require('fzf-lua').buffers({winopts = { width=1.0, height=0.3, row=0, preview = {hidden = 'hidden'} } })<cr>",
		-- "<cmd>lua require('fzf-lua').buffers({winopts = { width=0.5, height=0.9, row=0, preview = { layout='vertical', vertical='down:80%'} } })<cr>",
		-- nicely to the right, like a sidebar (prepend prompt with a space)
		"<cmd>lua require('fzf-lua').buffers({winopts = { width=0.2, height=.98, row=0, col=1, preview = { hidden='hidden' }, border='none' }, prompt = ' Buffers❯'})<cr>",
		"Buffers",
	},
	u = { "<cmd>FzfLua grep_curbuf<cr>", "Current Buffer" },
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
	d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
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
lvim.builtin.which_key.mappings["L"]["h"] = { "<cmd>LvimCacheReset<cr>", "Cache Reset" }

-- term
lvim.builtin.which_key.mappings["m"] = {
	name = "Ter[m]inal",
	t = { "<cmd>ToggleTerm<cr>", "Toggle" },
	s = { "<cmd>ToggleTermSendCurrentLine<cr>", "Send Line" },
}

lvim.builtin.which_key.mappings["q"] = {
	name = "Quickfix",
	n = { "<cmd>cn<cr>", "Next" },
	p = { "<cmd>cp<cr>", "Previous" },
	l = { "<cmd>clast<cr>", "Last" },
	f = { "<cmd>cfirst<cr>", "First" },
	c = { "<cmd>ccl<cr>", "Close" },
}

lvim.builtin.which_key.setup["icons"]["separator"] = ":"
lvim.builtin.which_key.setup["icons"]["group"] = "+"

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

	-- terminal stuff
	wk.register({
		m = {
			name = "Ter[m]inal (V)",
			t = { "<cmd>ToggleTerm<cr>", "Toggle" },
			s = { "<cmd>ToggleTermSendCurrentLine<cr>ToggleTerm<cr>", "Send Line" },
			v = { "<cmd>ToggleTermSendVisualSelection<cr>", "Send VLines" },
		},
	}, { prefix = "<leader>", mode = "v" })
end

-- disable things
lvim.builtin.alpha.active = false
lvim.builtin.project.active = false
lvim.lsp.automatic_servers_installation = false
lvim.builtin.bufferline.active = false
lvim.builtin.dap.active = false
lvim.builtin.indentlines.active = false
lvim.builtin.terminal.active = true

-- keep the navic filetype/name indicator out of FZF windows
table.insert(lvim.builtin.breadcrumbs.winbar_filetype_exclude, "fzf")

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

-- treesitter
lvim.builtin.treesitter.ignore_install = { "haskell", "ruby" }
lvim.builtin.treesitter.highlight.enable = true

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
	}, filetypes = { "python" } },
	{ exe = "mypy", filetypes = { "python" } },
})
