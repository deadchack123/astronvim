if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

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
        -- install language servers
        "lua-language-server",

        -- install formatters
        "stylua",

        -- install debuggers
        "debugpy",

        -- install any other package
        "tree-sitter-cli",

        -- "ts_ls",
        "html",
        "cssls",

        "lua_ls",
        "pyright",
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
