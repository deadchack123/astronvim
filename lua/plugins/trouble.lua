---@type LazySpec
return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  opts = {},
  keys = {
    { "<Leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (project)" },
    { "<Leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Diagnostics (buffer)" },
    { "<Leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo list" },
    { "<Leader>xr", "<cmd>Trouble lsp_references toggle<cr>", desc = "LSP references" },
  },
}
