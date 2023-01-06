---------------------------------------------------------------------------------------------------
-- metrosigns mod for minetest by A S Lewis
--      https://github.com/axcore/metrosigns
--      Licence: GNU Affero GPL
---------------------------------------------------------------------------------------------------
-- Code/textures from advtrains_subwayblocks by gpcf/orwell
--      https://git.gpcf.eu/?p=advtrains_subwayblocks.git
--      Licence: GNU Affero GPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original material from advtrains_subwayblocks by gpcf/orwell
---------------------------------------------------------------------------------------------------

if not HAVE_SUBWAYBLOCKS_FLAG and
        (metrosigns.create_all_flag or metrosigns.create_subwayblocks_flag) then

    local category = "Signs from subwayblocks mod"
    metrosigns.register_category(category)

    minetest.register_node("metrosigns:sb_box_berlin", {
        description = "Berlin U-Bahn lightbox (subwayblocks)",
        tiles = {
            "advtrains_subwayblocks_box_berlin_top.png",
            "advtrains_subwayblocks_box_berlin_top.png",
            "advtrains_subwayblocks_box_berlin_side.png",
            "advtrains_subwayblocks_box_berlin_side.png",
            "advtrains_subwayblocks_box_berlin_side.png",
            "advtrains_subwayblocks_box_berlin_side.png",
        },
        groups = box_groups,

        light_source = box_light_source,
    })
    metrosigns.register_sign(category, "metrosigns:sb_box_berlin", metrosigns.writer.box_units)

    minetest.register_node("metrosigns:sb_box_london", {
        description = "London Underground lightbox (subwayblocks)",
        tiles = {
            "advtrains_subwayblocks_box_london_top.png",
            "advtrains_subwayblocks_box_london_top.png",
            "advtrains_subwayblocks_box_london_side.png",
            "advtrains_subwayblocks_box_london_side.png",
            "advtrains_subwayblocks_box_london_side.png",
            "advtrains_subwayblocks_box_london_side.png",
        },
        groups = box_groups,

        light_source = box_light_source,
    })
    metrosigns.register_sign(category, "metrosigns:sb_box_london", metrosigns.writer.box_units)

    minetest.register_node("metrosigns:sb_box_madrid", {
        description = "Madrid Metro lightbox (subwayblocks)",
        tiles = {
            "advtrains_subwayblocks_box_madrid_top.png",
            "advtrains_subwayblocks_box_madrid_top.png",
            "advtrains_subwayblocks_box_madrid_side.png",
            "advtrains_subwayblocks_box_madrid_side.png",
            "advtrains_subwayblocks_box_madrid_side.png",
            "advtrains_subwayblocks_box_madrid_side.png",
        },
        groups = box_groups,

        light_source = box_light_source,
    })
    metrosigns.register_sign(category, "metrosigns:sb_box_madrid", metrosigns.writer.box_units)

    minetest.register_node("metrosigns:sb_box_mountain", {
        description = "Mountain Railway lightbox (subwayblocks)",
        tiles = {
            "advtrains_subwayblocks_box_mountain_top.png",
            "advtrains_subwayblocks_box_mountain_top.png",
            "advtrains_subwayblocks_box_mountain_side.png",
            "advtrains_subwayblocks_box_mountain_side.png",
            "advtrains_subwayblocks_box_mountain_side.png",
            "advtrains_subwayblocks_box_mountain_side.png",
        },
        groups = box_groups,

        light_source = box_light_source,
    })
    metrosigns.register_sign(category, "metrosigns:sb_box_mountain", metrosigns.writer.box_units)

    minetest.register_node("metrosigns:sb_box_paris", {
        description = "Paris Metro lightbox (subwayblocks)",
        tiles = {
            "advtrains_subwayblocks_box_paris_top.png",
            "advtrains_subwayblocks_box_paris_top.png",
            "advtrains_subwayblocks_box_paris_side.png",
            "advtrains_subwayblocks_box_paris_side.png",
            "advtrains_subwayblocks_box_paris_side.png",
            "advtrains_subwayblocks_box_paris_side.png",
        },
        groups = box_groups,

        light_source = box_light_source,
    })
    metrosigns.register_sign(category, "metrosigns:sb_box_paris", metrosigns.writer.box_units)

    for i = 1, 10, 1 do

        local num
        
        -- (Put signs in the right order in unified_inventory, etc)
        if i < 10 then
            num = "0" .. i
        else
            num = i
        end

        minetest.register_node("metrosigns:sb_sign_line_"..num, {
            description = "Line " .. i .. " sign (subwayblocks)",
            tiles = {"advtrains_subwayblocks_sign_line_" .. i .. ".png"},
            groups = {attached_node = 1, choppy = 2, flammable = 2, oddly_breakable_by_hand = 3},

            drawtype = "nodebox",
            inventory_image = "advtrains_subwayblocks_sign_line_"..i.."_inv.png",
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
            use_texture_alpha = "clip",
            walkable = false
        })
        metrosigns.register_sign(
            category, "metrosigns:sb_sign_line_"..num, metrosigns.writer.sign_units
        )

    end
    
end
