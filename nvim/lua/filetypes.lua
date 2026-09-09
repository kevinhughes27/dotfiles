-- Filetype detection
--
-- Neovim only recognizes these as dot-prefixed files (.gitconfig, .gitignore)
-- or in their usual locations (.git/config, ~/.config/git/ignore). This repo
-- keeps them un-dotted at the root, so match on the bare names too.

vim.filetype.add({
  filename = {
    gitconfig = 'gitconfig',
    gitignore = 'gitignore',
  },
})
