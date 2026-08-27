local fonts = {}

local fontsCache = {}

local function generateNewFont(size)
	return love.graphics.newFont(math.floor(size + 0.5))
end

function fonts.getFont(size)
    if not fontsCache[size] then
        fontsCache[size] = generateNewFont(size)
    end
    return fontsCache[size]
end

return fonts
