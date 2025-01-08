return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "ols",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "odin",
      })
    end,
  },
}
