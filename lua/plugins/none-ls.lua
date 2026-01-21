-- Customize None-ls sources

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    -- opts variable is the default configuration table for the setup function call
    local null_ls = require "null-ls"

    -- Check supported formatters and linters
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics

    -- Only insert new sources, do not replace the existing ones
    -- (If you wish to replace, use `opts.sources = {}` instead of the `list_insert_unique` function)
    opts.sources = require("astrocore").list_insert_unique(opts.sources, {
      -- JavaScript/TypeScript/JSON/YAML/CSS/HTML formatting
      null_ls.builtins.formatting.prettierd.with {
        filetypes = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "vue",
          "css",
          "scss",
          "less",
          "html",
          "json",
          "jsonc",
          "yaml",
          "markdown",
          "markdown.mdx",
          "graphql",
        },
      },

      -- Lua formatting
      null_ls.builtins.formatting.stylua,

      -- Markdown linting (с отключенными раздражающими правилами)
      null_ls.builtins.diagnostics.markdownlint.with {
        extra_args = { "--disable", "all", "--set", "rules.MD013.line_length=999" },
      },

      -- Code Actions
      null_ls.builtins.code_actions.gitsigns,
    })
  end,
}
