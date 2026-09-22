---@type LazySpec
return {
  { "b0o/SchemaStore.nvim", lazy = true },
  {
    "AstroNvim/astrolsp",
    dependencies = { "b0o/SchemaStore.nvim" },
    opts = function(_, opts)
      local schemastore = require "schemastore"
      opts.config = opts.config or {}
      opts.config.jsonls = vim.tbl_deep_extend("force", opts.config.jsonls or {}, {
        settings = {
          json = {
            schemas = schemastore.json.schemas(),
            validate = { enable = true },
          },
        },
      })
      opts.config.yamlls = vim.tbl_deep_extend("force", opts.config.yamlls or {}, {
        settings = {
          yaml = {
            schemaStore = { enable = false, url = "" },
            schemas = schemastore.yaml.schemas(),
          },
        },
      })
    end,
  },
}
