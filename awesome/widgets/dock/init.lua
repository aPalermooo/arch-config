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

    local tasklist_buttons = gears.table.join(
        awful.button({}, 1, function(c) -- left click
            if c == client.focus then
                c.minimized = true
            else
                c:emit_signal("request::activate", "tasklist", { raise = true })
        end
            -- c:activate { } -- context = "tasklist", action = "toggle_minimization" }
            -- optional: emit a custom signal if you want others to listen
            -- if s and s.mytasklist then s.mytasklist:emit_signal("custom::release", c) end
        end),
        awful.button({}, 3, function() -- right click
            awful.menu.client_list { theme = { width = 250 } }
        end),
        awful.button({}, 4, function() awful.client.focus.byidx(-1) end),
        awful.button({}, 5, function() awful.client.focus.byidx( 1) end)
    )

    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
        -- {
        --     -- awful.button({ }, 1, function () end),
        --     -- awful.button({ }, 3, function() end),
        --     -- awful.button({ }, 4, function() end),
        --     -- awful.button({ }, 5, function() end),
        -- }
    }


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