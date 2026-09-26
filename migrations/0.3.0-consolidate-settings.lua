-- Port the per-object settings from 0.1.x into the consolidated categories.
-- A category is only enabled if every old setting folded into it was enabled,
-- so nothing a player previously excluded starts getting deconstructed.
-- "autoclearcut-remove-ruins" kept its name and needs no porting.

local function old(name)
  return settings.global["autoclearcut-remove-" .. name].value
end

local function set(name, value)
  settings.global["autoclearcut-remove-" .. name] = { value = value }
end

set("rocks", old("rocks") and old("vents") and old("lithium") and old("fulgorite"))
set("creatures", old("demolisher") and old("pentapod") and old("stromatolite"))

require("list_builder").build()
