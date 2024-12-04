return {
  {
    'nvim-tree/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup {
        default = true,
        override = {
          c = {
            icon = "C",     -- Use a simple "C" as an icon for C files
            color = "#6d8086",
            cterm_color = "66",
            name = "C"
          },
          lua = {
            icon = "L",     -- Use a simple "L" as an icon for Lua files
            color = "#51a0cf",
            cterm_color = "74",
            name = "Lua"
          },
          js = {
            icon = "J",     -- Use a simple "J" as an icon for JavaScript files
            color = "#f1e05a",
            cterm_color = "185",
            name = "JavaScript"
          },
          txt = {
            icon = "-",     -- Use a dash for text files
            color = "#89e051",
            cterm_color = "113",
            name = "Text"
          },
        };
      }
    end
  },
}


