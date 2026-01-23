return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" }, -- загружается только для markdown файлов
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      -- Настройки рендеринга
      heading = {
        -- Включить иконки для заголовков
        enabled = true,
        -- Иконки для разных уровней заголовков
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
        -- Подсветка фона для заголовков
        backgrounds = {
          "RenderMarkdownH1Bg",
          "RenderMarkdownH2Bg",
          "RenderMarkdownH3Bg",
          "RenderMarkdownH4Bg",
          "RenderMarkdownH5Bg",
          "RenderMarkdownH6Bg",
        },
        -- Цвет текста заголовков
        foregrounds = {
          "RenderMarkdownH1",
          "RenderMarkdownH2",
          "RenderMarkdownH3",
          "RenderMarkdownH4",
          "RenderMarkdownH5",
          "RenderMarkdownH6",
        },
      },
      -- Блоки кода
      code = {
        enabled = true,
        style = "full",
        width = "block",
        position = "left",
        left_pad = 2,
        right_pad = 2,

        sign = false, -- ✅ убирает дубли (иконка в signcolumn)
        language_name = true, --
      },
      -- Горизонтальные линии
      dash = {
        enabled = true,
        icon = "─",
        width = "full",
      },
      -- Буллеты (маркеры списков)
      bullet = {
        enabled = true,
        -- Иконки для разных уровней списков
        icons = { "●", "○", "◆", "◇" },
      },
      -- Чекбоксы
      checkbox = {
        enabled = true,
        unchecked = { icon = "󰄱 " },
        checked = { icon = "󰱒 " },
      },
      -- Цитаты
      quote = {
        enabled = true,
        icon = "▋",
      },
      -- Таблицы
      pipe_table = {
        enabled = true,
        style = "full",
      },
      -- Ссылки
      link = {
        enabled = true,
        -- Иконка для ссылок
        icon = "󰌷 ",
      },
      -- Latex (математика)
      latex = {
        enabled = true,
      },
    },
    config = function(_, opts)
      require("render-markdown").setup(opts)
      local function set_pastel()
        -- Заголовки: пастельный текст + очень мягкий фон
        vim.api.nvim_set_hl(0, "RenderMarkdownH1", { fg = "#A6C8FF", bold = true })
        vim.api.nvim_set_hl(0, "RenderMarkdownH2", { fg = "#B8E0D2", bold = true })
        vim.api.nvim_set_hl(0, "RenderMarkdownH3", { fg = "#FFD6A5", bold = true })
        vim.api.nvim_set_hl(0, "RenderMarkdownH4", { fg = "#E7C6FF", bold = true })
        vim.api.nvim_set_hl(0, "RenderMarkdownH5", { fg = "#FFAFCC", bold = true })
        vim.api.nvim_set_hl(0, "RenderMarkdownH6", { fg = "#CDEAC0", bold = true })

        -- ФОН заголовков — полностью прозрачный
        vim.api.nvim_set_hl(0, "RenderMarkdownH1Bg", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "RenderMarkdownH2Bg", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "RenderMarkdownH3Bg", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "RenderMarkdownH4Bg", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "RenderMarkdownH5Bg", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "RenderMarkdownH6Bg", { bg = "NONE" })

        -- Код — без “плашек”
        vim.api.nvim_set_hl(0, "RenderMarkdownCode", { link = "Normal" })
        vim.api.nvim_set_hl(0, "RenderMarkdownCodeInline", { link = "Comment" })
      end

      -- применить сейчас
      set_pastel()

      -- и применять заново после смены темы (очень важно в AstroNvim)
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = set_pastel,
      })
      -- Горячие клавиши для переключения рендеринга
      vim.keymap.set("n", "<Leader>tm", "<cmd>RenderMarkdown toggle<CR>", {
        desc = "Toggle Markdown rendering",
      })
    end,
  },
}
