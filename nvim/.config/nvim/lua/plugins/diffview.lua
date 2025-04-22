return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("diffview").setup({
      view = {
        merge_tool = {
          layout = "diff3_mixed",
          disable_diagnostics = false,
          winbar_info = true,
        },
      },
      hooks = {
        view_opened = function()
          require("diffview.actions").toggle_files()
        end,
      },
    })
  end,
}


