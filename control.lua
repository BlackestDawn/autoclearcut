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

-- Run once a second per player as to not overload the system
script.on_event(defines.events.on_tick,
  function(event)
    for _, player in pairs(game.connected_players) do
      if player.index % 60 == event.tick % 60 then
        clearing.mobile(player)
      end
    end
  end
)
