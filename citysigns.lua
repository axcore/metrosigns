---------------------------------------------------------------------------------------------------
-- metrosigns mod for minetest by A S Lewis
--      https://github.com/axcore/metrosigns
--      Licence: GNU Affero GPL
---------------------------------------------------------------------------------------------------

local city, cap_city, city_descrip

---------------------------------------------------------------------------------------------------
-- Athens Metro https://en.wikipedia.org/wiki/Athens_Metro
---------------------------------------------------------------------------------------------------

if metrosigns.create_all_flag or metrosigns.create_athens_flag then

    city = "athens"
    city_descrip = "Athens Metro"

    metrosigns.register_category(city_descrip)

    add_lightbox(city, city_descrip)

    add_sign(city, city_descrip, "m1", "M1", 1, 0)
    add_sign(city, city_descrip, "m2", "M2", 1, 0)
    add_sign(city, city_descrip, "m3", "M3", 1, 0)

    add_map(
        city,
        city_descrip,
        {
            ["m1"] = "M1",
            ["m2"] = "M2",
            ["m3"] = "M3",
        },
        {
            ["line"] = "Line",
            ["station"] = "Station",
        }
    )

end

---------------------------------------------------------------------------------------------------
-- Bangkok BTS Skytrain https://en.wikipedia.org/wiki/BTS_Skytrain
---------------------------------------------------------------------------------------------------

if metrosigns.create_all_flag or metrosigns.create_bangkok_flag then

    city = "bangkok"
    city_descrip = "Bangkok BTS Skytrain"

    metrosigns.register_category(city_descrip)

    add_lightbox(city, city_descrip)

    add_map(
        city,
        city_descrip,
        {
            ["arl"] = "ARL",
            ["brt"] = "BRT",
            ["mrt_blue"] = "MRT Blue",
            ["mrt_purple"] = "MRT Purple",
            ["silom"] = "BTS Silom",
            ["sukhumvit"] = "BTS Sukhumvit"
        },
        {
            ["line"] = "Line",
            ["station"] = "Station",
            ["cstation"] = "Interchange",
        }
    )

end

---------------------------------------------------------------------------------------------------
-- Berlin U-Bahn https://en.wikipedia.org/wiki/Berlin_U-Bahn
---------------------------------------------------------------------------------------------------

if metrosigns.create_all_flag or metrosigns.create_berlin_flag then

    city = "berlin"
    city_descrip = "Berlin U-Bahn"

    metrosigns.register_category(city_descrip)

    add_lightbox(city, city_descrip)

    add_sign(city, city_descrip, "u1", "U1", 1, 0)
    add_sign(city, city_descrip, "u2", "U2", 1, 0)
    add_sign(city, city_descrip, "u3", "U3", 1, 0)
    add_sign(city, city_descrip, "u4", "U4", 1, 0)
    add_sign(city, city_descrip, "u5", "U5", 1, 0)
    add_sign(city, city_descrip, "u6", "U6", 1, 0)
    add_sign(city, city_descrip, "u7", "U7", 1, 0)
    add_sign(city, city_descrip, "u8", "U8", 1, 0)
    add_sign(city, city_descrip, "u9", "U9", 1, 0)

    add_map(
        city,
        city_descrip,
        {
            ["u1"] = "U1",
            ["u2"] = "U2",
            ["u3"] = "U3",
            ["u4"] = "U4",
            ["u5"] = "U5",
            ["u6"] = "U6",
            ["u7"] = "U7",
            ["u8"] = "U8",
            ["u9"] = "U9",
        },
        {
            ["line"] = "Line",
            ["station"] = "Station",
            ["cstation"] = "Interchange",
        }
    )

end

---------------------------------------------------------------------------------------------------
-- Bucharest Metro https://en.wikipedia.org/wiki/Bucharest_Metro
---------------------------------------------------------------------------------------------------

if metrosigns.create_all_flag or metrosigns.create_bucharest_flag then

    city = "bucharest"
    city_descrip = "Bucharest Metro"

    metrosigns.register_category(city_descrip)

    add_lightbox(city, city_descrip)

    add_sign(city, city_descrip, "m1", "M1", 2, 0)
    add_sign(city, city_descrip, "m2", "M2", 2, 0)
    add_sign(city, city_descrip, "m3", "M3", 2, 0)
    add_sign(city, city_descrip, "m4", "M4", 2, 0)
    add_sign(city, city_descrip, "m5", "M5", 2, 0)
    add_sign(city, city_descrip, "m6", "M6", 2, 0)

    add_map(
        city,
        city_descrip,
        {
            ["m1"] = "M1",
            ["m2"] = "M2",
            ["m3"] = "M3",
            ["m4"] = "M4",
            ["m5"] = "M5",
            ["m6"] = "M6",
        },
        {
            ["line"] = "Line",
            ["station"] = "Station",
        }
    )

end

---------------------------------------------------------------------------------------------------
-- Budapest Metro https://en.wikipedia.org/wiki/Budapest_Metro
---------------------------------------------------------------------------------------------------

if metrosigns.create_all_flag or metrosigns.create_budapest_flag then

    city = "budapest"
    city_descrip = "Budapest Metro"

    metrosigns.register_category(city_descrip)

    add_lightbox(city, city_descrip)
    add_lightbox("budapest_2", city_descrip)

    add_sign(city, city_descrip, "1", "1", 1, 1)
    add_sign(city, city_descrip, "2", "2", 1, 1)
    add_sign(city, city_descrip, "3", "3", 1, 1)
    add_sign(city, city_descrip, "4", "4", 1, 1)
    add_sign(city, city_descrip, "5", "5", 1, 1)
    add_sign(city, city_descrip, "6", "6", 1, 1)
    add_sign(city, city_descrip, "7", "7", 1, 1)
    add_sign(city, city_descrip, "8", "8", 1, 1)
    add_sign(city, city_descrip, "9", "9", 1, 1)

    add_map(
        city,
        city_descrip,
        {
            ["1"] = "1",
            ["2"] = "2",
            ["3"] = "3",
            ["4"] = "4",
            ["5"] = "5",
            ["6"] = "6",
            ["7"] = "7",
            ["8"] = "8",
            ["9"] = "9",
        },
        {
            ["line"] = "Line",
            ["station"] = "Station",
            ["cstation"] = "Interchange",
        }
    )

end

---------------------------------------------------------------------------------------------------
-- Glasgow Subway https://en.wikipedia.org/wiki/Glasgow_Subway
---------------------------------------------------------------------------------------------------

if metrosigns.create_all_flag or metrosigns.create_glasgow_flag then

    city = "glasgow"
    city_descrip = "Glasgow Subway"

    metrosigns.register_category(city_descrip)

    add_lightbox(city, city_descrip)

    add_map(
        city,
        city_descrip,
        {
            ["circle"] = "Circle",
        },
        {
            ["line"] = "Line",
            ["station"] = "Station",
        }
    )

end

---------------------------------------------------------------------------------------------------
-- Ho Chi Minh City Metro https://en.wikipedia.org/wiki/Ho_Chi_Minh_City_Metro
---------------------------------------------------------------------------------------------------

if metrosigns.create_all_flag or metrosigns.create_hcmc_flag then

    city = "hcmc"
    city_descrip = "HCMC Metro"

    metrosigns.register_category(city_descrip)

    add_lightbox(city, city_descrip)

    add_map(
        city,
        city_descrip,
        {
            ["1s"] = "Sai Gon Line",
        },
        {
            ["line"] = "Line",
            ["station"] = "Station",
        }
    )

end

---------------------------------------------------------------------------------------------------
-- London Underground https://en.wikipedia.org/wiki/London_Underground
---------------------------------------------------------------------------------------------------

if metrosigns.create_all_flag or metrosigns.create_london_flag then

    city = "london"
    city_descrip = "London Underground"

    metrosigns.register_category(city_descrip)

    add_lightbox(city, city_descrip)

    -- Format of the London Underground map is a little unusual, so we don't call add_map()

    line_table = {
        ["bakerloo"] = "Bakerloo",
        ["central"] = "Central",
        ["circle"] = "Circle",
        ["district"] = "District",
        ["hscity"] = "Hammersmith & City",
        ["jubilee"] = "Jubilee",
        ["metropolitan"] = "Metropolitan",
        ["northern"] = "Norterhn",
        ["piccadilly"] = "Piccadilly",
        ["victoria"] = "Victoria",
        ["wlcity"] = "Waterloo & City",
    }

    type_table = {
        ["line"] = "Line",
        ["ustation"] = "Station (down)",
        ["dstation"] = "Station (up)",
        ["lstation"] = "Terminus (left)",
        ["rstation"] = "Terminus (right)",
    }

    special_table = {
        ["cstation"] = "Interchange",
        ["tstation"] = "Handicap Access to Train",
        ["pstation"] = "Handicap Access to Platform",
    }

    for line, line_descrip in pairs(line_table) do

        for unit, unit_descrip in pairs(type_table) do
            add_map_unit(city, city_descrip, line, line_descrip, unit, unit_descrip, "", "")
        end

        for unit, unit_descrip in pairs(special_table) do

            local node = "metrosigns:map_london_" .. line .. "_" .. unit
            local img = "metrosigns_map_london_" .. line .. "_line.png^metrosigns_map_london_" ..
                    unit .. ".png"

            minetest.register_node(node, {
                description = city_descrip .. " " .. line_descrip .. " " .. unit_descrip ..
                        " sign",
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
                        {-8/16, -8/16, 6/16,  8/16,  8/16, 8/16},
                    },
                },
                paramtype = "light",
                paramtype2 = "facedir",
                walkable = false,
            })
            metrosigns.register_sign(city_descrip, node, metrosigns.writer.map_units)

        end

    end

end

---------------------------------------------------------------------------------------------------
-- Luton to Dunstable Busway https://en.wikipedia.org/wiki/Luton_to_Dunstable_Busway
---------------------------------------------------------------------------------------------------

if metrosigns.create_all_flag or metrosigns.create_luton_flag then

    city = "luton"
    city_descrip = "Luton Busway"

    metrosigns.register_category(city_descrip)

    add_lightbox(city, city_descrip)

    add_map(
        city,
        city_descrip,
        {
            ["groute"] = "Guided Route",
            ["ngroute"] = "Non-Guide Route",
        },
        {
            ["line"] = "Line",
            ["station"] = "Station",
        }
    )

end

---------------------------------------------------------------------------------------------------
-- Madrid Metro https://en.wikipedia.org/wiki/Madrid_Metro
---------------------------------------------------------------------------------------------------

if metrosigns.create_all_flag or metrosigns.create_madrid_flag then

    city = "madrid"
    city_descrip = "Madrid Metro"

    metrosigns.register_category(city_descrip)

    add_lightbox(city, city_descrip)

    add_sign(city, city_descrip, "1", "1", 0, 0)
    add_sign(city, city_descrip, "2", "2", 0, 0)
    add_sign(city, city_descrip, "3", "3", 0, 0)
    add_sign(city, city_descrip, "4", "4", 0, 0)
    add_sign(city, city_descrip, "5", "5", 0, 0)
    add_sign(city, city_descrip, "6", "6", 0, 0)
    add_sign(city, city_descrip, "7", "7", 0, 0)
    add_sign(city, city_descrip, "8", "8", 0, 0)
    add_sign(city, city_descrip, "9", "9", 0, 0)
    add_sign(city, city_descrip, "10", "10", 0, 0)
    add_sign(city, city_descrip, "11", "11", 0, 0)
    add_sign(city, city_descrip, "12", "12", 0, 0)
    add_sign(city, city_descrip, "r", "r", 0, 0)

    add_map(
        city,
        city_descrip,
        {
            ["1"] = "1",
            ["2"] = "2",
            ["3"] = "3",
            ["4"] = "4",
            ["5"] = "5",
            ["6"] = "6",
            ["7"] = "7",
            ["8"] = "8",
            ["9"] = "9",
            ["10"] = "10",
            ["11"] = "11",
            ["12"] = "12",
            ["r"] = "R",
        },
        {
            ["line"] = "Line",
            ["ustation"] = "Station (down)",
            ["dstation"] = "Station (up)",
            ["cstation"] = "Interchange",
        }
    )

end

---------------------------------------------------------------------------------------------------
-- Moscow Metro https://en.wikipedia.org/wiki/Moscow_Metro
---------------------------------------------------------------------------------------------------

if metrosigns.create_all_flag or metrosigns.create_athens_flag then

    city = "moscow"
    city_descrip = "Moscow Metro"

    metrosigns.register_category(city_descrip)

    add_lightbox(city, city_descrip)

    add_sign(city, city_descrip, "1", "1", 0, 0)
    add_sign(city, city_descrip, "2", "2", 0, 0)
    add_sign(city, city_descrip, "3", "3", 0, 0)
    add_sign(city, city_descrip, "4", "4", 0, 0)
    add_sign(city, city_descrip, "5", "5", 0, 0)
    add_sign(city, city_descrip, "6", "6", 0, 0)
    add_sign(city, city_descrip, "7", "7", 0, 0)
    add_sign(city, city_descrip, "8", "8", 0, 0)
    add_sign(city, city_descrip, "9", "9", 0, 0)
    add_sign(city, city_descrip, "10", "10", 0, 0)
    add_sign(city, city_descrip, "11", "11", 0, 0)
    add_sign(city, city_descrip, "12", "12", 0, 0)
    add_sign(city, city_descrip, "13", "13", 0, 0)
    add_sign(city, city_descrip, "14", "14", 0, 0)
    add_sign(city, city_descrip, "15", "15", 0, 0)

    add_map(
        city,
        city_descrip,
        {
            ["1"] = "1",
            ["2"] = "2",
            ["3"] = "3",
            ["4"] = "4",
            ["5"] = "5",
            ["6"] = "6",
            ["7"] = "7",
            ["8"] = "8",
            ["9"] = "9",
            ["10"] = "10",
            ["11"] = "11",
            ["12"] = "12",
            ["15"] = "15",
        },
        {
            ["line"] = "Line",
            ["ustation"] = "Station (down)",
            ["dstation"] = "Station (up)",
            ["cstation"] = "Interchange",
        }
    )

    add_map(
        city,
        city_descrip,
        {
            ["13"] = "13",
            ["14"] = "14",
        },
        {
            ["line"] = "Line",
            ["cstation"] = "Interchange",
        }
    )

end

---------------------------------------------------------------------------------------------------
-- New York City Subway https://en.wikipedia.org/wiki/New_York_City_Subway
---------------------------------------------------------------------------------------------------

if metrosigns.create_all_flag or metrosigns.create_newyork_flag then

    city = "newyork"
    city_descrip = "New York City Subway"

    metrosigns.register_category(city_descrip)

    add_lightbox(city, city_descrip)

    -- 8th Avenue #006bb6 a c e
    add_sign_special(city, city_descrip, "a", "A 8th Ave Express")
    add_sign_special(city, city_descrip, "c", "C 8th Ave Local (C)")
    add_sign_special(city, city_descrip, "e", "E 8th Ave Local (E)")
    -- 6th Avenue #f58220 b d f fd m
    add_sign_special(city, city_descrip, "b", "B 6th Ave Express")
    add_sign_special(city, city_descrip, "d", "D 6th Ave Express")
    add_sign_special(city, city_descrip, "f", "F QB Express/6th Ave Local")
    add_sign_special(city, city_descrip, "fd", "F QB Express/6th Ave Local")
    add_sign_special(city, city_descrip, "m", "M QB/6th Avenue Local")
    -- Crosstown #7dc242 g
    add_sign_special(city, city_descrip, "g", "G Crosstown")
    -- Canarsie #939598 l
    add_sign_special(city, city_descrip, "l", "L 14th St/Canarsie Local")
    -- Nassau St #b0720d j z
    add_sign_special(city, city_descrip, "j", "J Nassau St Local")
    add_sign_special(city, city_descrip, "z", "Z Nassau St Express")
    -- Broadway #ffd420 n q r w
    add_sign_special(city, city_descrip, "n", "N Broadway Express")
    add_sign_special(city, city_descrip, "q", "Q 2nd Ave/Broadway/Brighton")
    add_sign_special(city, city_descrip, "r", "R Broadway Local")
    add_sign_special(city, city_descrip, "w", "W Broadway Local")
    -- Broadway-7th Avenue #ef3e42 1 2 3
    add_sign_special(city, city_descrip, "1", "1 Broadway/7th Ave Local")
    add_sign_special(city, city_descrip, "2", "2 7th Ave Express")
    add_sign_special(city, city_descrip, "3", "3 7th Ave Express")
    -- Lexington Avenue #009d57 4 5 6 6d
    add_sign_special(city, city_descrip, "4", "4 Lexington Ave Express")
    add_sign_special(city, city_descrip, "5", "5 Lexington Ave Express")
    add_sign_special(city, city_descrip, "6", "6 Lexington Ave Local")
    add_sign_special(city, city_descrip, "6d", "6 Pelham Bay Park Express")
    -- Flushing #9d3d96 7 7d
    add_sign_special(city, city_descrip, "7", "7 Flushing Local")
    add_sign_special(city, city_descrip, "7d", "7 Flushing Express")
    -- Second Avenue #00add0 t
    add_sign_special(city, city_descrip, "t", "T 2nd Ave Local")
    -- Shuttles #6d6e71 s
    add_sign_special(city, city_descrip, "s", "S Shuttle Service")

    add_map(
        city,
        city_descrip,
        {
            ["8avenue"] = "8th Avenue",
            ["6avenue"] = "6th Avenue",
            ["crosstown"] = "Crosstown",
            ["canarsie"] = "Canarsie",
            ["nassaust"] = "Nassau St",
            ["broadway"] = "Broadway",
            ["bw7avenue"] = "Broadway-7th Avenue",
            ["lexington"] = "Lexington Avenue",
            ["flushing"] = "Flushing",
            ["2avenue"] = "Second Avenue",
            ["shuttle"] = "Shuttles",
        },
        {
            ["line"] = "Line",
            ["astation"] = "Station (all)",
            ["lstation"] = "Station (local)",
        }
    )

end

---------------------------------------------------------------------------------------------------
-- Paris Metro https://en.wikipedia.org/wiki/Paris_M%C3%A9tro
---------------------------------------------------------------------------------------------------

if metrosigns.create_all_flag or metrosigns.create_paris_flag then

    city = "paris"
    city_descrip = "Paris Metro"
    line_table = {
        ["1"] = "1",
        ["2"] = "2",
        ["3"] = "3",
        ["3bis"] = "3bis",
        ["4"] = "4",
        ["5"] = "5",
        ["6"] = "6",
        ["7"] = "7",
        ["7bis"] = "7bis",
        ["8"] = "8",
        ["9"] = "9",
        ["10"] = "10",
        ["11"] = "11",
        ["12"] = "12",
        ["13"] = "13",
        ["14"] = "14",
    }

    metrosigns.register_category(city_descrip)

    add_lightbox(city, city_descrip)

    add_sign(city, city_descrip, "1", "1", 1, 1)
    add_sign(city, city_descrip, "2", "2", 1, 1)
    add_sign(city, city_descrip, "3bis", "3bis", 1, 1)
    add_sign(city, city_descrip, "4", "4", 1, 1)
    add_sign(city, city_descrip, "5", "5", 1, 1)
    add_sign(city, city_descrip, "6", "6", 1, 1)
    add_sign(city, city_descrip, "7", "7", 1, 1)
    add_sign(city, city_descrip, "7bis", "7bis", 1, 1)
    add_sign(city, city_descrip, "8", "8", 1, 1)
    add_sign(city, city_descrip, "9", "9", 1, 1)
    add_sign(city, city_descrip, "10", "10", 1, 1)
    add_sign(city, city_descrip, "11", "11", 1, 1)
    add_sign(city, city_descrip, "12", "12", 1, 1)
    add_sign(city, city_descrip, "13", "13", 1, 1)
    add_sign(city, city_descrip, "14", "14", 1, 1)

    add_map(
        city,
        city_descrip,
        line_table,
        {
            ["line"] = "Line",
            ["station"] = "Station",
        }
    )

    -- If we add "cstation" in the function call above, we get duplicate terminus stations
    for line, line_descrip in pairs(line_table) do
        add_map_unit(city, city_descrip, line, line_descrip, "cstation", "Interchange", "", "")
    end

end

---------------------------------------------------------------------------------------------------
-- Prague Metro https://en.wikipedia.org/wiki/Prague_Metro
---------------------------------------------------------------------------------------------------

if metrosigns.create_all_flag or metrosigns.create_prague_flag then

    city = "prague"
    city_descrip = "Prague Metro"
    line_table = {
        ["a"] = "A",
        ["b"] = "B",
        ["c"] = "C",
    }

    metrosigns.register_category(city_descrip)

    add_lightbox(city, city_descrip)

    add_sign(city, city_descrip, "a", "A", 0, 0)
    add_sign(city, city_descrip, "b", "B", 0, 0)
    add_sign(city, city_descrip, "c", "C", 0, 0)

    add_map(
        city,
        city_descrip,
        line_table,
        {
            ["line"] = "Line",
            ["station"] = "Station",
        }
    )

    -- Interchanges contain colours from both lines

    for line, cap_line in pairs(line_table) do

        for line2, cap_line2 in pairs(line_table) do

            if line ~= line2 then

                add_map_unit(
                    city, city_descrip, line, cap_line, line2 .. "station", "Interchange " ..
                            cap_line .. "-" .. cap_line2, "", ""
                )

            end

        end

    end

end

---------------------------------------------------------------------------------------------------
-- Rome Metro https://en.wikipedia.org/wiki/Rome_Metro
---------------------------------------------------------------------------------------------------

if metrosigns.create_all_flag or metrosigns.create_rome_flag then

    city = "rome"
    city_descrip = "Rome Metro"

    metrosigns.register_category(city_descrip)

    add_lightbox(city, city_descrip)

    add_sign(city, city_descrip, "ma", "Line A", 3, 0)
    add_sign(city, city_descrip, "mb", "Line B", 3, 0)
    add_sign(city, city_descrip, "mc", "Line C", 3, 0)

    add_map(
        city,
        city_descrip,
        {
            ["ma"] = "Line A",
            ["mb"] = "Line B",
            ["mc"] = "Line C",
        },
        {
            ["line"] = "Line",
            ["station"] = "Station",
        }
    )

end

---------------------------------------------------------------------------------------------------
-- Stockholm Metro https://en.wikipedia.org/wiki/Stockholm_metro
---------------------------------------------------------------------------------------------------

if metrosigns.create_all_flag or metrosigns.create_stockholm_flag then

    city = "stockholm"
    cap_city = capitalise(city)
    city_descrip = "Stockholm Metro"

    metrosigns.register_category(city_descrip)

    add_lightbox(city, city_descrip)

    -- Blue line
    add_sign_special(city, city_descrip, "10", "Route 10")
    add_sign_special(city, city_descrip, "11", "Route 11")
    -- Red line
    add_sign_special(city, city_descrip, "13", "Route 13")
    add_sign_special(city, city_descrip, "14", "Route 14")
    -- Green line
    add_sign_special(city, city_descrip, "17", "Route 17")
    add_sign_special(city, city_descrip, "18", "Route 18")
    add_sign_special(city, city_descrip, "19", "Route 19")

    add_map(
        city,
        city_descrip,
        {
            ["blue"] = "Blue",
            ["red"] = "Red",
            ["green"] = "Green",
        },
        -- Use "stop" rather than "station" to prevent the function adding terminus stations
        {
            ["line"] = "Line",
            ["stop"] = "Station",
            ["cstop"] = "Interchange",
        }
    )

    -- Now add terminus stations
    terminus_table = {
        ["10"] = "blue",
        ["11"] = "blue",
        ["13"] = "red",
        ["14"] = "red",
        ["17"] = "green",
        ["18"] = "green",
        ["19"] = "green",
    }
    side_table = {
        ["l"] = "left",
        ["r"] = "right",
    }

    for route, colour in pairs(terminus_table) do

        for side, side_descrip in pairs(side_table) do

            local node = "metrosigns:map_" .. city .. "_" .. route .. "_station_term" .. side
            local img = "metrosigns_map_" .. city .. "_" .. colour ..
                    "_line.png^metrosigns_sign_" .. city .. "_route_" .. route ..
                    ".png^metrosigns_map_" .. city .. "_term" .. side .. ".png"

            minetest.register_node(node, {
                description = cap_city .. " " .. route ..  " station sign (" .. side_descrip ..
                        " terminus)",
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
                        {-8/16, -8/16, 6/16,  8/16,  8/16, 8/16},
                    },
                },
                paramtype = "light",
                paramtype2 = "facedir",
                walkable = false
            })
            metrosigns.register_sign(city_descrip, node, metrosigns.writer.map_units)

        end

    end

end

---------------------------------------------------------------------------------------------------
-- Taipei Metro https://en.wikipedia.org/wiki/Taipei_Metro
---------------------------------------------------------------------------------------------------

if metrosigns.create_all_flag or metrosigns.create_taipei_flag then

    city = "taipei"
    city_descrip = "Taipei Metro"

    metrosigns.register_category(city_descrip)

    add_lightbox(city, city_descrip)

    add_sign(city, city_descrip, "br", "brown", 2, 2)
    add_sign(city, city_descrip, "r", "red", 2, 2)
    add_sign(city, city_descrip, "g", "green", 2, 2)
    add_sign(city, city_descrip, "o", "orange", 2, 2)
    add_sign(city, city_descrip, "bl", "blue", 2, 2)
    add_sign(city, city_descrip, "y", "yellow", 2, 2)

    add_map(
        city,
        city_descrip,
        {
        ["br"] = "Brown",
        ["r"] = "Red",
        ["g"] = "Green",
        ["o"] = "Orange",
        ["bl"] = "Blue",
        ["y"] = "Yellow",
        },
        {
            ["line"] = "Line",
            ["station"] = "Station",
        }
    )

end

---------------------------------------------------------------------------------------------------
-- Tokyo Metro https://en.wikipedia.org/wiki/Tokyo_Metro
---------------------------------------------------------------------------------------------------

if metrosigns.create_all_flag or metrosigns.create_tokyo_flag then

    city = "tokyo"
    city_descrip = "Tokyo Metro"

    metrosigns.register_category(city_descrip)

    add_lightbox(city, city_descrip)

    add_sign(city, city_descrip, "g", "Ginza", 2, 2)
    add_sign(city, city_descrip, "m", "Marunouchi", 2, 2)
    add_sign(city, city_descrip, "h", "Hibiya", 2, 2)
    add_sign(city, city_descrip, "t", "Tozai", 2, 2)
    add_sign(city, city_descrip, "c", "Chiyoda", 2, 2)
    add_sign(city, city_descrip, "y", "Yurakucho", 2, 2)
    add_sign(city, city_descrip, "z", "Hanzomon", 2, 2)
    add_sign(city, city_descrip, "n", "Namboku", 2, 2)
    add_sign(city, city_descrip, "f", "Fukutoshin", 2, 2)

    add_map(
        city,
        city_descrip,
        {
            ["g"] = "Ginza",
            ["m"] = "Marunouchi",
            ["h"] = "Hibiya",
            ["t"] = "Tozai",
            ["c"] = "Chiyoda",
            ["y"] = "Yurakucho",
            ["z"] = "Hanzomon",
            ["n"] = "Namboku",
            ["f"] = "Fukutoshin",
        },
        {
            ["line"] = "Line",
            ["station"] = "Station",
            ["cstation"] = "Interchange",
        }
    )

end

---------------------------------------------------------------------------------------------------
-- Toronto Subway https://en.wikipedia.org/wiki/Toronto_subway
---------------------------------------------------------------------------------------------------

if metrosigns.create_all_flag or metrosigns.create_toronto_flag then

    city = "toronto"
    city_descrip = "Toronto Subway"

    metrosigns.register_category(city_descrip)

    add_lightbox(city, city_descrip)

    add_sign(city, city_descrip, "1", "Yonge-University", 2, 2)
    add_sign(city, city_descrip, "2", "Bloor-Danforth", 2, 2)
    add_sign(city, city_descrip, "3", "Scarborough", 2, 2)
    add_sign(city, city_descrip, "4", "Sheppard", 2, 2)
    add_sign(city, city_descrip, "5", "Eglinton", 2, 2)
    add_sign(city, city_descrip, "6", "Finch West", 2, 2)

    add_map(
        city,
        city_descrip,
        {
            ["1"] = "Yonge-University",
            ["2"] = "Bloor-Danforth",
            ["3"] = "Scarborough",
            ["4"] = "Sheppard",
            ["5"] = "Eglinton",
            ["6"] = "Finch West",
        },
        {
            ["line"] = "Line",
            ["station"] = "Station",
            ["hstation"] = "Station (access)",
        }
    )

end

---------------------------------------------------------------------------------------------------
-- Vienna U-Bahn https://en.wikipedia.org/wiki/Vienna_U-Bahn
---------------------------------------------------------------------------------------------------

if metrosigns.create_all_flag or metrosigns.create_vienna_flag then

    city = "vienna"
    city_descrip = "Vienna U-Bahn"

    metrosigns.register_category(city_descrip)

    add_lightbox(city, city_descrip)

    add_sign(city, city_descrip, "u1", "U1", 1, 0)
    add_sign(city, city_descrip, "u2", "U2", 1, 0)
    add_sign(city, city_descrip, "u3", "U3", 1, 0)
    add_sign(city, city_descrip, "u4", "U4", 1, 0)
    add_sign(city, city_descrip, "u6", "U6", 1, 0)

    add_map(
        city,
        city_descrip,
        {
            ["u1"] = "U1",
            ["u2"] = "U2",
            ["u3"] = "U3",
            ["u4"] = "U4",
            ["u6"] = "U6",
        },
        {
            ["line"] = "Line",
            ["station"] = "Station",
        }
    )

end
