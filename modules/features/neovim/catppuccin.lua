require("catppuccin").setup({
  background = {
    light = "latte",
    dark = "mocha",
  },

  float = {
    transparent = true,
    solid = true,
  },

  transparent_background = true,

  integrations = {
    snacks = {
      enabled = true,
      indent_scope_color = "lavender",
    },
    treesitter = true,
    mini = {
      enabled = true,
    },
  },
})

vim.cmd.colorscheme("catppuccin")
