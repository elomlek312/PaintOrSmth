local Vector2 = {}
Vector2.__index = Vector2

-- Constructor
function Vector2.new(x, y)
    return setmetatable({
        x = x or 0,
        y = y or 0
    }, Vector2)
end

-- Add two vectors
function Vector2:add(other)
    return Vector2.new(
        self.x + other.x,
        self.y + other.y
    )
end

-- Subtract vectors
function Vector2:sub(other)
    return Vector2.new(
        self.x - other.x,
        self.y - other.y
    )
end

-- Multiply by a number
function Vector2:mul(scalar)
    return Vector2.new(
        self.x * scalar,
        self.y * scalar
    )
end

-- Get vector length
function Vector2:length()
    return math.sqrt(self.x * self.x + self.y * self.y)
end

-- Normalize the vector
function Vector2:normalize()
    local length = self:length()

    if length > 0 then
        return Vector2.new(
            self.x / length,
            self.y / length
        )
    end

    return Vector2.new(0, 0)
end

-- Distance between two vectors
function Vector2:distance(other)
    return self:sub(other):length()
end

return Vector2
