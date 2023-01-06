---------------------------------------------------------------------------------------------------
-- metrosigns mod for minetest by A S Lewis
--      https://github.com/axcore/metrosigns
--      Licence: GNU Affero GPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Extended line and platform signs
---------------------------------------------------------------------------------------------------

local line_flag, line_min, line_max, line_bt_cols_flag, line_category

line_flag = metrosigns.create_all_flag or metrosigns.create_ext_line_flag
line_min = tonumber(metrosigns.ext_line_min)
line_max = tonumber(metrosigns.ext_line_max)
line_bt_cols_flag = metrosigns.ext_line_bt_cols_flag
if not isint(line_min) or not isint(line_max) or line_min < 0 or line_max > 99 then
    line_flag = false
end

if line_flag then

    line_category = "Extended line signs"
    metrosigns.register_category(line_category)
    
end

local platform_flag, platform_min, platform_max, platform_category

platform_flag = metrosigns.create_all_flag or metrosigns.create_ext_platform_flag
platform_min = tonumber(metrosigns.ext_platform_min)
platform_max = tonumber(metrosigns.ext_platform_max)
if not isint(platform_min) or not isint(platform_max) or platform_min < 0 or platform_max > 99 then
    platform_flag = false
end

if platform_flag then

    platform_category = "Extended platform signs"
    metrosigns.register_category(platform_category)
    
end

if line_flag or platform_flag then

    for m = 0, 9, 1 do

        for n = 0, 9, 1 do

            local num, col
            
            num = (m * 10) + n
            if n == 6 then
                col = "black"
            else
                col = "white"
            end

            if num >= line_min and num <= line_max then

                local tex, inv

                -- Line signs in the range 11-99 might use either of two colour schemes
                if (not line_bt_cols_flag) or num < 11 then

                    -- Old metrosigns colour scheme
                    tex = "metrosigns_bg_small_" .. n .. ".png^metrosigns_char_small_" .. col ..
                            "_" .. m .. "0.png^metrosigns_char_small_" .. col .. "_" .. n .. ".png"
                    inv = "metrosigns_bg_large_" .. n .. ".png^metrosigns_char_large_" .. col ..
                            "_" .. m .. "0.png^metrosigns_char_large_" .. col .. "_" .. n .. ".png"

                else

                    -- Colour scheme from basic_trains
					local red = math.fmod((num * 67) + 101, 255)
					local green = math.fmod((num * 97) + 109, 255)
					local blue = math.fmod((num * 73) + 127, 255)

					if red + green + blue > 512 then
                        col = "black"
                    else
                        col = "white"
                    end

                    local colourise = string.format(
                        "^[colorize:#%X%X%X%X%X%X",
                        math.floor(red / 16), math.fmod(red, 16), math.floor(green / 16),
                        math.fmod(green, 16), math.floor(blue / 16), math.fmod(blue, 16)
                    )
                    
                    tex = "(metrosigns_bg_small_x.png" .. colourise .. ")" .. 
                            "^metrosigns_char_small_" .. col .. "_" .. m .. 
                            "0.png^metrosigns_char_small_" .. col .. "_" .. n .. ".png"
                            
                    inv = "(metrosigns_bg_large_x.png" .. colourise .. ")" .. 
                            "^metrosigns_char_large_" .. col .. "_" .. m .. 
                            "0.png^metrosigns_char_large_" .. col .. "_" .. n .. ".png"
                    
                end

                minetest.register_node("metrosigns:sign_line_" .. m .. n, {
                    description = "Line " .. num .. " sign",
                    tiles = {tex},
                    groups = {
                        attached_node = 1, choppy = 2, flammable = 2, oddly_breakable_by_hand = 3
                    },

                    drawtype = "nodebox",
                    inventory_image = inv,
                    is_ground_content = false,
                    legacy_wallmounted = true,
                    light_source = 12,
                    node_box = {
                        type = "wallmounted",
                        wall_top = {-8/16, -4/16, -4/16, -7/16, 4/16, 4/16},
                        wall_bottom = {-8/16, -4/16, -4/16, -7/16, 4/16, 4/16},
                        wall_side = {-8/16, -4/16, -5/16, -7/16, 4/16, 5/16},
                    },
                    paramtype = "light",
                    paramtype2 = "wallmounted",
                    sunlight_propagates = true,
                    -- Fix for minetest 5.4
                    use_texture_alpha = "clip",
                    walkable = false
                })
                metrosigns.register_sign(
                    line_category, "metrosigns:sign_line_" .. m .. n, metrosigns.writer.sign_units
                )

            end

            if num >= platform_min and num <= platform_max then

                minetest.register_node("metrosigns:sign_platform_" .. m .. n, {
                    description = "Platform " .. num .. " sign",
                    tiles = {
                        "metrosigns_bg_small_platform.png^metrosigns_char_small_white_" .. m .. 
                                "0.png^metrosigns_char_small_white_" .. n .. ".png"
                    },
                    groups = {cracky = 3},

                    drawtype = "nodebox",
                    inventory_image =
                            "metrosigns_bg_large_platform.png^metrosigns_char_large_white_" ..
                            m .. "0.png^metrosigns_char_large_white_" .. n .. ".png",
                    is_ground_content = false,
                    legacy_wallmounted = true,
                    light_source = 5,
                    node_box = {
                        type = "wallmounted",
                        wall_top = {-8/16, -4/16, -4/16, -7/16, 4/16, 4/16},
                        wall_bottom = {-8/16, -4/16, -4/16, -7/16, 4/16, 4/16},
                        wall_side = {-8/16, -4/16, -5/16, -7/16, 4/16, 5/16},
                    },
                    node_box = {
                        type = "fixed",
                        fixed = {
                            { -5/16, -4/16, 6/16,  5/16,  4/16, 8/16},
                        },
                    },
                    paramtype = "light",
                    paramtype2 = "facedir",
                    -- Fix for minetest 5.4
                    use_texture_alpha = "clip",
                    walkable = false
                })
                metrosigns.register_sign(
                    platform_category,
                    "metrosigns:sign_platform_" .. m .. n,
                    metrosigns.writer.sign_units
                )

            end

        end

    end

end
