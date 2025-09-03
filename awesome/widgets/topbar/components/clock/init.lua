local wibox = require("wibox")

local clock_component = {}

function clock_component.create_new(s)
    local time_display = wibox.widget.textclock('%I:%M %p')  -- %p is lowercase am/pm
    return time_display
end

return clock_component
