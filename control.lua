local simple_list = require("list_builder")
local clearing = require("clearing")

-- Initialize simple_list
simple_list.build()

-- Trigger only when building entities of prototype roboport
script.on_event(defines.events.on_built_entity,
  function(event)
    local playerID
    if event.player_index ~= nil then
      playerID = event.player_index
    end
    clearing.stationary(event.entity, playerID)
  end,
  { { filter = "type", type = "roboport" } }
)

script.on_event(defines.events.on_robot_built_entity,
  function(event)
    local playerID
    if event.entity.last_user ~= nil then
      playerID = event.entity.last_user.index
    elseif event.player ~= nil then
      playerID = event.player.index
    end
    clearing.stationary(event.entity, playerID)
  end,
  { { filter = "type", type = "roboport" } }
)

-- Update search list on settings change
script.on_event(defines.events.on_runtime_mod_setting_changed,
  function(event)
    if string.sub(event.setting, 1, 13) ~= "autoclearcut-" then return end
    simple_list.build()
  end
)

-- Grey out the shortcut when player has no personal roboport equipped
local function update_shortcut_available(player)
  player.set_shortcut_available("autoclearcut-toggle-mobile", clearing.has_personal_roboport(player))
end

-- Run once a second per player as to not overload the system
script.on_event(defines.events.on_tick,
  function(event)
    for _, player in pairs(game.connected_players) do
      if player.index % 60 == event.tick % 60 then
        -- Also catches changes not covered by the equipment events below, e.g. death, respawn, and editor mode
        update_shortcut_available(player)
        if player.is_shortcut_toggled("autoclearcut-toggle-mobile") then
          clearing.mobile(player)
        end
      end
    end
  end
)

-- Update shortcut availability right away on equipment and armor changes
script.on_event({
    defines.events.on_player_placed_equipment,
    defines.events.on_player_removed_equipment,
    defines.events.on_player_armor_inventory_changed
  },
  function(event)
    local player = game.get_player(event.player_index)
    if not player then return end
    update_shortcut_available(player)
  end
)

-- Toggle clearing around the player, the shortcut's toggled state doubles as the stored on/off state
local function toggle_mobile(event)
  local player = game.get_player(event.player_index)
  if not player then return end
  -- Keyboard shortcut still fires when the button is greyed out, so ignore it then
  if not player.is_shortcut_available("autoclearcut-toggle-mobile") then return end
  player.set_shortcut_toggled("autoclearcut-toggle-mobile", not player.is_shortcut_toggled("autoclearcut-toggle-mobile"))
end

script.on_event("autoclearcut-toggle-mobile", toggle_mobile)

script.on_event(defines.events.on_lua_shortcut,
  function(event)
    if event.prototype_name ~= "autoclearcut-toggle-mobile" then return end
    toggle_mobile(event)
  end
)
