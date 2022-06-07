--[[ Copyright (c) 2022 danbka33
 * Part of Fed1sCityblockNames
 *
 * See LICENSE.md in the project directory for license information.
--]]

data:extend({
    {
        type = "int-setting",
        name = "fcbn-x",
        order = "ab",
        setting_type = "runtime-global",
        default_value = 0,
        minimum_value = -40000,
        maximum_value = 40000,
    },
    {
        type = "int-setting",
        name = "fcbn-y",
        order = "ab",
        setting_type = "runtime-global",
        default_value = 0,
        minimum_value = -40000,
        maximum_value = 40000,
    },
    {
        type = "int-setting",
        name = "fcbn-cityblock-x",
        order = "ab",
        setting_type = "runtime-global",
        default_value = 10,
        minimum_value = -40000,
        maximum_value = 40000,
    },
    {
        type = "int-setting",
        name = "fcbn-cityblock-y",
        order = "ab",
        setting_type = "runtime-global",
        default_value = 10,
        minimum_value = -40000,
        maximum_value = 40000,
    },
    {
        type = "bool-setting",
        name = "fcbn-debug-logfile",
        order = "ah",
        setting_type = "runtime-global",
        default_value = false
    },
})