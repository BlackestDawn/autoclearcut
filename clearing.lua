local simple_list = require("list_builder")

local mod = {}

local function area_around(pos, radius)
  return {
    left_top = {
      x = pos.x - radius,
      y = pos.y - radius
    },
    right_bottom = {
      x = pos.x + radius,
      y = pos.y + radius
    }
  }
end

-- Function for actually clearing an area
local function clear_cutting(surface, area, player, force)
  -- Find all trees within the search area
  local listEntities = surface.find_entities_filtered({ area = area, type = "tree" })
  for _, rem_entity in pairs(listEntities) do
    if rem_entity.valid and not rem_entity.to_be_deconstructed() then
      rem_entity.order_deconstruction(force, player)
    end
  end

  -- Find all simple-entities within the search area
  listEntities = surface.find_entities_filtered({ area = area, name = simple_list.search_items })
  for _, rem_entity in pairs(listEntities) do
    -- Entities can become invalid mid-loop, e.g. neighbouring cliffs get replaced when a player
    -- in the map editor instantly deconstructs a cliff
    if rem_entity.valid and not rem_entity.to_be_deconstructed() then
      rem_entity.order_deconstruction(force, player)
    end
  end

  -- Find all items on ground within the search area
  if settings.global['autoclearcut-remove-grounditems'].value then
    listEntities = surface.find_entities_filtered({ area = area, type = "item-entity", name = "item-on-ground" })
    for _, rem_entity in pairs(listEntities) do
      if rem_entity.valid and not rem_entity.to_be_deconstructed() then
        rem_entity.order_deconstruction(force, player)
      end
    end
  end
end

-- Function for determining area around stationary roboports and then clearing it
function mod.stationary(entity, playerID)
  -- Resolve player and force once; fall back to the entity's force if no player is known
  local player = playerID and game.get_player(playerID)
  local force = player and player.force or entity.force

  local radius = entity.prototype.construction_radius - settings.global["autoclearcut-margin-distance"].value
  if radius <= 0 then return end

  clear_cutting(entity.surface, area_around(entity.position, radius), player, force)
end

-- Function for clearing area around player
function mod.mobile(player)
  if not player.character or not player.character.logistic_cell then return end
  if not player.character.allow_dispatching_robots then return end

  local radius = player.character.logistic_cell.construction_radius - settings.global["autoclearcut-margin-distance"].value
  if radius <= 0 then return end

  clear_cutting(player.character.surface, area_around(player.character.position, radius), player, player.force)
end

return mod
