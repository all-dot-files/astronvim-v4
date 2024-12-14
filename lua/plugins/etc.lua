return {
    -- goto-preview
    {
        "rmagatti/goto-preview",
        config = function()
            require("goto-preview").setup {
                default_mappings = true
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
  -- avante
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
        --- @type AvanteProvider
        ["deepseek"] = {
          endpoint = "https://api.deepseek.com/chat/completions",
          model = "deepseek-coder",
          api_key_name = "DEEPSEEK_API_KEY",
          parse_curl_args = function(opts, code_opts)
            return {
              url = opts.endpoint,
              headers = {
                ["Accept"] = "application/json",
                ["Content-Type"] = "application/json",
                ["Authorization"] = "Bearer " .. os.getenv(opts.api_key_name),
              },
              body = {
                model = opts.model,
                messages = require("avante.providers").copilot.parse_messages(code_opts),
                temperature = 0,
                max_tokens = 4096,
                stream = true,
              },
            }
          end,
          parse_response_data = function(data_stream, event_state, opts)
            require("avante.providers").copilot.parse_response(data_stream, event_state, opts)
          end,
        },
      },
    },
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
  }
}
