data:extend({
  -- Keyboard shortcut for toggling clearing around the player
  {
    type = "custom-input",
    name = "autoclearcut-toggle-mobile",
    key_sequence = "SHIFT + ALT + C",
    consuming = "none",
    order = "a"
  },
  -- Action bar button for toggling clearing around the player, its toggled state is what's used to determine if it's on or off
  {
    type = "shortcut",
    name = "autoclearcut-toggle-mobile",
    order = "c[toggles]-z[autoclearcut]",
    action = "lua",
    toggleable = true,
    associated_control_input = "autoclearcut-toggle-mobile",
    icon = "__autoclearcut__/graphics/icons/toggle-mobile-x56.png",
    icon_size = 56,
    small_icon = "__autoclearcut__/graphics/icons/toggle-mobile-x24.png",
    small_icon_size = 24
  }
})
