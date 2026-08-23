local vector2 = require "modules.variables.vector2"
local mouse   = require "modules.core.mouse"

local buttons = {}

local activeButtons = {}

function buttons.addButton(pos, size, event)
    local btn = {
        Position = pos,
        Size = size,
        Event = event
    }

    table.insert(activeButtons, btn)
end

function buttons.update()
    if mouse.m1.State ~= "JustEnded"  then
        goto continue
    end

    for index, value in ipairs(activeButtons) do
        if value.Position.x < mouse.Pos.x and --checked its good
            mouse.Pos.x < value.Position.x + value.Size.x and
            value.Position.y < mouse.Pos.y and
            mouse.Pos.y < value.Position.y + value.Size.y then
            print("Button with index " .. tostring(index) .. " pressed!", mouse.Pos.x, mouse.Pos.y)
        end
    end

    ::continue::
end

function buttons.activateButton()
end

return buttons
