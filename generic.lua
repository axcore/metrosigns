---------------------------------------------------------------------------------------------------
-- metrosigns mod for minetest by A S Lewis
--      https://github.com/axcore/metrosigns
--      Licence: GNU Affero GPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Generic functions used by city-specific and server-specific signs
---------------------------------------------------------------------------------------------------

function add_lightbox(city, city_descrip)

    -- Adds a lightbox node (every city usually has at least one)
    --
    -- Args:
    --      city (string): The short city name, e.g. "london"
    --      city_descrip (string): The long city name, e.g. "London Underground"; should be the
    --          one of the categories specified by metrosigns.writer.categories

    minetest.register_node("metrosigns:box_" .. city, {
        description = city_descrip .. " lightbox",
        tiles = {
            "metrosigns_box_" .. city .. "_top.png",
            "metrosigns_box_" .. city .. "_top.png",
            "metrosigns_box_" .. city .. "_side.png",
            "metrosigns_box_" .. city .. "_side.png",
            "metrosigns_box_" .. city .. "_side.png",
            "metrosigns_box_" .. city .. "_side.png",
        },
        groups = box_groups,

        light_source = box_light_source,
    })
    metrosigns.register_sign(city_descrip, "metrosigns:box_" .. city, metrosigns.writer.box_units)

end

function add_sign(city, city_descrip, line, line_descrip, extra_width, extra_height)

    -- Adds a line sign
    --
    -- Args:
    --      city (string): The short city name, e.g. "london"
    --      city_descrip (string): The long city name, e.g. "London Underground"; should be the
    --          one of the categories specified by metrosigns.writer.categories
    --      line (string): The short line name/number, used in the node name (e.g. "1", "a1",
    --          "bakerloo"
    --      line_descrip (string): The long line name/number, used in the node description (so it
    --          should be capitalised, e.g. "1", "A1", "Bakerloo Line"
    --      extra_width (int): The sign can be made wider (minimum value 1), or given its default
    --          length (0)
    --      extra_height (int): The sign can be made higher (minimum value 1), or given its default
    --          height (0)

    local cap_city = capitalise(city)
    local node = "metrosigns:sign_" .. city .. "_line_" .. line

    -- Convert (e.g.) 1 pixel to the node box equivalent, 1/16
    extra_width = (4 + extra_width) / 16
    extra_height = (4 + extra_height) / 16

    minetest.register_node(node, {
        description = cap_city .. " Line " .. line_descrip .. " sign",
        tiles = {"metrosigns_sign_" .. city .. "_line_" .. line .. ".png"},
        groups = {attached_node = 1, choppy = 2, flammable = 2, oddly_breakable_by_hand = 3},

        drawtype = "nodebox",
        inventory_image = "metrosigns_sign_" .. city .. "_line_" .. line .. "_inv.png",
        is_ground_content = false,
        legacy_wallmounted = true,
        light_source = 12,
        node_box = {
            type = "wallmounted",
            wall_top = {-8/16, -4/16, -4/16, -7/16, 4/16, 4/16},
            wall_bottom = {-8/16, -4/16, -4/16, -7/16, 4/16, 4/16},
            wall_side = {
                -8/16, (extra_height * -1), (extra_width * -1), -7/16, extra_height, extra_width,
            },
        },
        paramtype = "light",
        paramtype2 = "wallmounted",
        sunlight_propagates = true,
        use_texture_alpha = "clip",
        walkable = false
    })
    metrosigns.register_sign(city_descrip, node, metrosigns.writer.sign_units)

end

function add_sign_special(city, city_descrip, route, route_descrip)

    -- Modified version of add_sign(); used for New York and Stockholm, which have multiple routes
    --      on each line
    -- Adds a line sign
    --
    -- Args:
    --      city (string): The short city name, e.g. "london"
    --      city_descrip (string): The long city name, e.g. "London Underground"; should be the
    --          one of the categories specified by metrosigns.writer.categories
    --      route (string): The short route name/number, used in the node name (e.g. "1", "a1",
    --          "bakerloo"
    --      route_descrip (string): The long route name/number, used in the node description (so it
    --          should be capitalised, e.g. "1", "A1", "Bakerloo Line"

    local cap_city = capitalise(city)
    local node = "metrosigns:sign_" .. city .. "_route_" .. route

    minetest.register_node(node, {
        description = cap_city .. " Route " .. route_descrip .. " sign",
        tiles = {"metrosigns_sign_" .. city .. "_route_" .. route .. ".png"},
        groups = {attached_node = 1, choppy = 2, flammable = 2, oddly_breakable_by_hand = 3},

        drawtype = "nodebox",
        inventory_image = "metrosigns_sign_" .. city .. "_route_" .. route .. "_inv.png",
        is_ground_content = false,
        legacy_wallmounted = true,
        light_source = 12,
        node_box = {
            type = "wallmounted",
            wall_top = {-8/16, -4/16, -4/16, -7/16, 4/16, 4/16},
            wall_bottom = {-8/16, -4/16, -4/16, -7/16, 4/16, 4/16},
            wall_side = {-8/16, -7/16, -7/16, -7/16, 7/16, 7/16},
        },
        paramtype = "light",
        paramtype2 = "wallmounted",
        sunlight_propagates = true,
        use_texture_alpha = "clip",
        walkable = false
    })
    metrosigns.register_sign(city_descrip, node, metrosigns.writer.sign_units)

end

function add_map_unit(
    city, city_descrip, line, line_descrip, unit, unit_descrip, terminus, terminus_descrip
)

    -- Usually called by add_map(), but can be called by each city/server as required (see examples
    --      in the code below)
    -- Adds a single map sign
    --
    -- Args:
    --      city (string): The short city name, e.g. "london"
    --      city_descrip (string): The long city name, e.g. "London Underground"; should be the
    --          one of the categories specified by metrosigns.writer.categories
    --      line (string): The short line name/number, used in the node name (e.g. "1", "a1",
    --          "bakerloo"
    --      line_descrip (string): The long line name/number, used in the node description (so it
    --          should be capitalised, e.g. "1", "A1", "Bakerloo Line"
    --      unit (string): The type of map sign. Typical values include "line" for a section of the
    --          line without a station, "station" for a section of the line with a normal station,
    --          "cstation" for an interchange station. Any non-empty string is acceptable, and some
    --          cities/servers may use their own custom values (e.g. the London Underground has
    --          different signs for stations which are wheelchair-accessible)
    --      unit_descrip (string): A description for the map sign, used in the node description
    --          (e.g. "Line", "Station", "Interchange")
    --      terminus (string): Default value is an empty string. Four other values are used to
    --          modify a map sign to show a terminus (the end of the line): "terml" and "termr" for
    --          normal stations, and "termlc" and "termrc" for interchange stations. The map sign
    --          is modified by applying a blank texture over a part of the original texture, hiding
    --          the line on the far left or far right side of the sign
    --      terminus_descrip (string): A description for the terminus map sign, used in the node
    --          description (e.g. "left terminus", "right terminus"

    local cap_city, node, description, img

    cap_city = capitalise(city)
    if terminus == "" then

        node = "metrosigns:map_" .. city .. "_" .. line .. "_" .. unit
        description = cap_city .. " " .. line_descrip ..  " " .. unit_descrip .. " sign"
        img = "metrosigns_map_" .. city .. "_" .. line .. "_" .. unit .. ".png"

    else

        node = "metrosigns:map_" .. city .. "_" .. line .. "_" .. unit .. "_" .. terminus
        description = cap_city .. " " .. line_descrip ..  " " .. unit_descrip .. " sign (" .. 
                terminus_descrip .. ")"
        img = "metrosigns_map_" .. city .. "_" .. line .. "_" .. unit .. ".png^metrosigns_map_" ..
                city .. "_" .. terminus .. ".png"

    end

    minetest.register_node(node, {
        description = description,
        -- Reverse the back image, so map signs can be viewed from the front or back
        tiles = {img, img, img, img, img .. "^[transform4", img},
        groups = {cracky = 3},

        drawtype = "nodebox",
        inventory_image = img,
        is_ground_content = false,
        legacy_wallmounted = true,
        light_source = 5,
        node_box = {
            type = "fixed",
            fixed = {
                { -8/16, -8/16, 6/16,  8/16,  8/16, 8/16},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        use_texture_alpha = "clip",
        walkable = false
    })
    metrosigns.register_sign(city_descrip, node, metrosigns.writer.map_units)

end

function add_map(city, city_descrip, line_table, type_table)

    -- Adds one or more map signs. The signs to add are specified by two tables. The tables can
    --      contain any values (but you should follow the examples below as closely as possible)
    --
    -- Args:
    --      city (string): The short city name, e.g. "london"
    --      city_descrip (string): The long city name, e.g. "London Underground"; should be the
    --          one of the categories specified by metrosigns.writer.categories
    --      line_table (table): A set of lines or routes for a city/server
    --      type_table (table): A set of map sign types. For every line/route, there are typically
    --          several types - a normal station, an interchange station, a section of the line
    --          with no station, and so on

    for line, line_descrip in pairs(line_table) do

        for unit, unit_descrip in pairs(type_table) do

            add_map_unit(city, city_descrip, line, line_descrip, unit, unit_descrip, "", "")
            if unit == "cstation" then

                add_map_unit(
                    city, city_descrip, line, line_descrip, unit, unit_descrip,
                    "termlc", "left terminus"
                )
                add_map_unit(
                    city, city_descrip, line, line_descrip, unit, unit_descrip,
                    "termrc", "right terminus"
                )

            elseif string.find(unit, "station") then

                add_map_unit(
                    city, city_descrip, line, line_descrip, unit, unit_descrip,
                    "terml", "left terminus"
                )
                add_map_unit(
                    city, city_descrip, line, line_descrip, unit, unit_descrip,
                    "termr", "right terminus"
                )

            end

        end

    end

end
