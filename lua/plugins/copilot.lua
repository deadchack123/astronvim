return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      -- default prompts
      model = "claude-3.5-sonnet",
      prompts = {
        Explain = {
          prompt = "> /COPILOT_EXPLAIN\n\nНапишите пояснение к выбранному коду в виде абзацев текста.",
        },
        Review = {
          prompt = "> /COPILOT_REVIEW\n\nПросмотрите выбранный код.",
          -- see config.lua for implementation
        },
        Fix = {
          prompt = "> /COPILOT_GENERATE\n\nВ этом коде есть проблема. Перепишите код, чтобы он отображался с исправленной ошибкой.",
        },
        Optimize = {
          prompt = "> /COPILOT_GENERATE\n\nОптимизируйте выбранный код, чтобы улучшить производительность и читаемость.",
        },
        Docs = {
          prompt = "> /COPILOT_GENERATE\n\nПожалуйста, добавьте комментарии к документации к выбранному коду».",
        },
        Tests = {
          prompt = "> /COPILOT_GENERATE\n\nPlease generate tests for my code.",
        },
        Commit = {
          prompt = "> #git:staged\n\nНапишите сообщение о фиксации изменения с соглашением о фиксации. Убедитесь, что заголовок содержит не более 50 символов, а длина сообщения — 72 символа. Оберните все сообщение в блок кода с помощью языка gitcommit.",
        },
        TestJest = {
          prompt = "Напиши юнит тесты, используй test(), Добавь все крайнее случаи, Не используй describe, Не мокай // Mock styled components, Не используй циклы для тест кейсов, Для JSX компонентов используй enzyme, хуки вызывай через render hook, Мокай все импорты Пример мока const mockUseHasShowUserAccess = jest.fn();jest.mock('entities/user-access/hooks', () => ({useHasShowUserAccess: () => mockUseHasShowUserAccess(),}));mutation const mockMutate = jest.fn();jest.mock('entities/application-transport/hooks', () => ({useApplicationDcReject: () => ({mutate: (data: { applicationId: number; data: FormData },option: { onSuccess: () => void }) => mockMutate(data, option),}),})); form: FormInstance let mockForm: FormInstance;beforeEach(() => {const { result } = renderHook(() => Form.useForm());mockForm = result.current[0];});",
          description = "My custom Jest test prompt",
        },
      },
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
