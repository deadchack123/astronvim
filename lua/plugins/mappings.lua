return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        -- first key is the mode
        n = {
          -- second key is the lefthand side of the map
          -- mappings seen under group name "Buffer"
          -- ["<Leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
          ["<S-Tab>"] = {
            ":bprev<CR>",
            desc = "Prev tab",
          },
          ["<Tab>"] = {
            ":bnext<CR>",
            desc = "Next tab",
          },
          ["tgd"] = {
            ":TSToolsGoToSourceDefinition<CR>",
            desc = "Go to sourse definition TS",
          },
          ["tgf"] = {
            ":TSToolsFileReferences<CR>",
            desc = "Go to File References TS",
          },
          ["tgi"] = {
            ":TSToolsOrganizeImports<CR>",
            desc = "Sorts and removes unused imports",
          },
          ["tga"] = {
            ":TSToolsFixAll<CR>",
            desc = "Fixes all fixable errors",
          },
          ["<Leader>fg"] = {
            function() require("telescope").extensions.live_grep_args.live_grep_args() end,
            desc = "Live grep with args",
          },
          -- TSToolsFileReferences
          -- tables with just a `desc` key will be registered with which-key if it's installed
          -- this is useful for naming menus
          -- ["<Leader>b"] = { desc = "Buffers" },
          -- quick save
          -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
        },
      },
    },
  },
}
