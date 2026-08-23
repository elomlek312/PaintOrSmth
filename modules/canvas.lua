local vector2 = require("modules.variables.vector2")
local mouse   = require("modules.core.mouse")



local canvas = {}

canvas.settings = {
    CanvasSize = vector2.new(),
    CanvasColor = { 1, 1, 1 },
    Size = 10,
    ActiveColor = { 0, 0, 0 },
}

function canvas.createCanvas(size)
    local cnvs = love.graphics.newCanvas(size.x, size.y)
    canvas.settings.CanvasSize = vector2.new(size.x, size.y)
    return cnvs
end

function canvas.centerCanvas(cnvs)
    local prevCanvas = love.graphics.getCanvas() --makes sure that the canvas at the end stays the same
    local windowres = vector2.new(love.graphics.getWidth(), love.graphics.getHeight())

    love.graphics.setCanvas(cnvs)
    local w, h = love.graphics.getCanvas():getDimensions()
    local cnvsSize = vector2.new(w, h)
    local cnvsMiddle = cnvsSize:mul(0.5)

    ActiveCanvasOffset = windowres:mul(0.5):sub(cnvsMiddle) --see it works!

    love.graphics.setCanvas(prevCanvas)
end

function canvas.setActiveColor(newColor)
    canvas.settings.ActiveColor = newColor
end

local lastMousePos = vector2.new()

local function mouseMoveCanvas()
    if mouse.m3.State == "Click" then
        lastMousePos.x = mouse.Pos.x
        lastMousePos.y = mouse.Pos.y
        goto continue
    end

    local moveVec = mouse.Pos:sub(lastMousePos)

    ActiveCanvasOffset = ActiveCanvasOffset:add(moveVec)

    lastMousePos.x = mouse.Pos.x
    lastMousePos.y = mouse.Pos.y

    ::continue::
end

function canvas.fillWholeCanvas(cnvs)

    if not type(cnvs) == "userdata" then --not sure if thats needed
        return
    end

    local r, g, b, a = love.graphics.getColor()

    love.graphics.setColor(canvas.settings.ActiveColor)

    love.graphics.setCanvas(cnvs)

    love.graphics.rectangle("fill", 0, 0, canvas.settings.CanvasSize.x, canvas.settings.CanvasSize.y)

    love.graphics.setColor(r, g, b, a)
    love.graphics.setCanvas()
end

function canvas.drawPen(cnvs)
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setCanvas(cnvs)

    if mouse.m1.State == "Click" then
        lastMousePos = nil
    end

    love.graphics.setColor(canvas.settings.ActiveColor)

    local canvasMousePos = mouse.Pos:sub(ActiveCanvasOffset) --dont touch it its very much calculated

    if not lastMousePos then
        love.graphics.circle("fill", canvasMousePos.x, canvasMousePos.y, 1)
    else
        local canvasLastMousePos = lastMousePos:sub(ActiveCanvasOffset) --fuck yeah it works!!!
        love.graphics.setLineWidth(1)
        love.graphics.line(canvasMousePos.x, canvasMousePos.y, canvasLastMousePos.x, canvasLastMousePos.y)
    end

    lastMousePos = vector2.new(mouse.Pos.x, mouse.Pos.y)

    love.graphics.setCanvas()
    love.graphics.setColor(r, g, b, a)
end

function canvas.update()
    if mouse.m1.IsDown then
        canvas.drawPen(ActiveCanvas)
    end

    if mouse.m2.IsDown then

    end

    if mouse.m3.IsDown then
        mouseMoveCanvas()
    end
end

return canvas
