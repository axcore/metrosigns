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

    server = "tabyss"
    server_descrip = "Tunnelers' Abyss"

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

    add_sign(server, server_descrip, "s1", "Abyssal Express", 1, 1)
    add_sign(server, server_descrip, "s2", "Fractal Plains", 1, 1)
    add_sign(server, server_descrip, "s3", "Erosion Trap", 1, 1)
    add_sign(server, server_descrip, "s4", "Coram Line", 1, 1)
    add_sign(server, server_descrip, "s5", "Thorviss Line", 1, 1)
    add_sign(server, server_descrip, "s6", "Recursive Dragon", 1, 1)
    add_sign(server, server_descrip, "s15", "Beach Line", 2, 1)
    add_sign(server, server_descrip, "r1", "Narsh Express", 1, 1)
    add_sign(server, server_descrip, "t1", "Tommy's Line", 1, 1)
    add_sign(server, server_descrip, "t2", "Subway", 1, 1)

    add_map(
        server,
        server_descrip,
        {
            ["s1"] = "Abyssal Express",
            ["s2"] = "Fractal Plains",
            ["s3"] = "Erosion Trap",
            ["s4"] = "Coram Line",
            ["s5"] = "Thorviss Line",
            ["s6"] = "Recursive Dragon",
            ["s15"] = "Beach Line",
            ["r1"] = "Narsh Express",
            ["t1"] = "Tommy's Line",
            ["t2"] = "Subway",
        },
        {
            ["line"] = "Line",
            ["station"] = "Station",
        }
    )

    -- Interchanges show the colours of the connecting lines in the centre of the texture
    -- These interchanges are not at the end of a line
    add_map(
        server,
        server_descrip,
        {
            ["s1_s15_r1"] = "Abyssal Express",
            ["s1_s15"] = "Abyssal Express",
            ["s1_spn"] = "Abyssal Express",
            ["s1_s2_s15"] = "Abyssal Express",
            ["s1_s2_s6"] = "Abyssal Express",
            ["s1_s2"] = "Abyssal Express",
            ["s2_s3_t1"] = "Fractal Plains",
            ["s2_s3"] = "Fractal Plains",
            ["s2_spn"] = "Fractal Plains",
            ["s2_s1_s15"] = "Fractal Plains",
            ["s2_s1_s6"] = "Fractal Plains",
            ["s2_s1"] = "Fractal Plains",
            ["s3_s2_t1"] = "Erosion Trap",
            ["s3_s2"] = "Erosion Trap",
            ["s3_s1"] = "Erosion Trap",
            ["s3_s1_s15"] = "Erosion Trap",
            ["s4_spn"] = "Coram Line",
            ["s5_s15"] = "Thorviss Line",
            ["s5_spn"] = "Thorviss Line",
            ["s6_s1_s2"] = "Recursive Dragon",
            ["s15_s1_r1"] = "Beach Line",
            ["s15_s1"] = "Beach Line",
            ["s15_s1_s4"] = "Beach Line",
            ["s15_s5"] = "Beach Line",
        },
        {
            ["istation"] = "Interchange",
        }
    )

    -- These interchanges ARE at the end of a line
    add_map(
        server,
        server_descrip,
        {
            ["s2_s3_s4"] = "Fractal Plains",
            ["s3_s2_s4"] = "Erosion Trap",
            ["s4_s2_s3"] = "Coram Line",
            ["r1_s1_s15"] = "Narsh Express",
            ["t1_s2_s3"] = "Tommy's Line",
            ["t1_t2"] = "Tommy's Line",
            ["t2_t1"] = "Subway",
            ["t2_spn"] = "Subway",
        },
        {
            ["cstation"] = "Interchange",
        }
    )

end

