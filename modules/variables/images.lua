local images = {}

images.Assets = {
    pasteButton = "assets/images/pasteButtonImg.png",
    copyButton = "assets/images/copyButtonImg.png"
}

local imageCache = {}

function images.GetImage(path)
    if not imageCache[path] then
        imageCache[path] = love.graphics.newImage(path)
    end
    return imageCache[path]
end

return images
