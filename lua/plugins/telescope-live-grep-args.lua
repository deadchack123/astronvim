return {
  {
    "nvim-telescope/telescope-live-grep-args.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      local telescope = require("telescope")
      local lga_actions = require("telescope-live-grep-args.actions")

      local function set_telescope_hl()
        -- Подсветка совпадений в списке результатов (слева)
        vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = "#f7768e", bold = true })
        -- Прозрачный фон строки поиска
        vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "TelescopePromptTitle", { bg = "NONE" })
      end

      set_telescope_hl()
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = set_telescope_hl,
      })

      telescope.setup({
        extensions = {
          live_grep_args = {
            auto_quoting = true,
            prompt_title = "Grep │ C-k \"\" │ C-g -g src/** -g !*.test.* │ C-t -t ts -t js │ C-f literal",
            layout_config = {
              prompt_position = "top",
              width = 0.95,
              height = 0.9,
              preview_width = 0.55,
            },
            sorting_strategy = "ascending",
            mappings = {
              i = {
                ["<C-k>"] = lga_actions.quote_prompt(),
                ["<C-g>"] = lga_actions.quote_prompt({ postfix = " -g " }),
                ["<C-t>"] = lga_actions.quote_prompt({ postfix = " -t " }),
                ["<C-f>"] = lga_actions.quote_prompt({ postfix = " -F" }),
              },
            },
          },
        },
      })

      telescope.load_extension("live_grep_args")
    end,
  },
}
