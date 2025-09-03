local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")

local clientkeys = require("bindings.client.keys")
local clientbuttons = require("bindings.client.mouse")

client.connect_signal("manage", function(c)
    if awesome.startup
       and not c.size_hints.user_position
       and not c.size_hints.program_position then
        awful.placement.no_offscreen(c)
    end
end)

awful.rules.rules = {
    {
        rule = { },
        properties = {
            keys = clientkeys,       -- client keyboard bindings
            buttons = clientbuttons,  -- client mouse bindings
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
        }
    },

    -- Normal/dialog clients get titlebars
    {
        rule_any = { 
            type = { "normal", "dialog" },
            -- class = { "Firefox" },
        },
        properties = { titlebars_enabled = true }
    }
}




client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
