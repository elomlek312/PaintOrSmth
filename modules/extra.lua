local extra = {}

extra.on = false

function extra.stress(iterations)
    local x = 0

    for i = 1, iterations do
        x = x + math.sin(i) * math.cos(i)
        x = x * 1.000001
    end

    return x
end

return extra
