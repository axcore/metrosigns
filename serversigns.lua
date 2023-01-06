---------------------------------------------------------------------------------------------------
-- metrosigns mod for minetest by A S Lewis
--      https://github.com/axcore/metrosigns
--      Licence: GNU Affero GPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Tunnelers' Abyss https://h2mm.gitlab.io/web/
--      NB These items were created for a specific server, but they are released under the same
--      licence as everything else, so you're free to use them with other servers/projects
---------------------------------------------------------------------------------------------------

if metrosigns.create_all_flag or metrosigns.create_tabyss_flag then

    local server = "tabyss"
    local server_descrip = "Tunnelers' Abyss"

    metrosigns.register_category(server_descrip)

    add_lightbox(server, server_descrip)
    -- GS metro gets its own lightbox
    minetest.register_node("metrosigns:box_tabyss_metro", {
        description = "Grapeyard Superb lightbox",
        tiles = {
            "metrosigns_box_tabyss_metro_top.png",
            "metrosigns_box_tabyss_metro_top.png",
            "metrosigns_box_tabyss_metro_side.png",
            "metrosigns_box_tabyss_metro_side.png",
            "metrosigns_box_tabyss_metro_side.png",
            "metrosigns_box_tabyss_metro_side.png",
        },
        groups = box_groups,

        light_source = box_light_source,
    })
    metrosigns.register_sign(
        server_descrip,
        "metrosigns:box_tabyss_metro",
        metrosigns.writer.box_units
    )

    -- Trains
    add_sign(server, server_descrip, "s1", "Abyssal Express", 1, 1)
    add_sign(server, server_descrip, "s2", "Fractal Plains", 1, 1)
    add_sign(server, server_descrip, "s3", "Erosion Trap", 1, 1)
    add_sign(server, server_descrip, "s4", "Coram Line", 1, 1)
    add_sign(server, server_descrip, "s5", "Thorviss Line", 1, 1)
    add_sign(server, server_descrip, "s6", "Recursive Dragon", 1, 1)
    add_sign(server, server_descrip, "s8", "Tiny Line", 1, 1)
    add_sign(server, server_descrip, "s13", "Exfactor Line", 2, 1)
    add_sign(server, server_descrip, "s15", "Beach Line", 2, 1)
    add_sign(server, server_descrip, "r1", "Narsh Express", 1, 1)
    add_sign(server, server_descrip, "r2", "Crystal Line", 1, 1)
    add_sign(server, server_descrip, "t1", "Tommy's Line", 1, 1)
    add_sign(server, server_descrip, "t2", "Subway", 1, 1)
    -- GS Metro
    add_sign(server, server_descrip, "gsm1", "GSM Line 1", 3, 3)
    add_sign(server, server_descrip, "gsm2", "GSM Line 2", 3, 3)
    add_sign(server, server_descrip, "gsm3", "GSM Line 3", 3, 3)
    add_sign(server, server_descrip, "gsm4a", "GSM Line 4A", 3, 3)
    add_sign(server, server_descrip, "gsm4b", "GSM Line 4B", 3, 3)
    add_sign(server, server_descrip, "gsm4c", "GSM Line 4C", 3, 3) 
    add_sign(server, server_descrip, "gsm4d", "GSM Line 4D", 3, 3) 
    add_sign(server, server_descrip, "gsm5a", "GSM Line 5A", 3, 3)
    add_sign(server, server_descrip, "gsm5b", "GSM Line 5B", 3, 3)
    add_sign(server, server_descrip, "gsm5c", "GSM Line 5C", 3, 3) 
    add_sign(server, server_descrip, "gsm6", "GSM Line 6", 3, 3)
    add_sign(server, server_descrip, "gsm7", "GSM Line 7", 3, 3)
    add_sign(server, server_descrip, "gsm8a", "GSM Line 8A", 3, 3)
    add_sign(server, server_descrip, "gsm8b", "GSM Line 8B", 3, 3)
    add_sign(server, server_descrip, "gsm9a", "GSM Line 9A", 3, 3) 
    add_sign(server, server_descrip, "gsm9b", "GSM Line 9B", 3, 3) 
    add_sign(server, server_descrip, "gsme1", "GSM Line E1", 3, 3) 
    add_sign(server, server_descrip, "gsmrl", "GSMRL Corporate Logo", 3, 3) 
    
    add_map(
        server,
        server_descrip,
        {
            -- Trains
            ["s1"] = "Abyssal Express",
            ["s2"] = "Fractal Plains",
            ["s3"] = "Erosion Trap",
            ["s4"] = "Coram Line",
            ["s5"] = "Thorviss Line",
            ["s6"] = "Recursive Dragon",
            ["s8"] = "Tiny Line",
            ["s13"] = "Exfactor Line",
            ["s15"] = "Beach Line",
            ["r1"] = "Narsh Express",
            ["r2"] = "Crystal Line",
            ["t1"] = "Tommy's Line",
            ["t2"] = "Subway",
            -- GS Metro (other lines use the same colours as above)
            ["gsm4b"] = "GSM Line 4B",
            ["gsm5b"] = "GSM Line 5B",
            ["gsm8b"] = "GSM Line 8B",
            ["gsm9a"] = "GSM Line 9A",  
            ["gsme1"] = "GSM Line E1",                        
        },
        {
            ["line"] = "Line",
            ["station"] = "Station",
            ["istation"] = "Interchange",
        }
    )

    add_map(
        server,
        server_descrip,
        {
            ["s1"] = "Abyssal Express",
            ["s2"] = "Fractal Plains",
--          ["s3"] = "Erosion Trap",
            ["s4"] = "Coram Line",
            ["s5"] = "Thorviss Line",
--          ["s6"] = "Recursive Dragon",
--          ["s8"] = "Tiny Line",
--          ["s13"] = "Exfactor Line",
--          ["s15"] = "Beach Line",
--          ["r1"] = "Narsh Express",
            ["r2"] = "Crystal Line",
--          ["t1"] = "Tommy's Line",
            ["t2"] = "Subway",
--          ["gsm4b"] = "GSM Line 4B",
--          ["gsm5b"] = "GSM Line 5B",
--          ["gsm8b"] = "GSM Line 8B",
        },
        {
            ["sstation"] = "Spawn Interchange",
        }
    )
    
end
