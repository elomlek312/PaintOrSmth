local tableUtils = require "modules.tableUtils"

local Actions = {
    [">!<escape"] = function()
        love.event.quit()
    end
}

local pressedkeys = {}

local keyboard = {}

function love.keypressed(key)
    for i, v in ipairs(pressedkeys) do --safety check
        if v == key then
            print(string.format("Wierd behaviour: tried to but key: %s in table, already there.", key))
            goto skip1
        end
    end

    table.insert(pressedkeys, key)

    ::skip1::

    local keyString = ""

    for _, v in ipairs(pressedkeys) do
        keyString = keyString .. ">!<" .. v
    end

    print(tableUtils.getTableString(pressedkeys),keyString)

    if Actions[keyString] then
        Actions[keyString]()
    end
end

function love.keyreleased(key)
    print("release",key)
    for i, v in ipairs(pressedkeys) do
        if v == key then
            table.remove(pressedkeys, i)
            goto skip1
        end
    end

    print("Wierd behaviour: EventKeyreleased but key is not present in pressedkeys")

    ::skip1::
end

function keyboard.keydown(key)
    for _, v in ipairs(pressedkeys) do
        if v == key then
            return true
        end
    end
    return false
end

function keyboard.bindToActions(key, func)
    Actions[key] = func
end

function keyboard.checkActionsBindExists(key)
    return Actions[key] ~= nil
end

return keyboard
