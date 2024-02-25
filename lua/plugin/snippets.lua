local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
-- local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
-- local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local events = require("luasnip.util.events")
-- local ai = require("luasnip.nodes.absolute_indexer")
-- local extras = require("luasnip.extras")
-- local l = extras.lambda
-- local rep = extras.rep
-- local p = extras.partial
-- local m = extras.match
-- local n = extras.nonempty
-- local dl = extras.dynamic_lambda
-- local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta
-- local conds = require("luasnip.extras.expand_conditions")
-- local postfix = require("luasnip.extras.postfix").postfix
-- local types = require("luasnip.util.types")
-- local parse = require("luasnip.util.parser").parse_snippet
-- local ms = ls.multi_snippet
-- local k = require("luasnip.nodes.key_indexer").new_key


local jsnippets = {
  s({ trig = "imp" }, {
    t("import "),i(1),t(" from "),i(2),t(";")
  }),
  s({ trig = "stest" }, {
    t('import { describe, test, expect } from "bun:test";'),
    t({"",""}),
    t({
      "describe('Describe', () => {",
      "",
      "\ttest('Test', () => {",
      "\t\texpect().toBe();",
      "\t})",
      "",
      "});"
    })
  }),
	s({ trig = "func" }, {
    t("function "),i(0),t({"() {", "\t", "}"})
  }),
	s({ trig = "cl" }, {
    t("console.log("),i(0),t(")")
  }),
  s({ trig = "try" }, {
    t({ "try {", "\t" }),i(0),
    t({
      "",
      "} catch (e) {",
      "\t",
      "}"
    })
  }),
	s({ trig = "for" }, {
    t("for (let i = 0, len = "),i(0),
    t({
      ";i < len;i++) {",
      "\t",
      "}"
    })
  }),
}

ls.add_snippets("typescript", jsnippets)
ls.add_snippets("javascript", jsnippets)
ls.add_snippets("svelte", jsnippets)


