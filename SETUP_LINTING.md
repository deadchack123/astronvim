# План настройки ESLint, Prettier и форматирования в Neovim

## Что уже установлено через Mason ✅

**Python инструменты:**
- black, autopep8, isort (форматтеры)
- autoflake, mypy, ruff (линтеры)

**Lua инструменты:**
- lua-language-server (LSP)
- stylua (форматтер)
- selene (линтер)

**TypeScript:**
- typescript-language-server (не используется, т.к. есть typescript-tools.nvim)

**Docker:**
- docker-language-server
- docker-compose-language-server

**Другое:**
- tree-sitter-cli

---

## Что нужно установить дополнительно

### Для JavaScript/TypeScript форматирования и линтинга:

```bash
# Через Mason в Neovim (используйте правильные названия пакетов!)
:MasonInstall prettierd prettier eslint-lsp json-lsp yaml-language-server css-lsp html-lsp markdownlint
```

Или добавить в `lua/plugins/mason.lua` ensure_installed:
- **prettierd** - быстрый Prettier для форматирования JS/TS/JSON/YAML/CSS/HTML
- **prettier** - фолбек если prettierd не работает
- **eslint-lsp** - ESLint как LSP для линтинга (в Mason называется eslint-lsp!)
- **json-lsp** - JSON LSP с валидацией схем (в Mason называется json-lsp!)
- **yaml-language-server** - YAML LSP (в Mason называется yaml-language-server!)
- **css-lsp** - CSS LSP (в Mason называется css-lsp!)
- **html-lsp** - HTML LSP (в Mason называется html-lsp!)
- **markdownlint** - линтер для Markdown

---

## Текущее состояние конфигурации

### ❌ Отключено (нужно включить):

1. **`lua/plugins/none-ls.lua`** - имеет guard `if true then return {} end` на строке 1
2. **`lua/plugins/mason.lua`** - имеет guard `if true then return {} end` на строке 1

### ✅ Работает:

1. **typescript-tools.nvim** - TypeScript интеллект
2. **StyLua** - форматирование Lua файлов
3. **Format-on-save** - включен глобально в astrolsp.lua

---

## План реализации

### Шаг 1: Включить Mason и добавить инструменты

**Файл:** `lua/plugins/mason.lua`

**Действия:**
1. Удалить строку 1: `if true then return {} end`
2. Обновить `ensure_installed` (заменить строки 13-32):

```lua
ensure_installed = {
  -- Language Servers
  "lua-language-server",  -- ✓ уже есть
  "pyright",              -- ✓ уже есть
  "html",                 -- NEW
  "cssls",                -- NEW
  "jsonls",               -- NEW
  "yamlls",               -- NEW
  "eslint",               -- NEW: ESLint как LSP
  "docker-language-server",         -- ✓ уже есть
  "docker-compose-language-server", -- ✓ уже есть

  -- Форматтеры JS/TS
  "prettierd",            -- NEW: Быстрый Prettier
  "prettier",             -- NEW: Фолбек

  -- Форматтеры Lua
  "stylua",               -- ✓ уже есть

  -- Форматтеры Python (уже установлены вручную)
  "black",                -- ✓ уже есть
  "isort",                -- ✓ уже есть
  "autopep8",             -- ✓ уже есть

  -- Линтеры
  "ruff",                 -- ✓ уже есть (Python)
  "mypy",                 -- ✓ уже есть (Python)
  "selene",               -- ✓ уже есть (Lua)
  "markdownlint",         -- NEW: Markdown

  -- Debuggers
  "debugpy",              -- ✓ уже есть

  -- Tools
  "tree-sitter-cli",      -- ✓ уже есть
}
```

---

### Шаг 2: Включить и настроить none-ls

**Файл:** `lua/plugins/none-ls.lua`

**Действия:**
1. Удалить строку 1: `if true then return {} end`
2. Раскомментировать строку 10: `local null_ls = require "null-ls"`
3. Обновить `opts.sources` (строки 18-22):

```lua
opts.sources = require("astrocore").list_insert_unique(opts.sources, {
  -- JavaScript/TypeScript/JSON/YAML/CSS/HTML форматирование
  null_ls.builtins.formatting.prettierd.with({
    filetypes = {
      "javascript", "javascriptreact",
      "typescript", "typescriptreact",
      "vue", "css", "scss", "less",
      "html", "json", "jsonc", "yaml",
      "markdown", "markdown.mdx", "graphql"
    },
  }),

  -- Lua форматирование
  null_ls.builtins.formatting.stylua,

  -- Python форматирование (у вас установлены black, isort, ruff)
  -- Выберите один из вариантов:

  -- Вариант 1: Black + isort (классика)
  null_ls.builtins.formatting.black,
  null_ls.builtins.formatting.isort,

  -- Вариант 2: Ruff (современный, быстрый, заменяет оба)
  -- null_ls.builtins.formatting.ruff,

  -- Code Actions
  null_ls.builtins.code_actions.gitsigns,
})
```

**Примечание про Python:**
- **Black + isort** - традиционный подход, очень популярен
- **Ruff** - современная альтернатива, в 10-100 раз быстрее, заменяет black + isort + flake8 + много других
- Рекомендую: если проект уже использует black - оставьте black, если новый проект - попробуйте ruff

---

### Шаг 3: Настроить AstroLSP (избежать конфликтов)

**Файл:** `lua/plugins/astrolsp.lua`

**Действия:**

1. Найти секцию `formatting` и обновить (примерно строки 18-37):

```lua
formatting = {
  format_on_save = {
    enabled = true,
    allow_filetypes = {},
    ignore_filetypes = {},
  },
  disabled = {
    -- Отключить форматирование от LSP (none-ls обрабатывает)
    "lua_ls",      -- Lua → stylua через none-ls
    "html",        -- HTML → prettier через none-ls
    "cssls",       -- CSS → prettier через none-ls
    "jsonls",      -- JSON → prettier через none-ls
    "yamlls",      -- YAML → prettier через none-ls
    "pyright",     -- Python → black/ruff через none-ls
  },
  timeout_ms = 3000,  -- Увеличить с 1000 для больших файлов
}
```

2. Добавить ESLint handler в секцию `handlers`:

```lua
handlers = {
  ts_ls = false,  -- ✓ уже есть (typescript-tools обрабатывает)

  -- NEW: Настроить ESLint LSP
  eslint = function(_, opts)
    require("lspconfig").eslint.setup({
      on_attach = function(client, bufnr)
        -- Отключить форматирование (prettier обрабатывает)
        client.server_capabilities.documentFormattingProvider = false

        -- Авто-фикс при сохранении
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "EslintFixAll",
        })
      end,
      settings = {
        workingDirectory = { mode = "auto" },
        format = false,  -- Не использовать ESLint для форматирования
      }
    })
  end
}
```

---

### Шаг 4: Обновить typescript-tools

**Файл:** `lua/plugins/typescript-tools.lua`

**Действия:**

Обновить строку 13 (добавить `on_attach` перед `settings`):

```lua
require("typescript-tools").setup {
  on_attach = function(client, bufnr)
    -- Отключить форматирование (none-ls обрабатывает через prettier)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
  settings = {
    -- существующие настройки остаются без изменений...
    separate_diagnostic_server = false,
    complete_function_calls = true,
    -- и т.д.
  }
}
```

---

## Конфигурационные файлы для проектов

### `.prettierrc.json` (создать в корне каждого проекта)

```json
{
  "semi": true,
  "trailingComma": "es5",
  "singleQuote": true,
  "printWidth": 100,
  "tabWidth": 2,
  "useTabs": false,
  "arrowParens": "avoid",
  "endOfLine": "lf"
}
```

### `.eslintrc.json` (создать в корне TypeScript/React проекта)

```json
{
  "env": {
    "browser": true,
    "es2021": true,
    "node": true
  },
  "extends": [
    "eslint:recommended",
    "plugin:@typescript-eslint/recommended",
    "plugin:react/recommended",
    "plugin:react-hooks/recommended",
    "prettier"
  ],
  "parser": "@typescript-eslint/parser",
  "parserOptions": {
    "ecmaVersion": "latest",
    "sourceType": "module"
  },
  "plugins": [
    "@typescript-eslint",
    "react",
    "react-hooks"
  ],
  "rules": {
    "@typescript-eslint/no-unused-vars": ["warn", {
      "argsIgnorePattern": "^_"
    }],
    "react/react-in-jsx-scope": "off",
    "react/prop-types": "off"
  },
  "settings": {
    "react": {
      "version": "detect"
    }
  }
}
```

### Установить npm зависимости в проекте:

```bash
npm install -D \
  eslint \
  @typescript-eslint/parser \
  @typescript-eslint/eslint-plugin \
  eslint-plugin-react \
  eslint-plugin-react-hooks \
  eslint-config-prettier \
  prettier
```

---

## Горячие клавиши (опционально)

**Файл:** `lua/plugins/mappings.lua`

Добавить после существующих маппингов:

```lua
-- Форматирование и линтинг
["<Leader>lf"] = {
  function() vim.lsp.buf.format({ async = true }) end,
  desc = "Format buffer",
},

["<Leader>la"] = {
  "<cmd>EslintFixAll<CR>",
  desc = "ESLint fix all",
},

-- Показать активные none-ls источники
["<Leader>ln"] = {
  "<cmd>NullLsInfo<CR>",
  desc = "None-ls info",
},
```

---

## Проверка после настройки

### 1. Установить инструменты Mason

```vim
:Mason
```

Проверить что установлены:
- ✅ prettierd
- ✅ prettier
- ✅ eslint
- ✅ jsonls
- ✅ yamlls
- ✅ cssls
- ✅ html

### 2. Проверить none-ls источники

```vim
:NullLsInfo
```

В TypeScript файле должны быть видны:
- formatting: prettierd
- (если есть .eslintrc.json) diagnostics: eslint

В Python файле должны быть видны:
- formatting: black (или ruff)
- formatting: isort (если выбрали black)

### 3. Проверить LSP клиенты

```vim
:LspInfo
```

Убедиться что:
- typescript-tools attached (для .ts файлов)
- eslint attached (если есть .eslintrc.json)
- Форматирование disabled для lua_ls, html, cssls, jsonls, yamlls

### 4. Тест форматирования

**TypeScript файл:**
```typescript
// Создать файл с плохим форматированием
const x={a:1,b:2}
function test(  ){
return x
}
```

Сохранить (`:w`) - должно автоматически отформатироваться:
```typescript
const x = { a: 1, b: 2 };
function test() {
  return x;
}
```

**Python файл:**
```python
# Создать файл с плохим форматированием
def test(  ):
    x=[1,2,3]
    return x
```

Сохранить - должно отформатироваться через black/ruff.

### 5. Тест ESLint

```typescript
// Создать ошибку
const unusedVar = 123; // ESLint должен показать warning

// Выполнить
:EslintFixAll
// или просто сохранить файл - авто-фикс при сохранении
```

---

## Troubleshooting

### Prettier не работает

**Проверить:**
1. `:MasonInstall prettierd` - установлен?
2. `:NullLsInfo` - виден prettierd в sources?
3. Проект имеет `.prettierrc.json`?

**Решение:**
- Создать `.prettierrc.json` в корне проекта
- Перезапустить Neovim
- Проверить логи: `:messages`

### ESLint не показывает ошибки

**Проверить:**
1. Файл `.eslintrc.json` существует?
2. `npm install` выполнен в проекте?
3. `:LspInfo` показывает eslint клиента?

**Решение:**
- Создать `.eslintrc.json`
- Установить eslint: `npm install -D eslint`
- Перезапустить LSP: `:LspRestart`

### Несколько форматтеров конфликтуют

**Проверить:**
`:LspInfo` - сколько клиентов с documentFormattingProvider?

**Решение:**
Добавить в `formatting.disabled` в astrolsp.lua имена LSP которые конфликтуют.

### Python форматирование не работает

**Если используете black + isort:**
```vim
:NullLsInfo
```
Должны быть видны оба форматтера.

**Если используете ruff:**
- Закомментировать black и isort в none-ls.lua
- Оставить только ruff
- Перезапустить Neovim

---

## Итоговая архитектура

### Форматирование по языкам:

| Язык | Форматтер | Через |
|------|-----------|-------|
| TypeScript/JavaScript | prettierd | none-ls |
| JSON/YAML | prettierd | none-ls |
| CSS/HTML | prettierd | none-ls |
| Markdown | prettierd | none-ls |
| Lua | stylua | none-ls |
| Python | black + isort (или ruff) | none-ls |

### Линтинг по языкам:

| Язык | Линтер | Через |
|------|--------|-------|
| TypeScript/JavaScript | ESLint | eslint LSP |
| Python | ruff / mypy | установлены через Mason |
| Lua | selene | установлен через Mason |
| Markdown | markdownlint | none-ls (опционально) |

### Интеллект (LSP):

| Язык | LSP | Статус |
|------|-----|--------|
| TypeScript | typescript-tools.nvim | ✅ Работает |
| Python | pyright | ✅ Работает |
| Lua | lua_ls | ✅ Работает |
| HTML | html | Нужно установить |
| CSS | cssls | Нужно установить |
| JSON | jsonls | Нужно установить |
| YAML | yamlls | Нужно установить |
| Docker | docker-language-server | ✅ Работает |

### Workflow при сохранении файла:

1. Пользователь нажимает `:w`
2. AstroLSP запускает `format_on_save`
3. none-ls выполняет соответствующий форматтер:
   - TypeScript → prettierd
   - Python → black + isort (или ruff)
   - Lua → stylua
4. ESLint выполняет `EslintFixAll` (авто-фикс)
5. Файл сохраняется отформатированным

### Производительность:

- **prettierd**: ~10-20ms на файл (daemon)
- **black**: ~50-100ms на файл
- **ruff**: ~5-10ms на файл (Rust, очень быстрый)
- **stylua**: ~5ms на файл

**Общее время форматирования:** <100ms для типичных файлов

---

## Дополнительные рекомендации

### 1. EditorConfig

Создать `.editorconfig` в корне проекта для консистентности:

```ini
root = true

[*]
indent_style = space
indent_size = 2
end_of_line = lf
charset = utf-8
trim_trailing_whitespace = true
insert_final_newline = true

[*.py]
indent_size = 4

[*.md]
trim_trailing_whitespace = false
```

### 2. Ruff вместо black + isort (опционально)

Если хотите максимальную скорость для Python:

```lua
-- В none-ls.lua заменить black + isort на:
null_ls.builtins.formatting.ruff,
null_ls.builtins.diagnostics.ruff,
```

**Преимущества ruff:**
- В 10-100 раз быстрее
- Заменяет black, isort, flake8, pylint и многие другие
- Один конфиг вместо нескольких
- Написан на Rust

### 3. Biome для новых JavaScript проектов (опционально)

Для новых проектов можно попробовать Biome вместо ESLint + Prettier:

```vim
:MasonInstall biome
```

```lua
-- В none-ls.lua заменить prettierd на:
null_ls.builtins.formatting.biome,
```

**Преимущества:**
- Один инструмент вместо двух
- Очень быстрый (Rust)
- Совместим с Prettier на 95%+

---

## Следующие шаги

1. ✅ Установить недостающие инструменты через `:Mason`
2. ✅ Удалить guards из `lua/plugins/none-ls.lua` и `lua/plugins/mason.lua`
3. ✅ Обновить конфигурацию согласно плану выше
4. ✅ Создать `.prettierrc.json` и `.eslintrc.json` в проектах
5. ✅ Протестировать форматирование и линтинг
6. ✅ Настроить горячие клавиши (опционально)

**Время реализации:** ~15-20 минут

**Результат:** Полноценная настройка форматирования и линтинга для TypeScript, JavaScript, Python, Lua с автоматическим форматированием при сохранении.
