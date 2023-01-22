WarMenu = { }

WarMenu.debug = false

local menus = { }
local keys = { up = 172, down = 173, left = 174, right = 175, select = 176, back = 177 }

local optionCount = 0

local currentKey = nil

local currentMenu = nil


local menuWidth = 0.23

local titleHeight = 0.11
local titleYOffset = 0.03
local titleScale = 1.0

local buttonHeight = 0.038
local buttonFont = 4
local buttonScale = 0.365
local buttonTextXOffset = 0.005
local buttonTextYOffset = 0.005


-- Local functions=
local function debugPrint(text)
    if WarMenu.debug then
        Citizen.Trace('[WarMenu] '..tostring(text))
    end
end


local function setMenuProperty(id, property, value)
    if id and menus[id] then
        menus[id][property] = value
        debugPrint(id..' menu property changed: { '..tostring(property)..', '..tostring(value)..' }')
    end
end


local function isMenuVisible(id)
    if id and menus[id] then
        return menus[id].visible
    else
        return false
    end
end


local function setMenuVisible(id, visible, holdCurrent)
    if id and menus[id] then
        setMenuProperty(id, 'visible', visible)

        if not holdCurrent and menus[id] then
            setMenuProperty(id, 'currentOption', 1)
        end

        if visible then
            if id ~= currentMenu and isMenuVisible(currentMenu) then
                setMenuVisible(currentMenu, false)
            end

            currentMenu = id
        end
    end
end


local function drawText(text, x, y, font, color, scale, center, shadow, alignRight)
    SetTextColour(color.r, color.g, color.b, color.a)
    SetTextFont(font)
    SetTextScale(scale, scale)

    if shadow then
        SetTextDropShadow(7, 4, 0, 0, 0)
    end

    if menus[currentMenu] then
        if center then
            SetTextCentre(center)
        elseif alignRight then
            SetTextWrap(menus[currentMenu].x, menus[currentMenu].x + menuWidth - buttonTextXOffset)
            SetTextRightJustify(true)
        end
    end

    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(x, y)
end


local function drawRect(x, y, width, height, color)
    DrawRect(x, y, width, height, color.r, color.g, color.b, color.a)
end


local function drawTitle()
    if menus[currentMenu] then
        local x = menus[currentMenu].x + menuWidth / 2
        local y = menus[currentMenu].y + titleHeight / 2
        --DrawRect(x, y, menuWidth, titleHeight, menus[currentMenu].titleBackgroundColor)
        if menus[currentMenu].background == "default" then
            RequestStreamedTextureDict("CommonMenu")
            DrawSprite("CommonMenu", "interaction_bgd", x, y, menuWidth, titleHeight, 0.0, 255, 255, 255, 255)
        elseif menus[currentMenu].background == "barber" then
            RequestStreamedTextureDict("shopui_title_barber")
            DrawSprite("shopui_title_barber", "shopui_title_barber", x, y, menuWidth, titleHeight, 0.0, 255, 255, 255, 255)
        elseif menus[currentMenu].background == "barber2" then
            RequestStreamedTextureDict("shopui_title_barber2")
            DrawSprite("shopui_title_barber2", "shopui_title_barber2", x, y, menuWidth, titleHeight, 0.0, 255, 255, 255, 255)
        elseif menus[currentMenu].background == "barber3" then
            RequestStreamedTextureDict("shopui_title_barber3")
            DrawSprite("shopui_title_barber3", "shopui_title_barber3", x, y, menuWidth, titleHeight, 0.0, 255, 255, 255, 255)
        elseif menus[currentMenu].background == "barber4" then
            RequestStreamedTextureDict("shopui_title_barber4")
            DrawSprite("shopui_title_barber4", "shopui_title_barber4", x, y, menuWidth, titleHeight, 0.0, 255, 255, 255, 255)
        elseif menus[currentMenu].background == "carmod" then
            RequestStreamedTextureDict("shopui_title_carmod")
            DrawSprite("shopui_title_carmod", "shopui_title_carmod", x, y, menuWidth, titleHeight, 0.0, 255, 255, 255, 255)
        elseif menus[currentMenu].background == "carmod2" then
            RequestStreamedTextureDict("shopui_title_carmod2")
            DrawSprite("shopui_title_carmod2", "shopui_title_carmod2", x, y, menuWidth, titleHeight, 0.0, 255, 255, 255, 255)
        elseif menus[currentMenu].background == "convience" then
            RequestStreamedTextureDict("shopui_title_conveniencestore")
            DrawSprite("shopui_title_conveniencestore", "shopui_title_conveniencestore", x, y, menuWidth, titleHeight, 0.0, 255, 255, 255, 255)
        elseif menus[currentMenu].background == "darts" then
            RequestStreamedTextureDict("shopui_title_darts")
            DrawSprite("shopui_title_darts", "shopui_title_darts", x, y, menuWidth, titleHeight, 0.0, 255, 255, 255, 255)
        elseif menus[currentMenu].background == "gasstation" then
            RequestStreamedTextureDict("shopui_title_gasstation")
            DrawSprite("shopui_title_gasstation", "shopui_title_gasstation", x, y, menuWidth, titleHeight, 0.0, 255, 255, 255, 255)
        elseif menus[currentMenu].background == "golf" then
            RequestStreamedTextureDict("shopui_title_golfshop")
            DrawSprite("shopui_title_golfshop", "shopui_title_golfshop", x, y, menuWidth, titleHeight, 0.0, 255, 255, 255, 255)
        elseif menus[currentMenu].background == "gunclub" then
            RequestStreamedTextureDict("shopui_title_golfshop")
            DrawSprite("shopui_title_golfshop", "shopui_title_golfshop", x, y, menuWidth, titleHeight, 0.0, 255, 255, 255, 255)
        elseif menus[currentMenu].background == "highendfashion" then
            RequestStreamedTextureDict("shopui_title_highendfashion")
            DrawSprite("shopui_title_highendfashion", "shopui_title_highendfashion", x, y, menuWidth, titleHeight, 0.0, 255, 255, 255, 255)
        elseif menus[currentMenu].background == "highendsalon" then
            RequestStreamedTextureDict("shopui_title_highendsalon")
            DrawSprite("shopui_title_highendsalon", "shopui_title_highendsalon", x, y, menuWidth, titleHeight, 0.0, 255, 255, 255, 255)
        elseif menus[currentMenu].background == "liqourstore" then
            RequestStreamedTextureDict("shopui_title_liqourstore")
            DrawSprite("shopui_title_liqourstore", "shopui_title_liqourstore", x, y, menuWidth, titleHeight, 0.0, 255, 255, 255, 255)
        elseif menus[currentMenu].background == "liqourstore2" then
            RequestStreamedTextureDict("shopui_title_liqourstore2")
            DrawSprite("shopui_title_liqourstore2", "shopui_title_liqourstore2", x, y, menuWidth, titleHeight, 0.0, 255, 255, 255, 255)
        elseif menus[currentMenu].background == "liqourstore3" then
            RequestStreamedTextureDict("shopui_title_liqourstore3")
            DrawSprite("shopui_title_liqourstore3", "shopui_title_liqourstore3", x, y, menuWidth, titleHeight, 0.0, 255, 255, 255, 255)
        elseif menus[currentMenu].background == "lowendfashion" then
            RequestStreamedTextureDict("shopui_title_lowendfashion")
            DrawSprite("shopui_title_lowendfashion", "shopui_title_lowendfashion", x, y, menuWidth, titleHeight, 0.0, 255, 255, 255, 255)
        elseif menus[currentMenu].background == "lowendfashion2" then
            RequestStreamedTextureDict("shopui_title_lowendfashion2")
            DrawSprite("shopui_title_lowendfashion2", "shopui_title_lowendfashion2", x, y, menuWidth, titleHeight, 0.0, 255, 255, 255, 255)
        elseif menus[currentMenu].background == "midfashion" then
            RequestStreamedTextureDict("shopui_title_midfashion")
            DrawSprite("shopui_title_midfashion", "shopui_title_midfashion", x, y, menuWidth, titleHeight, 0.0, 255, 255, 255, 255)
        elseif menus[currentMenu].background == "moviemasks" then
            RequestStreamedTextureDict("shopui_title_movie_masks")
            DrawSprite("shopui_title_movie_masks", "shopui_title_movie_masks", x, y, menuWidth, titleHeight, 0.0, 255, 255, 255, 255)
        elseif menus[currentMenu].background == "tattoos" then
            RequestStreamedTextureDict("shopui_title_tattoos")
            DrawSprite("shopui_title_tattoos", "shopui_title_tattoos", x, y, menuWidth, titleHeight, 0.0, 255, 255, 255, 255)
        elseif menus[currentMenu].background == "tattoos2" then
            RequestStreamedTextureDict("shopui_title_tattoos2")
            DrawSprite("shopui_title_tattoos2", "shopui_title_tattoos2", x, y, menuWidth, titleHeight, 0.0, 255, 255, 255, 255)
        elseif menus[currentMenu].background == "tattoos3" then
            RequestStreamedTextureDict("shopui_title_tattoos3")
            DrawSprite("shopui_title_tattoos3", "shopui_title_tattoos3", x, y, menuWidth, titleHeight, 0.0, 255, 255, 255, 255)
        elseif menus[currentMenu].background == "tattoos4" then
            RequestStreamedTextureDict("shopui_title_tattoos4")
            DrawSprite("shopui_title_tattoos4", "shopui_title_tattoos4", x, y, menuWidth, titleHeight, 0.0, 255, 255, 255, 255)
        elseif menus[currentMenu].background == "tattoos5" then
            RequestStreamedTextureDict("shopui_title_tattoos5")
            DrawSprite("shopui_title_tattoos5", "shopui_title_tattoos5", x, y, menuWidth, titleHeight, 0.0, 255, 255, 255, 255)
        elseif menus[currentMenu].background == "tennis" then
            RequestStreamedTextureDict("shopui_title_tennis")
            DrawSprite("shopui_title_tennis", "shopui_title_tennis", x, y, menuWidth, titleHeight, 0.0, 255, 255, 255, 255)
        elseif menus[currentMenu].background == "supermod" then
            RequestStreamedTextureDict("shopui_title_supermod")
            DrawSprite("shopui_title_supermod", "shopui_title_supermod", x, y, menuWidth, titleHeight, 0.0, 255, 255, 255, 255)
        elseif menus[currentMenu].background == "clubhouse" then
            RequestStreamedTextureDict("shopui_title_clubhousemod")
            DrawSprite("shopui_title_clubhousemod", "shopui_title_clubhousemod", x, y, menuWidth, titleHeight, 0.0, 255, 255, 255, 255)
        elseif menus[currentMenu].background == "vechupgrade" then
            RequestStreamedTextureDict("shopui_title_exec_vechupgrade")
            DrawSprite("shopui_title_exec_vechupgrade", "shopui_title_exec_vechupgrade", x, y, menuWidth, titleHeight, 0.0, 255, 255, 255, 255)
        elseif menus[currentMenu].background == "modgarage" then
            RequestStreamedTextureDict("shopui_title_ie_modgarage")
            DrawSprite("shopui_title_ie_modgarage", "shopui_title_ie_modgarage", x, y, menuWidth, titleHeight, 0.0, 255, 255, 255, 255)
        elseif menus[currentMenu].background == "gunmod" then
            RequestStreamedTextureDict("shopui_title_gr_gunmod")
            DrawSprite("shopui_title_gr_gunmod", "shopui_title_gr_gunmod", x, y, menuWidth, titleHeight, 0.0, 255, 255, 255, 255)
        end        
        drawText(menus[currentMenu].title, x, y - titleHeight / 2 + titleYOffset, menus[currentMenu].titleFont, menus[currentMenu].titleColor, titleScale, true)
    end
end


local function drawSubTitle()
    if menus[currentMenu] then
        local x = menus[currentMenu].x + menuWidth / 2
        local y = menus[currentMenu].y + titleHeight + buttonHeight / 2

        local subTitleColor = { r = menus[currentMenu].subTitleTextColor.r, g = menus[currentMenu].subTitleTextColor.g, b = menus[currentMenu].subTitleTextColor.b, a = 255 }

        drawRect(x, y, menuWidth, buttonHeight, menus[currentMenu].subTitleBackgroundColor)
        drawText(menus[currentMenu].subTitle, menus[currentMenu].x + buttonTextXOffset, y - buttonHeight / 2 + buttonTextYOffset, buttonFont, subTitleColor, buttonScale, false)

        if optionCount > menus[currentMenu].maxOptionCount then
            drawText(tostring(menus[currentMenu].currentOption)..' / '..tostring(optionCount), menus[currentMenu].x + menuWidth, y - buttonHeight / 2 + buttonTextYOffset, buttonFont, subTitleColor, buttonScale, false, false, true)
        end
    end
end


local function drawButton(text, subText)
    local x = menus[currentMenu].x + menuWidth / 2
    local multiplier = nil

    if menus[currentMenu].currentOption <= menus[currentMenu].maxOptionCount and optionCount <= menus[currentMenu].maxOptionCount then
        multiplier = optionCount
    elseif optionCount > menus[currentMenu].currentOption - menus[currentMenu].maxOptionCount and optionCount <= menus[currentMenu].currentOption then
        multiplier = optionCount - (menus[currentMenu].currentOption - menus[currentMenu].maxOptionCount)
    end

    if multiplier then
        local y = menus[currentMenu].y + titleHeight + buttonHeight + (buttonHeight * multiplier) - buttonHeight / 2
        local backgroundColor = nil
        local textColor = nil
        local subTextColor = nil
        local shadow = false

        if menus[currentMenu].currentOption == optionCount then
            backgroundColor = menus[currentMenu].menuFocusBackgroundColor
            textColor = menus[currentMenu].menuFocusTextColor
            subTextColor = menus[currentMenu].menuFocusTextColor
        else
            backgroundColor = menus[currentMenu].menuBackgroundColor
            textColor = menus[currentMenu].menuTextColor
            subTextColor = menus[currentMenu].menuSubTextColor
            shadow = true
        end

        drawRect(x, y, menuWidth, buttonHeight, backgroundColor)

        if (type(text) == "table") then
            while (not HasStreamedTextureDictLoaded(text["textureDict"])) do
                RequestStreamedTextureDict(text["textureDict"], true)

                Citizen.Wait(0)
            end

            DrawSprite(text["textureDict"], text["textureName"], menus[currentMenu].x + (buttonTextXOffset + 0.01), y - (buttonHeight / 2) + (buttonTextYOffset + 0.015), 0.025, 0.04, 0.0, textColor.r, textColor.g, textColor.b, textColor.a)
        else
            drawText(tostring(text), menus[currentMenu].x + buttonTextXOffset, y - (buttonHeight / 2) + buttonTextYOffset, buttonFont, textColor, buttonScale, false, shadow)
        end

        if subText then
            if (type(subText) == "table") then
                while (not HasStreamedTextureDictLoaded(subText["textureDict"])) do
                    RequestStreamedTextureDict(subText["textureDict"], true)

                    Citizen.Wait(0)
                end

                DrawSprite(subText["textureDict"], subText["textureName"], menus[currentMenu].x + (menuWidth - 0.025) + (buttonTextXOffset + 0.01), y - (buttonHeight / 2) + (buttonTextXOffset + 0.014), 0.025, 0.04, 0.0, subTextColor.r, subTextColor.g, subTextColor.b, subTextColor.a)
            else
                drawText(tostring(subText), menus[currentMenu].x + buttonTextXOffset, y - buttonHeight / 2 + buttonTextYOffset, buttonFont, subTextColor, buttonScale, false, shadow, true)
            end
        end
    end
end

-- API
menus_list = { }

function WarMenu.CreateMenu(id, background, title)
    table.insert(menus_list, id)
    menus[id] = { }
    menus[id].background = "a"
    menus[id].title = title
    menus[id].subTitle = 'PedMenu'

    menus[id].visible = false

    menus[id].previousMenu = nil

    menus[id].aboutToBeClosed = false

    menus[id].x = 0.375
	menus[id].y = 0.125
    menus[id].width = 0.23

    menus[id].currentOption = 1
    menus[id].maxOptionCount = 15

    menus[id].titleFont = 4
    menus[id].titleColor = { r = 255, g = 255, b = 255, a = 255 }
    menus[id].titleBackgroundColor = { r = 255, g = 0, b = 255, a = 255 }

    menus[id].menuTextColor = { r = 255, g = 255, b = 255, a = 255 }
    menus[id].menuSubTextColor = { r = 255, g = 255, b = 255, a = 255 }
    menus[id].menuFocusTextColor = { r = 0, g = 0, b = 0, a = 255 }
    menus[id].menuFocusBackgroundColor = { r = 245, g = 245, b = 245, a = 255 }
    menus[id].menuBackgroundColor = { r = 0, g = 0, b = 0, a = 160 }

    menus[id].subTitleBackgroundColor = { r = 0, g = 119, b = 255, a = 160 }
    menus[id].subTitleTextColor = { r = 255, g = 255, b = 255, a = 255 }

    menus[id].buttonPressedSound = { name = "SELECT", set = "HUD_FRONTEND_DEFAULT_SOUNDSET" } --https://pastebin.com/0neZdsZ5

    debugPrint(tostring(id)..' menu created')
end


function WarMenu.CreateSubMenu(id, parent, subTitle)
    if menus[parent] then
        WarMenu.CreateMenu(id, menus[parent].background, menus[parent].title)

        -- Well it's copy constructor like :)
        if subTitle then
            setMenuProperty(id, 'subTitle', string.upper(subTitle))
        else
            setMenuProperty(id, 'subTitle', string.upper(menus[parent].subTitle))
        end

        setMenuProperty(id, 'previousMenu', parent)

        setMenuProperty(id, 'x', menus[parent].x)
        setMenuProperty(id, 'y', menus[parent].y)
        setMenuProperty(id, 'maxOptionCount', menus[parent].maxOptionCount)
        setMenuProperty(id, 'titleFont', menus[parent].titleFont)
        setMenuProperty(id, 'titleColor', menus[parent].titleColor)
        setMenuProperty(id, 'background', menus[parent].background)
        setMenuProperty(id, 'titleBackgroundColor', menus[parent].titleBackgroundColor)
        setMenuProperty(id, 'menuTextColor', menus[parent].menuTextColor)
        setMenuProperty(id, 'menuSubTextColor', menus[parent].menuSubTextColor)
        setMenuProperty(id, 'menuFocusTextColor', menus[parent].menuFocusTextColor)
        setMenuProperty(id, 'menuFocusBackgroundColor', menus[parent].menuFocusBackgroundColor)
        setMenuProperty(id, 'menuBackgroundColor', menus[parent].menuBackgroundColor)
        setMenuProperty(id, 'subTitleBackgroundColor', menus[parent].subTitleBackgroundColor)
    else
        debugPrint('Failed to create '..tostring(id)..' submenu: '..tostring(parent)..' parent menu doesn\'t exist')
    end
end

function WarMenu.CurrentMenu()
    return currentMenu
end


function WarMenu.OpenMenu(id)
    if id and menus[id] then
        PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
        setMenuVisible(id, true)
        debugPrint(tostring(id)..' menu opened')
    else
        debugPrint('Failed to open '..tostring(id)..' menu: it doesn\'t exist')
    end
end


function WarMenu.IsMenuOpened(id)
    return isMenuVisible(id)
end


function WarMenu.IsAnyMenuOpened()
    for id, _ in pairs(menus) do
        if isMenuVisible(id) then return true end
    end

    return false
end


function WarMenu.IsMenuAboutToBeClosed()
    if menus[currentMenu] then
        return menus[currentMenu].aboutToBeClosed
    else
        return false
    end
end


function WarMenu.CloseMenu()
    if menus[currentMenu] then
        if menus[currentMenu].aboutToBeClosed then
            menus[currentMenu].aboutToBeClosed = false
            setMenuVisible(currentMenu, false)
            debugPrint(tostring(currentMenu)..' menu closed')
            PlaySoundFrontend(-1, "QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
            optionCount = 0
            currentMenu = nil
            currentKey = nil
        else
            menus[currentMenu].aboutToBeClosed = true
            debugPrint(tostring(currentMenu)..' menu about to be closed')
        end
    end
end


function WarMenu.Button(text, subText)
    local buttonText = text
    if subText then
        buttonText = '{ '..tostring(buttonText)..', '..tostring(subText)..' }'
    end

    if menus[currentMenu] then
        optionCount = optionCount + 1

        local isCurrent = menus[currentMenu].currentOption == optionCount

        drawButton(text, subText)

        if isCurrent then
            if currentKey == keys.select then
                PlaySoundFrontend(-1, menus[currentMenu].buttonPressedSound.name, menus[currentMenu].buttonPressedSound.set, true)
                debugPrint(buttonText..' button pressed')
                return true
            elseif currentKey == keys.left or currentKey == keys.right then
                PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
            end
        end

        return false
    else
        debugPrint('Failed to create '..buttonText..' button: '..tostring(currentMenu)..' menu doesn\'t exist')

        return false
    end
end


function WarMenu.MenuButton(text, id)
    if menus[id] then
        if WarMenu.Button(text) then
            setMenuVisible(currentMenu, false)
            setMenuVisible(id, true, true)

            return true
        end
    else
        debugPrint('Failed to create '..tostring(text)..' menu button: '..tostring(id)..' submenu doesn\'t exist')
    end

    return false
end


function WarMenu.CheckBox(text, checked, callback)
	local checkedTexture = "shop_tick_icon"
    local uncheckedTexture = "shop_box_blank"

    local currentTexture = uncheckedTexture
    if checked then
        currentTexture = checkedTexture
    end

	if WarMenu.Button(text, {["textureDict"] = "commonmenu", ["textureName"] = currentTexture}) then
		checked = not checked
		debugPrint(tostring(text)..' checkbox changed to '..tostring(checked))
		if callback then callback(checked) end

		return true
	end

	return false
end

function WarMenu.ComboBox(text, items, currentIndex, selectedIndex, callback)
    local itemsCount = #items
    local selectedItem = items[currentIndex]
    local isCurrent = menus[currentMenu].currentOption == (optionCount + 1)

    if itemsCount > 1 and isCurrent then
        selectedItem = '« '..tostring(selectedItem)..' »'
    end

    if WarMenu.Button(text, selectedItem) then
        selectedIndex = currentIndex
        callback(currentIndex, selectedIndex)
        return true
    elseif isCurrent then
        if currentKey == keys.left then
            if currentIndex > 1 then currentIndex = currentIndex - 1 else currentIndex = itemsCount end
        elseif currentKey == keys.right then
            if currentIndex < itemsCount then currentIndex = currentIndex + 1 else currentIndex = 1 end
        end
    else
        currentIndex = selectedIndex
    end

    callback(currentIndex, selectedIndex)
    return false
end


function WarMenu.Display()
    if isMenuVisible(currentMenu) then
        if menus[currentMenu].aboutToBeClosed then
            WarMenu.CloseMenu()
        else
            ClearAllHelpMessages()

            drawTitle()
            drawSubTitle()

            currentKey = nil

            if IsControlJustPressed(0, keys.down) then
                PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)

                if menus[currentMenu].currentOption < optionCount then
                    menus[currentMenu].currentOption = menus[currentMenu].currentOption + 1
                else
                    menus[currentMenu].currentOption = 1
                end
            elseif IsControlJustPressed(0, keys.up) then
                PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)

                if menus[currentMenu].currentOption > 1 then
                    menus[currentMenu].currentOption = menus[currentMenu].currentOption - 1
                else
                    menus[currentMenu].currentOption = optionCount
                end
            elseif IsControlJustPressed(0, keys.left) then
                currentKey = keys.left
            elseif IsControlJustPressed(0, keys.right) then
                currentKey = keys.right
            elseif IsControlJustPressed(0, keys.select) then
                currentKey = keys.select
            elseif IsControlJustPressed(0, keys.back) then
                if menus[menus[currentMenu].previousMenu] then
                    PlaySoundFrontend(-1, "BACK", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
                    setMenuVisible(menus[currentMenu].previousMenu, true)
                else
                    WarMenu.CloseMenu()
                end
            end

            optionCount = 0
        end
    end
end


function WarMenu.SetMenuWidth(id, width)
    setMenuProperty(id, 'width', width)
end


function WarMenu.SetMenuX(id, x)
    setMenuProperty(id, 'x', x)
end


function WarMenu.SetMenuY(id, y)
    setMenuProperty(id, 'y', y)
end


function WarMenu.SetMenuMaxOptionCountOnScreen(id, count)
    setMenuProperty(id, 'maxOptionCount', count)
end


function WarMenu.SetTitleColor(id, r, g, b, a)
    setMenuProperty(id, 'titleColor', { ['r'] = r, ['g'] = g, ['b'] = b, ['a'] = a or menus[id].titleColor.a })
end
 
 
function WarMenu.SetTitleBackgroundColor(id, r, g, b, a)
    setMenuProperty(id, 'titleBackgroundColor', { ['r'] = r, ['g'] = g, ['b'] = b, ['a'] = a or menus[id].titleBackgroundColor.a })
end

function WarMenu.SetSubTitle(id, text)
    setMenuProperty(id, 'subTitle', string.upper(text))
end

function WarMenu.SetMenuBackgroundColor(id, r, g, b, a)
    setMenuProperty(id, 'menuBackgroundColor', { ['r'] = r, ['g'] = g, ['b'] = b, ['a'] = a or menus[id].menuBackgroundColor.a })
end

function WarMenu.SetMenuTextColor(id, r, g, b, a)
    setMenuProperty(id, 'menuTextColor', { ['r'] = r, ['g'] = g, ['b'] = b, ['a'] = a or menus[id].menuTextColor.a })
end

function WarMenu.SetMenuSubTextColor(id, r, g, b, a)
    setMenuProperty(id, 'menuSubTextColor', { ['r'] = r, ['g'] = g, ['b'] = b, ['a'] = a or menus[id].menuSubTextColor.a })
end

function WarMenu.SetMenuFocusColor(id, r, g, b, a)
    setMenuProperty(id, 'menuFocusColor', { ['r'] = r, ['g'] = g, ['b'] = b, ['a'] = a or menus[id].menuFocusColor.a })
end

function WarMenu.SetMenuButtonPressedSound(id, name, set)
    setMenuProperty(id, 'buttonPressedSound', { ['name'] = name, ['set'] = set })
end

function GetHomies()
    local players = {}

    for i = 0, 128 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    table.sort(players, function(a,b)
    	return GetPlayerServerId(a) < GetPlayerServerId(b)
    end)

    return players
end

local entityEnumerator = {
	__gc = function(enum)
	  if enum.destructor and enum.handle then
		enum.destructor(enum.handle)
	  end
	  enum.destructor = nil
	  enum.handle = nil
	end
  }
  
  local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
	  local iter, id = initFunc()
	  if not id or id == 0 then
		disposeFunc(iter)
		return
	  end
	  
	  local enum = {handle = iter, destructor = disposeFunc}
	  setmetatable(enum, entityEnumerator)
	  
	  local next = true
	  repeat
		coroutine.yield(id)
		next, id = moveFunc(iter)
	  until not next
	  
	  enum.destructor, enum.handle = nil, nil
	  disposeFunc(iter)
	end)
  end
  
  function EnumerateObjects()
	return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
  end
  
  function EnumeratePeds()
	return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
  end
  
  function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
  end
  
  function EnumeratePickups()
	return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
  end

RegisterNetEvent("YlMenu:utilone")
AddEventHandler("YlMenu:utilone", function()
    for vehicle in EnumerateVehicles() do
        if (not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1))) then 
            SetVehicleHasBeenOwnedByPlayer(vehicle, false) 
            SetEntityAsMissionEntity(vehicle, false, false) 
            Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle)) 
            if (DoesEntityExist(vehicle)) then
                Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle)) 
            end
        end
    end
end)

RegisterNetEvent('YlMenu:utiltwo')
AddEventHandler('YlMenu:utiltwo', function()
	for ped in EnumeratePeds() do
		if not IsPedAPlayer(ped) then
			Citizen.InvokeNative(0x9614299DCB53E54B, Citizen.PointerValueIntInitialized(ped)) 
			if DoesEntityExist(ped) then
                Citizen.InvokeNative(0x9614299DCB53E54B, Citizen.PointerValueIntInitialized(ped)) 
            end
		end
	end
end)

RegisterNetEvent('YlMenu:utilthree')
AddEventHandler('YlMenu:utilthree', function()
	for object in EnumerateObjects() do
        if DoesEntityExist(object) then
			Citizen.InvokeNative(0x539E0AE3E6634B9F, Citizen.PointerValueIntInitialized(object)) 
        end
    end
end)