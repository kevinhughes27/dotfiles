-- sublime style multiple cursors. ctrl-n to start.
-- Note: VM_default_mappings / VM_maps are set in plugins/init.lua because they
-- must be defined before the plugin loads.
vim.keymap.set({ 'n', 'v' }, '<C-n>', ':call g:VM_maps["Find Under"][1]')
