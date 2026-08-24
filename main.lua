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
    -- local path = windows.openFileDialog()

    -- if path then
    --     print("Selected:", path)
    -- else
    --     print("Cancelled")
    -- end

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
