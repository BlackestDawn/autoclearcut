local simple_list = require("list_builder")
local clearing = require("clearing")

-- Initialize simple_list
simple_list.build()

-- Trigger when building entities of prototype roboport
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

-- update search list on settings change
script.on_event(defines.events.on_runtime_mod_setting_changed,
  function(event)
    if string.sub(event.setting, 1, 13) ~= "autoclearcut-" then return end
    simple_list.build()
  end
)
