return {
  {
    "3rd/image.nvim",
    ft = { "markdown", "norg", "html" }, -- загружается для этих типов файлов
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      backend = "kitty", -- Ghostty поддерживает kitty protocol. Если не работает - попробуйте "ueberzug"
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true, -- скачивать картинки из интернета
          only_render_image_at_cursor = false, -- показывать все картинки
          filetypes = { "markdown", "vimwiki" },
        },
        html = {
          enabled = true,
        },
        css = {
          enabled = false,
        },
      },
      max_width = nil, -- максимальная ширина (nil = по размеру окна)
      max_height = nil, -- максимальная высота
      max_width_window_percentage = nil,
      max_height_window_percentage = 50, -- 50% высоты окна
      window_overlap_clear_enabled = false,
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
      editor_only_render_when_focused = false,
      tmux_show_only_in_active_window = false,
      hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.svg" },
    },
  },
}
