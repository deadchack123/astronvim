return {
  "vim-test/vim-test",
  dependencies = { "preservim/vimux" },
  keys = {
    { "<Leader>Tt", "<cmd>TestNearest<cr>", desc = "Test nearest" },
    { "<Leader>TT", "<cmd>TestFile<cr>", desc = "Test file" },
    { "<Leader>Ta", "<cmd>TestSuite<cr>", desc = "Test suite" },
    { "<Leader>Tl", "<cmd>TestLast<cr>", desc = "Test last" },
    { "<Leader>Tg", "<cmd>TestVisit<cr>", desc = "Visit test file" },
  },
  init = function() vim.g["test#strategy"] = "vimux" end,
}
