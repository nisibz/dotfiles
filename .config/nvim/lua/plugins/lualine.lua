return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  opts = function(_, opts)
    -- Remove default datetime from LazyVim's lualine_z (rightmost section)
    -- LazyVim puts time here: function() return " " .. os.date("%R") end
    opts.sections.lualine_z = {}

    -- Add built-in components to lualine_x (right section)
    table.insert(opts.sections.lualine_x, {
      "searchcount",
      icon = "🔍",
    })

    table.insert(opts.sections.lualine_x, {
      "filesize",
    })

    return opts
  end,
}
