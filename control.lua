local simple_list = require("list_builder")

-- Main function: Form search area, find trees/entities and mark them
local function acc_clear_cutting(entity, player)
  -- Form search are by getting radius from roboport, adjust it for safety margin, and make sure it's not negative
  local radius = entity.prototype.construction_radius - settings.global["autoclearcut-margin-distance"].value
  if radius < 0 then
    radius = 0
  end
  local searchArea = {
    left_top = {
      x = entity.position.x - radius,
      y = entity.position.y - radius
    },
    right_bottom = {
      x = entity.position.x + radius,
      y = entity.position.y + radius
    }
  }

  -- Find all trees within the search area
  local listEntities = game.surfaces[entity.surface_index].find_entities_filtered({ area = searchArea, type = "tree" })
  for _, rem_entity in pairs(listEntities) do
    rem_entity.order_deconstruction(game.get_player(player).force, game.get_player(player))
  end

  -- Find all simple-entities within the search area
  listEntities = game.surfaces[entity.surface_index].find_entities_filtered({ area = searchArea, name = simple_list
  .search_items })
  for _, rem_entity in pairs(listEntities) do
    rem_entity.order_deconstruction(game.get_player(player).force, game.get_player(player))
  end
end

-- Initialize simple_list
simple_list.build()

-- Trigger when building entities of prototype roboport
script.on_event(defines.events.on_built_entity,
  function(event)
    local playerID
    if event.player_index ~= nil then
      playerID = event.player_index
    end
    acc_clear_cutting(event.entity, playerID)
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
    acc_clear_cutting(event.entity, playerID)
  end,
  { { filter = "type", type = "roboport" } }
)
