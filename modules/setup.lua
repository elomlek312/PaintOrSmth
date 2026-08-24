local keyboard = require "modules.core.keyboard"
local canvas   = require "modules.canvas"
local debugStats = require "modules.debugStats"
local vector2    = require "modules.variables.vector2"

local setup = {}

function setup.begin()
    --########### GENERAL

    ActiveCanvas = canvas.createCanvas(vector2.new(500, 500))
    canvas.centerCanvas(ActiveCanvas)
    --canvas.setActiveColor({ 1, 0, 0 })
    love.graphics.setBackgroundColor({ 0.7, 0.7, 0.7 })
    canvas.setActiveColor({ 1, 1, 1 })
    canvas.fillWholeCanvas(ActiveCanvas)
    canvas.setActiveColor({ 0, 0, 0 })

    --########## KEYBINDS

    keyboard.bindToActions(">!<lshift>!<f", function ()
        canvas.setActiveColor({ 1, 1, 1 })
        canvas.fillWholeCanvas(ActiveCanvas)
        canvas.setActiveColor({ 0, 0, 0 })
    end)

    keyboard.bindToActions(">!<f12", function ()
        debugStats.switch()
    end)

    keyboard.bindToActions(">!<c", function ()
        collectgarbage("collect")
    end)
end

return setup
