---------------------------------------------------------------------------------------------------
-- metrosigns mod for minetest by A S Lewis
--      https://github.com/axcore/metrosigns
--      Licence: GNU Affero GPL
---------------------------------------------------------------------------------------------------
-- Includes code/textures from advtrains_subwayblocks by gpcf/orwell
--      https://git.gpcf.eu/?p=advtrains_subwayblocks.git
--      Licence: GNU Affero GPL
--
-- Includes code from basic_trains by gpcf/orwell
--      https://git.bananach.space/basic_trains.git
--      Licence: GNU Affero GPL
--
-- Includes code/textures from trainblocks by Maxx
--      https://github.com/maxhipp/trainblocks_bc
--      https://forum.minetest.net/viewtopic.php?t=19743
--      Licence: GNU Affero GPL
--
-- Includes code/textures from roads by cheapie
--      https://cheapiesystems.com/git/roads/
--      https://forum.minetest.net/viewtopic.php?t=13904
--      Licence: CC-BY-SA 3.0 Unported
--
-- Includes various fixes/additions by Guill4um
---------------------------------------------------------------------------------------------------
-- Do you want to add signs for a a new city/server? This is how to do it:
--
--  1. Add a new flag in the "Load Settings" section below, e.g.
--          metrosigns.create_barcelona_flag
--  2. Edit settingtypes.txt to add the same flag there
--  3. Edit settings.lua to add the same flag there
--  4. Add a new section to citysigns.lua or serversigns.lua, using the existing code as a template
--  5. Add new textures to the /textures folder
--  6. If a city's name contains more than one word (e.g. "San Francisco", you'll need to edit the
--          capitalise() function below
--  7. That's it!
--
-- If you're not sure what to do, the authors will be happy to help!
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

metrosigns = {}

metrosigns.name = "metrosigns"
metrosigns.ver_max = 1
metrosigns.ver_min = 36
metrosigns.ver_rev = 0

metrosigns.writer = {}

---------------------------------------------------------------------------------------------------
-- Constants
---------------------------------------------------------------------------------------------------

metrosigns.path_mod = minetest.get_modpath(minetest.get_current_modname())

-- If default and basic_materials are loaded, the sign writer and cartridges are craftable
if minetest.get_modpath("default") then
    HAVE_DEFAULT_FLAG = true
else
    HAVE_DEFAULT_FLAG = false
end

if minetest.get_modpath("basic_materials") then
    HAVE_BASIC_MATERIALS_FLAG = true
else
    HAVE_BASIC_MATERIALS_FLAG = false
end

-- If signs_api from display_modpack is loaded, create signs with customisable text
if minetest.get_modpath("signs_api") then
    HAVE_SIGNS_API_FLAG = true
else
    HAVE_SIGNS_API_FLAG = false
end

-- If advtrains_subwayblocks is loaded, we don't create duplicate blocks
if minetest.get_modpath("advtrains_subwayblocks") then
    HAVE_SUBWAYBLOCKS_FLAG = true
else
    HAVE_SUBWAYBLOCKS_FLAG = false
end

-- If trainblocks is loaded, we don't create duplicate blocks
if minetest.get_modpath("trainblocks") then
    HAVE_TRAINBLOCKS_FLAG = true
else
    HAVE_TRAINBLOCKS_FLAG = false
end

-- Cartridge ink levels are implemented using wear
-- Ink capacity of a cartridge
metrosigns.writer.cartridge_max = 60000
-- Amount of ink used for one unit
metrosigns.writer.cartridge_min = 1000
-- Number of units used for printing various kinds of sign
-- (The printing capacity of a cartridge was doubled in v1.12.0, but reduced slightly in v1.28.0)
metrosigns.writer.box_units = 15
metrosigns.writer.sign_units = 5
metrosigns.writer.map_units = 10
metrosigns.writer.text_units = 10

-- Used in material copied from advtrains_subwayblocks and trainblocks
box_groups = {cracky = 3}
box_light_source = 10

---------------------------------------------------------------------------------------------------
-- Variables
---------------------------------------------------------------------------------------------------

-- Signs are divided into categories. Each category represents a single city (or server). There are
--      are also some special categories not related to a city or a server, e.g. "Signs with text"
-- A category's name is the same as the city description (i.e. "London Underground" rather than
--      "London")
-- An ordered list of categories, as displayed in the sign-writing machine's dropdrown box, e.g.
--      categories[1] = "London Underground", categories[2] = "Paris Metro"
metrosigns.writer.categories = {}
-- The current category; one of the values in metrosigns.writer.categories. Only signs in this
--      category are visible in the sign-writing machine's list
metrosigns.writer.current_category = nil
-- Ordered list of signs in each category and their properties. The properties are arranged in a
--      table:
--
--      category - one of the values in metrosigns.writer.current_category
--      name - the name of the sign's node, e.g. "metrosigns:map_london_bakerloo_line"
--      ink_needed - the amount of ink removed from each cartridge when printing the sign, e.g. 10
-- Thus we have, e.g.
--      signtypes["London Underground"][1] = property_table,
--      signtypes["London Underground"][2] = property_table, etc
metrosigns.writer.signtypes = {}
-- The number of signs in each category, e.g. signcounts["London Underground"] = 20
metrosigns.writer.signcounts = {}

---------------------------------------------------------------------------------------------------
-- Load settings
---------------------------------------------------------------------------------------------------

-- Load settings from Minetest's main menu
metrosigns.create_all_flag = minetest.settings:get_bool("metrosigns_create_all", true)

metrosigns.create_subwayblocks_flag =
        minetest.settings:get_bool("metrosigns_create_subwayblocks", false)
metrosigns.create_trainblocks_flag =
        minetest.settings:get_bool("metrosigns_create_trainblocks", false)

metrosigns.create_ext_line_flag = minetest.settings:get_bool("metrosigns_create_ext_line", true)
metrosigns.ext_line_min = minetest.settings:get("metrosigns_ext_line_min") or 11
metrosigns.ext_line_max = minetest.settings:get("metrosigns_ext_line_min") or 20
metrosigns.ext_line_bt_cols_flag = minetest.settings:get_bool("metrosigns_ext_line_bt_cols", true)

metrosigns.create_ext_platform_flag =
        minetest.settings:get_bool("metrosigns_create_ext_platform", true)
metrosigns.ext_platform_min = minetest.settings:get("metrosigns_ext_platform_min") or 11
metrosigns.ext_platform_max = minetest.settings:get("metrosigns_ext_platform_min") or 20

metrosigns.create_text_flag = minetest.settings:get_bool("metrosigns_create_text", true)

metrosigns.create_athens_flag = minetest.settings:get_bool("metrosigns_create_athens", false)
metrosigns.create_bangkok_flag = minetest.settings:get_bool("metrosigns_create_bangkok", false)
metrosigns.create_berlin_flag = minetest.settings:get_bool("metrosigns_create_berlin", false)
metrosigns.create_bucharest_flag = minetest.settings:get_bool("metrosigns_create_bucharest", false)
metrosigns.create_budapest_flag = minetest.settings:get_bool("metrosigns_create_budapest", false)
metrosigns.create_glasgow_flag = minetest.settings:get_bool("metrosigns_create_glasgow", false)
metrosigns.create_hcmc_flag = minetest.settings:get_bool("metrosigns_create_hcmc", false)
metrosigns.create_london_flag = minetest.settings:get_bool("metrosigns_create_london", true)
metrosigns.create_luton_flag = minetest.settings:get_bool("metrosigns_create_luton", false)
metrosigns.create_madrid_flag = minetest.settings:get_bool("metrosigns_create_madrid", false)
metrosigns.create_moscow_flag = minetest.settings:get_bool("metrosigns_create_moscow", false)
metrosigns.create_newyork_flag = minetest.settings:get_bool("metrosigns_create_newyork", false)
metrosigns.create_paris_flag = minetest.settings:get_bool("metrosigns_create_paris", false)
metrosigns.create_prague_flag = minetest.settings:get_bool("metrosigns_create_prague", false)
metrosigns.create_rome_flag = minetest.settings:get_bool("metrosigns_create_rome", false)
metrosigns.create_stockholm_flag = minetest.settings:get_bool("metrosigns_create_stockholm", false)
metrosigns.create_taipei_flag = minetest.settings:get_bool("metrosigns_create_taipei", false)
metrosigns.create_tokyo_flag = minetest.settings:get_bool("metrosigns_create_tokyo", false)
metrosigns.create_toronto_flag = minetest.settings:get_bool("metrosigns_create_toronto", false)
metrosigns.create_vienna_flag = minetest.settings:get_bool("metrosigns_create_vienna", false)

metrosigns.create_tabyss_flag = minetest.settings:get_bool("metrosigns_create_tabyss", false)

-- Override one or more of these settings by uncommenting the lines in this file
dofile(metrosigns.path_mod.."/override.lua")

---------------------------------------------------------------------------------------------------
-- General functions
---------------------------------------------------------------------------------------------------

function capitalise(str)

    -- Returns a capitalised city name. At the moment, only one city name contains more than one
    --      word, so we create an exception for that
    --
    -- Args:
    --      str (string): The lower-case city name used by this mod, e.g. "london" or "newyork"
    --
    -- Return values:
    --      Returns the capitalised city name, e.g. "London" or "New York"

    if str == "newyork" then
        return "New York"
    elseif str == "tabyss" then
        return "TA"
    else
        return (str:gsub("^%l", string.upper))
    end

end

function isint(n)

  return n == math.floor(n)

end

function metrosigns.register_category(category)

    -- Adds a new category (representing a single city, or a single server)
    --
    -- Args:
    --      category (string): The category name, which will be visible in the sign-writing
    --          machine's dropdown box. See the category-naming hints above; i.e. the calling
    --          function should specify "London Underground" rather than "London"

    table.insert(metrosigns.writer.categories, category)
    metrosigns.writer.signcounts[category] = 0
    metrosigns.writer.signtypes[category] = {}
    if metrosigns.writer.current_category == nil then
        metrosigns.writer.current_category = category
    end

end

function metrosigns.register_sign(category, node, ink_needed)

    -- Registers a sign. All types of sign - lightboxes, line/platform signs, map signs and text
    --      signs - are registered via a call to this function
    --
    -- Args:
    --      category (string): The category to which the sign belongs. Must be one of the items in
    --          metrosigns.writer.categories
    --      node (string): The node name, e.g. "metrosigns:map_london_wlcity_line"
    --      ink_needed (int): The amount of ink required to write the sign; should be consistent
    --          with the values specified above (i.e. metrosigns.writer.box_units,
    --          metrosigns.writer.sign_units, metrosigns.writer.map_units or
    --          metrosigns.writer.text_units)

    local data = {category = category, name = node, ink_needed = ink_needed}
    table.insert(metrosigns.writer.signtypes[category], data)
    metrosigns.writer.signcounts[category] = metrosigns.writer.signcounts[category] + 1

end

---------------------------------------------------------------------------------------------------
-- Original material from advtrains_subwayblocks by gpcf/orwell
---------------------------------------------------------------------------------------------------

dofile(metrosigns.path_mod.."/subwayblocks.lua")

---------------------------------------------------------------------------------------------------
-- Original material from trainblocks by Maxx
---------------------------------------------------------------------------------------------------

dofile(metrosigns.path_mod.."/trainblocks.lua")

---------------------------------------------------------------------------------------------------
-- Extended line and platform signs
---------------------------------------------------------------------------------------------------

dofile(metrosigns.path_mod.."/extsigns.lua")

---------------------------------------------------------------------------------------------------
-- Signs with customisable text (designed to be used alongside the map nodes). Requires signs_api
--      from display_modpack
---------------------------------------------------------------------------------------------------

dofile(metrosigns.path_mod.."/customsigns.lua")

---------------------------------------------------------------------------------------------------
-- Generic functions used by city-specific and server-specific signs
---------------------------------------------------------------------------------------------------

dofile(metrosigns.path_mod.."/generic.lua")

---------------------------------------------------------------------------------------------------
-- City-specific signs
---------------------------------------------------------------------------------------------------

dofile(metrosigns.path_mod.."/citysigns.lua")

---------------------------------------------------------------------------------------------------
-- Server-specific signs
---------------------------------------------------------------------------------------------------

dofile(metrosigns.path_mod.."/serversigns.lua")

---------------------------------------------------------------------------------------------------
-- Sign-writing machines and ink cartridges
---------------------------------------------------------------------------------------------------

dofile(metrosigns.path_mod.."/machine.lua")
