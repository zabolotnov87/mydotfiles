local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local fmt = require("luasnip.extras.fmt").fmt
local extras = require("luasnip.extras")
local m = extras.m
local l = extras.l
local rep = extras.rep
local postfix = require("luasnip.extras.postfix").postfix

ls.config.setup({store_selection_keys="<Tab>"})

ruby = {
  s({trig="pry"}, {t("require 'pry'; ::Kernel.binding.pry")}),

  s({trig="d"}, {
    t("def "), i(1, "method"), sn(2, {t("("), i(1, "args"), t(")")}),
    t({"", "  "}), i(0),
    t({"", "end"}),
  }),
}

ls.add_snippets("ruby", ruby)
