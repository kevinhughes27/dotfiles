-- Auto Commands
--

local fmt_group = vim.api.nvim_create_augroup('FormattingGroup', {})
local misc_group = vim.api.nvim_create_augroup('MiscGroup', {})

-- resize windows automatically
vim.api.nvim_create_autocmd('VimResized', {
  group = misc_group,
  pattern = '*',
  command = 'wincmd =',
  desc = 'Automatically resize windows when the host window size changes.'
})

-- remove traiing whitespace
vim.api.nvim_create_autocmd('BufWritePre', {
  group = fmt_group,
  pattern = '*',
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos('.', save_cursor)
  end,
})

-- go: organize imports and format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = fmt_group,
  pattern = "*.go",
  callback = function()
    -- get the active gopls client for this buffer
    local clients = vim.lsp.get_clients({ name = "gopls", bufnr = 0 })
    if #clients == 0 then return end
    local client = clients[1]

    -- extract the offset_encoding, defaulting to utf-16 (the LSP standard)
    local enc = client.offset_encoding or "utf-16"

    -- organize imports synchronously
    local params = vim.lsp.util.make_range_params(0, enc)
    params.context = { only = { "source.organizeImports" } }

    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)

    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local edit_enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or enc
          vim.lsp.util.apply_workspace_edit(r.edit, edit_enc)
        end
      end
    end

    -- format the file via gopls
    vim.lsp.buf.format({ async = false, name = "gopls" })
  end,
})

-- automatically leave NvimTree before leaving a tab
-- this makes the tabline display a filename which is more useful
vim.api.nvim_create_autocmd('TabLeave', {
  group = misc_group,
  callback = function()
    local current_buffer = vim.api.nvim_buf_get_name(0)

    if current_buffer:match('NvimTree_%d+') then
      vim.api.nvim_exec('winc l', true)
    end
  end
})
