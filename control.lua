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
	local listEntities = game.surfaces[entity.surface_index].find_entities_filtered({area = searchArea, type = "tree"})
	for _, rem_entity in pairs(listEntities) do
		rem_entity.order_deconstruction(game.get_player(player).force, game.get_player(player))
	end

	-- Optionally, if rocks are to be deconstructed too, repeat for them.
	-- Note: Rocks are of type "simple-entity" which includes other stuff, so we have to exclude specifically by name.
	--       For a list of up-to-date simple entities: https://wiki.factorio.com/Data.raw#simple-entity
	if settings.global['autoclearcut-remove-rocks'].value then
		-- Find all rocks within the search area
	  listEntities = game.surfaces[entity.surface_index].find_entities_filtered({area = searchArea, name = {"big-rock", "huge-rock", "big-sand-rock"}})
	  for _, rem_entity in pairs(listEntities) do
		  rem_entity.order_deconstruction(game.get_player(player).force, game.get_player(player))
	  end
    if script.active_mods["space-age"] ~= nil then
      -- SA rocks:
	    listEntities = game.surfaces[entity.surface_index].find_entities_filtered({area = searchArea, name = {"big-volcanic-rock", "huge-volcanic-rock", "big-fulgora-rock"}})
	    for _, rem_entity in pairs(listEntities) do
		    rem_entity.order_deconstruction(game.get_player(player).force, game.get_player(player))
	    end
    end
	end

	if settings.global["autoclearcut-remove-cliffs"].value then
		-- Find all cliffs within the search area
	  listEntities = game.surfaces[entity.surface_index].find_entities_filtered({area = searchArea, name = {"cliff"}})
	  for _, rem_entity in pairs(listEntities) do
		  rem_entity.order_deconstruction(game.get_player(player).force, game.get_player(player))
	  end
    if script.active_mods["space-age"] ~= nil then
      -- SA cliffs:
	    listEntities = game.surfaces[entity.surface_index].find_entities_filtered({area = searchArea, name = {"cliff-fulgora", "cliff-vulcanus", "cliff-gleba", "crater-cliff"}})
	    for _, rem_entity in pairs(listEntities) do
		    rem_entity.order_deconstruction(game.get_player(player).force, game.get_player(player))
	    end
    end
	end

  if script.active_mods["space-age"] ~= nil then
    -- Vulcanus: {small, medium, big}-demolisher-corpse :: vulcanus-chimney-{faded, cold, "", short, truncated}
    if settings.global['autoclearcut-remove-demolisher'].value then
	    listEntities = game.surfaces[entity.surface_index].find_entities_filtered({area = searchArea, name = {"small-demolisher-corpse", "medium-demolisher-corpse", "big-demolisher-corpse"}})
	    for _, rem_entity in pairs(listEntities) do
		    rem_entity.order_deconstruction(game.get_player(player).force, game.get_player(player))
	    end
    end
    if settings.global['autoclearcut-remove-vents'].value then
	    listEntities = game.surfaces[entity.surface_index].find_entities_filtered({area = searchArea, name = {"vulcanus-chimney-faded", "vulcanus-chimney-cold", "vulcanus-chimney", "vulcanus-chimney-short", "vulcanus-chimney-truncated"}})
	    for _, rem_entity in pairs(listEntities) do
		    rem_entity.order_deconstruction(game.get_player(player).force, game.get_player(player))
	    end
    end

		-- Fulgora: fulgorite, fulgorite-small :: fulgoran-ruin-{small, medium, stonehenge, big, huge, colossal, vault}
    if settings.global['autoclearcut-remove-fulgorite'].value then
	    listEntities = game.surfaces[entity.surface_index].find_entities_filtered({area = searchArea, name = {"fulgurite", "fulgurite-small"}})
	    for _, rem_entity in pairs(listEntities) do
		    rem_entity.order_deconstruction(game.get_player(player).force, game.get_player(player))
	    end
    end
    if settings.global['autoclearcut-remove-ruins'].value then
	    listEntities = game.surfaces[entity.surface_index].find_entities_filtered({area = searchArea, name = {"fulgoran-ruin-small", "fulgoran-ruin-medium", "fulgoran-ruin-big", "fulgoran-ruin-huge", "fulgoran-ruin-colossal", "fulgoran-ruin-stonehenge", "fulgoran-ruin-vault"}})
	    for _, rem_entity in pairs(listEntities) do
		    rem_entity.order_deconstruction(game.get_player(player).force, game.get_player(player))
	    end
    end

		-- Gleba: {small, medium, big}-stomper-shell :: {copper, iron}-stromatolite
    if settings.global['autoclearcut-remove-pentapod'].value then
	    listEntities = game.surfaces[entity.surface_index].find_entities_filtered({area = searchArea, name = {"small-stomper-shell", "medium-stomper-shell", "big-stomper-shell"}})
	    for _, rem_entity in pairs(listEntities) do
		    rem_entity.order_deconstruction(game.get_player(player).force, game.get_player(player))
	    end
    end
    if settings.global['autoclearcut-remove-stromatolite'].value then
	    listEntities = game.surfaces[entity.surface_index].find_entities_filtered({area = searchArea, name = {"copper-stromatolite", "iron-stromatolite"}})
	    for _, rem_entity in pairs(listEntities) do
		    rem_entity.order_deconstruction(game.get_player(player).force, game.get_player(player))
	    end
    end

		-- Aquilo: lithium-iceberg-{big, huge}
    if settings.global['autoclearcut-remove-lithium'].value then
	    listEntities = game.surfaces[entity.surface_index].find_entities_filtered({area = searchArea, name = {"lithium-iceberg-big", "lithium-iceberg-huge"}})
	    for _, rem_entity in pairs(listEntities) do
		    rem_entity.order_deconstruction(game.get_player(player).force, game.get_player(player))
	    end
    end
  end
end

-- Trigger when building entities of prototype roboport
script.on_event(defines.events.on_built_entity,
  function(event)
		local playerID
		if event.player_index ~= nil then
			playerID = event.player_index
		end
		acc_clear_cutting(event.entity, playerID)
	end,
  {{filter = "type", type = "roboport"}}
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
  {{filter = "type", type = "roboport"}}
)
