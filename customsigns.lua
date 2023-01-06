---------------------------------------------------------------------------------------------------
-- metrosigns mod for minetest by A S Lewis
--      https://github.com/axcore/metrosigns
--      Licence: GNU Affero GPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Signs with customisable text (designed to be used alongside the map nodes). Requires signs_api
--      from display_modpack
---------------------------------------------------------------------------------------------------

if HAVE_SIGNS_API_FLAG and (metrosigns.create_all_flag or metrosigns.create_text_flag) then

    local category = "Signs with text"
    metrosigns.register_category(category)

    local width_table = {
        [1] = "short",
        [2] = "medium",
        [3] = "long",
    }

    for width, width_descrip in pairs(width_table) do

        -- Default sign: text on a white background
        signs_api.register_sign(
            ":signs_road",
            "metrosigns_text_" .. width_descrip,
            {
                depth = 2/16,
                width = width,
                height = 1,

                entity_fields = {
                    size = {x = width, y = 12 / 16},
                    maxlines = 3,
                    color = "#000",
                },
                node_fields = {
                    description = "Metrosigns Text Sign (" .. width_descrip .. ")",
                    tiles = {
                        "metrosigns_text_side.png",
                        "metrosigns_text_side.png",
                        "metrosigns_text_side.png",
                        "metrosigns_text_side.png",
                        "metrosigns_text_side.png",
                        "metrosigns_text_front.png",
                    },
                    inventory_image = "metrosigns_text_width_" .. width_descrip .. "_inv.png",
                },
            }
        )
        metrosigns.register_sign(
            category,
            "signs_road:metrosigns_text_" .. width_descrip,
            (metrosigns.writer.text_units * width)
        )

        minetest.override_item("signs_road:metrosigns_text_" .. width_descrip, {light_source = 5})

        -- "You are here sign": text on a reddish background
        signs_api.register_sign(
            ":signs_road",
            "metrosigns_here_" .. width_descrip,
            {
                depth = 2/16,
                width = width,
                height = 1,

                entity_fields = {
                    size = {x = width, y = 12 / 16},
                    maxlines = 3,
                    color = "#000",
                },
                node_fields = {
                    description = "Metrosigns \"You Are Here\" Sign (" .. width_descrip .. ")",
                    tiles = {
                        "metrosigns_text_side.png",
                        "metrosigns_text_side.png",
                        "metrosigns_text_side.png",
                        "metrosigns_text_side.png",
                        "metrosigns_text_side.png",
                        "metrosigns_here_front.png",
                    },
                    inventory_image = "metrosigns_here_width_" .. width_descrip .. "_inv.png",
                },
            }
        )
        metrosigns.register_sign(
            category,
            "signs_road:metrosigns_here_" .. width_descrip,
            (metrosigns.writer.text_units * width)
        )

        minetest.override_item(
            "signs_road:metrosigns_here_" .. width_descrip,
            {light_source = 5}
        )

    end

end
