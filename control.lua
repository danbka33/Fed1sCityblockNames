--[[ Copyright (c) 2022 danbka33
 * Part of Fed1sCityblockNames
 *
 * See LICENSE.md in the project directory for license information.
--]]

local mod_gui = require("mod-gui")

require "script.constants"
require "script.settings"

script.on_event(defines.events.on_gui_click, function(event)
    local player = game.players[event.player_index]

    local cityBlockOffsetX = start_offset_x;
    local cityBlockOffsetY = start_offset_y;
    local serviceOffsetXSector = 32 * 2 + 14;
    local serviceOffsetYSector = 23;
    local stationOffsetXSector = 32 * 2 + 8;
    local stationOffsetYSector = 39;
    local stationOffsetYSectorPlus = 10;

    local serviceOffsetXSectorBottom = 49;
    local serviceOffsetYSectorBottom = 233;
    local stationOffsetXSectorBottom = 55;
    local stationOffsetYSectorBottom = 217;
    local stationOffsetYSectorPlusBottom = -10;

    local rightServiceOffsetX = 233;
    local rightServiceOffsetY = 143;
    local rightStationOffsetXSector = 217;
    local rightStationOffsetYSector = 137;
    local rightStationOffsetXSectorPlus = -10;

    local leftServiceOffsetX = 23;
    local leftServiceOffsetY = 113;
    local leftStationOffsetXSector = 39;
    local leftStationOffsetYSector = 119;
    local leftStationOffsetXSectorPlus = 10;

    if event.element.name == GUI_BUTTON then
        game.print("Search start. X offset: " .. cityBlockOffsetX .. ", Y offset: " .. cityBlockOffsetY .. ". Zero city block: " .. start_cityblock_x .. ", " .. start_cityblock_y)
        if (debug_log) then
            log("search...")
        end
        local foundCount = 0;

        for xCityBlock = -100, 100 do
            for yCityBlock = -100, 100 do
                local xPos = xCityBlock * 32 * 8 + cityBlockOffsetX;
                local yPos = yCityBlock * 32 * 8 + cityBlockOffsetY;

                local blockX = xCityBlock + start_cityblock_x
                local blockY = yCityBlock + start_cityblock_y

                local rightStations = player.surface.find_entities_filtered {
                    position = { xPos + rightServiceOffsetX, yPos + rightServiceOffsetY },
                    radius = 5,
                    name = { "train-stop", "logistic-train-stop" }
                }

                for _, rightStation in pairs(rightStations) do
                    if rightStation.valid then
                        if (rightStation and not string.match(string.lower(rightStation.backer_name), "grid")) then
                            local newStationName = "[" .. string.format("%02d", blockX) .. "-" .. string.format("%02d", blockY) .. "-" .. "R0" .. "]" .. rightStation.backer_name:gsub("^(%[.+%])( .+)$", "%2")
                            if (debug_log) then
                                log('Found service station: ' .. rightStation.backer_name .. "Sector: R, Pos: " .. rightStation.position.x .. ", " .. rightStation.position.y .. ". Block: " .. blockX .. ", " .. blockY)
                                log(newStationName)
                            end
                            rightStation.backer_name = newStationName
                            foundCount = foundCount + 1
                        end
                    end
                end

                for stationNumber = 1, 4 do
                    local stations = player.surface.find_entities_filtered {
                        position = { xPos + rightStationOffsetXSector + rightStationOffsetXSectorPlus * (stationNumber - 1), yPos + rightStationOffsetYSector },
                        radius = 5,
                        name = { "train-stop", "logistic-train-stop" }
                    }

                    for _, station in pairs(stations) do
                        if station.valid then
                            if (station and not string.match(string.lower(station.backer_name), "grid")) then
                                local newStationName = "[" .. string.format("%02d", blockX) .. "-" .. string.format("%02d", blockY) .. "-" .. 'R' .. stationNumber .. "]" .. station.backer_name:gsub("^(%[.+%])( .+)$", "%2")
                                if (debug_log) then
                                    log('Found station ' .. stationNumber .. ': ' .. station.backer_name .. ". Sector: R, Pos: " .. station.position.x .. ", " .. station.position.y)
                                    log(newStationName)
                                end
                                station.backer_name = newStationName
                                foundCount = foundCount + 1
                            end
                        end
                    end
                end

                local leftStations = player.surface.find_entities_filtered {
                    position = { xPos + leftServiceOffsetX, yPos + leftServiceOffsetY },
                    radius = 5,
                    name = { "train-stop", "logistic-train-stop" }
                }

                for _, leftStation in pairs(leftStations) do
                    if leftStation.valid then
                        if (leftStation and not string.match(string.lower(leftStation.backer_name), "grid")) then
                            local newStationName = "[" .. string.format("%02d", blockX) .. "-" .. string.format("%02d", blockY) .. "-" .. "L0" .. "]" .. leftStation.backer_name:gsub("^(%[.+%])( .+)$", "%2")
                            if (debug_log) then
                                log('Found service station: ' .. leftStation.backer_name .. "Sector: L, Pos: " .. leftStation.position.x .. ", " .. leftStation.position.y)
                                log(newStationName)
                            end
                            leftStation.backer_name = newStationName
                            foundCount = foundCount + 1
                        end
                    end
                end

                for stationNumber = 1, 4 do
                    local stations = player.surface.find_entities_filtered {
                        position = { xPos + leftStationOffsetXSector + leftStationOffsetXSectorPlus * (stationNumber - 1), yPos + leftStationOffsetYSector },
                        radius = 5,
                        name = { "train-stop", "logistic-train-stop" }
                    }

                    for _, station in pairs(stations) do
                        if station.valid then
                            if (station and not string.match(string.lower(station.backer_name), "grid")) then
                                local newStationName = "[" .. string.format("%02d", blockX) .. "-" .. string.format("%02d", blockY) .. "-" .. 'L' .. stationNumber .. "]" .. station.backer_name:gsub("^(%[.+%])( .+)$", "%2")
                                if (debug_log) then
                                    log('Found station ' .. stationNumber .. ': ' .. station.backer_name .. ". Sector: L, Pos: " .. station.position.x .. ", " .. station.position.y)
                                    log(newStationName)
                                end
                                station.backer_name = newStationName
                                foundCount = foundCount + 1
                            end
                        end
                    end
                end

                local sectors = { "A", "B", "C" }
                for sector = 1, 3 do

                    local serviceStations = player.surface.find_entities_filtered {
                        position = { xPos + serviceOffsetXSector + ((sector - 1) * 64), yPos + serviceOffsetYSector },
                        radius = 5,
                        name = { "train-stop", "logistic-train-stop" }
                    }

                    for _, stationService in pairs(serviceStations) do
                        if stationService.valid then
                            if (stationService and not string.match(string.lower(stationService.backer_name), "grid")) then
                                local newStationName = "[" .. string.format("%02d", blockX) .. "-" .. string.format("%02d", blockY) .. "-" .. sectors[sector] .. "0" .. "]" .. stationService.backer_name:gsub("^(%[.+%])( .+)$", "%2")
                                if (debug_log) then
                                    log('Found service station: ' .. stationService.backer_name .. ". Sector: " .. sector .. " Pos: " .. stationService.position.x .. ", " .. stationService.position.y)
                                    log(newStationName)
                                end
                                stationService.backer_name = newStationName
                                foundCount = foundCount + 1
                            end
                        end
                    end

                    for stationNumber = 1, 4 do
                        local stations = player.surface.find_entities_filtered {
                            position = { xPos + stationOffsetXSector + ((sector - 1) * 64), yPos + stationOffsetYSector + stationOffsetYSectorPlus * (stationNumber - 1) },
                            radius = 5,
                            name = { "train-stop", "logistic-train-stop" }
                        }

                        for _, station in pairs(stations) do
                            if station.valid then
                                if (station and not string.match(string.lower(station.backer_name), "grid")) then
                                    local newStationName = "[" .. string.format("%02d", blockX) .. "-" .. string.format("%02d", blockY) .. "-" .. sectors[sector] .. stationNumber .. "]" .. station.backer_name:gsub("^(%[.+%])( .+)$", "%2")
                                    if (debug_log) then
                                        log('Found station ' .. stationNumber .. ': ' .. station.backer_name .. ". Sector: " .. sector .. " Pos: " .. station.position.x .. ", " .. station.position.y)
                                        log(newStationName)
                                    end
                                    station.backer_name = newStationName
                                    foundCount = foundCount + 1
                                end
                            end
                        end
                    end

                end

                sectors = { "D", "E", "F" }
                for sector = 1, 3 do

                    local serviceStations = player.surface.find_entities_filtered {
                        position = { xPos + serviceOffsetXSectorBottom + ((sector - 1) * 64), yPos + serviceOffsetYSectorBottom },
                        radius = 5,
                        name = { "train-stop", "logistic-train-stop" }
                    }

                    for _, stationService in pairs(serviceStations) do
                        if stationService.valid then
                            if (stationService and not string.match(string.lower(stationService.backer_name), "grid")) then
                                local newStationName = "[" .. string.format("%02d", blockX) .. "-" .. string.format("%02d", blockY) .. "-" .. sectors[sector] .. "0" .. "]" .. stationService.backer_name:gsub("^(%[.+%])( .+)$", "%2")
                                if (debug_log) then
                                    log('Found service station: ' .. stationService.backer_name .. ". Sector: " .. (sector + 3) .. " Pos: " .. stationService.position.x .. ", " .. stationService.position.y)
                                    log(newStationName)
                                end
                                stationService.backer_name = newStationName
                                foundCount = foundCount + 1
                            end
                        end
                    end

                    for stationNumber = 1, 4 do
                        local stations = player.surface.find_entities_filtered {
                            position = { xPos + stationOffsetXSectorBottom + ((sector - 1) * 64), yPos + stationOffsetYSectorBottom + stationOffsetYSectorPlusBottom * (stationNumber - 1) },
                            radius = 5,
                            name = { "train-stop", "logistic-train-stop" }
                        }

                        for _, station in pairs(stations) do
                            if station.valid then
                                if (station and not string.match(string.lower(station.backer_name), "grid")) then

                                    local newStationName = "[" .. string.format("%02d", blockX) .. "-" .. string.format("%02d", blockY) .. "-" .. sectors[sector] .. stationNumber .. "]" .. station.backer_name:gsub("^(%[.+%])( .+)$", "%2")
                                    if (debug_log) then
                                        log('Found station ' .. stationNumber .. ': ' .. station.backer_name .. ". Sector: " .. (sector + 3) .. " Pos: " .. station.position.x .. ", " .. station.position.y)
                                        log(newStationName)
                                    end

                                    station.backer_name = newStationName
                                    foundCount = foundCount + 1
                                end
                            end
                        end
                    end

                end


            end
        end

        game.print("Search end. Stations processed: " .. foundCount)
        if (debug_log) then
            log("search end")
        end

    end
end)

function get_le_flow(player)

    local button_flow = mod_gui.get_button_flow(player)
    local flow = button_flow.le_flow
    if not flow then
        flow = button_flow.add {
            type = "flow",
            name = "le_flow",
            direction = "horizontal"
        }
    end
    return flow
end

function add_top_button(player)

    if player.gui.top.le_flow then
        player.gui.top.le_flow.destroy()
    end -- remove the old flow

    local flow = get_le_flow(player)

    if flow[GUI_BUTTON] then
        flow[GUI_BUTTON].destroy()
    end
    flow.add {
        type = "sprite-button",
        name = GUI_BUTTON,
        sprite = "item/train-stop",
        style = mod_gui.button_style,
        tooltip = { "fcbn_tooltip" }
    }
end

script.on_event(defines.events.on_player_created, function(event)
    local player = game.players[event.player_index]
    add_top_button(player)
end)

script.on_init(function()
    for _, player in pairs(game.players) do
        add_top_button(player)
    end
end)