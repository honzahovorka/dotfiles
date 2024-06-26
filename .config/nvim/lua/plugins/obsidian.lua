return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    workspaces = {
      {
        name = 'personal',
        path = '~/Documents/Vault',
      },
    },

    notes_subdir = 'inbox',
    new_notes_location = 'notes_subdir',

    disable_frontmatter = true,

    templates = {
      subdir = 'templates',
      date_format = '%Y-%m-%d',
      time_format = '%H:%M:%S',
    },

    -- name new notes starting the date and ending with note name
    -- put them in the inbox subdir
    note_id_func = function(title)
      local suffix = ""
      -- get current ISO datetime with +2 hours offset from UTC for CEST
      local current_datetime = os.date("!%Y-%m-%d", os.time() + 2*3600)
      if title ~= nil then
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return current_datetime .. "_" .. suffix
    end,
  },
}
