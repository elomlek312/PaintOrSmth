local keyboard = require "modules.core.keyboard"
local canvas   = require "modules.canvas"
local debugStats = require "modules.debugStats"
local vector2    = require "modules.variables.vector2"
local interface  = require "modules.interface"
local interfaceData = require "modules.data.interfaceData"

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

    keyboard.bindToActions(">!<a", function ()
        interface.addToActiveInterfaces("newFileWindow" ,interfaceData.newFileWindow, "last")
        interface.updateActiveInterface()
    end)

    --########### INTERFACE

    interface.addToActiveInterfaces("Main", interfaceData.Main)
    interface.updateActiveInterface()
end

return setup
