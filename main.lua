local vector2 = require("modules.variables.vector2")
local canvas = require("modules.canvas")
local interface = require("modules.interface")
local debugStats = require("modules.debugStats")
local mouse      = require("modules.core.mouse")
local keyboard = require("modules.core.keyboard")
local buttons    = require("modules.buttons")
local setup      = require("modules.setup")

local windows = require("windows")


ActiveCanvas = nil
ActiveCanvasOffset = vector2.new()

function love.load()
    setup.begin()

    setup = nil
    package.loaded["modules.setup"] = nil
end

function love.update()
    mouse.update()  --update mouse clicks and coords
    buttons.update()
    canvas.update() --update canvas if drawn on
end

function love.draw()
    love.graphics.draw(ActiveCanvas, ActiveCanvasOffset.x, ActiveCanvasOffset.y, 0, canvas.settings.Zoom, canvas.settings.Zoom)
    interface.draw()
    debugStats.draw()
    --love.graphics.print("Memory: " .. tostring(collectgarbage("count")), 10, 30)
end


function love.resize(w, h)
    print(string.format("resize to: %i, %i", w, h))
    interface.updateActiveInterface()
end

function love.wheelmoved(x, y)
    if keyboard.keydown("lshift") then
        canvas.settings.Size = math.min(math.max(canvas.settings.Size + y, 1), 25)
    else
        local prevZoom = canvas.settings.Zoom

        canvas.settings.Zoom = math.min(
            math.max(prevZoom * (1.2 ^ y), 0.01),
            10
        )

        local prevX = canvas.settings.CanvasSize.x * prevZoom
        local prevY = canvas.settings.CanvasSize.y * prevZoom

        local nowX = canvas.settings.CanvasSize.x * canvas.settings.Zoom
        local nowY = canvas.settings.CanvasSize.y * canvas.settings.Zoom

        ActiveCanvasOffset.x = ActiveCanvasOffset.x - (nowX - prevX) * 0.5
        ActiveCanvasOffset.y = ActiveCanvasOffset.y - (nowY - prevY) * 0.5


    end
end
