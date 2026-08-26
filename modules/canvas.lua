local vector2    = require("modules.variables.vector2")
local mouse      = require("modules.core.mouse")
local tableUtils = require("modules.tableUtils")



local canvas = {}

canvas.settings = {
    DrawMode = "Pencil",
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

--########################

function canvas.newCanvas()
    ActiveCanvas = canvas.createCanvas(vector2.new(800, 500))
    canvas.centerCanvas(ActiveCanvas)

    local prevColors = tableUtils.copyTable(canvas.settings.ActiveColor)
    canvas.settings.ActiveColor = canvas.settings.CanvasColor

    canvas.fillWholeCanvas(ActiveCanvas)

    canvas.settings.ActiveColor = prevColors
end

-- function canvas.openFilePath(path)
--     --local sucess, tempImg = pcall(love.graphics.newImage, path)
--     local file = love.filesystem.newFileData(
--         path
--     )

--     local imageData = love.image.newImageData(file)
--     local tempImg = love.graphics.newImage(imageData)
--     if true then
--         local w, h = tempImg:getWidth(), tempImg:getHeight()
--         tableUtils.clearTable(ActiveCanvas)
--         ActiveCanvas = canvas.createCanvas(vector2.new(w, h))

--         love.graphics.setCanvas(ActiveCanvas)
--         love.graphics.draw(tempImg)
--         love.graphics.setCanvas()
--     else
--         print(tempImg)
--     end
-- end

function canvas.openFilePath(path)
    local file, err = io.open(path, "rb")
    if not file then
        return nil, err
    end

    local bytes = file:read("*a")
    file:close()

    local fileData = love.filesystem.newFileData(bytes, path)
    local imageData = love.image.newImageData(fileData)

    local tempImg, erro = love.graphics.newImage(imageData)

    if tempImg then
        local w, h = tempImg:getWidth(), tempImg:getHeight()

        ActiveCanvas = canvas.createCanvas(vector2.new(w, h))
        canvas.centerCanvas(ActiveCanvas)

        love.graphics.setCanvas(ActiveCanvas)
        love.graphics.draw(tempImg)
        love.graphics.setCanvas()
    else
        print("Error: " .. erro)
    end
end

--#######################

local lastMousePos = vector2.new()

local function mouseMoveCanvas()
    if mouse.m3.State == "Click" then
        lastMousePos.x = mouse.Pos.x
        lastMousePos.y = mouse.Pos.y
        goto continue
    end

    -- local moveVec = mouse.Pos:sub(lastMousePos)

    ActiveCanvasOffset = ActiveCanvasOffset:add(mouse.Pos:sub(lastMousePos))

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

local draw = {}

function draw.Pencil(cnvs)
    if mouse.m1.State == "Click" then
        lastMousePos = nil
    end

    if lastMousePos and not mouse.Moving then
        return
    end

    local r, g, b, a = love.graphics.getColor()
    love.graphics.setCanvas(cnvs)


    love.graphics.setColor(canvas.settings.ActiveColor)

    --local canvasMousePos = mouse.Pos:sub(ActiveCanvasOffset) --dont touch it its very much calculated

    if not lastMousePos then
        local canvasMousePos = mouse.Pos:sub(ActiveCanvasOffset)

        love.graphics.circle("fill", canvasMousePos.x, canvasMousePos.y, 1)
    elseif mouse.Moving then
        local canvasMousePos = mouse.Pos:sub(ActiveCanvasOffset)

        local canvasLastMousePos = lastMousePos:sub(ActiveCanvasOffset) --fuck yeah it works!!!
        love.graphics.setLineWidth(1)
        love.graphics.line(canvasMousePos.x, canvasMousePos.y, canvasLastMousePos.x, canvasLastMousePos.y)
    end

    lastMousePos = vector2.new(mouse.Pos.x, mouse.Pos.y)

    love.graphics.setCanvas()
    love.graphics.setColor(r, g, b, a)
end

function draw.Brush(cnvs)
    if mouse.m1.State == "Click" then
        lastMousePos = nil
    end

    if lastMousePos and not mouse.Moving then
        return
    end

    local r, g, b, a = love.graphics.getColor()
    love.graphics.setCanvas(cnvs)


    love.graphics.setColor(canvas.settings.ActiveColor)

    --local canvasMousePos = mouse.Pos:sub(ActiveCanvasOffset) --dont touch it its very much calculated

    if not lastMousePos then
        local canvasMousePos = mouse.Pos:sub(ActiveCanvasOffset)

        love.graphics.circle("fill", canvasMousePos.x, canvasMousePos.y, canvas.settings.Size * 0.5)
    elseif mouse.Moving then
        local canvasMousePos = mouse.Pos:sub(ActiveCanvasOffset)

        local canvasLastMousePos = lastMousePos:sub(ActiveCanvasOffset) --fuck yeah it works!!!
        love.graphics.setLineWidth(canvas.settings.Size)
        love.graphics.line(canvasMousePos.x, canvasMousePos.y, canvasLastMousePos.x, canvasLastMousePos.y)
    end

    lastMousePos = vector2.new(mouse.Pos.x, mouse.Pos.y)

    love.graphics.setCanvas()
    love.graphics.setColor(r, g, b, a)
end

function canvas.update()
    if mouse.m1.IsDown then
        draw[canvas.settings.DrawMode](ActiveCanvas)
    end

    if mouse.m2.IsDown then

    end

    if mouse.m3.IsDown then
        mouseMoveCanvas()
    end
end

return canvas
