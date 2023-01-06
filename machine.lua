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

function metrosigns.writer.check_supplies(pos)

    -- Called by metrosigns.writer.populate_output()
    -- Signs are only visible in the sign-writing machine if the user has added plastic sheets and
    --      ink cartridges
    --
    -- Return values:
    --  Returns true if signs can be displayed, false if they can't be displayed

    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    local redcart = inv:get_stack("redcart", 1)
    local greencart = inv:get_stack("greencart", 1)
    local bluecart = inv:get_stack("bluecart", 1)
    local plastic = inv:get_stack("plastic", 1)

    if not redcart:to_table() or
            not greencart:to_table() or
            not bluecart:to_table() or
            not plastic:to_table() then
        return false
    end

    local redcart_good = redcart:to_table().name == "metrosigns:cartridge_red" and
            redcart:to_table().wear < metrosigns.writer.cartridge_max
    local greencart_good = greencart:to_table().name == "metrosigns:cartridge_green" and
            greencart:to_table().wear < metrosigns.writer.cartridge_max
    local bluecart_good = bluecart:to_table().name == "metrosigns:cartridge_blue" and
            bluecart:to_table().wear < metrosigns.writer.cartridge_max
    local plastic_good = plastic:to_table().name == "basic_materials:plastic_sheet"
    local good = redcart_good and greencart_good and bluecart_good and plastic_good

    return good

end

function metrosigns.writer.nom(pos, amount)

    -- Called by on_metadata_inventory_take()
    -- When the player takes an item from the sign-writing machine's inventory into their own
    --      inventory, hence "writing" a sign, reduce the amount of available ink/plastic
    --      accordingly
    --
    -- Args:
    --      amount (int): The amount of ink needed to write the sign

    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    local redcart = inv:get_stack("redcart", 1)
    local greencart = inv:get_stack("greencart", 1)
    local bluecart = inv:get_stack("bluecart", 1)
    local plastic = inv:get_stack("plastic", 1)

    redcart:add_wear(amount * metrosigns.writer.cartridge_min)
    greencart:add_wear(amount * metrosigns.writer.cartridge_min)
    bluecart:add_wear(amount * metrosigns.writer.cartridge_min)
    plastic:take_item(1)

    inv:set_stack("redcart", 1, redcart)
    inv:set_stack("greencart", 1, greencart)
    inv:set_stack("bluecart", 1, bluecart)
    inv:set_stack("plastic", 1, plastic)

end

function metrosigns.writer.populate_output(pos)

    -- Called by several functions
    -- Displays (or updates) the formspec for the sign-writing machine

    -- Sanity check: If no signs have been defined, then there is no need to display a formspec
    if metrosigns.writer.current_category == nil then
        return
    end

    local typescount = metrosigns.writer.signcounts[metrosigns.writer.current_category]
    local pagesize = 8 * 5
    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    local page = meta:get_int("page")
    local maxpage = math.ceil(typescount/pagesize)
    local dropdown_string = ""
    local dropdown_index = 1

    inv:set_list("output", {})
    -- For aesthetic reasons, I prefer that the first page is a full 8x5 grid, even if all of the
    --  slots are empty. Later pages, however, can have exactly as many slots as they need
    if typescount > 40 then
        inv:set_size("output", typescount)
    else
        inv:set_size("output", 40)
    end

    if metrosigns.writer.check_supplies(pos) then

        for k, v in pairs(metrosigns.writer.signtypes[metrosigns.writer.current_category]) do
            inv:set_stack("output", k, v.name)
        end

    end

    for k, v in ipairs(metrosigns.writer.categories) do

        -- The dropdown_string includes all available categories
        if k == 1 then
            dropdown_string = v
        else
            dropdown_string = dropdown_string .. "," .. v
        end

        -- This fixes an issue in the parent roads mod, in which the dropdown box used to
        --      immediately reset itself
        if metrosigns.writer.current_category == v then
            dropdown_index = k
        end

    end

    meta:set_string("formspec", "size[11,10]" ..
        -- Cartridges
        "label[0,0;Red\nCartridge]" ..
        "list[current_name;redcart;1.5,0;1,1;]" ..
        "label[0,1;Green\nCartridge]" ..
        "list[current_name;greencart;1.5,1;1,1;]" ..
        "label[0,2;Blue\nCartridge]" ..
        "list[current_name;bluecart;1.5,2;1,1;]" ..
        -- Plastic
        "label[0,3;Plastic\nSheet]" ..
        "list[current_name;plastic;1.5,3;1,1;]" ..
        -- Recycling
        "label[0,4;Recycling\nSlot]" ..
        "list[current_name;recycle;1.5,4;1,1;]" ..
        -- Sign categories
        "label[0,5;Sign\nCategory]" ..
        "dropdown[1.5,5;3.75,1;category;" .. dropdown_string .. ";" .. tostring(dropdown_index) ..
                "]" ..
        -- List of signs
        "list[current_name;output;2.8,0;8,5;" .. tostring((page - 1) * pagesize) .. "]" ..
        -- Player inventory
        "list[current_player;main;1.5,6.25;8,4;]" ..
        -- (Change by Guill4um - allow printing the signs with SHIFT + click, as well as by
        --      dragging them from one inventory to another. Reverted because it breaks the code
        --      below, which allows cartridges to be added to their slots with a SHIFT + click
        --      (and also because it should require a bit of effort, so that the user doesn't
        --      accidentally waste ink/plastic)
--       "listring[]" ..
        -- Page buttons
        "button[5.5,5;1,1;prevpage;<<<]" ..
        "button[8.5,5;1,1;nextpage;>>>]" ..
        "label[6.75,5.25;Page " .. page .. " of " .. maxpage .. "]" ..
        -- List rings
        "listring[current_player;main]" ..
        "listring[current_name;redcart]" ..
        "listring[current_player;main]" ..
        "listring[current_name;greencart]" ..
        "listring[current_player;main]" ..
        "listring[current_name;bluecart]" ..
        "listring[current_player;main]" ..
        "listring[current_name;plastic]" ..
        "listring[current_player;main]" ..
        "listring[current_name;recycle]"
    )
    meta:set_int("maxpage",maxpage)

end

---------------------------------------------------------------------------------------------------
-- Callbacks
---------------------------------------------------------------------------------------------------

function metrosigns.writer.allow_metadata_inventory_put(pos, listname, index, stack, player)

    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    local stack_name = stack:get_name()
    local stack_count = stack:get_count()
    local player_inv = player:get_inventory()
    local move_flag

    local ink_refund = 0
    local redcart = inv:get_stack("redcart", 1)
    local greencart = inv:get_stack("greencart", 1)
    local bluecart = inv:get_stack("bluecart", 1)

    local plastic_refund = 0
    local plastic = inv:get_stack("plastic", 1)

    -- Deal with the right node in the right slot
    if listname == "redcart" and stack_name == "metrosigns:cartridge_red" then
        return 1
    elseif listname == "greencart" and stack_name == "metrosigns:cartridge_green" then
        return 1
    elseif listname == "bluecart" and stack_name == "metrosigns:cartridge_blue" then
        return 1
    elseif listname == "plastic" and stack_name == "basic_materials:plastic_sheet" then
        return stack_count
    end

    -- (Change by Guill4um - refill cartridges by dropping the dye directly into the same inventory
    --      slots)
    if listname == "redcart" and stack_name == "dye:red" then

        if redcart:get_name() == "metrosigns:cartridge_red" then

            redcart:set_wear(0)
            inv:set_stack("redcart", 1, redcart)
            stack:set_count(2)
            player_inv:remove_item("main", stack)
            stack:set_count(0)
            metrosigns.writer.populate_output(pos)

        end

        return 0

    elseif listname == "greencart" and stack_name == "dye:green" then

        if greencart:get_name() == "metrosigns:cartridge_green" then

            greencart:set_wear(0)
            inv:set_stack("greencart", 1, greencart)
            stack:set_count(2)
            player_inv:remove_item("main", stack)
            stack:set_count(0)
            metrosigns.writer.populate_output(pos)

        end

        return 0

    elseif listname == "bluecart" and stack_name == "dye:blue" then

        if bluecart:get_name() == "metrosigns:cartridge_blue" then

            bluecart:set_wear(0)
            inv:set_stack("bluecart", 1, bluecart)
            stack:set_count(2)
            player_inv:remove_item("main", stack)
            stack:set_count(0)
            metrosigns.writer.populate_output(pos)

        end

        return 0

    -- (Change by Guill4um - drop an item to the ground, rather than erasing it)
    elseif listname == "main" then

        local player_inv = player:get_inventory()
        if player_inv:room_for_item("main", stack) then
            return stack:get_count()
        else
            return 0
        end

    end

    -- Cannot rely on the listring to put the right type of cartridge into the right slot; a green
    --      cartridge would be put into the red cartridge slot
    -- The workaround is to move the green cartridge into the green slot directly
    if stack_name == "metrosigns:cartridge_green" and inv:is_empty("greencart") then

        if player_inv:remove_item("main", stack) then

            inv:add_item("greencart", stack)
            move_flag = true

        end

    elseif stack_name == "metrosigns:cartridge_blue" and inv:is_empty("bluecart") then

        if player_inv:remove_item("main", stack) then

            inv:add_item("bluecart", stack)
            move_flag = true

        end

    elseif stack_name == "basic_materials:plastic_sheet" and inv:is_empty("plastic") then

        if player_inv:remove_item("main", stack) then

            inv:add_item("plastic", stack)
            move_flag = true

        end

    end

    -- All metrosigns nodes (except lightboxes and the sign writer itself) can be recycled
    -- For each compatible node added to the recycling slot, the player has a 66% chance of
    --      receiving some plastic. In addition, they receive between 50-100% of the ink consumed in
    --      crafting the node
    if listname == "recycle" and
            string.find(stack_name, "metrosigns") and
            not string.find(stack_name, "writer") and
            not string.find(stack_name, "cartridge") and
            (string.find(stack_name, "sign") or string.find(stack_name, "map")) then

        -- Decide how much ink to recover from the recycling process, and restore it to the
        --      cartridges
        -- THe player never receives the full amount
        if string.find(stack_name, "metrosigns:sign") then
            ink_refund = math.random(1, (metrosigns.writer.sign_units - 1))
        elseif string.find(stack_name, "metrosigns:map") then
            ink_refund = math.random(1, (metrosigns.writer.map_units - 1))
        else
            ink_refund = math.random(1, (metrosigns.writer.text_units - 1))
        end

        ink_refund = ink_refund * metrosigns.writer.cartridge_min * stack_count

        if not inv:is_empty("redcart") then

            if redcart:get_wear() < ink_refund then
                redcart:set_wear(0)
            else
                redcart:set_wear(redcart:get_wear() - ink_refund)
            end

            inv:set_stack("redcart", 1, redcart)

        end

        if not inv:is_empty("greencart") then

            if greencart:get_wear() < ink_refund then
                greencart:set_wear(0)
            else
                greencart:set_wear(greencart:get_wear() - ink_refund)
            end

            inv:set_stack("greencart", 1, greencart)

        end

        if not inv:is_empty("bluecart") then

            if bluecart:get_wear() < ink_refund then
                bluecart:set_wear(0)
            else
                bluecart:set_wear(bluecart:get_wear() - ink_refund)
            end

            inv:set_stack("bluecart", 1, bluecart)

        end

        -- Randomly restore a plastic sheet
        chance = (math.random(0, 100)) / 100
        if (stack_count == 1 and chance <= 0.67) then
            plastic_refund = 1
        elseif stack_count > 1 then
            plastic_refund = math.floor(stack_count * chance)
        end

        if plastic_refund > 0 then

            if inv:is_empty("plastic") then

                inv:add_item(
                    "plastic",
                    ItemStack("basic_materials:plastic_sheet " .. tostring(plastic_refund))
                )

            elseif plastic:get_count() < plastic:get_stack_max() then

                if (plastic:get_count() + plastic_refund) > plastic:get_stack_max() then
                    plastic:set_count(plastic:get_stack_max())
                else
                    plastic:set_count(plastic:get_count() + plastic_refund)
                end

                inv:set_stack("plastic", 1, plastic)

            end

        end

        -- Destroy the recycled item
        player_inv:remove_item("main", stack)
        return 0

    end

    -- In this situation, the list of writeable signs is not updated automatically
    if move_flag then
        metrosigns.writer.populate_output(pos)
    end

    -- Having put the green cartridge in the green slot, don't put the green cartridge in the red
    --  slot (etc), as well
    return 0

end

function metrosigns.writer.can_dig(pos)

    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    
    return (
        inv:is_empty("redcart") and
                inv:is_empty("greencart") and
                inv:is_empty("bluecart") and
                inv:is_empty("plastic") and
                inv:is_empty("recycle")
    )

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
    inv:set_size("recycle", 1)

    metrosigns.writer.populate_output(pos)

end

function metrosigns.writer.on_metadata_inventory_put(pos)

    metrosigns.writer.populate_output(pos)

end

function metrosigns.writer.on_metadata_inventory_take(pos, listname, index, stack, player)

    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    local input_stack = inv:get_stack(listname,  index)

    if listname == "output" then

        local cost =
                metrosigns.writer.signtypes[metrosigns.writer.current_category][index].ink_needed
        metrosigns.writer.nom(pos, cost)

        -- (Change by Guill4um - when moving signs onto a slot that's not empty, the inventory item
        --      occupying that slot is erased. This fixes the problem. Credit to
        --      moreblocks:cnc code)
        if not input_stack:is_empty() and input_stack:get_name() ~= stack:get_name() then

            local player_inv = player:get_inventory()
            if player_inv:room_for_item("main", input_stack) then

                -- If there is room in the player's inventory, the item is moved
                player_inv:add_item("main", input_stack)

            else

                -- if there is no room, the item is dropped
                minetest.item_drop(input_stack, player, pos)

            end

        end

    end

    metrosigns.writer.populate_output(pos)

end

function metrosigns.writer.on_receive_fields(pos, formname, fields, sender)

    -- This function fixes two issues in the original "roads" mod
    -- Firstly, the previous/next buttons did not work (fixed by checking them before checking the
    --      dropdown box)
    -- Secondly, when the user switched categories, the first page was not made visible
    --      automatically (very confusing if the new category has only one page)

    local meta = minetest.get_meta(pos)
    local page = meta:get_int("page")
    local maxpage = meta:get_int("maxpage")

    if fields.prevpage then

        -- User has clicked the previous button
        page = page - 1
        if page < 1 then
            page = maxpage
        end
        
        meta:set_int("page",page)

    elseif fields.nextpage then

        -- User has clicked the next button
        page = page + 1
        if page > maxpage then
            page = 1
        end
        
        meta:set_int("page",page)

    elseif fields.category then

        -- User has activated the dropdown box
        if metrosigns.writer.signtypes[fields.category] ~= nil then

            metrosigns.writer.current_category = fields.category
            meta:set_int("page", 1)

        end

    end

    -- In all cases, redraw the list of signs for the current category
    metrosigns.writer.populate_output(pos)

end

function metrosigns.writer.allow_metadata_inventory_move(
    pos, from_list, from_index, to_list, to_index, count, player
)
    return 0

end

---------------------------------------------------------------------------------------------------
-- Register crafts for the machine and its ink cartridges
---------------------------------------------------------------------------------------------------

minetest.register_tool("metrosigns:cartridge_red", {
    description = "Red Ink Cartridge",
    inventory_image = "streets_cartridge_red.png"
})

minetest.register_tool("metrosigns:cartridge_green", {
    description = "Green Ink Cartridge",
    inventory_image = "streets_cartridge_green.png"
})

minetest.register_tool("metrosigns:cartridge_blue", {
    description = "Blue Ink Cartridge",
    inventory_image = "streets_cartridge_blue.png"
})

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
        type = "shapeless",
        output = "metrosigns:cartridge_red",
        recipe = {"metrosigns:cartridge_red", "dye:red"}
    })

    minetest.register_craft({
        type = "shapeless",
        output = "metrosigns:cartridge_green",
        recipe = {"metrosigns:cartridge_green", "dye:green"}
    })

    minetest.register_craft({
        type = "shapeless",
        output = "metrosigns:cartridge_blue",
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
    description = "Sign Writer Machine",
    tiles = {
        "metrosigns_writer_top.png",
        "metrosigns_writer_side.png",
        "metrosigns_writer_side.png",
        "metrosigns_writer_side.png",
        "metrosigns_writer_side.png",
        "metrosigns_writer_front.png",
    },
    groups = {cracky = 2},

    paramtype = "light",
    paramtype2 = "facedir",
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

if HAVE_DEFAULT_FLAG then

    minetest.override_item(
        "metrosigns:sign_writer", { sounds = default.node_sound_stone_defaults() }
    )

end
