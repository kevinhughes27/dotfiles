return {
  {
    'rafcamlet/tabline-framework.nvim',
    lazy = true,
    event = 'TabNew',
    keys = {
      { '<C-z>', ':tab split<CR>', silent = true, desc = 'zoom (opens new tab)' },
      { '<Tab>', ':tabnext<CR>', silent = true },
      { '<S-Tab>', ':tabprev<CR>', silent = true },
    },
    config = function()
      require('tabline_framework').setup({
        render = function(f)
          f.add 'tabs: '

          -- Pre-calculate unique tab names for all open buffers
          local tab_names = {}
          local buffers = {}

          -- Collect all loaded buffers
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_loaded(buf) then
              local path = vim.api.nvim_buf_get_name(buf)
              if path ~= '' then
                local filename = vim.fn.fnamemodify(path, ':t')
                if filename ~= '' then
                  table.insert(buffers, { path = path, filename = filename })
                end
              end
            end
          end

          -- Calculate unique display names for each buffer
          for _, buf in ipairs(buffers) do
            local filename = buf.filename
            local path = buf.path

            -- Check for filename conflicts with other buffers
            local has_conflict = false
            for _, other in ipairs(buffers) do
              if other.path ~= path and other.filename == filename then
                has_conflict = true
                break
              end
            end

            local display_name

            if not has_conflict then
              display_name = filename
            else
              -- Add path components to disambiguate
              local path_parts = vim.split(path, '/')
              local parent_dir = path_parts[#path_parts - 1]
              display_name = parent_dir .. '/' .. filename

              -- Check if parent directory is sufficient for uniqueness
              local is_unique = true
              for _, other in ipairs(buffers) do
                if other.path ~= path then
                  local other_parent = vim.fn.fnamemodify(other.path, ':h:t')
                  if other_parent == parent_dir and other.filename == filename then
                    is_unique = false
                    break
                  end
                end
              end

              -- If still not unique, add more path components
              if not is_unique then
                for i = #path_parts - 2, 1, -1 do
                  display_name = path_parts[i] .. '/' .. display_name

                  -- Check uniqueness with this longer path
                  is_unique = true
                  for _, other in ipairs(buffers) do
                    if other.path ~= path then
                      local other_short = vim.fn.fnamemodify(other.path, ':~')
                      if other_short:match('.*' .. display_name .. '$') then
                        is_unique = false
                        break
                      end
                    end
                  end

                  if is_unique then
                    break
                  end
                end

                -- Fallback to full relative path if still not unique
                if not is_unique then
                  display_name = vim.fn.fnamemodify(path, ':~')
                end
              end
            end

            tab_names[path] = display_name
          end

          f.make_tabs(function(info)
            f.add ' '
            if info.filename then
              f.add { f.icon(info.filename) .. ' ' }
              f.add(tab_names[info.buf_name] or info.filename)
              f.add(info.modified and '+')
            else
              f.add(info.modified and '[+]' or '[-]')
            end
            f.add ' '
          end)
        end
      })
    end,
  },
}
