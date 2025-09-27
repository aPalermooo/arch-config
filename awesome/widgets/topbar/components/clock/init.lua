local wibox = require("wibox")

local clock_component = {}

function clock_component.create_new(s)
    local time_display = wibox.widget.textclock("<span font=\"sans 13 \"> %I:%M %p </span>")  -- %p is lowercase am/pm
    return time_display
end

return clock_component
 