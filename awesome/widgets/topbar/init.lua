-- Imports
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi 

awful.screen.connect_for_each_screen( function(s)

    -- Screen Dimension dependent geometry 
    local screen_width = s.geometry.width
    local screen_height = s.geometry.height

    local bar_width = screen_width
    local bar_height = screen_height * 0.025

    -- construct widget
    s.topbar = awful.wibar({
        -- TODO: refactor attributes to theme.lua
        width = bar_width,
        height = bar_height,
        position = "top", -- R 
        type = "dock", -- R
        ontop = true,
        screen = s,
        shape = function (cr, width, height)
            gears.shape.rectangle(cr,width,height)
        end,
        bg = "#101314", -- R
        -- bg_dark: 1c2224
    })

    local clock_component = require("widgets/topbar/components/clock")


    clock = clock_component.create_new(s)

    s.topbar:setup {
        layout = wibox.layout.align.horizontal,
        spacing = dpi(10),
        expand = "none",
        { --Left
            layout = wibox.layout.align.horizontal,
        },
        { -- Middle 
            layout = wibox.layout.align.horizontal,
        },
        { -- Right
            clock,
            layout = wibox.layout.align.horizontal,
        },
    }
end)