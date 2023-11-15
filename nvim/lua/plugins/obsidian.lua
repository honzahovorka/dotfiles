return {
  'epwalsh/obsidian.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    dir = '~/vault',
    notes_subdir = "notes",

    templates = {
      subdir = "templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },
  },
}
