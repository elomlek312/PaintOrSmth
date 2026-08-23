local vector2 = require "modules.variables.vector2"
local tableUtils = require "modules.tableUtils"

local viinfo = "assets/images/TMII.png"
local vi --veri importatn

local images = {
    pasteButton = "assets/images/copybuttonimg.png"
}

local mainPaintingInterface = {
    {
        Name = "",
        Type = "Rect",
        ScalePos = vector2.new(0, 0),
        ScaleSize = vector2.new(1, 0.12),
        Color = { 1, 1, 1 },
        Children = {
            { --copy paste region
                Name = "",
                Type = "Rect",
                ScalePos = vector2.new(0.01, 0.05),
                ScaleSize = vector2.new(0.08, 0.9),
                Color = { 0.8, 0.8, 0.8 },
                Children = {
                    {
                        Name = "CopyButton",
                        Type = "RectButton",
                        ScalePos = vector2.new(0.05, 0.05),
                        ScaleSize = vector2.new(0.9, 0.4),
                        Color = { 1, 0, 0 },
                    },
                    {
                        Name = "PasteButton",
                        Type = "Image",
                        ScalePos = vector2.new(0.05, 0.55),
                        ScaleSize = vector2.new(0.9, 0.4),
                        Image = images.pasteButton,
                    }
                }
            },
            {
                Name = "",
                Type = "Rect",
                ScalePos = vector2.new(0.1, 0.05),
                ScaleSize = vector2.new(0.2, 0.9),
                Color = { 0, 1, 0 }
            }
        }
    }
}

--#####################################################

local map = {}

function map.Rect(val)
    return {
        Type = val.Type,
        OffsetPos = val.OffsetPos,
        OffsetSize = val.OffsetSize,
        Color = val.Color
    }
end

function map.RectButton(val)
    return {
        Type = val.Type,
        OffsetPos = val.OffsetPos,
        OffsetSize = val.OffsetSize,
        Color = val.Color,
        Func = val.Func
    }
end

function map.Image(val)
    local width = love.graphics.newImage(val.Image):getWidth()
    local height = love.graphics.newImage(val.Image):getHeight()

    local ImageScale = vector2.new(
        val.OffsetSize.x / width,
        val.OffsetSize.y / height
    )

    return {
        Type = val.Type,
        OffsetPos = val.OffsetPos,
        ImageScale = ImageScale,
        Image = val.Image
    }
end

function map.ImageButton(val)

end

--#################################################

local draw = {}

function draw.Rect(val)
    love.graphics.setColor(val.Color)
    love.graphics.rectangle("fill", val.OffsetPos.x, val.OffsetPos.y, val.OffsetSize.x, val.OffsetSize.y)
end

function draw.RectButton(val) --to be changed
    love.graphics.setColor(val.Color)
    love.graphics.rectangle("fill", val.OffsetPos.x, val.OffsetPos.y, val.OffsetSize.x, val.OffsetSize.y)
end

function draw.Image(val)
    love.graphics.setColor(1,1,1,1)
    local img = love.graphics.newImage(val.Image)
	love.graphics.draw(img, val.OffsetPos.x, val.OffsetPos.y, 0, val.ImageScale.x, val.ImageScale.y)
end

local function loadImages(tbl)
    local info = love.filesystem.getInfo(viinfo)
    if not info then
        love.event.quit(1)
    end

    vi = love.graphics.newImage(viinfo)

    for key, value in pairs(tbl) do
        info = love.filesystem.getInfo(value)
        if info then
            tbl[key] = love.graphics.newImage(value)
        else
            tbl[key] = vi
        end
    end
end

local function getScaleToPixel(surface, scale)
    return vector2.new(surface.x * scale.x, surface.y * scale.y)
end

local drawCallsTable = {}

local function mapAllDrawables(data, parent)
    for key, val in pairs(data) do

        local surfacesize
        local surfacepos

        if parent then
            surfacesize = parent.OffsetSize
            surfacepos = parent.OffsetPos
        else --if there is no parent in interface table, get the window size
            surfacesize = vector2.new(
                love.graphics.getWidth(),
                love.graphics.getHeight()
            )
            surfacepos = vector2.new()
        end

        -- print(love.graphics.getWidth())
        -- print(surfacepos)


        val.OffsetSize = getScaleToPixel(surfacesize, val.ScaleSize)


        val.OffsetPos = vector2.new(
            surfacepos.x + surfacesize.x * val.ScalePos.x,
            surfacepos.y + surfacesize.y * val.ScalePos.y
        )

        local tbl = map[val.Type](val)

        table.insert(drawCallsTable, tbl)

        if val.Children then
            if next(val.Children) then
                mapAllDrawables(val.Children, val)
            end
        end
    end
end

loadImages(images)
mapAllDrawables(mainPaintingInterface)
--print(tableUtils.getTableFormattedString(mainPaintingInterface))
--print(tableUtils.getTableFormattedString(drawCallsTable))


local interface = {}

function interface.updateActiveInterface()
    drawCallsTable = {}
    mapAllDrawables(mainPaintingInterface)
end

function interface.update()

end

function interface.draw()
    local r, g, b, a = love.graphics.getColor()

    for index, value in ipairs(drawCallsTable) do

        draw[value.Type](value)

    end

    love.graphics.setColor(r, g, b, a)

    love.graphics.draw(images.pasteButton, 400, 10, 0, 0.5, 0.5)
end

return interface
