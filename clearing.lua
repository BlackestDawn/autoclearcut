local mod = {}

-- Function for actually clearing an area
local function clear_cutting(surface, area, player, force)
  -- Find all trees within the search area
  local listEntities = surface.find_entities_filtered({ area = area, type = "tree" })
  for _, rem_entity in pairs(listEntities) do
    if rem_entity.valid then
      rem_entity.order_deconstruction(force, player)
    end
  end

  -- Find all simple-entities within the search area
  listEntities = surface.find_entities_filtered({ area = area, name = simple_list.search_items })
  for _, rem_entity in pairs(listEntities) do
    -- Entities can become invalid mid-loop, e.g. neighbouring cliffs get replaced when a player
    -- in the map editor instantly deconstructs a cliff
    if rem_entity.valid then
      rem_entity.order_deconstruction(force, player)
    end
  end

  -- Find all items on ground within the search area
  if settings.global['autoclearcut-remove-grounditems'].value then
    listEntities = surface.find_entities_filtered({ area = area, type = "item-entity", name = "item-on-ground" })
    for _, rem_entity in pairs(listEntities) do
      if rem_entity.valid then
        rem_entity.order_deconstruction(force, player)
      end
    end
  end
end

-- Function for determining area around stationary roboports
function mod.stationary(entity, playerID)
  -- Resolve player and force once; fall back to the entity's force if no player is known
  local player = playerID and game.get_player(playerID)
  local force = player and player.force or entity.force

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

  clear_cutting(entity.surface, searchArea, player, force)
end

return mod
