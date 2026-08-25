local images = {}

local imageCache = {}

local nilAsset = "assets/images/TMII.png"
imageCache[nilAsset] = love.graphics.newImage(nilAsset)


images.Assets = {
    pasteButton = "assets/images/pasteButton.png",
    copyButton = "assets/images/copyButton.png",
    newFileButton = "assets/images/newFileButton.png",
    openFileButton = "assets/images/openFileButton.png"
}


function images.GetImage(path)
    if not imageCache[path] then
        local sucess, out = pcall(love.graphics.newImage, path)
        if not sucess then
            return imageCache[nilAsset]
        end
        imageCache[path] = out
    end
    return imageCache[path]
end

return images
