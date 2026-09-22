---@type LazySpec
return {
  "MagicDuck/grug-far.nvim",
  opts = { headerMaxWidth = 80 },
  keys = {
    {
      "<Leader>sr",
      function() require("grug-far").open { transient = true } end,
      mode = "n",
      desc = "Search and replace in project",
    },
    {
      "<Leader>sr",
      function() require("grug-far").with_visual_selection { transient = true } end,
      mode = "x",
      desc = "Search and replace selection",
    },
  },
}
