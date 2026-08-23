local tableUtils = {}

function tableUtils.tablesEqual(tbla, tblb)
    for key, val in pairs(tbla) do
        if tblb[key] ~= val then
            return false
        end
    end

    for key, val in pairs(tblb) do
        if tbla[key] ~= val then
            return false
        end
    end

    return true
end

function tableUtils.getTableString(tbl)
    local parts = { "{" }

    for key, value in pairs(tbl) do
        local keyStr = tostring(key)
        local valueStr

        if type(value) == "table" then
            valueStr = tableUtils.getTableString(value)
        elseif type(value) == "string" then
            valueStr = string.format("%q", value)
        else
            valueStr = tostring(value)
        end

        table.insert(parts, keyStr .. "=" .. valueStr .. ",")
    end

    table.insert(parts, "}")

    return table.concat(parts)
end

function tableUtils.getTableFormattedString(tbl, indent)
    indent = indent or 0

    local spacing = string.rep("    ", indent)
    local childSpacing = string.rep("    ", indent + 1)

    local parts = {"{\n"}

    for key, value in pairs(tbl) do
        local valueStr

        if type(value) == "table" then
            valueStr = tableUtils.getTableFormattedString(value, indent + 1)
        elseif type(value) == "string" then
            valueStr = string.format("%q", value)
        else
            valueStr = tostring(value)
        end

        table.insert(parts,
            childSpacing .. tostring(key) .. " = " .. valueStr .. ",\n"
        )
    end

    table.insert(parts, spacing .. "}")

    return table.concat(parts)
end

function tableUtils.copyTable(t)
    local copy = {}

    for key, value in pairs(t) do
        copy[key] = value
    end

    return copy
end

return tableUtils
