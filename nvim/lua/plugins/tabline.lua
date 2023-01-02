return {
  'rafcamlet/tabline-framework.nvim',
  config = function()
    require('tabline_framework').setup({
      render = function(f)
        f.add 'tabs: '

        f.make_tabs(function(info)
          f.add ' '
          if info.filename then
            f.add {
              f.icon(info.filename) .. ' ',
            }
            f.add(info.filename)
            f.add(info.modified and '+')
          else
            f.add(info.modified and '[+]' or '[-]')
          end

          f.add ' '
        end)
      end
    })
  end
}
