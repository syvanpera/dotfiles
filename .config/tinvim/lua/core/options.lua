local options = {
	autoindent = true,
	backspace = "indent,eol,start",
	backup = false,
	breakindent = true,
	clipboard = "",
	cmdheight = 1,
	completeopt = "menu,menuone,noselect",
	conceallevel = 3,
	confirm = true,
	cursorline = true,
	expandtab = true,
	fileencoding = "utf-8",
	formatoptions = "jcroqlnt",
	grepformat = "%f:%l:%c:%m",
	grepprg = "rg --vimgrep",
	hlsearch = true,
	ignorecase = true,
	inccommand = "split",
	laststatus = 3,
	list = true,
	listchars = { trail = "·", tab = "» ", nbsp = "␣", extends = "·", precedes = "<" },
	mouse = "a",
	number = true,
	numberwidth = 4,
	pumblend = 10,
	pumheight = 10,
	relativenumber = true,
	scrolloff = 10,
	sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal",
	shiftround = true,
	shiftwidth = 4,
	showcmd = false,
	showmode = false,
	showtabline = 0,
	si = true,
	sidescrolloff = 8,
	signcolumn = "yes",
	smartcase = true,
	smartindent = true,
	smarttab = true,
	splitbelow = true,
	splitkeep = "screen",
	splitright = true,
	swapfile = false,
	tabstop = 4,
	termguicolors = true,
	timeoutlen = 500,
	undofile = true,
	undolevels = 10000,
	updatetime = 50,
	wildmenu = true,
	wildmode = "longest:full,full",
	winminwidth = 5,
	wrap = false,
	writebackup = false,
}

vim.cmd([[
     setlocal spell spelllang=en "Set spellcheck language to en
     setlocal spell! "Disable spell checks by default
     filetype plugin indent on
 ]])

vim.opt.path:append({ "**" })

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])
vim.cmd([[noremap Y Y]])
