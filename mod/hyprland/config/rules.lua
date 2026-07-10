-- Copyright: Banki <development@xbanki.me>
--            Licensed under the MIT License.
--            See LICENSE for details.

-- App: Zen Browser
hl.window_rule({
  match = { class = "app.zen_browser.zen", },
  ["hyprbars:no_bar"] = true,
  border_size = 0,
  rounding = 8,
})

-- App: Steam
hl.window_rule({
  match = { class = "^([Ss]team)$", },
  ["hyprbars:no_bar"] = true,
  border_size = 0,
  rounding = 0,
})

hl.window_rule({
  match = { class = "^(steamwebhelper)$" },
  ["hyprbars:no_bar"] = true,
  border_size = 0,
  rounding = 0,
})

hl.window_rule({
  match = { title = "^(Friends List)$" },
  ["hyprbars:no_bar"] = true,
  border_size = 0,
  rounding = 0,
  float = true,
})

hl.window_rule({
  match = { title = "^(Steam Settings)$" },
  ["hyprbars:no_bar"] = true,
  border_size = 0,
  rounding = 0,
  float = true,
})

-- Game: RuneScape
hl.window_rule({
  match = { class = "^runescape.exe$", },
  ["hyprbars:no_bar"] = true,
  border_size = 0,
  rounding = 8,
})
