local top = require("signals.client.titlebars.top")
local left = require("signals.client.titlebars.left")


client.connect_signal("request::titlebars", function(c)

    if c.type == "normal" 
        or c.type == "dialog" 
    then
        top.create(c)
        left.create(c)
    end


end)