return {
  'junegunn/fzf',
  config = function()
    local g = vim.g

    -- actions
    g.fzf_action = {
      ['ctrl-t'] = 'tab split',
      ['ctrl-s'] = 'split',
      ['ctrl-h'] = 'vsplit',
    }

    -- preview window
    g.fzf_preview_window = 'right:60%:sharp'

    -- layout
    if vim.fn.exists('$TMUX') == 1 then
      g.fzf_tmux = 1
      g.fzf_layout = {
        tmux = '-p 90%,90%'
      }
    else
      g.fzf_tmux = 0
      g.fzf_layout = {
        window = {
          width = 0.9,
          height = 0.9,
        }
      }
    end

    -- toggle tmux layout
    vim.api.nvim_create_user_command("FzfTmuxToggle", function()
      if g.fzf_tmux == 1 then
        g.fzf_tmux = 0
        g.fzf_layout = {
          window = {
            width = 0.9,
            height = 0.9,
          }
        }
      else
        g.fzf_tmux = 1
        g.fzf_layout = {
          tmux = '-p 90%,90%'
        }
      end
    end, {
      nargs = 0,
      desc = "Toggle Fzf to use a vim window. Needed for pairing to display fzf"
    })

    -- colors
    g.fzf_colors = {
      fg =      {'fg', 'Normal'},
      bg =      {'bg', 'Normal'},
      hl =      {'fg', 'Label'},
      info =    {'fg', 'Comment'},
      border =  {'fg', 'Ignore'},
      prompt =  {'fg', 'Function'},
      pointer = {'fg', 'Statement'},
      marker =  {'fg', 'Conditional'},
      spinner = {'fg', 'Label'},
      header =  {'fg', 'Comment'},
    }
    g.fzf_colors['fg+'] = {'fg', 'CursorLine', 'CursorColumn', 'Normal'}
    g.fzf_colors['bg+'] = {'bg', 'CursorLine', 'CursorColumn'}
    g.fzf_colors['hl+'] = {'fg', 'Label'}


    -- fzf
    -- https://github.com/junegunn/fzf/blob/master/README-VIM.md
    local function fzf(source, options)
      local fzf_run = vim.fn["fzf#run"]
      local fzf_wrap = vim.fn["fzf#wrap"]

      -- typically fzf_wrap would setup --expects and the sinklist but
      -- it does so with an anonymous vim function which does not live
      -- outside of the first vim.fn call meaning it is undefined when
      -- we call fzf_run. Therefore we have to setup the expected keys
      -- and sinklist ourselves. fzf_wrap is still useful for setting
      -- the layout and colors.

      local action_keys = {}
      for k in pairs(g.fzf_action) do action_keys[#action_keys + 1] = k end
      options = options .. " --expect=" .. table.concat(action_keys, ",")

      local sinklist = function(lines)
        local count = 0
        for _ in pairs(lines) do count = count + 1 end

        -- cancelled
        if count == 0 then return end

        -- normal case:
        -- optional action + one file
        if count == 2 then
          local key = lines[1]
          local match = lines[2]

          local file = string.match(match, "(.-):") or match
          local lineno = string.match(match, ":(.-):")

          -- action if any (e.g. split)
          local action = g.fzf_action[key]
          if action then vim.cmd(action) end

          -- open the file
          vim.cmd("e " .. file)

          -- move to line
          if lineno then vim.cmd(":" .. lineno) end

          return
        end

        -- multiple files -> quickfix
        if count > 2 then
          local qflist = {}
          for i,v in ipairs(lines) do
            if i > 1 then
              local file = string.match(v, "(.-):")
              local lineno = string.match(v, ":(.-):")
              table.insert(qflist, {filename = file, lnum = lineno})
            end
          end
          vim.fn.setqflist(qflist)
          vim.cmd("copen")
        end
      end

      fzf_run(fzf_wrap({
        source = source,
        options = options,
        sinklist = sinklist
      }))
    end

    -- Files
    vim.api.nvim_create_user_command("Files", function()
      local source = '' -- FZF_DEFAULT_COMMAND
      local options = '--preview "bat --style=numbers --color=always {}"'
      fzf(source, options)
    end, {})


    -- RecentBuffers
    -- needed for RecentFiles because oldfiles does not update until vim is closed
    -- based on https://github.com/smartpde/telescope-recent-files
    local recent_buffers = {}

    _G.track_recent_buffers = function()
      local bufnr = vim.api.nvim_get_current_buf()
      local file = vim.api.nvim_buf_get_name(bufnr)
      table.insert(recent_buffers, file)
    end

    vim.cmd([[
      augroup recent_files
        au!
        au! bufenter * lua track_recent_buffers()
      augroup end
    ]])

    vim.api.nvim_create_user_command("RecentBuffers", function()
      local source = recent_buffers
      local options = '--prompt "Buffers> " --preview "bat --style=numbers --color=always {}"'
      fzf(source, options)
    end, {})


    -- RecentFiles
    -- based on https://github.com/smartpde/telescope-recent-files
    local function get_recent_files()
      local function uniq(t)
        local result = {}
        local seen = {}
        for _,v in ipairs(t) do
          if not seen[v] then
            seen[v] = true
            table.insert(result, v)
          end
        end
        return result
      end

      local function stat(filename)
        local s = vim.loop.fs_stat(filename)
        if not s then
          return nil
        end
        return s.type
      end

      local recent_files = {}

      for _,file in ipairs(recent_buffers) do
        if stat(file) then
          file = vim.fn.fnamemodify(file, ":~:.")
          table.insert(recent_files, file)
        end
      end

      for _, file in ipairs(vim.v.oldfiles) do
        if stat(file) then
          file = vim.fn.fnamemodify(file, ":~:.")
          table.insert(recent_files, file)
        end
      end

      return uniq(recent_files)
    end

    vim.api.nvim_create_user_command("RecentFiles", function()
      local source = get_recent_files()
      local options = '--prompt "Recent> " --preview "bat --style=numbers --color=always {}"'
      fzf(source, options)
    end, {})


    -- Rg
    vim.api.nvim_create_user_command("Rg", function(args)
      local source = 'rg --hidden --glob "!.git/*" --column --line-number --color=always --smart-case -- ' .. args.args
      local preview = '--delimiter : --preview "bat --style=numbers --color=always --highlight-line {2} {1}" --preview-window +{2}-/2'
      local options = string.format('--prompt "Rg> " --ansi --multi %s', preview)
      fzf(source, options)
    end, { nargs = 1 })


    -- RG
    -- live ripgrep. fzf acts as selector only
    vim.api.nvim_create_user_command("RG", function(args)
      local command_fmt = 'rg --hidden --glob "!.git/*" --column --line-number --no-heading --color=always --smart-case -- %s || true'
      local initial_command = string.format(command_fmt, args.args)
      local reload_command = string.format(command_fmt, '{q}')

      local source = initial_command
      local preview = "--delimiter : --preview 'bat --style=numbers --color=always --highlight-line {2} {1}' --preview-window +{2}-/2"
      local options = string.format("--prompt 'RG> ' --ansi --multi %s --query '%s' --bind 'change:reload:%s'", preview, args.args, reload_command)

      fzf(source, options)
    end, { nargs = "*" })
  end
}
