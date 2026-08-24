local vector2 = require("modules.variables.vector2")
local canvas = require("modules.canvas")
local interface = require("modules.interface")
local extra     = require("modules.extra")
local debugStats = require("modules.debugStats")
local mouse      = require("modules.core.mouse")
local keyboard = require("modules.core.keyboard")
local buttons    = require("modules.buttons")

local windows = require("windows")


ActiveCanvas = nil
ActiveCanvasOffset = vector2.new()

function love.load()
    --print("loaded")

    -- local path = windows.openFileDialog()

    -- if path then
    --     print("Selected:", path)
    -- else
    --     print("Cancelled")
    -- end

    ActiveCanvas = canvas.createCanvas(vector2.new(500, 500))
    canvas.centerCanvas(ActiveCanvas)
    --canvas.setActiveColor({ 1, 0, 0 })
    love.graphics.setBackgroundColor({ 0.7, 0.7, 0.7 })
    canvas.setActiveColor({ 1, 1, 1 })
    canvas.fillWholeCanvas(ActiveCanvas)
    canvas.setActiveColor({ 0, 0, 0 })

    buttons.addButton(vector2.new(100, 100), vector2.new(100, 100), nil)

    keyboard.bindToActions(">!<lshift>!<f", function ()
        canvas.fillWholeCanvas(ActiveCanvas)
    end)

    keyboard.bindToActions(">!<f12", function ()
        debugStats.switch()
    end)

    keyboard.bindToActions(">!<c", function ()
        collectgarbage("collect")
    end)

    keyboard.bindToActions(">!<f", function()
        canvas.setActiveColor({ 1, 1, 1 })
        canvas.fillWholeCanvas(ActiveCanvas)
        canvas.setActiveColor({ 0, 0, 0 })
    end)
end

function love.update()
    mouse.update()  --update mouse clicks and coords
    buttons.update()
    canvas.update() --update canvas if drawn on
end

function love.draw()
    love.graphics.draw(ActiveCanvas, ActiveCanvasOffset.x, ActiveCanvasOffset.y)
    interface.draw()
    debugStats.draw()
    --love.graphics.print("Memory: " .. tostring(collectgarbage("count")), 10, 30)
end

-- function love.keypressed(key)
--     if key == "escape" then
--         love.event.quit()
--     elseif key == "f12" then
--         debugStats.switch()
--     elseif key == "f" then
--         canvas.fillWholeCanvas(ActiveCanvas)
--     elseif key == "c" then
--         collectgarbage("collect")
--     elseif key == "up" then
--         ActiveCanvasOffset.y = ActiveCanvasOffset.y - 50
--     elseif key == "down" then
--         ActiveCanvasOffset.y = ActiveCanvasOffset.y + 50
--     elseif key == "left" then
--         ActiveCanvasOffset.x = ActiveCanvasOffset.x - 50
--     elseif key == "right" then
--         ActiveCanvasOffset.x = ActiveCanvasOffset.x + 50
--     elseif key == "1" then
--         canvas.setActiveColor({ 0, 0, 0 })
--     elseif key == "2" then
--         canvas.setActiveColor({ 1, 0, 0 })
--     elseif key == "3" then
--         canvas.setActiveColor({ 1, 1, 1 })
--     end
-- end

function love.resize(w, h)
    print(string.format("resize to: %i, %i", w, h))
    interface.updateActiveInterface()
end
