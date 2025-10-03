local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local M = {}

-- icon directory
local icon_dir = "/home/cinnamon/.config/awesome/theme/icons/candy-icons-master/apps/scalable/"

function M.create_new(s)

    local tasklist_buttons = gears.table.join(
        awful.button({}, 1, function(c)
            if c == client.focus then
                c.minimized = true
            else
                c:emit_signal("request::activate", "tasklist", { raise = true })
            end
        end),
        awful.button({}, 3, function()
            awful.menu.client_list { theme = { width = 250 } }
        end),
        awful.button({}, 4, function() awful.client.focus.byidx(-1) end),
        awful.button({}, 5, function() awful.client.focus.byidx(1) end)
    )

    s.mytasklist = awful.widget.tasklist {
        screen   = s,
        filter   = awful.widget.tasklist.filter.currenttags,
        buttons  = tasklist_buttons,
        layout   = {
            spacing = 5,
            layout  = wibox.layout.fixed.horizontal,
        },
        widget_template = {
                {
                wibox.widget.base.make_widget(),
                forced_height = 5,
                forced_width = 50,
                id            = 'background_role',
                widget        = wibox.container.background,
            },
            {
                {
                    {
                        id     = 'clienticon',
                        widget = awful.widget.clienticon,
                    },
                    widget = wibox.container.place,
                },
            margins = 5,
            widget  = wibox.container.margin
        },
        nil,
        create_callback = function(self, c, index, objects) --luacheck: no unused args
            self:get_children_by_id('clienticon')[1].client = c
        end,
        layout = wibox.layout.align.vertical,
    },
    }

    return s.mytasklist
end

return M
