local vector2    = require("modules.variables.vector2")
local mouse      = require("modules.core.mouse")
local tableUtils = require("modules.tableUtils")



local canvas = {}

canvas.settings = {
    Zoom = 1,
    DrawMode = "Pencil",
    CanvasSize = vector2.new(),
    CanvasColor = { 1, 1, 1 },
    Size = 10,
    ActiveColor = { 0, 0, 0 },
}

function canvas.createCanvas(size)
    local cnvs = love.graphics.newCanvas(size.x, size.y)

    canvas.settings.CanvasSize.x = size.x
    canvas.settings.CanvasSize.y = size.y

    return cnvs
end

function canvas.centerCanvas(cnvs)
    local prevCanvas = love.graphics.getCanvas() --makes sure that the canvas at the end stays the same

    local windowResX = love.graphics.getWidth()
    local windowresY = love.graphics.getHeight()

    love.graphics.setCanvas(cnvs)
    local cnvsSizeX, cnvsSizeY = love.graphics.getCanvas():getDimensions()

    ActiveCanvasOffset.x = (windowResX - cnvsSizeX) * 0.5
    ActiveCanvasOffset.y = (windowresY - cnvsSizeY) * 0.5

    love.graphics.setCanvas(prevCanvas)
end

function canvas.setActiveColor(newColor)
    canvas.settings.ActiveColor = newColor
end



function canvas.newCanvas(xSize, ySize)
    if ActiveCanvas then
        ActiveCanvas:release()
        ActiveCanvas = nil
    end

    ActiveCanvas = canvas.createCanvas(vector2.new(xSize, ySize))
    canvas.settings.Zoom = 1
    canvas.centerCanvas(ActiveCanvas)

    local prevColors = tableUtils.copyTable(canvas.settings.ActiveColor)
    canvas.settings.ActiveColor = canvas.settings.CanvasColor

    canvas.fillWholeCanvas(ActiveCanvas)

    canvas.settings.ActiveColor = prevColors
end


function canvas.getSetting(setting)
    return canvas.settings[setting]
end

--########################

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

    if not tempImg then
        print("Error: " .. erro)
        return
    end

    local w, h = tempImg:getWidth(), tempImg:getHeight()

    if ActiveCanvas then
        ActiveCanvas:release()
        ActiveCanvas = nil
    end

    ActiveCanvas = canvas.createCanvas(vector2.new(w, h))
    canvas.settings.Zoom = 1
    canvas.centerCanvas(ActiveCanvas)

    love.graphics.setCanvas(ActiveCanvas)
    love.graphics.draw(tempImg)
    love.graphics.setCanvas()

    tempImg:release() --clear up
    imageData:release()
    fileData:release()
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

    -- ActiveCanvasOffset = ActiveCanvasOffset:add(mouse.Pos:sub(lastMousePos)) --to rewrite
    ActiveCanvasOffset.x = ActiveCanvasOffset.x + mouse.Pos.x - lastMousePos.x
    ActiveCanvasOffset.y = ActiveCanvasOffset.y + mouse.Pos.y - lastMousePos.y

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

    if not lastMousePos then --it works right?
        local canvasMouseX = (mouse.Pos.x - ActiveCanvasOffset.x) / canvas.settings.Zoom
        local canvasMouseY = (mouse.Pos.y - ActiveCanvasOffset.y) / canvas.settings.Zoom

        love.graphics.circle("fill", canvasMouseX, canvasMouseY, 1)
    elseif mouse.Moving then
        local canvasMouseX = (mouse.Pos.x - ActiveCanvasOffset.x) / canvas.settings.Zoom
        local canvasMouseY = (mouse.Pos.y - ActiveCanvasOffset.y) / canvas.settings.Zoom

        local canvasLastMouseX = (lastMousePos.x - ActiveCanvasOffset.x)
        local canvasLastMouseY = (lastMousePos.y - ActiveCanvasOffset.y)

        love.graphics.setLineWidth(1)
        love.graphics.line(canvasMouseX, canvasMouseY, canvasLastMouseX / canvas.settings.Zoom, canvasLastMouseY / canvas.settings.Zoom)
    end

    if lastMousePos then
        lastMousePos.x = mouse.Pos.x
        lastMousePos.y = mouse.Pos.y
    else
        lastMousePos = vector2.new(mouse.Pos.x, mouse.Pos.y)
    end

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

    if not lastMousePos then --i think its fine now?
        local canvasMouseX = (mouse.Pos.x - ActiveCanvasOffset.x) / canvas.settings.Zoom
        local canvasMouseY = (mouse.Pos.y - ActiveCanvasOffset.y) / canvas.settings.Zoom

        love.graphics.circle("fill", canvasMouseX, canvasMouseY, canvas.settings.Size * 0.5)
    elseif mouse.Moving then
        local canvasMouseX = (mouse.Pos.x - ActiveCanvasOffset.x) / canvas.settings.Zoom
        local canvasMouseY = (mouse.Pos.y - ActiveCanvasOffset.y) / canvas.settings.Zoom

        local canvasLastMouseX = (lastMousePos.x - ActiveCanvasOffset.x)
        local canvasLastMouseY = (lastMousePos.y - ActiveCanvasOffset.y)

        love.graphics.setLineWidth(canvas.settings.Size)
        love.graphics.line(canvasMouseX, canvasMouseY, canvasLastMouseX / canvas.settings.Zoom, canvasLastMouseY / canvas.settings.Zoom)
    end

    if lastMousePos then
        lastMousePos.x = mouse.Pos.x
        lastMousePos.y = mouse.Pos.y
    else
        lastMousePos = vector2.new(mouse.Pos.x, mouse.Pos.y)
    end

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
