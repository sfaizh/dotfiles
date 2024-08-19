return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
      },
    },
  },

  {
    "akinsho/toggleterm.nvim",
    init = function()
      require("toggleterm").setup {
        size = 20,
        open_mapping = [[<c-\>]],
        direction = "float",
        hide_numbers = true,
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        close_on_exit = true,
        highlights = {
          -- highlights which map to a highlight group name and a table of it's values
          -- NOTE: this is only a subset of values, any group placed here will be set for the terminal window split
          Normal = {
            guibg = "#1e1e2e",
          },
          NormalFloat = {
            link = "Normal",
          },
          FloatBorder = {
            guifg = "#d6d6d6",
            guibg = "#1e1e2e",
          },
        },
        float_opts = {
          border = "curved",
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
      }
    end,
    version = "*",
    config = true,
  },

  {
    "elentok/format-on-save.nvim",
    init = function()
      local formatters = require "format-on-save.formatters"
      require("format-on-save").setup {
        formatter_by_ft = {
          css = formatters.lsp,
          html = formatters.lsp,
          java = formatters.lsp,
          javascript = formatters.lsp,
          json = formatters.lsp,
          lua = formatters.lsp,
          markdown = formatters.prettierd,
          openscad = formatters.lsp,
          python = formatters.black,
          rust = formatters.lsp,
          scad = formatters.lsp,
          scss = formatters.lsp,
          sh = formatters.shfmt,
          terraform = formatters.lsp,
          typescript = formatters.prettierd,
          typescriptreact = formatters.prettierd,
          yaml = formatters.lsp,
          go = formatters.lsp,
        },
      }
      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = { "*.js", "*.jsx", "*.ts", "*.tsx", "*.go" },
        callback = function()
          require("format-on-save").format()
        end,
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require "lspconfig"

      -- Example: Set up tsserver for JavaScript/TypeScript
      lspconfig.tsserver.setup {
        on_attach = function(client)
          client.server_capabilities.document_formatting = true
        end,
      }

      -- You can add more LSP server setups here if needed
      -- Set up gopls for Go
      lspconfig.gopls.setup {
        on_attach = function(client)
          client.server_capabilities.document_formatting = true
        end,
      }
    end,
  },

  -- Neovim Session Manager
  {
    "mackeper/SeshMgr.nvim",
    event = "VeryLazy",
    opts = {},

    -- optional keymappings
    keys = {
      { "<leader>sl", "<CMD>SessionLoadLast<CR>", desc = "Load last session" },
      { "<leader>sc", "<CMD>SessionLoadCurrent<CR>", desc = "Load current session" },
      { "<leader>sL", "<CMD>SessionList<CR>", desc = "List sessions" },
      { "<leader>ss", "<CMD>SessionSave<CR>", desc = "Save session" },
    },
  },
}
