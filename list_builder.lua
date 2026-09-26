local mod = {}

mod.search_items = {}

function mod.build()
  local search = {}

  -- Optionally, if rocks are to be deconstructed too, repeat for them.
  -- Note: Rocks are of type "simple-entity" which includes other stuff, so we have to exclude specifically by name.
  --       For a list of up-to-date simple entities: https://wiki.factorio.com/Data.raw#simple-entity
  if settings.global['autoclearcut-remove-rocks'].value then
    -- Find all rocks within the search area
    search = { "big-rock", "huge-rock", "big-sand-rock", table.unpack(search) }
    if script.active_mods["space-age"] ~= nil then
      -- SA rocks:
      search = { "big-volcanic-rock", "huge-volcanic-rock", "big-fulgora-rock", table.unpack(search) }
    end
  end

  if settings.global["autoclearcut-remove-cliffs"].value then
    -- Find all cliffs within the search area
    search = { "cliff", table.unpack(search) }
    if script.active_mods["space-age"] ~= nil then
      -- SA cliffs:
      search = { "cliff-fulgora", "cliff-vulcanus", "cliff-gleba", "crater-cliff", table.unpack(search) }
    end
  end

  if script.active_mods["space-age"] ~= nil then
    -- Vulcanus: {small, medium, big}-demolisher-corpse :: vulcanus-chimney-{faded, cold, "", short, truncated}
    if settings.global['autoclearcut-remove-demolisher'].value then
      search = { "small-demolisher-corpse", "medium-demolisher-corpse", "big-demolisher-corpse", table.unpack(search) }
    end
    if settings.global['autoclearcut-remove-vents'].value then
      search = { "vulcanus-chimney-faded", "vulcanus-chimney-cold", "vulcanus-chimney", "vulcanus-chimney-short",
        "vulcanus-chimney-truncated", table.unpack(search) }
    end

    -- Fulgora: fulgorite, fulgorite-small :: fulgoran-ruin-{small, medium, stonehenge, big, huge, colossal, vault}
    if settings.global['autoclearcut-remove-fulgorite'].value then
      search = { "fulgurite", "fulgurite-small", table.unpack(search) }
    end
    if settings.global['autoclearcut-remove-ruins'].value then
      search = { "fulgoran-ruin-small", "fulgoran-ruin-medium", "fulgoran-ruin-big", "fulgoran-ruin-huge",
        "fulgoran-ruin-colossal", "fulgoran-ruin-stonehenge", "fulgoran-ruin-vault", table.unpack(search) }
    end

    -- Gleba: {small, medium, big}-stomper-shell :: {copper, iron}-stromatolite
    if settings.global['autoclearcut-remove-pentapod'].value then
      search = { "small-stomper-shell", "medium-stomper-shell", "big-stomper-shell", table.unpack(search) }
    end
    if settings.global['autoclearcut-remove-stromatolite'].value then
      search = { "copper-stromatolite", "iron-stromatolite", table.unpack(search) }
    end

    -- Aquilo: lithium-iceberg-{big, huge}
    if settings.global['autoclearcut-remove-lithium'].value then
      search = { "lithium-iceberg-big", "lithium-iceberg-huge", table.unpack(search) }
    end
  end

  mod.search_items = search
end

return mod
