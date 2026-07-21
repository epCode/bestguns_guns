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


-- =============================================================================
-- Frag grenade
-- =============================================================================
--
-- A thrown fragmentation grenade, worked like the real thing:
--   * RMB pulls the pin (a pin-pull sound plays). The fuse starts immediately
--     and runs no matter what - whether the grenade is thrown or kept in hand.
--   * LMB throws it, any time: before the pin is pulled (an inert dud that lands
--     and drops back as a recoverable item) or after (it cooks off in flight).
--   * If the fuse runs out while it's still in your hand, it blows up on you.
-- On detonation it sprays 20-40 fragments outward in every direction. Each
-- fragment is a real bestguns bullet (speed 150), so it carries the exact same
-- smoke trail and raycast hit detection as any other round - the grenade kills by
-- fragmentation, like the real thing. The blast deals no separate splash damage:
-- everything is the fragments.
--
-- Sounds are placeholders for now (TODO: drop the real ogg files in sounds/).

local FRAG_FUSE            = 3   -- seconds from the throw to detonation
local FRAG_THROW_SPEED     = 16.2  -- initial lob speed along the look direction
local FRAG_BOUNCE          = 0.45  -- restitution: fraction of speed kept normal to a surface
local FRAG_FRICTION        = 0.84   -- fraction of speed kept along a surface each bounce
local FRAG_MIN_FRAGMENTS   = 5
local FRAG_MAX_FRAGMENTS   = 30
local FRAG_FRAGMENT_SPEED  = 150   -- speed of each fragment (acts as a bullet)
local FRAG_BLAST_RADIUS    = 9.2   -- close-range shockwave reach (nodes)
local FRAG_BLAST_DAMAGE    = 200    -- shockwave HP at the centre, before damage_scale
local FRAG_RING_HEAR       = 8    -- max hear distance of the ears-ringing sound
local FRAG_BLIND_RADIUS    = 8     -- flash-blinds players within this many nodes
local FRAG_BLIND_LOOK_DOT  = 0.4   -- must be facing the blast within this cone (dot)
local FRAG_FLASH_TIME      = 2.5   -- seconds for the white overlay to fully fade

-- Placeholder sound names (TODO: real audio).
local FRAG_SOUND_PIN     = "bestguns_frag_pin"
local FRAG_SOUND_THROW   = "bestguns_frag_throw"
local FRAG_SOUND_BOUNCE  = "bestguns_frag_bounce"
local FRAG_SOUND_EXPLODE = "bestguns_frag_explode"
local FRAG_SOUND_RING    = "bestguns_frag_ring"   -- ears ringing when caught close

-- Each fragment is a bullet. Registered like any other round so the bullet
-- entity picks up its smoke trail (on by default) and hit handling. It's never
-- loaded into a gun - it's spawned directly at detonation - so its caliber is a
-- dummy and it stays out of the creative inventory. Whizz-by and node-impact
-- sounds are silenced: dozens landing at once would be a wall of noise.
bestguns.register_bullet("bestguns:frag_fragment", {
    description = "Grenade Fragment",
    caliber = "frag",
    speed = FRAG_FRAGMENT_SPEED,
    size = 0.35,
    texture = "blank.png",   -- overridden per-fragment at spawn
    inventory_image = "bestguns_frag_frag_1.png",
    damage = 30,
    trail_spacing = 0.8,          -- a touch sparser than a bullet's default 0.5
    whiz_sound = false,
    hit_node_sound = false,
    not_in_creative_inventory = true,
})

-- Uniformly random unit vector (proper spherical distribution - so fragments
-- scatter evenly in all directions rather than clumping like bestguns.r would).
local function frag_random_dir()
    local z = math.random() * 2 - 1
    local a = math.random() * 2 * math.pi
    local r = math.sqrt(math.max(1 - z * z, 0))
    return vector.new(r * math.cos(a), z, r * math.sin(a))
end

-- A full-screen white flash the player was staring into. A solid-white texture
-- (textures/bestguns_frag_flash.png); opacity is animated down to zero each
-- globalstep to fade the blindness out.
local FRAG_FLASH_TEX = "bestguns_frag_flash.png"
local frag_flashes = {}   -- pname -> {id = hud_id, remaining = , total = }

-- Blind `player`: fade duration/starting opacity scale with `strength` in (0, 1].
-- A fresh flash while one is still fading takes whichever leaves them blinded
-- longer, so a double blast doesn't cut the effect short.
local function frag_flash(player, strength)
    local pname = player:get_player_name()
    local total = FRAG_FLASH_TIME * strength
    local existing = frag_flashes[pname]
    if existing then
        if total > existing.remaining then existing.remaining = total end
        if total > existing.total then existing.total = total end
        return
    end
    local id = player:hud_add({
        hud_elem_type = "image",
        position = {x = 0.5, y = 0.5},
        alignment = {x = 0, y = 0},
        scale = {x = -100, y = -100},   -- negative = percent of screen: fill it
        text = FRAG_FLASH_TEX .. "^[opacity:255",
        z_index = 1000,
    })
    if id then
        frag_flashes[pname] = {id = id, remaining = total, total = total}
    end
end

core.register_globalstep(function(dtime)
    if not next(frag_flashes) then return end
    for pname, f in pairs(frag_flashes) do
        local player = core.get_player_by_name(pname)
        if not player then
            frag_flashes[pname] = nil
        else
            f.remaining = f.remaining - dtime
            if f.remaining <= 0 then
                player:hud_remove(f.id)
                frag_flashes[pname] = nil
            else
                local alpha = math.floor(255 * (f.remaining / f.total))
                player:hud_change(f.id, "text", FRAG_FLASH_TEX .. "^[opacity:" .. alpha)
            end
        end
    end
end)

core.register_on_leaveplayer(function(player)
    frag_flashes[player:get_player_name()] = nil   -- HUD dies with the player anyway
end)

-- Detonate at `pos`: spray the fragment bullets outward and throw up a flash +
-- smoke burst. `thrower_name` attributes fragment kills to the thrower (and, as
-- with every bullet, keeps them from being hit by their own fragments).
local function frag_explode(pos, thrower_name)
    local b_def = bestguns.registered_bullets["bestguns:frag_fragment"]
    local center = vector.offset(pos, 0, 0.3, 0)   -- lift off the ground a touch

    local count = math.random(FRAG_MIN_FRAGMENTS, FRAG_MAX_FRAGMENTS)
    for _ = 1, count do
        local data = {
            velocity = vector.multiply(frag_random_dir(), FRAG_FRAGMENT_SPEED),
            shooter_name = thrower_name or "",
            _item = "bestguns:frag_fragment",
            _drops = "",   -- fragments never drop as an item
            damage = math.floor((b_def.damage or 1) * bestguns.damage_scale),
            texture = "blank.png",
            size = b_def.size or 1,
            _trail_max = math.random(2, 9),   -- each shard's trail dies after 2-9 nodes
            _self_hit = true,   -- your own frag can hit you: hug it and it hurts
        }
        core.add_entity(center, "bestguns:bullet", core.serialize(data))
    end

    -- Close-range shockwave: a burst of direct blast damage falling off linearly
    -- from the centre to zero at FRAG_BLAST_RADIUS. Independent of the fragments
    -- (which can miss), so anyone right on top of it is guaranteed to be hit. The
    -- thrower is NOT spared - hug your own grenade and it kills you. Damage is
    -- scaled by bestguns.damage_scale, same as every other damage source.
    local thrower = thrower_name and core.get_player_by_name(thrower_name)
    local puncher = (thrower and thrower:is_valid()) and thrower or nil
    for _, obj in ipairs(core.get_objects_inside_radius(center, FRAG_BLAST_RADIUS)) do
        if obj:is_valid() and (obj:is_player() or obj:get_luaentity()) then
            local opos = obj:get_pos()
            local dist = vector.distance(center, opos)
            -- Walls stop the blast: no damage unless there's a clear line from the
            -- centre to the target (aim at chest height so a low grenade still
            -- reaches a standing player over a step).
            local target = vector.offset(opos, 0, 1.0, 0)
            local dmg = math.floor(FRAG_BLAST_DAMAGE * (1 - dist / FRAG_BLAST_RADIUS) * bestguns.damage_scale)
            if dmg > 0 and core.line_of_sight(center, target) then
                local dir = dist > 0.05 and vector.direction(center, obj:get_pos()) or vector.new(0, 1, 0)
                obj:punch(puncher or obj, 1.0, {
                    full_punch_interval = 1.0,
                    damage_groups = {fleshy = dmg, ranged = 1, splash = 1},
                }, dir)
            end
        end
    end

    -- Flash burst.
    for _ = 1, math.random(10, 16) do
        core.add_particle({
            pos = center,
            velocity = {x = bestguns.r(8), y = bestguns.r(8), z = bestguns.r(8)},
            expirationtime = 0.15,
            size = math.random(16, 26),
            texture = "bestguns_muzzle_flash.png^[opacity:" .. math.random(50, 90),
            glow = 14,
        })
    end
    -- Lingering smoke cloud.
    for _ = 1, math.random(18, 28) do
        core.add_particle({
            pos = vector.offset(center, bestguns.r(0.6), bestguns.r(0.4), bestguns.r(0.6)),
            velocity = {x = bestguns.r(1.5), y = math.random(1, 3), z = bestguns.r(1.5)},
            acceleration = {x = 0, y = 1, z = 0},
            expirationtime = math.random(8, 16) / 10,
            size = math.random(12, 24),
            texture = "bestguns_smoke_" .. math.random(3) .. ".png^[opacity:" .. math.random(30, 70),
            glow = math.random(3, 8),
        })
    end

    core.sound_play(FRAG_SOUND_EXPLODE, {pos = center, gain = 1.2, max_hear_distance = 80}, true)

    for _, player in ipairs(core.get_connected_players()) do
        local ppos = player:get_pos()
        local dist = vector.distance(ppos, center)

        -- Ears ringing for anyone caught close, whether or not the blast hurt (or
        -- killed) them. Played to_player (non-positional) so it keeps ringing at a
        -- steady volume no matter where they move afterwards.
        if dist <= FRAG_RING_HEAR then
            core.sound_play(FRAG_SOUND_RING, {to_player = player:get_player_name(), gain = 1.0}, true)
        end

        -- Flash-blind anyone who was looking at the grenade with a clear line of
        -- sight to it when it went off, within FRAG_BLIND_RADIUS nodes.
        if dist <= FRAG_BLIND_RADIUS then
            local eye = vector.offset(ppos, 0, player:get_properties().eye_height or 1.625, 0)
            local dir = vector.direction(eye, center)
            -- Facing the blast?
            if vector.dot(player:get_look_dir(), dir) >= FRAG_BLIND_LOOK_DOT then
                -- Unobstructed line of sight? (nodes only; the grenade sits in air)
                local blocked = false
                for hit in core.raycast(eye, center, false, false) do
                    if hit.type == "node" then blocked = true break end
                end
                if not blocked then
                    -- Closer = brighter/longer, clamped so even the edge gets a solid flash.
                    local strength = math.max(1 - (dist / FRAG_BLIND_RADIUS) * 0.5, 0.4)
                    frag_flash(player, strength)
                end
            end
        end
    end
end

-- Swap a grenade item's look between "safe" (pin in) and "cooking" (pin pulled).
-- Clearing a meta field to "" reverts it to the base item definition's value.
local function frag_set_armed_visuals(meta, armed)
    if armed then
        meta:set_string("inventory_image", "bestguns_frag_without_pin.png")
        meta:set_string("wield_image", "bestguns_frag_without_pin.png")
        meta:set_string("description", "Frag Grenade\nPin pulled - cooking!")
    else
        meta:set_string("inventory_image", "")
        meta:set_string("wield_image", "")
        meta:set_string("description", "")
    end
end

-- Pin-pull tokens that have already been committed to a thrown/dropped grenade.
-- The whole stack shares one token, so after one is thrown the leftover grenades
-- in hand still bear it; this set lets the hand-detonate (and the next throw) know
-- that pin-pull is spent, so it can't also blow up in your hand. Entries are
-- cleaned up when the token's hand_detonate callback finally fires.
local frag_spent_tokens = {}

-- Every item name that behaves as a bestguns frag grenade. The canonical item is
-- "bestguns:frag", but other mods can graft this behaviour onto their own item
-- (e.g. bestguns_ctf overrides "ctf_grenades:frag" to replace CTF's builtin frag).
-- The hand-detonate scan matches any of these names, so a cooking grenade held in
-- hand blows up regardless of which registered frag item it is.
local frag_item_names = {["bestguns:frag"] = true}

-- Fuse expired while the grenade is still on the player (never thrown, or the
-- thrown one already handled its own blast). Each pin-pull carries a unique
-- token; we only detonate if a grenade still bearing THIS token is on the player
-- - otherwise it was thrown/disarmed and this callback is stale. Cooking one off
-- in your hand is lethal: a guaranteed self-hit finishes the careless holder.
local function frag_hand_detonate(pname, token)
    -- Already thrown/dropped under this pin-pull: the entity owns the blast.
    if frag_spent_tokens[token] then
        frag_spent_tokens[token] = nil
        return
    end

    local player = core.get_player_by_name(pname)
    if not player then return end

    local matched = false
    local wield = player:get_wielded_item()
    if frag_item_names[wield:get_name()] and wield:get_meta():get_string("fuse_id") == token then
        matched = true
        player:set_wielded_item(ItemStack(""))
    else
        local inv = player:get_inventory()
        for i = 1, inv:get_size("main") do
            local st = inv:get_stack("main", i)
            if frag_item_names[st:get_name()] and st:get_meta():get_string("fuse_id") == token then
                matched = true
                inv:set_stack("main", i, ItemStack(""))
                break
            end
        end
    end
    if not matched then return end   -- thrown/disarmed: the entity owns the blast

    local pos = vector.offset(player:get_pos(), 0, 1.0, 0)
    frag_explode(pos, pname)   -- credit nearby frags to them; they're excluded from their own
    player:punch(player, 1.0, {full_punch_interval = 1.0, damage_groups = {fleshy = 1000}})
end

-- RMB: pull the pin. The fuse starts NOW and runs no matter what happens next -
-- thrown or held. A pin-pull sound plays and the grenade is marked "cooking".
-- Pulling again does nothing (the pin's already out).
local function frag_pull_pin(itemstack, user)
    if not (user and user:is_player()) then return itemstack end
    local meta = itemstack:get_meta()
    if meta:get_int("armed") == 1 then return itemstack end

    local now = core.get_us_time() / 1000000
    local token = string.format("%d-%d", math.floor(now * 1000), math.random(1, 1000000000))
    meta:set_int("armed", 1)
    meta:set_float("fuse_start", now)
    meta:set_string("fuse_id", token)
    frag_set_armed_visuals(meta, true)

    core.sound_play(FRAG_SOUND_PIN, {pos = user:get_pos(), gain = 0.9, max_hear_distance = 12}, true)

    local pname = user:get_player_name()
    core.after(FRAG_FUSE, function() frag_hand_detonate(pname, token) end)
    return itemstack
end

-- The thrown grenade: a physical entity that arcs and rolls under gravity. If it
-- was thrown with the pin pulled it carries the fuse time remaining and detonates
-- when it runs out (see frag_explode). Thrown with the pin still in, it's a dud:
-- it lands inert and drops back as a recoverable grenade item.
core.register_entity(":bestguns:frag_grenade", {
    initial_properties = {
        physical = true,
        collide_with_objects = false,
        collisionbox = {-0.15, -0.15, -0.15, 0.15, 0.15, 0.15},
        pointable = false,
        visual = "sprite",
        visual_size = {x = 0.45, y = 0.45},
        textures = {"bestguns_frag_without_pin.png"},
        static_save = false,
    },

    on_activate = function(self, staticdata)
        self.object:set_armor_groups({immortal = 1})
        local data = core.deserialize(staticdata) or {}
        self.thrower_name = data.thrower_name
        self.item_name = data.item_name or "bestguns:frag"   -- what a dud drops back as
        self.timer = data.fuse   -- nil = dud (pin never pulled)
        -- A dud still shows the pin.
        if not self.timer then
            self.object:set_properties({textures = {"bestguns_frag_with_pin.png"}})
        end
        self.object:set_acceleration({x = 0, y = -9.8, z = 0})
    end,

    on_step = function(self, dtime, moveresult)
        -- Bounce off nodes: reflect the velocity along each axis it struck. The
        -- colliding axes keep FRAG_BOUNCE of their speed (flipped, so it rebounds);
        -- the tangential axes keep FRAG_FRICTION (scraping loss). This lets a
        -- grenade ricochet off walls and roll to rest on the ground.
        if moveresult and moveresult.collides and moveresult.collisions
                and #moveresult.collisions > 0 then
            local ov = moveresult.collisions[1].old_velocity
            local nv = {x = ov.x * FRAG_FRICTION, y = ov.y * FRAG_FRICTION, z = ov.z * FRAG_FRICTION}
            for _, c in ipairs(moveresult.collisions) do
                if c.axis == "x" then nv.x = -ov.x * FRAG_BOUNCE
                elseif c.axis == "y" then nv.y = -ov.y * FRAG_BOUNCE
                elseif c.axis == "z" then nv.z = -ov.z * FRAG_BOUNCE end
            end
            self.object:set_velocity(nv)

            -- Bounce/scrape sound the first tick it strikes something, re-armed
            -- once it's airborne again, so a grenade resting on the ground stays
            -- quiet. Skip the tiny settling taps once it's barely moving.
            if not self._colliding then
                self._colliding = true
                if math.abs(ov.x) + math.abs(ov.y) + math.abs(ov.z) > 1.5 then
                    core.sound_play(FRAG_SOUND_BOUNCE, {
                        pos = self.object:get_pos(), gain = 0.6, max_hear_distance = 20,
                    }, true)
                end
            end
        else
            self._colliding = false
        end

        if self.timer then
            self.timer = self.timer - dtime
            if self.timer <= 0 then
                frag_explode(self.object:get_pos(), self.thrower_name)
                self.object:remove()
            end
        else
            -- Dud: sit inert a moment, then hand the grenade back as an item.
            self._dud = (self._dud or 0) + dtime
            if self._dud > 6 then
                core.add_item(self.object:get_pos(), self.item_name)
                self.object:remove()
            end
        end
    end,
})

-- Launch a grenade from the player's hand as a live entity. `speed` is the lob
-- speed along the look direction and `lift` the upward kick; a hard throw uses the
-- full values, a drop uses near-zero so it just plops at your feet. `momentum`
-- adds the thrower's own velocity (a running throw carries further) - off for a
-- drop. Spends one grenade (minus creative) and disarms the rest of the stack.
local function frag_throw(itemstack, user, speed, lift, momentum)
    if not (user and user:is_player()) then return itemstack end
    local meta = itemstack:get_meta()

    -- If the pin's out (and this pin-pull hasn't already been spent on another
    -- grenade from the same stack), hand the entity the fuse time still remaining
    -- so it keeps counting down from where the hand-held fuse left off. Otherwise
    -- it flies as a dud (fuse = nil). Marking the token spent stops the pending
    -- hand-detonate from also blowing up the leftover grenades in your hand.
    local fuse
    local token = meta:get_string("fuse_id")
    if meta:get_int("armed") == 1 and token ~= "" and not frag_spent_tokens[token] then
        local now = core.get_us_time() / 1000000
        fuse = math.max(FRAG_FUSE - (now - meta:get_float("fuse_start")), 0.05)
        frag_spent_tokens[token] = true
    end

    local eye_height = user:get_properties().eye_height or 1.625
    local dir = user:get_look_dir()
    local origin = vector.offset(user:get_pos(), 0, eye_height - 0.2, 0)
    local spawn = vector.add(origin, vector.multiply(dir, 0.5))

    local vel = vector.add(vector.multiply(dir, speed), vector.new(0, lift, 0))
    if momentum then vel = vector.add(vel, user:get_velocity() or vector.zero()) end

    local obj = core.add_entity(spawn, "bestguns:frag_grenade", core.serialize({
        thrower_name = user:get_player_name(),
        item_name = itemstack:get_name(),
        fuse = fuse,
    }))
    if obj then obj:set_velocity(vel) end

    core.sound_play(FRAG_SOUND_THROW, {pos = origin, gain = 0.8, max_hear_distance = 16}, true)

    if not core.is_creative_enabled(user:get_player_name()) then
        itemstack:take_item(1)
    end

    -- The pin you pulled belonged to the grenade you just threw: any grenades left
    -- in the stack are fresh and safe again (so the stale hand-detonate callback
    -- finds no matching token and does nothing).
    if itemstack:get_count() > 0 then
        local m = itemstack:get_meta()
        m:set_int("armed", 0)
        m:set_string("fuse_id", "")
        m:set_float("fuse_start", 0)
        frag_set_armed_visuals(m, false)
    end
    return itemstack
end

-- The grenade item. RMB pulls the pin (arms the fuse); LMB throws; the drop key
-- gently lobs it at your feet. You can throw at any time - before pulling the pin
-- (an inert dud) or after (it'll cook off in flight). One grenade is spent per
-- throw, minus creative mode. Leading ":" registers the "bestguns:"-namespaced
-- item from this pack mod, like the bullets.
core.register_craftitem(":bestguns:frag", {
    description = "Frag Grenade",
    inventory_image = "bestguns_frag_with_pin.png",
    wield_image = "bestguns_frag_with_pin.png",
    stack_max = 1,   -- grenades never stack: one armed pin-pull per item, no shared state

    -- RMB (on a node or in the air): pull the pin.
    on_place = function(itemstack, user, pointed_thing)
        return frag_pull_pin(itemstack, user)
    end,
    on_secondary_use = function(itemstack, user, pointed_thing)
        return frag_pull_pin(itemstack, user)
    end,

    -- LMB: a full throw, with a little lift and the thrower's momentum.
    on_use = function(itemstack, user, pointed_thing)
        return frag_throw(itemstack, user, FRAG_THROW_SPEED, 2, true)
    end,

    -- Drop key: counts as a throw too, but with almost no velocity - it just rolls
    -- off your hand to your feet (a live grenade, cooking if the pin's out).
    on_drop = function(itemstack, dropper, pos)
        return frag_throw(itemstack, dropper, 0.5, 0.3, false)
    end,
})

-- Public frag API, so another mod can graft the frag grenade's behaviour onto a
-- different item (e.g. bestguns_ctf overrides "ctf_grenades:frag" so CTF hands out
-- this grenade in place of its builtin one). `apply_to(name)` registers the item
-- name so the hand-detonate scan recognises it and returns the standard callback
-- set to splice into an override; the throw speeds are exposed for the on_use/drop.
bestguns.frag = {
    THROW_SPEED = FRAG_THROW_SPEED,

    -- Register an item name as a frag grenade (so a cooking one in hand detonates).
    register_item_name = function(name)
        frag_item_names[name] = true
    end,

    -- The full set of item callbacks + visuals for a frag grenade. Feed straight
    -- into core.register_craftitem or minetest.override_item on any item name;
    -- also calls register_item_name so the item is recognised in-hand.
    item_fields = function(name)
        frag_item_names[name] = true
        return {
            description = "Frag Grenade",
            inventory_image = "bestguns_frag_with_pin.png",
            wield_image = "bestguns_frag_with_pin.png",
            stack_max = 1,
            on_place = function(itemstack, user, pointed_thing) return frag_pull_pin(itemstack, user) end,
            on_secondary_use = function(itemstack, user, pointed_thing) return frag_pull_pin(itemstack, user) end,
            on_use = function(itemstack, user, pointed_thing)
                return frag_throw(itemstack, user, FRAG_THROW_SPEED, 2, true)
            end,
            on_drop = function(itemstack, dropper, pos)
                return frag_throw(itemstack, dropper, 0.5, 0.3, false)
            end,
        }
    end,
}


-- CTF integration (loot, class loadouts, combat) lives in the separate
-- bestguns_ctf mod (mods/ctf/ctf_combat/bestguns_ctf).
