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
        -- Включить рендеринг блоков кода
        enabled = true,
        -- Иконка перед блоком кода
        icon = "󰘦 ",
        -- Стиль: full (с рамкой), language (только название языка), none
        style = "full",
        -- Позиция названия языка: left, right
        position = "left",
        width = "block",
        left_pad = 2,
        right_pad = 2,
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

      -- Горячие клавиши для переключения рендеринга
      vim.keymap.set("n", "<Leader>tm", "<cmd>RenderMarkdown toggle<CR>", {
        desc = "Toggle Markdown rendering",
      })
    end,
  },
}
