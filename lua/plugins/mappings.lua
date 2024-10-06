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
          ["gd"] = {
            ":TSToolsGoToSourceDefinition<CR>",
            desc = "Go to sourse definition TS",
          },

          ["gf"] = {
            ":TSToolsFileReferences<CR>",
            desc = "Go to File References TS",
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
