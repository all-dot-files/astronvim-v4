-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- import/override with your plugins folder
  -- theme
  { import = "astrocommunity.colorscheme.catppuccin" },

  -- languge
  -- { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.cpp" },
  { import = "astrocommunity.pack.bash" },
  -- { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.markdown" },
  -- { import = "astrocommunity.pack.typescript" },

  -- jump
  {
    import = "astrocommunity.motion.leap-nvim",
    -- config = function(_, _)
    --   local leap = require "leap"
    --   leap.create_default_mappings()
    -- end,
  },

  -- msic
  { import = "astrocommunity.utility.noice-nvim" },
  { import = "astrocommunity.completion.cmp-cmdline" },
  { import = "astrocommunity.git.git-blame-nvim" },

  -- editing-support
  -- { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
  { import = "astrocommunity.editing-support.suda-vim" },
  { import = "astrocommunity.editing-support.neogen" },
  { import = "astrocommunity.editing-support.multicursors-nvim" },
  { import = "astrocommunity.editing-support.telescope-undo-nvim" },
  { import = "astrocommunity.editing-support.todo-comments-nvim" },

  -- syntax
  { import = "astrocommunity.syntax.hlargs-nvim" },
  { import = "astrocommunity.syntax.vim-cool" },

  -- indent
  -- { import = "astrocommunity.indent.indent-rainbowline" },

  -- code runner
  -- { import = "astrocommunity.code-runner.executor-nvim" },

  -- diagnostics
  { import = "astrocommunity.diagnostics.trouble-nvim" },

  -- bars-and-lines
  { import = "astrocommunity.bars-and-lines.smartcolumn-nvim" },
}
