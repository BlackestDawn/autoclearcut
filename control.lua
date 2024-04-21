-- The actual deconstruction function.
local function acc_order_deconstruction(entity, player_index)
	-- Sets the deconstruction order to be done by the
	-- robots belonging to the player who triggered the event.
	entity.order_deconstruction(game.get_player(player_index).force, game.get_player(player_index))
end


local function acc_clear_cutting(entity, player)
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

	-- Find all trees within the bounding box.
	listTrees = game.surfaces[entity.surface_index].find_entities_filtered({area = searchArea, type = "tree"})
	-- Loop through the tree list and order their deconstruction.
	for i,tree in pairs(listTrees) do
		acc_order_deconstruction(tree, player)
	end
	-- Optionally, if rocks are to be deconstructed too, repeat for them.
	-- Note: Rocks are of type "simple-entity" which includes other stuff, so we have to exclude specifically by name.
	--       For a list of up-to-date simple entities: https://wiki.factorio.com/Data.raw#simple-entity
	if settings.global['autoclearcut-remove-rocks'].value then
		-- Find all rocks within the bounding box.
		listRocks = game.surfaces[entity.surface_index].find_entities_filtered({area = searchArea, name = {"rock-big", "rock-huge", "sand-rock-big"}})
		-- Loop through the rocks list and order their deconstruction.
		for i,rock in pairs(listRocks) do
			acc_order_deconstruction(rock, player)
		end
	end
end

script.on_event(defines.events.on_built_entity,
  function(event) acc_clear_cutting(event.created_entity, event.player_index) end,
  {{filter = "type", type = "roboport"}}
)

script.on_event(defines.events.on_robot_built_entity,
  function(event) acc_clear_cutting(event.created_entity, event.player_index) end,
  {{filter = "type", type = "roboport"}}
)
