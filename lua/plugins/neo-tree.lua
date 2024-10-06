return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = function(_, opts)
    opts.filesystem.filtered_items = {
      visible = false,
      hide_dotfiles = true,
      hide_gitignored = true,
    }
    opts.window.position = "left"
    opts.window.width = 35
    opts.source_selector = {
      selector = false
    }
  end,
}
