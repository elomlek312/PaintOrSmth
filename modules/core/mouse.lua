local vector2 = require "modules.variables.vector2"

local mouse = {}

mouse.Pos = vector2.new()
mouse.m1 = {
    State = "Idle",
    IsDown = false
}
mouse.m2 = {
    State = "Idle",
    IsDown = false
}
mouse.m3 = {
    State = "Idle",
    IsDown = false
}

function mouse.update()
    for i = 1, 3 do                         --update mouse clicks
        local m = mouse["m" .. tostring(i)] --current mouse button
        local down = love.mouse.isDown(i)   -- bool

        m.IsDown = down

        if down then
            if m.State == "Idle" then
                m.State = "Click"
            else
                m.State = "Continous"
            end
        else
            if m.State ~= "Idle" and m.State ~= "JustEnded" then
                m.State = "JustEnded"
            else
                m.State = "Idle"
            end
        end
    end

    mouse.Pos.x = love.mouse.getX()
    mouse.Pos.y = love.mouse.getY()
end

return mouse
