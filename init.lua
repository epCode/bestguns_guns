-- =============================================================================
-- bestguns default gun pack ("real" / modern-firearm weapons)
-- =============================================================================
--
-- The stock set of realistic firearms built on the bestguns API: pistol, uzi,
-- assault rifle, semi-auto rifle, shotgun, bolt-action sniper and revolver,
-- plus the bullets they fire.
--
-- This file only uses the public bestguns.* API (register_bullet, register_gun,
-- a_smoke, r, damage_scale, registered_bullets), so it can live here or be split
-- out into its own external mod that just depends on `bestguns`.
-- =============================================================================


-- Register a bullet
bestguns.register_bullet("bestguns:bullet_9mm", {
    description = "9mm Bullet",
    caliber = "9mm",
    speed = 600,
    size = 0.2,
    texture = "bestguns_bullet.png",
    inventory_image = "bestguns_9mm.png",
    damage = 51,
    recoil = 1,
    fire_sound = "bestguns_fire_9mm"
})


-- The AK-47 / assault-rifle round. Item id stays "bullet_39mm" for save/recipe
-- compatibility, but it is really 7.62x39mm ("39mm" was a mislabel: that number
-- is the case length, not a 39-millimetre-wide bullet). Rifle round, so it flies
-- much faster than the pistol calibers.
bestguns.register_bullet("bestguns:bullet_39mm", {
    description = "7.62x39mm Round",
    caliber = "7.62x39mm",
    speed = 715,       -- rifle muzzle velocity (~715 m/s), well above pistol rounds
    size = 0.5,
    texturesize = 20,
    texture = "bestguns_bullet_light.png",
    inventory_image = "bestguns_39mm.png",
    damage = 39,
    recoil = 1.4,
    fire_sound = "bestguns_ar_fire"
})

bestguns.register_bullet("bestguns:bullet_39_ak", {
    description = "7.62x39mm Round for AK-47",
    caliber = "7.62x39mm",
    speed = 715,       -- rifle muzzle velocity (~715 m/s), well above pistol rounds
    size = 0.5,
    texturesize = 20,
    texture = "bestguns_bullet_light.png",
    inventory_image = "bestguns_39mm.png",
    damage = 39,
    recoil = 1.4,
    fire_sound = "bestguns_ak_fire"
})


bestguns.register_bullet("bestguns:308", {
    description = ".308 Winchester",
    caliber = ".308",
    speed = 900,
    size = 2,
    texturesize = 20,
    texture = "bestguns_bullet_light.png",
    inventory_image = "bestguns_308.png",
    damage = 160,
    recoil = 15,
    fire_sound = "bestguns_sniper"
})
--[[
bestguns.register_bullet("bestguns:338", {
    description = ".338 Lapua Magnum",
    caliber = ".338",
    speed = 915,
    size = 2,
    texturesize = 20,
    texture = "bestguns_bullet_light.png",
    inventory_image = "bestguns_338.png",
    damage = 290,
    recoil = 22,
    fire_sound = "bestguns_fire_338"
})]]


-- Leading ":" lets this pack mod register the "bestguns:"-namespaced ball.
core.register_craftitem(":bestguns:12_gauge_ball", {
  description = "12 Gauge Ball",
  inventory_image = "bestguns_12_gauge_ball.png"
})


bestguns.register_bullet("bestguns:12_gauge", {
    description = "12 Gauge Shell",
    caliber = "12gauge",
    speed = 400,
    size = 0.2,
    texturesize = 20,
    shots = 9,
    drops = "bestguns:12_gauge_ball",
    texture = "bestguns_12gauge_ball.png",
    inventory_image = "bestguns_12gauge.png",
    damage = 59,
    recoil = 17,
    fire_sound = "bestguns_shotgun_fire"
})


--[[
bestguns.register_gun("bestguns:pistol", {
    description = "9mm Pistol",
    one_handed = true,   -- sidearm: held/posed in the right hand only
    gun_range = 0.3,     -- short barrel, sidearm: damage falls off fast
    default_bullet = "bestguns:bullet_9mm",
    texture_mag = "bestguns_pistol.png^bestguns_pistol_mag.png",
    texture_nomag = "bestguns_pistol.png",
    texture_mag_item = "bestguns_pistol_mag_empty.png",
    sound_fire = "bestguns_empty_click",
    sound_empty = "bestguns_empty_click",
    sound_reload = "bestguns_reload",
    sound_load_mag = "bestguns_load_bullet",
    mag_insert = "bestguns_mag_insert",
    mag_remove = "bestguns_mag_remove",
    inaccuracy = 1,
    fire_delay = 0.25,
    action = "semi",
    mag_capacity = 12,
    caliber = "9mm",

    -- Custom particle effect
    on_fire = function(itemstack, user, bullet_entity)


        local pos = user:get_pos()
        pos.y = pos.y + 1.5
        local look_dir = user:get_look_dir()

        for i=1, math.random(4,5) do
          core.add_particle({
            pos = vector.offset(vector.add(pos, vector.multiply(look_dir, 0.3)), bestguns.r(10)/100, bestguns.r(10)/100, bestguns.r(10)/100),
            expirationtime = 0.0001,
            size = math.random(9,12),
            playername = user:get_player_name(),
            texture = {name = "bestguns_muzzle_flash.png^[opacity:"..math.random(10)},
            glow = 14,
          })
        end

        bestguns.a_smoke(user, {
          minsmokes = 20,
          maxsmokes = 30,
          size = 10,
          base_opacity = 20,
        })
    end,

    -- Optional custom reload logic
    on_reload = function(itemstack, user)
      return
    end
})]]



-- A full-auto replica of the pistol that shares the pistol's 9mm ammo. Fires
-- 1.4x faster than its original 0.04s delay (0.04 / 1.4 ~= 0.0286).
bestguns.register_gun("bestguns:uzi", {
    description = "Uzi",
    one_handed = true,   -- compact SMG: held/posed in the right hand only
    gun_range = 0.35,    -- SMG: effective at close-to-mid range
    default_bullet = "bestguns:bullet_9mm",
    texture_mag = "bestguns_uzi.png^bestguns_uzi_mag.png",
    texture_nomag = "bestguns_uzi.png",
    texture_mag_item = "bestguns_uzi_mag_empty.png",
    loaded_texture = "bestguns_red_24.png",
    sound_fire = "bestguns_empty_click",
    sound_empty = "bestguns_empty_click",
    sound_reload = "bestguns_reload",
    sound_load_mag = "bestguns_load_bullet",
    mag_insert = "bestguns_mag_insert",
    mag_remove = "bestguns_mag_remove",
    inaccuracy = 6,
    wield_scale = vector.new(1.5,1.5,1.2),
    damage_mult = 0.51,   -- 9mm bullet (51) * 0.51 = 26 damage
    fire_delay = 0.04,
    action = "full",
    mag_capacity = 90,
    caliber = "9mm",

    -- Custom particle effect (same muzzle flash + smoke as the pistol)
    on_fire = function(itemstack, user, bullet_entity)
        local pos = user:get_pos()
        pos.y = pos.y + 1.5
        local look_dir = user:get_look_dir()

        for i=1, math.random(4,15) do
          core.add_particle({
            pos = vector.offset(vector.add(pos, vector.multiply(look_dir, 0.3)), bestguns.r(10)/100, bestguns.r(10)/100, bestguns.r(10)/100),
            expirationtime = 0.0001,
            size = math.random(9,12),
            playername = user:get_player_name(),
            texture = {name = "bestguns_muzzle_flash.png^[opacity:"..math.random(10)},
            glow = 14,
          })
        end

        bestguns.a_smoke(user, {
          minsmokes = 20,
          maxsmokes = 30,
          size = 10,
          base_opacity = 2,
        })
    end,

    on_reload = function(itemstack, user)
      return
    end
})



bestguns.register_gun("bestguns:assault_rifle", {
    description = "Assault Rifle",
    gun_range = 0.75,    -- rifle: holds damage well out to range
    texture_mag = "bestguns_assault_rifle.png^bestguns_assault_rifle_mag.png",
    texture_nomag = "bestguns_assault_rifle.png",
    texture_mag_item = "bestguns_assault_rifle_mag_empty.png",
    sound_fire = "bestguns_empty_click",
    sound_empty = "bestguns_empty_click",
    sound_reload = "bestguns_reload",
    sound_load_mag = "bestguns_load_bullet",
    mag_insert = "bestguns_mag_insert",
    mag_remove = "bestguns_mag_remove",
    default_bullet = "bestguns:bullet_39mm",
    inaccuracy = 1.2,
    kick = 2.1,

    fire_delay = 0.08,
    zoom = 0.7,
    scope_size = 2,
    zoomhud = true,
    wield_scale = vector.new(2.2,2.2,1.4),
    action = "full",
    loaded_texture = "bestguns_red_24.png",
    mag_capacity = 30,
    caliber = "7.62x39mm",

    -- Custom particle effect
    on_fire = function(itemstack, user, bullet_entity)
        local pos = user:get_pos()
        pos.y = pos.y + 1.5
        local look_dir = user:get_look_dir()

        for i=1, math.random(4,5) do
          core.add_particle({
            pos = vector.offset(vector.add(pos, vector.multiply(look_dir, 0.3)), bestguns.r(10)/100, bestguns.r(10)/100, bestguns.r(10)/100),
            expirationtime = 0.0001,
            size = math.random(9,12),
            playername = user:get_player_name(),
            texture = {name = "bestguns_muzzle_flash.png^[opacity:"..math.random(20)},
            glow = 14,
          })
        end

        bestguns.a_smoke(user, {
          minsmokes = 5,
          maxsmokes = 10,
          size = 10,
          base_opacity = 10,
        })
        bestguns.a_smoke(user, {
          minsmokes = 5,
          maxsmokes = 10,
          size = 20,
          acceleration = {x=0, y=8, z=0},
          smoke_min_brightness = -50,
          expirationtime = 10,
          base_opacity = 10,
        })

    end,

    -- Optional custom reload logic
    on_reload = function(itemstack, user)
      return
    end
})


bestguns.register_gun("bestguns:semi_auto_rifle", {
    description = "Semi-Auto Rifle",
    gun_range = 0.85,    -- marksman rifle: nearly sniper-tier reach
    texture_mag = "bestguns_semi_auto_rifle.png^bestguns_semi_auto_rifle_mag.png",
    texture_nomag = "bestguns_semi_auto_rifle.png",
    texture_mag_item = "bestguns_semi_auto_rifle_mag_empty.png",
    sound_fire = "bestguns_empty_click",
    sound_empty = "bestguns_empty_click",
    sound_reload = "bestguns_reload",
    sound_load_mag = "bestguns_load_bullet",
    mag_insert = "bestguns_mag_insert",
    mag_remove = "bestguns_mag_remove",
    default_bullet = "bestguns:bullet_39mm",
    inaccuracy = 0.12,  -- almost sniper-perfect (bolt sniper = 0), but not quite
    damage_mult = 1.3,  -- 1.3x the bullet's base 39 damage (~51)
    kick = 2.1,

    fire_delay = 0.14,  -- marksman cadence: slower than the assault rifle, but pinpoint + scoped
    zoom = 0.16,
    scope_size = 1.3,
    zoomhud = true,
    wield_scale = vector.new(2.2,2.2,1.4),
    action = "semi",
    loaded_texture = "bestguns_red_24.png",
    mag_capacity = 10,
    caliber = "7.62x39mm",

    -- Custom particle effect (same muzzle flash + smoke as the assault rifle)
    on_fire = function(itemstack, user, bullet_entity)
        local pos = user:get_pos()
        pos.y = pos.y + 1.5
        local look_dir = user:get_look_dir()

        for i=1, math.random(4,5) do
          core.add_particle({
            pos = vector.offset(vector.add(pos, vector.multiply(look_dir, 0.3)), bestguns.r(10)/100, bestguns.r(10)/100, bestguns.r(10)/100),
            expirationtime = 0.0001,
            size = math.random(9,12),
            playername = user:get_player_name(),
            texture = {name = "bestguns_muzzle_flash.png^[opacity:"..math.random(20)},
            glow = 14,
          })
        end

        bestguns.a_smoke(user, {
          minsmokes = 5,
          maxsmokes = 10,
          size = 10,
          base_opacity = 10,
        })
        bestguns.a_smoke(user, {
          minsmokes = 5,
          maxsmokes = 10,
          size = 20,
          acceleration = {x=0, y=8, z=0},
          smoke_min_brightness = -50,
          expirationtime = 10,
          base_opacity = 10,
        })
    end,

    -- Optional custom reload logic
    on_reload = function(itemstack, user)
      return
    end
})


bestguns.register_gun("bestguns:shotgun", {
    description = "Shotgun",
    gun_range = 0.25,    -- pellets bleed energy fast: a close-range weapon
    texture_nomag = "bestguns_shotgun.png",
    texture_open = "bestguns_shotgun_open.png",
    sound_fire = "bestguns_shotgun_trigger",
    sound_empty = "bestguns_shotgun_trigger",
    sound_reload = "bestguns_reload",
    sound_load_mag = "bestguns_shotgun_load",
    sound_open = "bestguns_shotgun_open",
    sound_close = "bestguns_shotgun_close",
    default_bullet = "bestguns:12_gauge",
    loaded_texture = "bestguns_red_20.png",
    load_speed = 0.7,
    fire_delay = 0.6,
    kick = 2.1,
    kick_time = 0.1,
    wield_scale = vector.new(2,2,2.8),
    action = "semi",
    load_action = "direct",
    mag_capacity = 2,
    caliber = "12gauge",

    -- Custom particle effect
    on_fire = function(itemstack, user, bullet_entity)

      local meta = itemstack:get_meta()
      local bullet_name = meta:get_string("bullet_name")
      local b_def = bestguns.registered_bullets[bullet_name]
      if not b_def then return nil end
      local eye_height = user:get_properties().eye_height or 1.625
      local pos = vector.add(user:get_pos(), {x=0, y=eye_height, z=0})
      local bullet_vel = vector.multiply(user:get_look_dir(), b_def.speed or 100)

      local def = bestguns.registered_guns["bestguns:shotgun"]
      for i=1, b_def.shots do
        local data = {
            velocity = vector.offset(bullet_vel, bestguns.r(90), bestguns.r(90), bestguns.r(90)),
            shooter_name = user:get_player_name(),
            _item = bullet_name,
            _drops = b_def.drops,
            damage = math.floor((b_def.damage or 1) * bestguns.damage_scale),
            texture = b_def.texture,
            size = b_def.size or 1
        }
        bestguns.apply_range(data, def)
        local obj = core.add_entity(pos, "bestguns:bullet", core.serialize(data))
      end




      local pos = user:get_pos()
      pos.y = pos.y + 1.5
      local look_dir = user:get_look_dir()
      for i=1, math.random(4,10) do
        core.add_particle({
          pos = vector.offset(vector.add(pos, vector.multiply(look_dir, 0.3)), bestguns.r(10)/100, bestguns.r(10)/100, bestguns.r(10)/100),
          expirationtime = 0.01,
          size = math.random(9,22),
          playername = user:get_player_name(),
          texture = {name = "bestguns_muzzle_flash.png^[opacity:"..math.random(20)},
          glow = 14,
        })
      end

      bestguns.a_smoke(user, {
        minsmokes = 20,
        maxsmokes = 40,
        size = 10,
        base_opacity = 40,
      })
      bestguns.a_smoke(user, {
        minsmokes = 20,
        maxsmokes = 100,
        size = 40,
        smoke_min_brightness = -100,
        acceleration = {x=3, y=8, z=3},
        expirationtime = 10.,
        base_opacity = 30,
      })

      return true
    end,

    -- Optional custom reload logic
    on_reload = function(itemstack, user)
      return
    end
})



bestguns.register_gun("bestguns:bolt_sniper", {
    description = "Bolt Action Rifle",
    gun_range = 1.0,     -- sniper: full damage at the longest ranges
    texture_nomag = "bestguns_assault_bold_sniper.png",
    texture_open = "bestguns_assault_bold_sniper_open.png",
    sound_fire = "bestguns_shotgun_trigger",
    sound_empty = "bestguns_shotgun_trigger",
    sound_reload = "bestguns_reload",
    sound_load_mag = "bestguns_bolt_load",
    sound_open = "bestguns_bolt_open",
    sound_close = "bestguns_bolt_close",
    default_bullet = "bestguns:308",
    loaded_texture = "bestguns_red_20.png",
    load_speed = 1.2,
    zoom = 0.3,
    cancel_scope_on_fire = true,
    zoomhud = true,
    fire_delay = 0,
    wield_scale = vector.new(2.8,2.8,2.1),
    action = "semi",
    load_action = "direct",
    mag_capacity = 1,
    caliber = ".308",

    -- Custom particle effect
    on_fire = function(itemstack, user, bullet_entity)

      local pos = user:get_pos()
      pos.y = pos.y + 1.5
      local look_dir = user:get_look_dir()

      for i=1, math.random(4,12) do
        core.add_particle({
          pos = vector.offset(vector.add(pos, vector.multiply(look_dir, 0.3)), bestguns.r(10)/100, bestguns.r(10)/100, bestguns.r(10)/100),
          expirationtime = 0.0001,
          size = math.random(9,12),
          playername = user:get_player_name(),
          texture = {name = "bestguns_muzzle_flash.png^[opacity:"..math.random(20)},
          glow = 14,
        })
      end

      bestguns.a_smoke(user, {
        minsmokes = 20,
        maxsmokes = 40,
        size = 10,
        base_opacity = 40,
      })
      bestguns.a_smoke(user, {
        minsmokes = 20,
        maxsmokes = 100,
        size = 40,
        smoke_min_brightness = -100,
        acceleration = {x=1, y=8, z=1},
        expirationtime = 10.,
        base_opacity = 15,
      })
    end,

    -- Optional custom reload logic
    on_reload = function(itemstack, user)
      return
    end
})


bestguns.register_bullet("bestguns:bullet_44", {
    description = ".44 Magnum Bullet",
    caliber = ".44",
    speed = 450,
    size = 0.35,
    texture = "bestguns_bullet_light.png",
    inventory_image = "bestguns_44.png",
    damage = 93,
    recoil = 3,
    fire_sound = "bestguns_44"
})


bestguns.register_bullet("bestguns:bullet_50", {
    description = ".50 Action Express Bullet",
    caliber = ".50",
    speed = 750,
    size = 0.35,
    texture = "bestguns_bullet_light.png",
    inventory_image = "bestguns_50.png",
    damage = 119,
    recoil = 3,
    fire_sound = "bestguns_deagle_fire"
})

bestguns.register_gun("bestguns:revolver", {
    description = ".44 Magnum Revolver",
    one_handed = true,   -- handgun: held/posed in the right hand only
    gun_range = 0.5,     -- powerful handgun: decent mid-range punch
    texture_nomag = "bestguns_revolver.png",
    texture_open = "bestguns_revolver_open.png",
    sound_fire = "bestguns_empty_click",
    sound_empty = "bestguns_empty_click",
    sound_reload = "bestguns_reload",
    sound_load_mag = "bestguns_load_revolver",
    sound_open = "bestguns_revolver_open", -- Reusing open/close sounds
    sound_close = "bestguns_revolver_close",
    default_bullet = "bestguns:bullet_44",
    loaded_texture = "bestguns_red_20.png",
    inaccuracy = 0.7,
    damage_mult = 0.9,   -- .44 bullet (93) * 0.9 = 83 damage
    fire_delay = 0.1,
    wield_scale = vector.new(1.4, 1.4, 1.4),
    action = "semi",
    load_action = "direct",
    mag_capacity = 6,
    caliber = ".44",

    on_fire = function(itemstack, user, bullet_entity)
        local pos = user:get_pos()
        pos.y = pos.y + 1.5
        local look_dir = user:get_look_dir()

        for i=1, math.random(4,5) do
          core.add_particle({
            pos = vector.offset(vector.add(pos, vector.multiply(look_dir, 0.3)), bestguns.r(10)/100, bestguns.r(10)/100, bestguns.r(10)/100),
            expirationtime = 0.0001,
            size = math.random(9,12),
            playername = user:get_player_name(),
            texture = {name = "bestguns_muzzle_flash.png^[opacity:"..math.random(20)},
            glow = 14,
          })
        end
        bestguns.a_smoke(user, {
          minsmokes = 20,
          maxsmokes = 40,
          size = 10,
          base_opacity = 40,
        })
    end
})

-- =============================================================================
-- Additional weapons: alternate takes on the pistol / SMG / rifle / shotgun /
-- revolver families, reusing the ammo already defined above.
-- =============================================================================

bestguns.register_gun("bestguns:glock", {
    description = "Glock 17",
    one_handed = true,   -- sidearm: held/posed in the right hand only
    gun_range = 0.3,     -- sidearm: short effective range
    default_bullet = "bestguns:bullet_9mm",
    texture_mag = "bestguns_glock.png^bestguns_glock_mag.png",
    texture_nomag = "bestguns_glock.png",
    texture_mag_item = "bestguns_glock_mag_empty.png",
    loaded_texture = "bestguns_red_20.png",
    sound_fire = "bestguns_empty_click",
    sound_empty = "bestguns_empty_click",
    sound_reload = "bestguns_reload",
    sound_load_mag = "bestguns_load_bullet",
    mag_insert = "bestguns_mag_insert",
    mag_remove = "bestguns_mag_remove",
    wield_scale = vector.new(1.3,1.3,1.3),
    inaccuracy = 0.8,
    damage_mult = 1,   -- 9mm bullet (51) * 1.99 = 101 damage
    fire_delay = 0.18,
    action = "semi",
    mag_capacity = 17,
    caliber = "9mm",

    -- Custom particle effect
    on_fire = function(itemstack, user, bullet_entity)
        local pos = user:get_pos()
        pos.y = pos.y + 1.5
        local look_dir = user:get_look_dir()

        for i=1, math.random(4,5) do
          core.add_particle({
            pos = vector.offset(vector.add(pos, vector.multiply(look_dir, 0.3)), bestguns.r(10)/100, bestguns.r(10)/100, bestguns.r(10)/100),
            expirationtime = 0.0001,
            size = math.random(9,12),
            playername = user:get_player_name(),
            texture = {name = "bestguns_muzzle_flash.png^[opacity:"..math.random(10)},
            glow = 14,
          })
        end

        bestguns.a_smoke(user, {
          minsmokes = 20,
          maxsmokes = 30,
          size = 10,
          base_opacity = 20,
        })
    end,

    on_reload = function(itemstack, user)
      return
    end
})


bestguns.register_gun("bestguns:deagle", {
    description = "Desert Eagle",
    one_handed = true,   -- hand cannon: held/posed in the right hand only
    gun_range = 0.45,    -- hand cannon: reaches a bit past most pistols
    default_bullet = "bestguns:bullet_50",
    texture_mag = "bestguns_deagle.png^bestguns_deagle_mag.png",
    texture_nomag = "bestguns_deagle.png",
    texture_mag_item = "bestguns_deagle_mag_empty.png",
    loaded_texture = "bestguns_red_20.png",
    sound_fire = "bestguns_empty_click",
    sound_empty = "bestguns_empty_click",
    sound_reload = "bestguns_reload",
    sound_load_mag = "bestguns_load_bullet",
    mag_insert = "bestguns_mag_insert",
    mag_remove = "bestguns_mag_remove",
    inaccuracy = 1.5,
    kick = 4,
    fire_delay = 0.35,
    wield_scale = vector.new(1.4, 1.4, 1.4),
    action = "semi",
    mag_capacity = 7,
    caliber = ".50",

    -- Custom particle effect
    on_fire = function(itemstack, user, bullet_entity)
        local pos = user:get_pos()
        pos.y = pos.y + 1.5
        local look_dir = user:get_look_dir()

        for i=1, math.random(4,6) do
          core.add_particle({
            pos = vector.offset(vector.add(pos, vector.multiply(look_dir, 0.3)), bestguns.r(10)/100, bestguns.r(10)/100, bestguns.r(10)/100),
            expirationtime = 0.0001,
            size = math.random(10,14),
            playername = user:get_player_name(),
            texture = {name = "bestguns_muzzle_flash.png^[opacity:"..math.random(15)},
            glow = 14,
          })
        end

        bestguns.a_smoke(user, {
          minsmokes = 20,
          maxsmokes = 35,
          size = 12,
          base_opacity = 25,
        })
    end,

    on_reload = function(itemstack, user)
      return
    end
})


bestguns.register_gun("bestguns:ak47", {
    description = "AK-47",
    gun_range = 0.7,     -- rifle: strong out to range, just short of the AR
    texture_mag = "bestguns_ak47.png^bestguns_ak47_mag.png",
    texture_nomag = "bestguns_ak47.png",
    texture_mag_item = "bestguns_ak47_mag_empty.png",
    sound_fire = "bestguns_empty_click",
    sound_empty = "bestguns_empty_click",
    loaded_texture = "bestguns_red_32.png",
    sound_reload = "bestguns_reload",
    sound_load_mag = "bestguns_load_bullet",
    mag_insert = "bestguns_mag_insert",
    mag_remove = "bestguns_mag_remove",
    default_bullet = "bestguns:bullet_39_ak",
    inaccuracy = 2,     -- looser than the Assault Rifle's 1.2: iconic spray-and-pray
    damage_mult = 1.15,
    kick = 2.6,

    fire_delay = 0.1,   -- slightly slower cyclic rate than the Assault Rifle's 0.08
    action = "full",
    wield_scale = vector.new(2.2,2.2,1.3),
    mag_capacity = 30,
    caliber = "7.62x39mm",

    -- Custom particle effect (same muzzle flash + smoke as the Assault Rifle)
    on_fire = function(itemstack, user, bullet_entity)
        local pos = user:get_pos()
        pos.y = pos.y + 1.5
        local look_dir = user:get_look_dir()

        for i=1, math.random(4,5) do
          core.add_particle({
            pos = vector.offset(vector.add(pos, vector.multiply(look_dir, 0.3)), bestguns.r(10)/100, bestguns.r(10)/100, bestguns.r(10)/100),
            expirationtime = 0.0001,
            size = math.random(9,12),
            playername = user:get_player_name(),
            texture = {name = "bestguns_muzzle_flash.png^[opacity:"..math.random(20)},
            glow = 14,
          })
        end

        bestguns.a_smoke(user, {
          minsmokes = 5,
          maxsmokes = 10,
          size = 10,
          base_opacity = 10,
        })
        bestguns.a_smoke(user, {
          minsmokes = 5,
          maxsmokes = 10,
          size = 20,
          acceleration = {x=0, y=8, z=0},
          smoke_min_brightness = -50,
          expirationtime = 10,
          base_opacity = 10,
        })
    end,

    on_reload = function(itemstack, user)
      return
    end
})


-- The carbine's own cartridge: the M1 Carbine's real .30 Carbine round. Its own
-- caliber so it no longer shares the AK/Assault-Rifle 7.62x39mm ammo, letting it
-- run a distinct muzzle velocity (812 m/s) without touching those guns.
bestguns.register_bullet("bestguns:bullet_carbine", {
    description = ".30 Carbine Round",
    caliber = ".30 Carbine",
    speed = 812,
    size = 0.5,
    texturesize = 20,
    texture = "bestguns_bullet_light.png",
    inventory_image = "bestguns_30mm.png",   -- TODO: dedicated art
    damage = 26,                             -- carbine's damage_mult of 2 -> 78 damage
    recoil = 1.4,
    fire_sound = "bestguns_carbine_fire"
})

bestguns.register_gun("bestguns:carbine", {
    description = "Carbine",
    gun_range = 0.6,     -- carbine: mid-range, between rifle and pistol
    texture_mag = "bestguns_carbine.png^bestguns_carbine_mag.png",
    texture_nomag = "bestguns_carbine.png",
    texture_mag_item = "bestguns_carbine_mag_empty.png",
    sound_fire = "bestguns_empty_click",
    sound_empty = "bestguns_empty_click",
    sound_reload = "bestguns_reload",
    sound_load_mag = "bestguns_load_bullet",
    mag_insert = "bestguns_mag_insert",
    mag_remove = "bestguns_mag_remove",
    default_bullet = "bestguns:bullet_carbine",
    inaccuracy = 0.8,   -- tighter than the AK's 2, looser than the Semi-Auto Rifle's 0.15
    damage_mult = 2,    -- .30 Carbine bullet (39) * 2 = 78 damage
    kick = 1.8,
    zoom = 0.2,
    scope_size = 1.4,
    zoomhud = true,

    fire_delay = 0.09,  -- quicker handling than the Semi-Auto Rifle's 0.14 marksman cadence
    action = "full",
    wield_scale = vector.new(2.2,2.2,1.4),
    loaded_texture = "bestguns_red_24.png",
    mag_capacity = 20,
    caliber = ".30 Carbine",

    -- Custom particle effect (same muzzle flash + smoke as the Assault Rifle)
    on_fire = function(itemstack, user, bullet_entity)
        local pos = user:get_pos()
        pos.y = pos.y + 1.5
        local look_dir = user:get_look_dir()

        for i=1, math.random(4,5) do
          core.add_particle({
            pos = vector.offset(vector.add(pos, vector.multiply(look_dir, 0.3)), bestguns.r(10)/100, bestguns.r(10)/100, bestguns.r(10)/100),
            expirationtime = 0.0001,
            size = math.random(9,12),
            playername = user:get_player_name(),
            texture = {name = "bestguns_muzzle_flash.png^[opacity:"..math.random(20)},
            glow = 14,
          })
        end

        bestguns.a_smoke(user, {
          minsmokes = 5,
          maxsmokes = 10,
          size = 10,
          base_opacity = 10,
        })
        bestguns.a_smoke(user, {
          minsmokes = 5,
          maxsmokes = 10,
          size = 20,
          acceleration = {x=0, y=8, z=0},
          smoke_min_brightness = -50,
          expirationtime = 10,
          base_opacity = 10,
        })
    end,

    on_reload = function(itemstack, user)
      return
    end
})


-- The Thompson's real cartridge: big, slow, hard-hitting .45 ACP. Lower velocity
-- and more punch per round than the 9mm pistol calibers.
bestguns.register_bullet("bestguns:bullet_45acp", {
    description = ".45 ACP Round",
    caliber = ".45 ACP",
    speed = 400,
    size = 0.25,
    texture = "bestguns_bullet.png",
    inventory_image = "bestguns_45acp.png",   -- TODO: art
    damage = 62,
    recoil = 1.6,
    fire_sound = "bestguns_fire_45acp"        -- TODO: sound
})

-- A drum-fed .45 ACP submachine gun: heavier and better controlled than the Uzi
-- (lower inaccuracy) but with a slower cyclic rate.
bestguns.register_gun("bestguns:tommy", {
    description = "Tommy Gun",
    gun_range = 0.35,    -- SMG: close-to-mid range
    default_bullet = "bestguns:bullet_45acp",
    texture_mag = "bestguns_tommy.png^bestguns_tommy_mag.png",
    texture_nomag = "bestguns_tommy.png",
    texture_mag_item = "bestguns_tommy_mag_empty.png",
    loaded_texture = "bestguns_red_48.png",
    sound_fire = "bestguns_empty_click",
    sound_empty = "bestguns_empty_click",
    sound_reload = "bestguns_reload",
    sound_load_mag = "bestguns_load_bullet",
    mag_insert = "bestguns_mag_insert",
    mag_remove = "bestguns_mag_remove",
    inaccuracy = 4,
    damage_mult = 0.5,
    kick = 2,
    fire_delay = 0.06,
    action = "full",
    wield_scale = vector.new(3.2,3.2,2.3),
    mag_capacity = 50,  -- classic drum magazine
    caliber = ".45 ACP",

    -- Custom particle effect (same muzzle flash + smoke as the Uzi)
    on_fire = function(itemstack, user, bullet_entity)
        local pos = user:get_pos()
        pos.y = pos.y + 1.5
        local look_dir = user:get_look_dir()

        for i=1, math.random(4,15) do
          core.add_particle({
            pos = vector.offset(vector.add(pos, vector.multiply(look_dir, 0.3)), bestguns.r(10)/100, bestguns.r(10)/100, bestguns.r(10)/100),
            expirationtime = 0.0001,
            size = math.random(9,12),
            playername = user:get_player_name(),
            texture = {name = "bestguns_muzzle_flash.png^[opacity:"..math.random(10)},
            glow = 14,
          })
        end

        bestguns.a_smoke(user, {
          minsmokes = 20,
          maxsmokes = 30,
          size = 10,
          base_opacity = 2,
        })
    end,

    on_reload = function(itemstack, user)
      return
    end
})


-- A compact break-action shotgun: quicker to reload and fire again than the
-- full Shotgun, at the cost of noticeably harsher recoil.
bestguns.register_gun("bestguns:sawed_shotgun", {
    description = "Sawed-Off Shotgun",
    gun_range = 0.15,    -- cut barrel: brutal up close, useless at range
    texture_nomag = "bestguns_sawed_shotgun.png",
    texture_open = "bestguns_sawed_shotgun_open.png",
    sound_fire = "bestguns_shotgun_sawed_fire",
    sound_empty = "bestguns_shotgun_trigger",
    sound_reload = "bestguns_reload",
    sound_load_mag = "bestguns_shotgun_load",
    sound_open = "bestguns_shotgun_open",
    sound_close = "bestguns_shotgun_close",
    default_bullet = "bestguns:12_gauge",
    loaded_texture = "bestguns_red_20.png",
    load_speed = 0.5,
    fire_delay = 0.2,
    kick = 3,
    kick_time = 0.1,
    wield_scale = vector.new(2,2,2.8),
    action = "semi",
    load_action = "direct",
    mag_capacity = 2,   -- double barrel
    caliber = "12gauge",

    -- Custom particle effect (same pellet-spray logic as the Shotgun)
    on_fire = function(itemstack, user, bullet_entity)

      local meta = itemstack:get_meta()
      local bullet_name = meta:get_string("bullet_name")
      local b_def = bestguns.registered_bullets[bullet_name]
      if not b_def then return nil end
      local eye_height = user:get_properties().eye_height or 1.625
      local pos = vector.add(user:get_pos(), {x=0, y=eye_height, z=0})
      local bullet_vel = vector.multiply(user:get_look_dir(), b_def.speed or 100)

      local def = bestguns.registered_guns["bestguns:sawed_shotgun"]
      for i=1, b_def.shots do
        local data = {
            velocity = vector.offset(bullet_vel, bestguns.r(120), bestguns.r(120), bestguns.r(120)),  -- wider spread than the full Shotgun's r(90)
            shooter_name = user:get_player_name(),
            _item = bullet_name,
            _drops = b_def.drops,
            damage = math.floor((b_def.damage or 1) * bestguns.damage_scale),
            texture = b_def.texture,
            size = b_def.size or 1
        }
        bestguns.apply_range(data, def)
        local obj = core.add_entity(pos, "bestguns:bullet", core.serialize(data))
      end

      local pos = user:get_pos()
      pos.y = pos.y + 1.5
      local look_dir = user:get_look_dir()
      for i=1, math.random(4,10) do
        core.add_particle({
          pos = vector.offset(vector.add(pos, vector.multiply(look_dir, 0.3)), bestguns.r(10)/100, bestguns.r(10)/100, bestguns.r(10)/100),
          expirationtime = 0.01,
          size = math.random(9,22),
          playername = user:get_player_name(),
          texture = {name = "bestguns_muzzle_flash.png^[opacity:"..math.random(20)},
          glow = 14,
        })
      end

      bestguns.a_smoke(user, {
        minsmokes = 20,
        maxsmokes = 40,
        size = 10,
        base_opacity = 40,
      })
      bestguns.a_smoke(user, {
        minsmokes = 20,
        maxsmokes = 100,
        size = 40,
        smoke_min_brightness = -100,
        acceleration = {x=3, y=8, z=3},
        expirationtime = 10.,
        base_opacity = 30,
      })

      return true
    end,

    on_reload = function(itemstack, user)
      return
    end
})


bestguns.register_bullet("bestguns:bullet_38", {
    description = ".38 Special Round",
    caliber = ".38",
    speed = 500,
    size = 0.3,
    texture = "bestguns_bullet_light.png",
    inventory_image = "bestguns_38.png",   -- TODO: art (was borrowing the .44's icon)
    damage = 79,
    recoil = 2,
    fire_sound = "bestguns_fire_38"        -- TODO: sound (was borrowing the .44's)
})
-- A compact, concealable revolver: less accurate than the .44 Magnum Revolver
-- (short sight radius) but faster-handling and lighter-hitting.
bestguns.register_gun("bestguns:snub_revolver", {
    description = ".38 Snub-Nose Revolver",
    one_handed = true,   -- snub-nose handgun: held/posed in the right hand only
    gun_range = 0.35,    -- snub barrel: short effective range
    texture_nomag = "bestguns_snub_revolver.png",
    texture_open = "bestguns_snub_revolver_open.png",
    sound_fire = "bestguns_empty_click",
    sound_empty = "bestguns_empty_click",
    sound_reload = "bestguns_reload",
    sound_load_mag = "bestguns_load_revolver",
    sound_open = "bestguns_revolver_open", -- Reusing open/close sounds
    sound_close = "bestguns_revolver_close",
    default_bullet = "bestguns:bullet_38",
    loaded_texture = "bestguns_red_20.png",
    inaccuracy = 1.5,
    fire_delay = 0.12,
    wield_scale = vector.new(1, 1, 1),
    action = "semi",
    load_action = "direct",
    mag_capacity = 5,   -- classic 5-shot snub cylinder
    caliber = ".38",

    on_fire = function(itemstack, user, bullet_entity)
        local pos = user:get_pos()
        pos.y = pos.y + 1.5
        local look_dir = user:get_look_dir()

        for i=1, math.random(4,5) do
          core.add_particle({
            pos = vector.offset(vector.add(pos, vector.multiply(look_dir, 0.3)), bestguns.r(10)/100, bestguns.r(10)/100, bestguns.r(10)/100),
            expirationtime = 0.0001,
            size = math.random(9,12),
            playername = user:get_player_name(),
            texture = {name = "bestguns_muzzle_flash.png^[opacity:"..math.random(20)},
            glow = 14,
          })
        end
        bestguns.a_smoke(user, {
          minsmokes = 20,
          maxsmokes = 40,
          size = 10,
          base_opacity = 40,
        })
    end
})


-- CTF integration (loot, class loadouts, combat) lives in the separate
-- bestguns_ctf mod (mods/ctf/ctf_combat/bestguns_ctf).
