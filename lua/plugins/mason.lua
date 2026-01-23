-- Customize Mason

---@type LazySpec
return {
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = {
      -- Make sure to use the names found in `:Mason`
      ensure_installed = {
        -- Language Servers
        "lua-language-server",
        "html-lsp", -- HTML LSP (правильное название)
        "css-lsp", -- CSS LSP (правильное название)
        "pyright",
        "json-lsp", -- JSON LSP (правильное название)
        "yaml-language-server", -- YAML LSP (правильное название)
        "eslint-lsp", -- ESLint LSP (правильное название)

        -- Formatters
        "stylua",
        "prettierd", -- Fast Prettier daemon
        "prettier", -- Fallback

        -- Linters
        -- "markdownlint",         -- Markdown linting

        -- Debuggers
        "debugpy",

        -- Tools
        "tree-sitter-cli",
      },
      -- handlers = {
      --   function(server_name)
      --     require("lspconfig")[server_name].setup {
      --       capabilities = require("cmp_nvim_lsp").default_capabilities(),
      --     }
      --   end,
      --
      --   ["ts_ls"] = function() end, -- handled by `typescript_tools.lua`
      -- },
    },
  },
  -- {
  --   "mason-lspconfig.nvim",
  --   opts = {
  --     ensure_installed = {
  --       "tsserver",
  --       -- others...
  --     },
  --     handlers = {
  --       -- default handler
  --       function(server_name) lspconfig[server_name].setup {} end,
  --       tsserver = function() lspconfig.ts_ls.setup {} end,
  --       -- other specific handlers...
  --     },
  --   },
  -- },
}
