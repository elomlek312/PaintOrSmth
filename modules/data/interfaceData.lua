local vector2 = require "modules.variables.vector2"
local images  = require "modules.variables.images"

local iData = {}

iData.Main = {
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
                ScaleSize = vector2.new(0.04, 0.9),
                Color = { 0.8, 0.8, 0.8 },
                Children = {
                    {
                        Name = "CopyButton",
                        Type = "ImageButton",
                        ScalePos = vector2.new(0.05, 0.05),
                        ScaleSize = vector2.new(0.9, 0.4),
                        Image = images.Assets.copyButton,
                        Func = function ()
                            print("Pressed copybutton")
                        end
                    },
                    {
                        Name = "PasteButton",
                        Type = "ImageButton",
                        ScalePos = vector2.new(0.05, 0.55),
                        ScaleSize = vector2.new(0.9, 0.4),
                        Image = images.Assets.pasteButton,
                        Func = function ()
                            print("Pressed pastebutton")
                        end
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

return iData
