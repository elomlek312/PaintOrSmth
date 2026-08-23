local mouse = require "modules.core.mouse"
local debug = {}

debug.drawStats = false

function debug.switch()
    debug.drawStats = not debug.drawStats
end

function debug.draw()
    if debug.drawStats then
        local r, g, b, a = love.graphics.getColor()

        local fps = love.timer.getFPS()
        local mem = collectgarbage("count")
        local resx, resy = love.graphics.getWidth(), love.graphics.getHeight()
        local isMaximized = love.window.isMaximized()

        love.graphics.setColor(0, 0, 0, 0.5)
        love.graphics.rectangle("fill", 10, 10, 250, 400)
        love.graphics.setColor({ 1, 1, 1 })

        love.graphics.print(string.format("Fps: %d Memory: %dKb", fps, mem), 10, 20)
        love.graphics.print(string.format("Res: %dx%d Maximized? : %s", resx, resy, isMaximized), 10, 35)

        love.graphics.print(string.format("CanvasPos: %dx%d", ActiveCanvasOffset.x, ActiveCanvasOffset.y), 10, 65)

        love.graphics.print(string.format("MousePos = %dx%d", mouse.Pos.x, mouse.Pos.y), 10, 95)
        love.graphics.print(string.format("M1 IsDown = %s, State = %s", mouse.m1.IsDown, mouse.m1.State), 10, 110)
        love.graphics.print(string.format("M2 IsDown = %s, State = %s", mouse.m2.IsDown, mouse.m2.State), 10, 125)
        love.graphics.print(string.format("M3 IsDown = %s, State = %s", mouse.m3.IsDown, mouse.m3.State), 10, 140)

        love.graphics.setColor(r, g, b, a)
    end
end

return debug
