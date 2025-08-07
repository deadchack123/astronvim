
return {
  {
    "pmizio/typescript-tools.nvim",
    event = { "BufReadPre", "BufNewFile" },
    ft = { "typescript", "typescriptreact" },
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("typescript-tools").setup {
        -- handlers = handlers,
        settings = {
          separate_diagnostic_server = false,
          -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
          complete_function_calls = true,
          include_completions_with_insert_text = true,
          code_lens = "off",
          tsserver_file_preferences = {
            includeInlayParameterNameHints = "all",
            includeCompletionsForModuleExports = true,
            quotePreference = "auto",
          },
          tsserver_plugins = {
            -- for TypeScript v4.9+
            "@styled/typescript-styled-plugin",
            -- or for older TypeScript versions
            "typescript-styled-plugin",
          },
          expose_as_code_action = "all",
        },
      }
    end,
  },
  {
    "styled-components/vim-styled-components",
    ft = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
  },
}
