-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "tsx",
      "typescript",
      "javascript",
      "html",
      "css",
      "vue",
      -- "astro",
      -- "svelte",
      "gitcommit",
      -- "graphql",
      "json",
      "json5",
      "lua",
      "markdown",
      -- "prisma",
      -- "glimmer",
      "regex",
      "bash",
      "vim",
      "vimdoc",
      "styled",
      -- "zig", -- add more arguments for adding more treesitter parsers
    },
    auto_install = true,
    highlight = {
      enable = true,
    },
  },
}
