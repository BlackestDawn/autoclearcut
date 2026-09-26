local mod = {}

mod.search_items = {}

function mod.build()
  local search = {}

  -- Note: Rocks and similar are of type "simple-entity" which includes other stuff, so we have to exclude specifically by name.
  --       For a list of up-to-date simple entities: https://wiki.factorio.com/Data.raw#simple-entity


  -- Find all rocks within the search area
  if settings.global['autoclearcut-remove-rocks'].value then
    -- Base
    search = { "big-rock", "huge-rock", "big-sand-rock", table.unpack(search) }

    -- Space Age
    if script.active_mods["space-age"] ~= nil then
      search = { "big-volcanic-rock", "huge-volcanic-rock", "big-fulgora-rock", "vulcanus-chimney-faded",
        "vulcanus-chimney-cold", "vulcanus-chimney", "vulcanus-chimney-short", "vulcanus-chimney-truncated",
        "fulgurite", "fulgurite-small", "lithium-iceberg-big", "lithium-iceberg-huge", table.unpack(search) }
    end

    -- Alien Biomes
    if script.active_mods["alien-biomes"] ~= nil then
      search = { "huge-rock-aubergine", "huge-rock-beige", "huge-rock-black", "huge-rock-brown", "huge-rock-cream",
        "huge-rock-dustyrose", "huge-rock-grey", "huge-rock-purple", "huge-rock-red", "huge-rock-tan", "huge-rock-violet",
        "huge-rock-volcanic", "huge-rock-white", "big-rock-aubergine", "big-rock-beige", "big-rock-black",
        "big-rock-brown", "big-rock-cream", "big-rock-dustyrose", "big-rock-grey", "big-rock-purple", "big-rock-red",
        "big-rock-tan", "big-rock-violet", "big-rock-volcanic", "big-rock-white", "sand-big-rock-black",
        "sand-big-rock-purple", "sand-big-rock-red", "sand-big-rock-tan", "sand-big-rock-white", table.unpack(search) }
    end

    -- Maraxis
    if script.active_mods["maraxsis"] ~= nil then
      search = { "big-sand-rock-underwater", "maraxsis-trench-wall", "maraxsis-trench-wall-collisionless",
        "maraxsis-chimney", table.unpack(search) }
    end

    -- Cerys
    if script.active_mods["Cerys-Moon-of-Fulgora"] ~= nil then
      search = { "cerys-methane-iceberg-big", "cerys-methane-iceberg-huge", table.unpack(search) }
    end

    -- Moshine
    if script.active_mods["Moshine"] ~= nil then
      search = { "moshine-big-fulgora-rock", "moshine-huge-volcanic-rock", table.unpack(search) }
    end

    -- Muluna
    if script.active_mods["planet-muluna"] ~= nil then
      search = { "lunar-rock", "lunar-huge-rock", table.unpack(search) }
    end

    -- Corrundum
    if script.active_mods["corrundum"] ~= nil then
      search = { "huge-corrundum-rock", table.unpack(search) }
    end

    -- Paracelsin
    if script.active_mods["Paracelsin"] ~= nil then
      search = { "big-metallic-rock", table.unpack(search) }
    end

    -- Igrys
    if script.active_mods["Igrys"] ~= nil then
      search = { "igrys-rock", table.unpack(search) }
    end

    -- Planetaris: Arig
    if script.active_mods["planetaris-arig"] ~= nil then
      search = { "arig-medium-sand-rock", "arig-big-sand-rock", table.unpack(search) }
    end

    -- Vesta
    if script.active_mods["skewer_planet_vesta"] ~= nil then
      search = { "vesta-petrite", "vesta_rock_huge", table.unpack(search) }
    end

    -- Tenebris Prime
    if script.active_mods["tenebris-prime"] ~= nil then
      search = { "quartz-node", table.unpack(search) }
    end

    -- Pelagos
    if script.active_mods["pelagos"] ~= nil then
      search = { "pelagos-big-rock", table.unpack(search) }
    end
  end
  -- end: Rocks

  -- Find all cliffs within the search area
  if settings.global["autoclearcut-remove-cliffs"].value then
    -- Base
    search = { "cliff", table.unpack(search) }

    -- Space Age
    if script.active_mods["space-age"] ~= nil then
      search = { "cliff-fulgora", "cliff-vulcanus", "cliff-gleba", "crater-cliff", table.unpack(search) }
    end

    -- Maraxsis
    if script.active_mods["maraxsis"] ~= nil then
      search = { "cliff-maraxsis", "cliff-maraxsis-collisionless", table.unpack(search) }
    end

    -- Moshine
    if script.active_mods["Moshine"] ~= nil then
      search = { "cliff-moshine", table.unpack(search) }
    end

    -- Muluna
    if script.active_mods["planet-muluna"] ~= nil then
      search = { "cliff-muluna", table.unpack(search) }
    end

    -- Planetaris: Arig
    if script.active_mods["planetaris-arig"] ~= nil then
      search = { "arig-cliff", table.unpack(search) }
    end
  end
  -- end: Cliffs

  -- Find all creature remains within the search area
  if settings.global['autoclearcut-remove-creatures'].value then
    -- Space Age
    if script.active_mods["space-age"] ~= nil then
      search = { "small-demolisher-corpse", "medium-demolisher-corpse", "big-demolisher-corpse",
        "small-stomper-shell", "medium-stomper-shell", "big-stomper-shell",
        "copper-stromatolite", "iron-stromatolite", table.unpack(search) }
    end

    -- Maraxsis
    if script.active_mods["maraxsis"] ~= nil then
      search = { "maraxsis-mollusk-husk", table.unpack(search) }
    end

    -- Pelagos
    if script.active_mods["pelagos"] ~= nil then
      search = { "pelagos-copper-stromatolite", "pelagos-titanium-coral", table.unpack(search) }
    end
  end
  -- end: Creatures

  -- Find all ruins within the search area
  if settings.global['autoclearcut-remove-ruins'].value then
    -- Space Age
    if script.active_mods["space-age"] ~= nil then
      search = { "fulgoran-ruin-small", "fulgoran-ruin-medium", "fulgoran-ruin-big", "fulgoran-ruin-huge",
        "fulgoran-ruin-colossal", "fulgoran-ruin-stonehenge", "fulgoran-ruin-vault", table.unpack(search) }
    end

    -- Cerys
    if script.active_mods["Cerys-Moon-of-Fulgora"] ~= nil then
      search = { "cerys-ruin-small", "cerys-ruin-medium", "cerys-ruin-big", "cerys-ruin-huge", "cerys-ruin-colossal",
        table.unpack(search) }
    end

    -- Rubia
    if script.active_mods["rubia"] ~= nil then
      search = { "rubia-pole-remnants", "rubia-spidertron-remnants", "rubia-junk-pile", table.unpack(search) }
    end

    -- Igrys
    if script.active_mods["Igrys"] ~= nil then
      search = { "igrys-ruin", table.unpack(search) }
    end

    -- Planetaris: Arig
    if script.active_mods["planetaris-arig"] ~= nil then
      search = { "arig-crash", table.unpack(search) }
    end
  end
  -- end: Ruins

  -- Find all "other" items within the search area
  if settings.global["autoclearcut-remove-other"].value then
    -- Tenebris Prime
    if script.active_mods["tenebris-prime"] ~= nil then
      search = { "tenecap", "lucifunnel", "glowdentale", table.unpack(search) }
    end

    -- Pelagos
    if script.active_mods["pelagos"] ~= nil then
      search = { "coconut-palm", table.unpack(search) }
    end
  end
  -- end: Others

  mod.search_items = search
end

return mod
