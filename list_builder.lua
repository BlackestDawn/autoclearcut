local mod = {}

mod.search_items = {}

-- Appends all given names to the end of list
local function add(list, ...)
  for i = 1, select("#", ...) do
    list[#list + 1] = select(i, ...)
  end
end

function mod.build()
  -- Note: Rocks and similar are of type "simple-entity" which includes other stuff, so we have to exclude specifically by name.
  --       For a list of up-to-date simple entities: https://wiki.factorio.com/Data.raw#simple-entity

  local search = {}
  -- script.active_mods builds a new table on every access, so fetch it once
  local active_mods = script.active_mods
  local settings_global = settings.global

  -- Find all rocks within the search area
  if settings_global['autoclearcut-remove-rocks'].value then
    -- Base
    add(search, "big-rock", "huge-rock", "big-sand-rock")

    -- Space Age
    if active_mods["space-age"] ~= nil then
      add(search, "big-volcanic-rock", "huge-volcanic-rock", "big-fulgora-rock", "vulcanus-chimney-faded",
        "vulcanus-chimney-cold", "vulcanus-chimney", "vulcanus-chimney-short", "vulcanus-chimney-truncated",
        "fulgurite", "fulgurite-small", "lithium-iceberg-big", "lithium-iceberg-huge")
    end

    -- Alien Biomes
    if active_mods["alien-biomes"] ~= nil then
      add(search, "huge-rock-aubergine", "huge-rock-beige", "huge-rock-black", "huge-rock-brown", "huge-rock-cream",
        "huge-rock-dustyrose", "huge-rock-grey", "huge-rock-purple", "huge-rock-red", "huge-rock-tan", "huge-rock-violet",
        "huge-rock-volcanic", "huge-rock-white", "big-rock-aubergine", "big-rock-beige", "big-rock-black",
        "big-rock-brown", "big-rock-cream", "big-rock-dustyrose", "big-rock-grey", "big-rock-purple", "big-rock-red",
        "big-rock-tan", "big-rock-violet", "big-rock-volcanic", "big-rock-white", "sand-big-rock-black",
        "sand-big-rock-purple", "sand-big-rock-red", "sand-big-rock-tan", "sand-big-rock-white")
    end

    -- Maraxis
    if active_mods["maraxsis"] ~= nil then
      add(search, "big-sand-rock-underwater", "maraxsis-trench-wall", "maraxsis-trench-wall-collisionless",
        "maraxsis-chimney")
    end

    -- Cerys
    if active_mods["Cerys-Moon-of-Fulgora"] ~= nil then
      add(search, "cerys-methane-iceberg-big", "cerys-methane-iceberg-huge")
    end

    -- Moshine
    if active_mods["Moshine"] ~= nil then
      add(search, "moshine-big-fulgora-rock", "moshine-huge-volcanic-rock")
    end

    -- Muluna
    if active_mods["planet-muluna"] ~= nil then
      add(search, "lunar-rock", "lunar-huge-rock")
    end

    -- Corrundum
    if active_mods["corrundum"] ~= nil then
      add(search, "huge-corrundum-rock")
    end

    -- Paracelsin
    if active_mods["Paracelsin"] ~= nil then
      add(search, "big-metallic-rock")
    end

    -- Igrys
    if active_mods["Igrys"] ~= nil then
      add(search, "igrys-rock")
    end

    -- Planetaris: Arig
    if active_mods["planetaris-arig"] ~= nil then
      add(search, "arig-medium-sand-rock", "arig-big-sand-rock")
    end

    -- Vesta
    if active_mods["skewer_planet_vesta"] ~= nil then
      add(search, "vesta-petrite", "vesta_rock_huge")
    end

    -- Tenebris Prime
    if active_mods["tenebris-prime"] ~= nil then
      add(search, "quartz-node")
    end

    -- Pelagos
    if active_mods["pelagos"] ~= nil then
      add(search, "pelagos-big-rock")
    end

    -- Planetaris: Hyarion
    if active_mods["planetaris-hyarion"] ~= nil then
      add(search, "hyarion-huge-volcanic-rock", "hyarion-big-volcanic-rock", "hyarion-chimney", "hyarion-chimney-short",
        "hyarion-chimney-truncated", "hyarion-chimney-cold", "hyarion-chimney-faded")
    end

    -- Rabbasca
    if active_mods["planet-rabbasca"] ~= nil then
      add(search, "rabbasca-big-rock")
    end

    -- Crucible
    if active_mods["planet-crucible"] ~= nil then
      add(search, "planet-crucible-chimney", "planet-crucible-big-rock", "planet-crucible-huge-rock",
        "planet-crucible-alum-rock", "planet-crucible-alum-rock-small")
    end

    -- Muria
    if active_mods["Muria"] ~= nil then
      add(search, "big-chloric-rock")
    end

    -- Foliax
    if active_mods["foliax"] ~= nil then
      add(search, "foliax-iron-rock", "foliax-scrap-rock", "foliax-tungsten-rock")
    end

    -- Carna
    if active_mods["carna"] ~= nil then
      add(search, "carna-mecha-rock-big", "carna-mecha-rock-huge", "carna-mecha-rock2-big", "carna-interland-rock-big",
        "carna-interland-rock-medium", "carna-interland-rock-medium2")
    end

    -- Arcanyx
    if active_mods["Arcanyx"] ~= nil then
      add(search, "arcanyx-big-rock", "arcanyx-huge-rock")
    end

    -- Ribbonia
    if active_mods["ribbonia"] ~= nil then
      add(search, "artificial-big-rock", "artificial-huge-rock")
    end

    -- Eneas
    if active_mods["moon-eneas"] ~= nil then
      add(search, "rock-01-eneas", "rock-02-eneas")
    end

    -- Khemia
    if active_mods["alchemy-khemia"] ~= nil then
      add(search, "medium-rock-alchemy")
    end

    -- Obsidiax
    if active_mods["obsidiax"] ~= nil then
      add(search, "iron-rock-tree", "copper-rock-tree", "uranium-rock-tree", "tungsten-rock-tree", "calcite-rock-tree",
        "holmium-rock-tree", "scrap-rock-tree", "lithium-rock-tree", "fluorite-rock-tree", "bitumen-rock-tree",
        "sulfur-rock-tree", "wood-rock-tree")
    end

    -- Omnia
    if active_mods["omnia"] ~= nil then
      add(search, "omnia-big-rock")
    end
  end
  -- end: Rocks

  -- Find all cliffs within the search area
  if settings_global["autoclearcut-remove-cliffs"].value then
    -- Base
    add(search, "cliff")

    -- Space Age
    if active_mods["space-age"] ~= nil then
      add(search, "cliff-fulgora", "cliff-vulcanus", "cliff-gleba", "crater-cliff")
    end

    -- Maraxsis
    if active_mods["maraxsis"] ~= nil then
      add(search, "cliff-maraxsis", "cliff-maraxsis-collisionless")
    end

    -- Moshine
    if active_mods["Moshine"] ~= nil then
      add(search, "cliff-moshine")
    end

    -- Muluna
    if active_mods["planet-muluna"] ~= nil then
      add(search, "cliff-muluna")
    end

    -- Planetaris: Arig
    if active_mods["planetaris-arig"] ~= nil then
      add(search, "arig-cliff")
    end

    -- Planetaris: Hyarion
    if active_mods["planetaris-hyarion"] ~= nil then
      add(search, "hyarion-cliff", "hyarion-crater-cliff")
    end

    -- Foliax
    if active_mods["foliax"] ~= nil then
      add(search, "cliff-foliax")
    end

    -- Carna
    if active_mods["carna"] ~= nil then
      add(search, "cliff-carna")
    end
  end
  -- end: Cliffs

  -- Find all creature remains within the search area
  if settings_global['autoclearcut-remove-creatures'].value then
    -- Space Age
    if active_mods["space-age"] ~= nil then
      add(search, "small-demolisher-corpse", "medium-demolisher-corpse", "big-demolisher-corpse",
        "small-stomper-shell", "medium-stomper-shell", "big-stomper-shell",
        "copper-stromatolite", "iron-stromatolite")
    end

    -- Maraxsis
    if active_mods["maraxsis"] ~= nil then
      add(search, "maraxsis-mollusk-husk")
    end

    -- Pelagos
    if active_mods["pelagos"] ~= nil then
      add(search, "pelagos-copper-stromatolite", "pelagos-titanium-coral")
    end

    -- Lignumis
    if active_mods["lignumis"] ~= nil then
      add(search, "gold-stromatolite")
    end

    -- Planetaris Tellus
    if active_mods["planetaris-tellus"] ~= nil then
      add(search, "planetaris-magnesium-stromatolite")
    end

    -- Muria
    if active_mods["Muria"] ~= nil then
      add(search, "cotunnite-lichen-colony", "holmium-lichen-colony", "metallic-lichen-colony")
    end
  end
  -- end: Creatures

  -- Find all ruins within the search area
  if settings_global['autoclearcut-remove-ruins'].value then
    -- Space Age
    if active_mods["space-age"] ~= nil then
      add(search, "fulgoran-ruin-small", "fulgoran-ruin-medium", "fulgoran-ruin-big", "fulgoran-ruin-huge",
        "fulgoran-ruin-colossal", "fulgoran-ruin-stonehenge", "fulgoran-ruin-vault")
    end

    -- Cerys
    if active_mods["Cerys-Moon-of-Fulgora"] ~= nil then
      add(search, "cerys-ruin-small", "cerys-ruin-medium", "cerys-ruin-big", "cerys-ruin-huge", "cerys-ruin-colossal")
    end

    -- Rubia
    if active_mods["rubia"] ~= nil then
      add(search, "rubia-pole-remnants", "rubia-spidertron-remnants", "rubia-junk-pile")
    end

    -- Igrys
    if active_mods["Igrys"] ~= nil then
      add(search, "igrys-ruin")
    end

    -- Planetaris: Arig
    if active_mods["planetaris-arig"] ~= nil then
      add(search, "arig-crash")
    end

    -- Carna
    if active_mods["carna"] ~= nil then
      add(search, "carna-assembling-machine-found-snow", "carna-mecha-geyser-medium", "carna-mecha-geyser-big",
        "carna-mecha-geyser-huge", "carna-mecha-rock2-huge", "carna-interland-lamp", "carna-interland-rock-huge",
        "carna-object-small", "carna-object-medium", "carna-object-big", "carna-object-huge", "carna-object-colossal",
        "carna-object2-small", "carna-object2-medium", "carna-object2-big", "carna-object2-huge",
        "carna-object2-colossal")
    end

    -- Eneas
    if active_mods["moon-eneas"] ~= nil then
      add(search, "eneas-ruin-medium", "eneas-ruin-big", "eneas-ruin-small", "eneas-ruin-stonehenge", "stonehenge-core",
        "eneas-ruin-colossal", "eneas-ruin-huge", "eneas-ruin-huge-tall")
    end

    -- Khemia
    if active_mods["alchemy-khemia"] ~= nil then
      add(search, "small-alchemy-wreakage")
    end

    -- Abacayba
    if active_mods["Abacayba_Moon_of_Nauvis"] ~= nil then
      add(search, "abacayba-academy-ruin", "abacayba-armoury-ruin", "abacayba-engineering_bay-ruin",
        "abacayba-science_facility-ruin", "abacayba-command_centre-ruin", "abacayba-starport-ruin",
        "abacayba-factory-ruin", "abacayba-barracks-ruin", "abacayba-bunker-ruin", "abacayba-supply_depot-ruin")
    end
  end
  -- end: Ruins

  -- Find all re-plantable and/or non tree-type plant items within the search area
  if settings_global["autoclearcut-remove-plants"].value then
    -- Space Age
    if active_mods["space-age"] ~= nil then
      add(search, "yumako-tree", "jellystem")
    end

    -- Tenebris Prime
    if active_mods["tenebris-prime"] ~= nil then
      add(search, "tenecap", "lucifunnel", "glowdentale")
    end

    -- Pelagos
    if active_mods["pelagos"] ~= nil then
      add(search, "coconut-palm")
    end

    -- Apia
    if active_mods["apia"] ~= nil then
      add(search, "wild-hive")
    end

    -- Muria
    if active_mods["Muria"] ~= nil then
      add(search, "eschatotaxite")
    end

    -- Foliax
    if active_mods["foliax"] ~= nil then
      add(search, "spoilage-farm-tree", "bauxite-farm-tree", "iron-farm-tree", "copper-farm-tree", "zinc-farm-tree",
        "tin-farm-tree", "lead-farm-tree", "bitumen-farm-tree", "uranium-farm-tree", "calcite-farm-tree",
        "tungsten-farm-tree", "obsidian-farm-tree", "holmium-farm-tree", "lithium-farm-tree", "fluorite-farm-tree",
        "scrap-farm-tree", "stone-farm-tree", "coal-farm-tree", "wood-farm-tree", "arcane-farm-tree",
        "promethium-farm-tree", "yumako-farm-tree", "jellystem-farm-tree", "sulfur-farm-tree")
    end
  end
  -- end: Plants

  -- Find all "other" items within the search area
  if settings_global["autoclearcut-remove-other"].value then
    -- Eneas
    if active_mods["moon-eneas"] ~= nil then
      add(search, "debris-a", "debris-b", "debris-c")
    end
  end
  -- end: Others

  mod.search_items = search
end

return mod
