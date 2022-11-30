---------------------------------------------------------------------------------------------------
-- metrosigns mod for minetest by A S Lewis
--      https://github.com/axcore/metrosigns
--      Licence: GNU Affero GPL
---------------------------------------------------------------------------------------------------
-- Code/textures from trainblocks by Maxx
--      https://github.com/maxhipp/trainblocks_bc
--      https://forum.minetest.net/viewtopic.php?t=19743
--      Licence: GNU Affero GPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original material from trainblocks by Maxx
---------------------------------------------------------------------------------------------------

if not HAVE_TRAINBLOCKS_FLAG and
        (metrosigns.create_all_flag or metrosigns.create_trainblocks_flag) then

    local category = "Signs from trainblocks mod"
    metrosigns.register_category(category)

    minetest.register_node("metrosigns:tb_sign_station", {
        description = "Station sign (trainblocks)",
        tiles = {
            "trainblocks_sign_station_blank.png",
            "trainblocks_sign_station_blank.png",
            "trainblocks_sign_station_blank.png",
            "trainblocks_sign_station_blank.png",
            "trainblocks_sign_station_text.png",
            "trainblocks_sign_station_text.png",
        },
        groups = {cracky = 3},

        drawtype = "nodebox",
        inventory_image = "trainblocks_sign_station_text.png",
        is_ground_content = false,
        light_source = 6,
        node_box = {
            type = "fixed",
            fixed = {
                {-8/16, -5/16, 6/16,  8/16,  5/16, 8/16},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })
    metrosigns.register_sign(category, "metrosigns:tb_sign_station", metrosigns.writer.sign_units)

    minetest.register_node("metrosigns:tb_sign_station_exit_left", {
        description = "Station left exit sign (trainblocks)",
        tiles = {
            "trainblocks_sign_station_blank.png",
            "trainblocks_sign_station_blank.png",
            "trainblocks_sign_station_blank.png",
            "trainblocks_sign_station_blank.png",
            "trainblocks_sign_station_exit_text.png",
            "trainblocks_sign_station_exit_text.png^[transformFX",
        },
        groups = {cracky = 3},

        drawtype = "nodebox",
        inventory_image = "trainblocks_sign_station_exit_text.png^[transformFX",
        is_ground_content = false,
        light_source = 6,
        node_box = {
            type = "fixed",
            fixed = {
                {-8/16, -5/16, 6/16,  8/16,  5/16, 8/16},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })
    metrosigns.register_sign(
        category, "metrosigns:tb_sign_station_exit_left", metrosigns.writer.sign_units
    )

    minetest.register_node("metrosigns:tb_sign_station_exit_right", {
        description = "Station right exit sign (trainblocks)",
        tiles = {
            "trainblocks_sign_station_blank.png",
            "trainblocks_sign_station_blank.png",
            "trainblocks_sign_station_blank.png",
            "trainblocks_sign_station_blank.png",
            "trainblocks_sign_station_exit_text.png",
            "trainblocks_sign_station_exit_text.png",
        },
        groups = {cracky = 3},

        drawtype = "nodebox",
        inventory_image = "trainblocks_sign_station_exit_text.png",
        is_ground_content = false,
        light_source = 6,
        node_box = {
            type = "fixed",
            fixed = {
                {-8/16, -5/16, 6/16,  8/16,  5/16, 8/16},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })
    metrosigns.register_sign(
        category, "metrosigns:tb_sign_station_exit_right", metrosigns.writer.sign_units
    )

    minetest.register_node("metrosigns:tb_box_berlin_ubahn", {
        description = "Berlin U-Bahn lightbox (trainblocks)",
        tiles = {
            "trainblocks_box_berlin_ubahn_top.png",
            "trainblocks_box_berlin_ubahn_top.png",
            "trainblocks_box_berlin_ubahn_side.png",
            "trainblocks_box_berlin_ubahn_side.png",
            "trainblocks_box_berlin_ubahn_side.png",
            "trainblocks_box_berlin_ubahn_side.png",
        },
        groups = box_groups,

        light_source = box_light_source,
    })
    metrosigns.register_sign(
        category, "metrosigns:tb_box_berlin_ubahn", metrosigns.writer.box_units
    )

    minetest.register_node("metrosigns:tb_sign_berlin_ubahn_exit_left", {
        description = "Berlin U-Bahn left exit sign (trainblocks)",
        tiles = {
            "trainblocks_sign_berlin_ubahn_exit_blank.png",
            "trainblocks_sign_berlin_ubahn_exit_blank.png",
            "trainblocks_sign_berlin_ubahn_exit_blank.png",
            "trainblocks_sign_berlin_ubahn_exit_blank.png",
            "trainblocks_sign_berlin_ubahn_exit_text.png",
            "trainblocks_sign_berlin_ubahn_exit_text.png^[transformFX",
        },
        groups = {cracky = 3},

        drawtype = "nodebox",
        inventory_image = "trainblocks_sign_berlin_ubahn_exit_text.png^[transformFX",
        is_ground_content = false,
        light_source = 6,
        node_box = {
            type = "fixed",
            fixed = {
                {-8/16, -5/16, 6/16,  8/16,  5/16, 8/16},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })
    metrosigns.register_sign(
        category, "metrosigns:tb_sign_berlin_ubahn_exit_left", metrosigns.writer.sign_units
    )

    minetest.register_node("metrosigns:tb_sign_berlin_ubahn_exit_right", {
        description = "Berlin U-Bahn right exit sign (trainblocks)",
        tiles = {
            "trainblocks_sign_berlin_ubahn_exit_blank.png",
            "trainblocks_sign_berlin_ubahn_exit_blank.png",
            "trainblocks_sign_berlin_ubahn_exit_blank.png",
            "trainblocks_sign_berlin_ubahn_exit_blank.png",
            "trainblocks_sign_berlin_ubahn_exit_text.png",
            "trainblocks_sign_berlin_ubahn_exit_text.png",
        },
        groups = {cracky = 3},

        drawtype = "nodebox",
        inventory_image = "trainblocks_sign_berlin_ubahn_exit_text.png",
        is_ground_content = false,
        light_source = 6,
        node_box = {
            type = "fixed",
            fixed = {
                {-8/16, -5/16, 6/16,  8/16,  5/16, 8/16},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })
    metrosigns.register_sign(
        category, "metrosigns:tb_sign_berlin_ubahn_exit_right", metrosigns.writer.sign_units
    )

    minetest.register_node("metrosigns:tb_box_berlin_sbahn", {
        description = "Berlin S-Bahn lightbox (trainblocks)",
        tiles = {
            "trainblocks_box_berlin_sbahn_top.png",
            "trainblocks_box_berlin_sbahn_top.png",
            "trainblocks_box_berlin_sbahn_side.png",
            "trainblocks_box_berlin_sbahn_side.png",
            "trainblocks_box_berlin_sbahn_side.png",
            "trainblocks_box_berlin_sbahn_side.png",
        },
        groups = box_groups,

        light_source = box_light_source,
    })
    metrosigns.register_sign(
        category, "metrosigns:tb_box_berlin_sbahn", metrosigns.writer.box_units
    )

    minetest.register_node("metrosigns:tb_sign_berlin_sbahn_exit_left", {
        description = "Berlin S-Bahn left exit sign (trainblocks)",
        tiles = {
            "trainblocks_sign_berlin_sbahn_exit_blank.png",
            "trainblocks_sign_berlin_sbahn_exit_blank.png",
            "trainblocks_sign_berlin_sbahn_exit_blank.png",
            "trainblocks_sign_berlin_sbahn_exit_blank.png",
            "trainblocks_sign_berlin_sbahn_exit_revtext.png",
            "trainblocks_sign_berlin_sbahn_exit_revtext.png^[transformFX",
        },
        groups = {cracky = 3},

        drawtype = "nodebox",
        inventory_image = "trainblocks_sign_berlin_sbahn_exit_revtext.png^[transformFX",
        is_ground_content = false,
        light_source = 6,
        node_box = {
            type = "fixed",
            fixed = {
                {-8/16, -5/16, 6/16,  8/16,  5/16, 8/16},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })
    metrosigns.register_sign(
        category, "metrosigns:tb_sign_berlin_sbahn_exit_left", metrosigns.writer.sign_units
    )

    minetest.register_node("metrosigns:tb_sign_berlin_sbahn_exit_right", {
        description = "Berlin S-Bahn right exit sign (trainblocks)",
        tiles = {
            "trainblocks_sign_berlin_sbahn_exit_blank.png",
            "trainblocks_sign_berlin_sbahn_exit_blank.png",
            "trainblocks_sign_berlin_sbahn_exit_blank.png",
            "trainblocks_sign_berlin_sbahn_exit_blank.png",
            "trainblocks_sign_berlin_sbahn_exit_text.png",
            "trainblocks_sign_berlin_sbahn_exit_text.png",
        },
        groups = {cracky = 3},

        drawtype = "nodebox",
        inventory_image = "trainblocks_sign_berlin_sbahn_exit_text.png",
        is_ground_content = false,
        light_source = 6,
        node_box = {
            type = "fixed",
            fixed = {
                {-8/16, -5/16, 6/16,  8/16,  5/16, 8/16},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })
    metrosigns.register_sign(
        category, "metrosigns:tb_sign_berlin_sbahn_exit_right", metrosigns.writer.sign_units
    )

    for i = 1, 10, 1 do

        local num
        
        -- (Put signs in the right order in unified_inventory, etc)
        if i < 10 then
            num = "0"..i
        else
            num = i
        end

        minetest.register_node("metrosigns:tb_sign_line_"..num, {
            description = "Line "..i.." sign (trainblocks)",
            tiles = {"trainblocks_sign_line_"..i..".png"},
            groups = {attached_node = 1, choppy = 2, flammable = 2, oddly_breakable_by_hand = 3},

            drawtype = "nodebox",
            inventory_image = "trainblocks_sign_line_"..i.."_inv.png",
            is_ground_content = false,
            legacy_wallmounted = true,
            light_source = 12,
            node_box = {
                type = "wallmounted",
                wall_top = {-8/16, -4/16, -4/16, -7/16, 4/16, 4/16},
                wall_bottom = {-8/16, -4/16, -4/16, -7/16, 4/16, 4/16},
                wall_side = {-8/16, -4/16, -4/16, -7/16, 4/16, 4/16},
            },
            paramtype = "light",
            paramtype2 = "wallmounted",
            sunlight_propagates = true,
            walkable = false
        })
        metrosigns.register_sign(
            category, "metrosigns:tb_sign_line_"..num, metrosigns.writer.sign_units
        )

        minetest.register_node("metrosigns:tb_sign_platform_"..num, {
            description = "Platform "..i.." sign (trainblocks)",
            tiles = {"trainblocks_sign_platform_"..i..".png"},
            groups = {cracky = 3},

            drawtype = "nodebox",
            inventory_image = "trainblocks_sign_platform_"..i.."_inv.png",
            is_ground_content = false,
            legacy_wallmounted = true,
            light_source = 5,
            node_box = {
                type = "fixed",
                fixed = {
                    {-4/16, -4/16, 6/16,  4/16,  4/16, 8/16},
                },
            },
            paramtype = "light",
            paramtype2 = "facedir",
            walkable = false
        })
        metrosigns.register_sign(
            category, "metrosigns:tb_sign_platform_"..num, metrosigns.writer.sign_units
        )

    end
    
end
