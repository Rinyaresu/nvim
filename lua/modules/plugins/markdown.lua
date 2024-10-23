return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    event = { 'BufEnter' },
    opts = {
      code = {
        sign = false,
        width = 'block',
        right_pad = 1,
      },
      heading = {
        sign = false,
        icons = {},
      },
    },
  },
}
