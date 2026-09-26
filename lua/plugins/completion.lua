require("blink.cmp").setup({
  keymap = {
    preset = "default",
    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-e>"] = { "cancel", "fallback" },
    ["<CR>"] = { "select_and_accept", "fallback" },
    ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
    ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
  },
  completion = {
    menu = { border = "rounded" },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 300,
      window = { border = "rounded" },
    },
    accept = { auto_brackets = { enabled = false } },
  },
  signature = { enabled = true, window = { border = "rounded" } },
  fuzzy = { implementation = "lua" },
})
