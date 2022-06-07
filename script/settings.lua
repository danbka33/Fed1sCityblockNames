--[[ Copyright (c) 2022 danbka33
 * Part of Fed1sCityblockNames
 *
 * See LICENSE.md in the project directory for license information.
--]]

debug_log = settings.global["fcbn-debug-logfile"].value

start_offset_x = settings.global["fcbn-x"].value
start_offset_y = settings.global["fcbn-y"].value

start_cityblock_x = settings.global["fcbn-cityblock-x"].value
start_cityblock_y = settings.global["fcbn-cityblock-y"].value

script.on_event(defines.events.on_runtime_mod_setting_changed, function(event)
    if not event then return end

    if event.setting == "fcbn-debug-logfile" then
        debug_log = settings.global["fcbn-debug-logfile"].value
    end
    if event.setting == "fcbn-x" then
        start_offset_x = settings.global["fcbn-x"].value
    end
    if event.setting == "fcbn-y" then
        start_offset_y = settings.global["fcbn-y"].value
    end
    if event.setting == "fcbn-cityblock-x" then
        start_cityblock_x = settings.global["fcbn-cityblock-x"].value
    end
    if event.setting == "fcbn-cityblock-y" then
        start_cityblock_y = settings.global["fcbn-cityblock-y"].value
    end
end)
