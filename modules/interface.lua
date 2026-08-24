local vector2 = require "modules.variables.vector2"
local tableUtils = require "modules.tableUtils"
local images     = require "modules.variables.images"
local interfaceData = require "modules.data.interfaceData"
local buttons       = require "modules.buttons"

local activeInterfaces = {}

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
    buttons.addButton(val.OffsetPos, val.OffsetSize, val.Func)

    return {
        Type = val.Type,
        OffsetPos = val.OffsetPos,
        OffsetSize = val.OffsetSize,
        Color = val.Color
    }
end

function map.Image(val)
    local img = love.graphics.newImage(val.Image)
    local ImageScale = vector2.new(
        val.OffsetSize.x / img:getWidth(),
        val.OffsetSize.y / img:getHeight()
    )

    return {
        Type = val.Type,
        OffsetPos = val.OffsetPos,
        ImageScale = ImageScale,
        Image = val.Image
    }
end

function map.ImageButton(val)
    buttons.addButton(val.OffsetPos, val.OffsetSize, val.Func)

    local img = love.graphics.newImage(val.Image)
    local ImageScale = vector2.new(
        val.OffsetSize.x / img:getWidth(),
        val.OffsetSize.y / img:getHeight()
    )

    return {
        Type = val.Type,
        OffsetPos = val.OffsetPos,
        ImageScale = ImageScale,
        Image = val.Image
    }
end

--#################################################

local draw = {}

function draw.Rect(val)
    love.graphics.setColor(val.Color)
    love.graphics.rectangle("fill", val.OffsetPos.x, val.OffsetPos.y, val.OffsetSize.x, val.OffsetSize.y)
end

function draw.RectButton(val) --to be changed (mabye?)
    love.graphics.setColor(val.Color)
    love.graphics.rectangle("fill", val.OffsetPos.x, val.OffsetPos.y, val.OffsetSize.x, val.OffsetSize.y)
end

function draw.Image(val)
    love.graphics.setColor(1, 1, 1, 1)
    local img = images.GetImage(val.Image)
    love.graphics.draw(img,
        val.OffsetPos.x, val.OffsetPos.y, 0, val.ImageScale.x, val.ImageScale.y)
end

function draw.ImageButton(val)
    love.graphics.setColor(1, 1, 1, 1)
    local img = images.GetImage(val.Image)
    love.graphics.draw(img,
        val.OffsetPos.x, val.OffsetPos.y, 0, val.ImageScale.x, val.ImageScale.y)
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

--mapAllDrawables(interfaceData.Main)
--print(tableUtils.getTableFormattedString(mainPaintingInterface))
--print(tableUtils.getTableFormattedString(drawCallsTable))


local interface = {}

function interface.addToActiveInterfaces(t, extra) --by default adds it last
    extra = extra or "last"

    if extra == "first" then
        table.insert(activeInterfaces, 1, t)
    elseif extra == "last" then
        activeInterfaces[#activeInterfaces + 1] = t
    else
        warn("UHHH")
    end
end

function interface.clearActiveInterfaces()
    tableUtils.clearTable(activeInterfaces)
end

function interface.updateActiveInterface()
    tableUtils.clearTable(drawCallsTable)
    for _, v in ipairs(activeInterfaces) do
        buttons.clear()
        mapAllDrawables(v)
    end
end


function interface.draw()
    local r, g, b, a = love.graphics.getColor()

    for _, value in ipairs(drawCallsTable) do

        draw[value.Type](value)

    end

    love.graphics.setColor(r, g, b, a)
end

return interface
