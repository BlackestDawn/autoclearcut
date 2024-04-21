-- Main function: Form search area, find trees/rocks and mark them
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
	listTrees = game.surfaces[entity.surface_index].find_entities_filtered({area = searchArea, type = "tree"})
	for _,tree in pairs(listTrees) do
		tree.order_deconstruction(game.get_player(player).force, game.get_player(player))
	end
	-- Optionally, if rocks are to be deconstructed too, repeat for them.
	-- Note: Rocks are of type "simple-entity" which includes other stuff, so we have to exclude specifically by name.
	--       For a list of up-to-date simple entities: https://wiki.factorio.com/Data.raw#simple-entity
	if settings.global['autoclearcut-remove-rocks'].value then
		-- Find all rocks within the search area
		listRocks = game.surfaces[entity.surface_index].find_entities_filtered({area = searchArea, name = {"rock-big", "rock-huge", "sand-rock-big"}})
		for _,rock in pairs(listRocks) do
			rock.order_deconstruction(game.get_player(player).force, game.get_player(player))
		end
	end
end

-- Trigger when building entities of prototype roboport
script.on_event(defines.events.on_built_entity,
  function(event) acc_clear_cutting(event.created_entity, event.player_index) end,
  {{filter = "type", type = "roboport"}}
)

script.on_event(defines.events.on_robot_built_entity,
  function(event) acc_clear_cutting(event.created_entity, event.player_index) end,
  {{filter = "type", type = "roboport"}}
)
