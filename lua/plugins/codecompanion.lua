-- lua/user/plugins/codecompanion.lua
return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("codecompanion").setup {
      display = {
        action_palette = {
          width = 100,
          height = 15,
          prompt = "🔍 AI команда > ",
          provider = "default", -- или "telescope"
          opts = {
            show_default_actions = true,
            show_default_prompt_library = true,
            title = "🚀 CodeCompanion Actions",
          },
        },
      },
      adapters = {
        http = {
          my_openai = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              env = {
                -- ключ от ВАШЕГО сервера (не от platform.openai.com)
                api_key = os.getenv "OPENAI_API_KEY",
                -- ВАЖНО: сразу с /v1, если ваш сервер так ожидает
                url = "https://api.proxyapi.ru/openai/v1",
                -- или вариант из issue:
                -- url = "https://your.custom.endpoint/v1",
                chat_url = "/chat/completions",
              },
              schema = {
                model = {
                  default = "gpt-4.1-mini",
                },
              },
            })
          end,

          ollama = function()
            return require("codecompanion.adapters").extend("ollama", {
              env = {
                url = "http://192.168.1.118:11434",
                api_key = "OLLAMA_API_KEY",
              },
              headers = {
                ["Content-Type"] = "application/json",
                ["Authorization"] = "Bearer ${api_key}",
              },
              parameters = {
                sync = true,
              },
              schema = {
                model = {
                  default = "llama3.1:latest",
                },
              },
            })
          end,
        },
      },

      strategies = {
        chat = {
          adapter = "my_openai",
        },
        inline = {
          adapter = "my_openai",
        },
        agent = {
          adapter = "my_openai",
        },
      },
      opts = {
        send_code = true,
        use_default_actions = true,
      },
      -- 🔥 Custom Prompt Library
      prompt_library = {
        -- 🧪 GENERATE UNIT TESTS
        ["Generate Unit Tests"] = {
          strategy = "chat",
          description = "🧪 Generate production-ready tests",
          opts = {
            short_name = "tests",
            auto_submit = true,
            stop_context_insertion = true,
          },
          prompts = {
            {
              role = "system",
              content = [[You are an expert test engineer. Write production-ready tests ONLY.

NEVER ask user for anything. NEVER say "I will..." - just DO IT immediately.]],
            },
            {
              role = "user",
              content = function(context)
                local text = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
                return [[@{full_stack_dev}

Write comprehensive unit tests for this code:

```]] .. context.filetype .. "\n" .. text .. [[```

IMMEDIATE ACTIONS:
1. Use @{file_search} to find: .cursor/rules/test.mdc, package.json, tsconfig.json
2. Use @{read_file} on those files to understand test framework and style
3. Use @{grep_search} to find existing test files and patterns
4. Use @{create_file} to create test file
5. Use @{cmd_runner} to run:
   - npx eslint <path>
   - npx tsc --noEmit <path>
   - yarn test:unit <path>
6. Use @{insert_edit_into_file} to fix any errors
7. Repeat steps 5-6 until all pass

COVERAGE: Happy path ✅ | Edge cases ❌ | Errors 🚨 | Async ⏱️

DO IT NOW. No explanations.]]
              end,
            },
          },
        },

        -- 🔍 CODE REVIEW
        ["Code Review"] = {
          strategy = "chat",
          description = "🔍 Review code quality & suggest improvements",
          opts = {
            short_name = "review",
            auto_submit = true,
            stop_context_insertion = true,
          },
          prompts = {
            {
              role = "system",
              content = [[You are a senior code reviewer. Analyze deeply, suggest improvements.]],
            },
            {
              role = "user",
              content = function(context)
                local text = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
                return [[@{files}

Review this code:

```]] .. context.filetype .. "\n" .. text .. [[```

ACTIONS:
1. Use @{list_code_usages} to find how this code is used
2. Use @{grep_search} to check for similar patterns in codebase
3. Use @{read_file} to read related files if needed

ANALYZE:
🐛 Bugs & edge cases
⚡ Performance issues
🔒 Security vulnerabilities
📐 Code quality & patterns
♻️ Maintainability concerns

Format: [CATEGORY] Issue → Suggestion]]
              end,
            },
          },
        },

        -- 🔧 REFACTOR CODE
        ["Refactor"] = {
          strategy = "chat",
          description = "♻️ Refactor code for better quality",
          opts = {
            short_name = "refactor",
            auto_submit = true,
            stop_context_insertion = true,
          },
          prompts = {
            {
              role = "system",
              content = [[You are an expert at refactoring. Improve code while preserving functionality.]],
            },
            {
              role = "user",
              content = function(context)
                local text = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
                return [[@{full_stack_dev}

Refactor this code:

```]] .. context.filetype .. "\n" .. text .. [[```

ACTIONS:
1. Use @{list_code_usages} to understand how code is used
2. Use @{grep_search} to find similar patterns in codebase
3. Use @{insert_edit_into_file} to apply refactoring
4. Use @{cmd_runner} to run tests and ensure no breaking changes

Focus on:
- Extract complex logic
- Remove duplication
- Improve naming
- Simplify conditionals
- Add type safety

Rules: Maintain exact behavior, no breaking changes.]]
              end,
            },
          },
        },

        -- 🐛 DEBUG & FIX
        ["Debug"] = {
          strategy = "chat",
          description = "🐛 Debug and fix issues",
          opts = {
            short_name = "debug",
            auto_submit = false,
            user_prompt = true,
          },
          prompts = {
            {
              role = "system",
              content = [[You are an expert debugger. Find root cause, fix it.]],
            },
            {
              role = "user",
              content = function(context)
                local text = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
                local input = vim.fn.input "Describe the issue: "
                return [[@{full_stack_dev}

Issue: ]] .. input .. [[

Code:
```]] .. context.filetype .. "\n" .. text .. [[```

ACTIONS:
1. Use @{list_code_usages} to understand context
2. Use @{grep_search} to find similar issues
3. Use @{cmd_runner} to reproduce the issue
4. Use @{insert_edit_into_file} to apply fix
5. Use @{cmd_runner} to verify fix works

Provide: Root cause → Explanation → Fix → Prevention]]
              end,
            },
          },
        },

        -- 📚 ADD DOCUMENTATION
        ["Document"] = {
          strategy = "chat",
          description = "📚 Add comprehensive documentation",
          opts = {
            short_name = "doc",
            auto_submit = true,
            stop_context_insertion = true,
          },
          prompts = {
            {
              role = "system",
              content = function(context)
                return [[You are a documentation expert for ]] .. context.filetype .. [[. Write clear, concise docs.]]
              end,
            },
            {
              role = "user",
              content = function(context)
                local text = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
                return [[@{files}

Document this code:

```]] .. context.filetype .. "\n" .. text .. [[```

ACTIONS:
1. Use @{grep_search} to find existing documentation style
2. Use @{read_file} to check documentation conventions
3. Use @{insert_edit_into_file} to add documentation

Include:
- Function/class purpose
- Parameters & return values
- Usage examples
- Edge cases & gotchas
- Type annotations]]
              end,
            },
          },
        },

        -- ⚡ OPTIMIZE PERFORMANCE
        ["Optimize"] = {
          strategy = "chat",
          description = "⚡ Optimize for performance",
          opts = {
            short_name = "optimize",
            auto_submit = true,
            stop_context_insertion = true,
          },
          prompts = {
            {
              role = "system",
              content = [[You are a performance optimization expert. Identify bottlenecks, improve speed.]],
            },
            {
              role = "user",
              content = function(context)
                local text = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
                return [[@{full_stack_dev}

Optimize this code:

```]] .. context.filetype .. "\n" .. text .. [[```

ACTIONS:
1. Use @{list_code_usages} to understand usage patterns
2. Use @{grep_search} to find performance-critical paths
3. Use @{insert_edit_into_file} to apply optimizations
4. Use @{cmd_runner} to run benchmarks before/after

Analyze:
- Time complexity (Big O)
- Memory usage
- Unnecessary operations
- Better algorithms/data structures
- Caching opportunities

Provide optimized version with benchmarks.]]
              end,
            },
          },
        },

        -- 💡 EXPLAIN CODE
        ["Explain"] = {
          strategy = "chat",
          description = "💡 Explain code clearly",
          opts = {
            short_name = "explain",
            auto_submit = true,
            stop_context_insertion = true,
          },
          prompts = {
            {
              role = "system",
              content = function(context)
                return [[You are a senior ]] .. context.filetype .. [[ developer. Explain code clearly.]]
              end,
            },
            {
              role = "user",
              content = function(context)
                local text = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
                return [[@{files}

Explain this code:

```]] .. context.filetype .. "\n" .. text .. [[```

ACTIONS:
1. Use @{list_code_usages} to show how it's used
2. Use @{grep_search} to find related code
3. Use @{read_file} for additional context

Cover:
- What it does (high-level)
- How it works (step-by-step)
- Why it's written this way
- Important patterns/concepts
- Potential issues or gotchas]]
              end,
            },
          },
        },

        -- 🔒 SECURITY AUDIT
        ["Security"] = {
          strategy = "chat",
          description = "🔒 Security vulnerability audit",
          opts = {
            short_name = "security",
            auto_submit = true,
            stop_context_insertion = true,
          },
          prompts = {
            {
              role = "system",
              content = [[You are a security expert. Identify vulnerabilities, suggest fixes. Focus on OWASP Top 10.]],
            },
            {
              role = "user",
              content = function(context)
                local text = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
                return [[@{files}

Audit this code for security issues:

```]] .. context.filetype .. "\n" .. text .. [[```

ACTIONS:
1. Use @{grep_search} to find similar security patterns in codebase
2. Use @{read_file} to check related authentication/authorization code
3. Use @{list_code_usages} to trace data flow

Check for:
🔓 Injection (SQL, command, etc.)
🔓 XSS attacks
🔓 Authentication/authorization flaws
🔓 Sensitive data exposure
🔓 Insecure dependencies
🔓 Rate limiting
🔓 Input validation

Format: [SEVERITY] Vulnerability → Fix]]
              end,
            },
          },
        },
      },
    }
  end,
  keys = {
    { "<C-a>", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "🚀 AI Actions", silent = true },
    { "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "💬 AI Chat", silent = true },
    { "ga", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "➕ Add to Chat", silent = true },
  },

  cmd = { "CodeCompanion" },
}
