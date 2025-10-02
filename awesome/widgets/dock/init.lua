-- Imports
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")

local xresources = require ("beautiful.xresources")
local dpi = xresources.apply_dpi

awful.screen.connect_for_each_screen( function(s)

    -- Screen Dimesnion dependent geometry
    local screen_width = s.geometry.width
    local screen_height = s.geometry.height

    local bar_width = screen_width * 0.75
    local bar_height = screen_height * 0.04

    local bar_spacing = dpi(10)

    -- Construct Widget
    s.dock = awful.wibar({
        
        width = bar_width,
        height = bar_height,
        position = "bottom", -- R 
        type = "dock", -- R
        ontop = true,
        screen = s,
        shape = function (cr, width, height)
            gears.shape.rectangle(cr,width,height)
        end,
        bg = "#101314FF", -- R
    })

    local tasklist_component = require("widgets.dock.components.tasklist")

    local tasklist = tasklist_component.create_new(s)

    -- Arrange Children on Widget
    s.dock:setup {
        { -- Left
            layout = wibox.layout.fixed.horizontal,
        },
        { -- Middle
            { -- Wrap Textbox
                widget = wibox.container.place,
                valign = "center",
                s.mytasklist,
            },
            layout = wibox.layout.fixed.horizontal,
        },
        { -- Right
            layout = wibox.layout.fixed.horizontal,
        },
        layout = wibox.layout.align.horizontal,
    }

        awful.screen.padding(s, { bottom = bar_height })
end)