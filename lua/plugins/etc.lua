return {
  -- goto-preview
  {
    "rmagatti/goto-preview",
    config = function()
      require("goto-preview").setup {
        default_mappings = true,
      }
    end,
  },
  -- heirline
  {
    "rebelot/heirline.nvim",
    opts = function(_, opts)
      local status = require "astroui.status"
      ---@diagnostic disable-next-line: inject-field
      status.component.line_end = function()
        return status.component.builder {
          {
            provider = function()
              local map = { ["unix"] = "LF", ["mac"] = "CR", ["dos"] = "CRLF" }
              return map[vim.bo.fileformat]
            end,
          },
          surround = {
            separator = "right",
          },
        }
      end
      opts.statusline = {
        hl = { fg = "fg", bg = "bg" },
        status.component.mode(),
        status.component.git_branch(),
        status.component.file_info(),
        status.component.git_diff(),
        status.component.diagnostics(),
        status.component.fill(),
        status.component.cmd_info(),
        status.component.fill(),
        status.component.lsp(),
        status.component.virtual_env(),
        status.component.treesitter(),
        status.component.line_end(),
        status.component.nav(),
      }
    end,
  },
  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "AstroNvim/astrocore",
    },
    opts = function(_, opts)
      local actions = require "telescope.actions"
      return require("astrocore").extend_tbl(opts, {
        defaults = {
          mappings = {
            i = {
              ["<C-n>"] = actions.move_selection_next,
              ["<C-p>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.cycle_history_next,
              ["<C-k>"] = actions.cycle_history_prev,
            },
          },
        },
      })
    end,
  },
  {
    "cordx56/rustowl",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
  },
  {
    "yetone/avante.nvim",
    -- config = function()
    --   require("avante_lib").load() -- note requiring avante_lib here
    --   require("avante").setup {
    --     -- add any options here if needed
    --   }
    -- end,
    -- run = "make BUILD_FROM_SOURCE=true", -- Build command (use this if you build from source)
    -- requires = {
    --   "nvim-treesitter/nvim-treesitter",
    --   "stevearc/dressing.nvim",
    --   "nvim-lua/plenary.nvim",
    --   "MunifTanjim/nui.nvim",
    --
    --   { "nvim-tree/nvim-web-devicons", opt = true },
    -- },
    opts = {
      provider = "deepseek",
      auto_suggestions_provider = "deepseek",
      behaviour = {
        auto_suggestions = true,
      },
      vendors = {
        -- --- @type AvanteProvider
        -- ["ollama"] = {
        --   __inherited_from = "openai",
        --   endpoint = "http://127.0.0.1:11434",
        --   api_key_name = '',
        --   model = "qwen2.5-coder:1.5b",
        --   -- model = '6d3abb8d2d53',
        --   parse_curl_args = function(opts, code_opts)
        --     return {
        --       url = opts.endpoint .. "/chat/completions",
        --       -- url = opts.endpoint,
        --       headers = {
        --         ["Accept"] = "application/json",
        --         ["Content-Type"] = "application/json",
        --       },
        --       body = {
        --         model = opts.model,
        --         messages = require("avante.providers").copilot.parse_message(code_opts), -- you can make your own message, but this is very advanced
        --         max_tokens = 2048,
        --         stream = true,
        --       },
        --     }
        --   end,
        --   parse_response_data = function(data_stream, event_state, opts)
        --     require("avante.providers").copilot.parse_response(data_stream, event_state, opts)
        --   end,
        -- },
        ["deepseek"] = {
          __inherited_from = "openai",
          api_key_name = "DEEPSEEK_API_KEY",
          endpoint = "https://api.deepseek.com",
          -- model = "deepseek-coder",
          model = "deepseek-chat",
        },
        -- ["tencent"] = {
        --   __inherited_from = "openai",
        --   api_key_name = "TENCENT_API_KEY",
        --   endpoint = "https://api.lkeap.cloud.tencent.com/v1/chat/completions",
        --   model = "deepseek-v3",
        -- },
        -- --- @type AvanteProvider
        -- ["deepseek"] = {
        --   endpoint = "https://api.deepseek.com/chat/completions",
        --   model = "deepseek-chat",
        --   api_key_name = "DEEPSEEK_API_KEY",
        --   parse_curl_args = function(opts, code_opts)
        --     return {
        --       url = opts.endpoint,
        --       headers = {
        --         ["Accept"] = "application/json",
        --         ["Content-Type"] = "application/json",
        --         ["Authorization"] = "Bearer " .. os.getenv(opts.api_key_name),
        --       },
        --       body = {
        --         model = opts.model,
        --         messages = require("avante.providers").copilot.parse_messages(code_opts),
        --         temperature = 0,
        --         max_tokens = 4096,
        --         stream = true,
        --       },
        --     }
        --   end,
        --   parse_response_data = function(data_stream, event_state, opts)
        --     require("avante.providers").copilot.parse_response(data_stream, event_state, opts)
        --   end,
        -- },
      },
    },
  },
  -- {
  --   "yetone/avante.nvim",
  --   event = "VeryLazy",
  --   lazy = false,
  --   opts = {
  --     -- add any opts here
  --   },
  --   keys = {
  --     { "<leader>aa", function() require("avante.api").ask() end, desc = "avante: ask", mode = { "n", "v" } },
  --     { "<leader>ar", function() require("avante.api").refresh() end, desc = "avante: refresh" },
  --     { "<leader>ae", function() require("avante.api").edit() end, desc = "avante: edit", mode = "v" },
  --   },
  --   -- config = function ()
  --   --   provider = "openai"
  --   -- end,
  --   config = {
  --     provider = "openai"
  --   },
  --   dependencies = {
  --     "stevearc/dressing.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --     --- The below dependencies are optional,
  --     "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
  --     "zbirenbaum/copilot.lua", -- for providers='copilot'
  --     {
  --       -- support for image pasting
  --       "HakonHarnes/img-clip.nvim",
  --       event = "VeryLazy",
  --       opts = {
  --         -- recommended settings
  --         default = {
  --           embed_image_as_base64 = false,
  --           prompt_for_file_name = false,
  --           drag_and_drop = {
  --             insert_mode = true,
  --           },
  --           -- required for Windows users
  --           use_absolute_path = true,
  --         },
  --       },
  --     },
  --     {
  --       -- Make sure to setup it properly if you have lazy=true
  --       "MeanderingProgrammer/render-markdown.nvim",
  --       opts = {
  --         file_types = { "markdown", "Avante" },
  --       },
  --       ft = { "markdown", "Avante" },
  --     },
  --   },
  -- },
}
