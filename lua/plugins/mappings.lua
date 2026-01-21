return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        -- first key is the mode
        v = {
          ['"'] = {
            function()
              local keys = vim.api.nvim_replace_termcodes('S"', true, false, true)
              vim.api.nvim_feedkeys(keys, "m", false)
            end,
            desc = "Surround selection with double quotes",
          },

          ["'"] = {
            function()
              local keys = vim.api.nvim_replace_termcodes("S'", true, false, true)
              vim.api.nvim_feedkeys(keys, "m", false)
            end,
            desc = "Surround selection with single quotes",
          },

          ["`"] = {
            function()
              local keys = vim.api.nvim_replace_termcodes("S`", true, false, true)
              vim.api.nvim_feedkeys(keys, "m", false)
            end,
            desc = "Surround selection with backticks",
          },
          ["("] = {
            function()
              local keys = vim.api.nvim_replace_termcodes("S(", true, false, true)
              vim.api.nvim_feedkeys(keys, "m", false)
            end,
            desc = "Surround selection with ()",
          },

          ["{"] = {
            function()
              local keys = vim.api.nvim_replace_termcodes("S{", true, false, true)
              vim.api.nvim_feedkeys(keys, "m", false)
            end,
            desc = "Surround selection with {}",
          },

          ["["] = {
            function()
              local keys = vim.api.nvim_replace_termcodes("S[", true, false, true)
              vim.api.nvim_feedkeys(keys, "m", false)
            end,
            desc = "Surround selection with []",
          },

          ["<"] = {
            function()
              local keys = vim.api.nvim_replace_termcodes("S<", true, false, true)
              vim.api.nvim_feedkeys(keys, "m", false)
            end,
            desc = "Surround selection with <>",
          },
        },
        n = {
          -- second key is the lefthand side of the map
          -- mappings seen under group name "Buffer"
          -- ["<Leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
          ["<Leader>("] = {
            function()
              local keys = vim.api.nvim_replace_termcodes("ysiw(", true, false, true)
              vim.api.nvim_feedkeys(keys, "m", false)
            end,
            desc = "Surround word with ()",
          },

          ["<Leader>{"] = {
            function()
              local keys = vim.api.nvim_replace_termcodes("ysiw{", true, false, true)
              vim.api.nvim_feedkeys(keys, "m", false)
            end,
            desc = "Surround word with {}",
          },

          ["<Leader>["] = {
            function()
              local keys = vim.api.nvim_replace_termcodes("ysiw[", true, false, true)
              vim.api.nvim_feedkeys(keys, "m", false)
            end,
            desc = "Surround word with []",
          },

          ["<Leader><"] = {
            function()
              local keys = vim.api.nvim_replace_termcodes("ysiw<", true, false, true)
              vim.api.nvim_feedkeys(keys, "m", false)
            end,
            desc = "Surround word with <>",
          },
          ['<Leader>"'] = {
            function()
              local keys = vim.api.nvim_replace_termcodes('ysiw"', true, false, true)
              vim.api.nvim_feedkeys(keys, "m", false) -- "m" = с учетом маппингов (remap)
            end,
            desc = "Surround word with double quotes",
          },
          ["<Leader>'"] = {
            function()
              local keys = vim.api.nvim_replace_termcodes("ysiw'", true, false, true)
              vim.api.nvim_feedkeys(keys, "m", false)
            end,
            desc = "Surround word with single quotes",
          },
          ["<Leader>`"] = {
            function()
              local keys = vim.api.nvim_replace_termcodes("ysiw`", true, false, true)
              vim.api.nvim_feedkeys(keys, "m", false)
            end,
            desc = "Surround word with backticks",
          },
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

          -- Formatting and linting
          ["<Leader>lf"] = {
            function() vim.lsp.buf.format { async = true } end,
            desc = "Format buffer",
          },
          ["<Leader>la"] = {
            "<cmd>EslintFixAll<CR>",
            desc = "ESLint fix all",
          },
          ["<Leader>ln"] = {
            "<cmd>NullLsInfo<CR>",
            desc = "None-ls info",
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
