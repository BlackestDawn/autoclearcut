data:extend({
  {
    type = "int-setting",
    name = "autoclearcut-margin-distance",
    setting_type = "runtime-global",
    default_value = 1,
    order = "a"
  },
  {
    type = "bool-setting",
    name = "autoclearcut-remove-rocks",
    setting_type = "runtime-global",
    default_value = true,
    order = "b"
  },
  {
    type = "bool-setting",
    name = "autoclearcut-remove-cliffs",
    setting_type = "runtime-global",
    default_value = true,
    order = "c"
  },
  {
    type = "bool-setting",
    name = "autoclearcut-remove-grounditems",
    setting_type = "runtime-global",
    default_value = false,
    order = "d"
  },
  {
    type = "bool-setting",
    name = "autoclearcut-remove-creatures",
    setting_type = "runtime-global",
    default_value = true,
    order = "g"
  },
  {
    type = "bool-setting",
    name = "autoclearcut-remove-ruins",
    setting_type = "runtime-global",
    default_value = true,
    order = "h"
  },
  {
    type = "bool-setting",
    name = "autoclearcut-remove-other",
    setting_type = "runtime-global",
    default_value = true,
    order = "i"
  }
})

-- Legacy settings from 0.2.0 and earlier, hidden and only kept so migrations/0.3.0-consolidate-settings.lua can read their values.
-- Can be removed in a later version once saves have had a chance to migrate.
local legacy = { "demolisher", "vents", "fulgorite", "pentapod", "stromatolite", "lithium" }
for _, name in pairs(legacy) do
  data:extend({
    {
      type = "bool-setting",
      name = "autoclearcut-remove-" .. name,
      setting_type = "runtime-global",
      default_value = true,
      hidden = true
    }
  })
end
