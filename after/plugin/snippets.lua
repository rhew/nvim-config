-- TODO convert to Lua
vim.cmd [[
  imap <silent><expr> <C-K> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<C-K>' 
  inoremap <silent> <C-J> <cmd>lua require'luasnip'.jump(-1)<Cr>

  snoremap <silent> <C-K> <cmd>lua require('luasnip').jump(1)<Cr>
  snoremap <silent> <C-J> <cmd>lua require('luasnip').jump(-1)<Cr>
]]

local ls = require"luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("all", {
  s("JIRA", {
    i(1, "Jira story title..."),
    t({"", "", ""}), i(2, "Introduction..."),
    t({"", "", ".h2 Details"}),
    t({"", "  * "}), i(3, "Detail..."),
    t({"", "", ".h2 Acceptance Criteria"}),
    t({"", "  * "}), i(4, "Criterium..."),
  })
})
