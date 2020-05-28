---------------------------------------------------------------------------------------------------
-- metrosigns mod for minetest by A S Lewis
--      https://github.com/axcore/metrosigns
--      Licence: GNU Affero GPL
---------------------------------------------------------------------------------------------------
-- Code/textures from roads by cheapie
--      https://forum.minetest.net/viewtopic.php?t=13904
--      https://cheapiesystems.com/git/roads/
--      Licence: CC-BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Sign-writing machine functions, based on the printer in the roads mod by cheapie
-- Functions
---------------------------------------------------------------------------------------------------

function metrosigns.writer.can_dig(pos)

    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    return (
        inv:is_empty("redcart") and inv:is_empty("greencart")
        and inv:is_empty("bluecart") and inv:is_empty("plastic")
    )

end

function metrosigns.writer.checksupplies(pos)

    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    local redcart = inv:get_stack("redcart", 1)
    local greencart = inv:get_stack("greencart", 1)
    local bluecart = inv:get_stack("bluecart", 1)
    local plastic = inv:get_stack("plastic", 1)

    if not redcart:to_table() or not greencart:to_table() or not bluecart:to_table()
    or not plastic:to_table() then
        return false
    end

    local redcart_good = redcart:to_table().name == "metrosigns:cartridge_red"
        and redcart:to_table().wear <= metrosigns.writer.cartridge_max
    local greencart_good = greencart:to_table().name == "metrosigns:cartridge_green"
        and greencart:to_table().wear <= metrosigns.writer.cartridge_max
    local bluecart_good = bluecart:to_table().name == "metrosigns:cartridge_blue"
        and bluecart:to_table().wear <= metrosigns.writer.cartridge_max
    local plastic_good = plastic:to_table().name == "basic_materials:plastic_sheet"
    local good = redcart_good and greencart_good and bluecart_good and plastic_good

    return good

end

function metrosigns.writer.nom(pos, amount)

    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    local redcart = inv:get_stack("redcart", 1)
    local greencart = inv:get_stack("greencart", 1)
    local bluecart = inv:get_stack("bluecart", 1)
    local plastic = inv:get_stack("plastic", 1)

    redcart:add_wear(amount * metrosigns.writer.cartridge_min )
    greencart:add_wear(amount * metrosigns.writer.cartridge_min )
    bluecart:add_wear(amount * metrosigns.writer.cartridge_min )
    plastic:take_item(1)

    inv:set_stack("redcart", 1, redcart)
    inv:set_stack("greencart", 1, greencart)
    inv:set_stack("bluecart", 1, bluecart)
    inv:set_stack("plastic", 1, plastic)

end

function metrosigns.writer.populateoutput(pos)

    -- Sanity check: If no signs have been defined, then there is no need to display a formspec
    if metrosigns.writer.current_category == nil then
        return
    end

    local typescount = metrosigns.writer.signcounts[metrosigns.writer.current_category]
    local pagesize = 8*5
    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    local page = meta:get_int("page")
    local maxpage = math.ceil(typescount/pagesize)

    inv:set_list("output", {})
    inv:set_size("output", typescount)

    if metrosigns.writer.checksupplies(pos) then

        for k,v in pairs(metrosigns.writer.signtypes[metrosigns.writer.current_category]) do
            inv:set_stack("output", k, v.name)
        end

    end

    local dropdown_string = ""
    for k, v in ipairs(metrosigns.writer.categories) do
        if k == 1 then
            dropdown_string = v
        else
            dropdown_string = dropdown_string..","..v
        end
    end

    meta:set_string("formspec", "size[11,10]"..
        -- Cartridges
        "label[0,0;Red\nCartridge]" ..
        "list[current_name;redcart;1.5,0;1,1;]" ..
        "label[0,1;Green\nCartridge]" ..
        "list[current_name;greencart;1.5,1;1,1;]" ..
        "label[0,2;Blue\nCartridge]" ..
        "list[current_name;bluecart;1.5,2;1,1;]" ..
        -- Plastic
        "label[0,3;Plastic\nSheeting]" ..
        "list[current_name;plastic;1.5,3;1,1;]" ..
        -- Sign categories
        "label[0,5;Sign\nCategory]" ..
        "dropdown[1.5,5;3.75,1;category;"..dropdown_string..";1]" ..
        -- List of signs
        "list[current_name;output;2.8,0;8,5;"..tostring((page-1)*pagesize).."]" ..
        -- Player inventory
        "list[current_player;main;1.5,6.25;8,4;]"..
        -- Page buttons
        "button[5.5,5;1,1;prevpage;<<<]"..
        "button[8.5,5;1,1;nextpage;>>>]"..
        "label[6.75,5.25;Page "..page.." of "..maxpage.."]"
    )
    meta:set_int("maxpage",maxpage)

end

function metrosigns.writer.on_construct(pos)

    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()

    meta:set_int("page", 1)
    meta:set_int("maxpage", 1)

    inv:set_size("redcart", 1)
    inv:set_size("greencart", 1)
    inv:set_size("bluecart", 1)
    inv:set_size("plastic", 1)

    metrosigns.writer.populateoutput(pos)

end

function metrosigns.writer.on_receive_fields(pos, formname, fields, sender)

    local meta = minetest.get_meta(pos)

    if fields.category then

        minetest.log(fields.category)

        -- User has activated the dropdown box
        if metrosigns.writer.signtypes[fields.category] ~= nil then
            metrosigns.writer.current_category = fields.category
        end

    else

        -- User has clicked the page buttons
        local page = meta:get_int("page")
        local maxpage = meta:get_int("maxpage")

        if fields.prevpage then
            page = page - 1
            if page < 1 then
                page = maxpage
            end
            meta:set_int("page",page)
        elseif fields.nextpage then
            page = page + 1
            if page > maxpage then
                page = 1
            end
            meta:set_int("page",page)
        end

    end

    -- In all cases, redraw the list of signs for the current category
    metrosigns.writer.populateoutput(pos)

end

function metrosigns.writer.allow_metadata_inventory_put(pos, listname, index, stack, player)

    if listname == "redcart" then

        if stack:get_name() == "metrosigns:cartridge_red" then
            return 1
        else
            return 0
        end

    elseif listname == "greencart" then

        if stack:get_name() == "metrosigns:cartridge_green" then
            return 1
        else
            return 0
        end

    elseif listname == "bluecart" then

        if stack:get_name() == "metrosigns:cartridge_blue" then
            return 1
        else
            return 0
        end

    elseif listname == "plastic" then

        if stack:get_name() == "basic_materials:plastic_sheet" then
            return stack:get_count()
        else
            return 0
        end

    else

        return 0

    end

end

function metrosigns.writer.on_metadata_inventory_put(pos)

    metrosigns.writer.populateoutput(pos)

end

function metrosigns.writer.on_metadata_inventory_take(pos, listname, index)

    if listname == "output" then
        local cost
            = metrosigns.writer.signtypes[metrosigns.writer.current_category][index].ink_needed
        metrosigns.writer.nom(pos, cost)
    end

    metrosigns.writer.populateoutput(pos)

end

function metrosigns.writer.allow_metadata_inventory_move(
    pos, from_list, from_index, to_list, to_index, count, player
)
    return 0

end

---------------------------------------------------------------------------------------------------
-- Register crafts for the machine and its ink cartridges
---------------------------------------------------------------------------------------------------

minetest.register_tool("metrosigns:cartridge_red",
    {
        description = "Red Ink Cartridge",
        inventory_image = "streets_cartridge_red.png"
    }
)

minetest.register_tool("metrosigns:cartridge_green",
    {
        description = "Green Ink Cartridge",
        inventory_image = "streets_cartridge_green.png"
    }
)

minetest.register_tool("metrosigns:cartridge_blue",
    {
        description = "Blue Ink Cartridge",
        inventory_image = "streets_cartridge_blue.png"
    }
)

if HAVE_DEFAULT_FLAG and HAVE_BASIC_MATERIALS_FLAG then

    local sheeting = "basic_materials:plastic_sheet"

    minetest.register_craft({
        output = "metrosigns:cartridge_red",
        recipe = {
            {sheeting, sheeting, sheeting},
            {sheeting, "dye:red", sheeting},
            {sheeting, "", ""},
        }
    })

    minetest.register_craft({
        output = "metrosigns:cartridge_green",
        recipe = {
            {sheeting, sheeting, sheeting},
            {sheeting, "dye:green", sheeting},
            {sheeting, "", ""},
        }
    })

    minetest.register_craft({
        output = "metrosigns:cartridge_blue",
        recipe = {
            {sheeting, sheeting, sheeting},
            {sheeting, "dye:blue", sheeting},
            {sheeting, "", ""},
        }
    })

    -- Refills
    minetest.register_craft({
        output = "metrosigns:cartridge_red",
        type = "shapeless",
        recipe = {"metrosigns:cartridge_red", "dye:red"}
    })

    minetest.register_craft({
        output = "metrosigns:cartridge_green",
        type = "shapeless",
        recipe = {"metrosigns:cartridge_green", "dye:green"}
    })

    minetest.register_craft({
        output = "metrosigns:cartridge_blue",
        type = "shapeless",
        recipe = {"metrosigns:cartridge_blue", "dye:blue"}
    })

    minetest.register_craft({
        output = "metrosigns:sign_writer",
        recipe = {
            {sheeting, "default:steel_ingot", sheeting},
            {"default:steel_ingot", "basic_materials:energy_crystal_simple", "default:steel_ingot"},
            {"basic_materials:motor", "default:steel_ingot", "basic_materials:motor"},
        }
    })

end

---------------------------------------------------------------------------------------------------
-- Register the sign-writing machine itself
---------------------------------------------------------------------------------------------------

minetest.register_node("metrosigns:sign_writer", {
    description = "Sign Writer",
    tiles = {
        "metrosigns_writer_top.png",
        "metrosigns_writer_side.png",
        "metrosigns_writer_side.png",
        "metrosigns_writer_side.png",
        "metrosigns_writer_side.png",
        "metrosigns_writer_front.png",
    },
    inventory_image = "metrosigns_writer_front.png",
    groups = {snappy = 3},
    paramtype = "light",
    paramtype2 = "facedir",
--  Commented out because I don't know how to fix the error
--  sound = default.node_sound_wood_defaults(),
    walkable = true,
    -- Callbacks
    allow_metadata_inventory_move = metrosigns.writer.allow_metadata_inventory_move,
    allow_metadata_inventory_put = metrosigns.writer.allow_metadata_inventory_put,
    can_dig = metrosigns.writer.can_dig,
    on_construct = metrosigns.writer.on_construct,
    on_metadata_inventory_put = metrosigns.writer.on_metadata_inventory_put,
    on_metadata_inventory_take = metrosigns.writer.on_metadata_inventory_take,
    on_receive_fields = metrosigns.writer.on_receive_fields,
})
