local windows = require("windows")
local canvas  = require("modules.canvas")

local vector2 = require "modules.variables.vector2"
local images  = require "modules.variables.images"

local iData   = {}

iData.Main = {
    {
        Name = "Main bar",
        Type = "Rect",
        ScalePos = vector2.new(0, 0),
        ScaleSize = vector2.new(1, 0.12),
        Color = { 1, 1, 1 },
        Children = {
            { --new file / open file region
                Name = "nF/oF region",
                Type = "Rect",
                ScalePos = vector2.new(0.01, 0.05),
                ScaleSize = vector2.new(0.08, 0.9),
                Color = { 0.8, 0.8, 0.8 },
                Children = {
                    {
                        Name = "newFileButton",
                        Type = "ImageButton",
                        ScalePos = vector2.new(0.02, 0.05),
                        ScaleSize = vector2.new(0.4, 0.4),
                        Image = images.Assets.newFileButton,
                        Func = function ()
                            print("newFileButton pressed")

                            canvas.newCanvas()
                        end
                    },
                    {
                        Name = "openFileButton",
                        Type = "ImageButton",
                        ScalePos = vector2.new(0.02, 0.55),
                        ScaleSize = vector2.new(0.4, 0.4),
                        Image = images.Assets.openFileButton,
                        Func = function ()
                            print("openFileButton pressed")

                            local path = windows.openFileDialog()

                            if path then
                                canvas.openFilePath(path)
                            end
                        end
                    }
                }
            },
            { --copy paste region
                Name = "c/p region",
                Type = "Rect",
                ScalePos = vector2.new(0.1, 0.05),
                ScaleSize = vector2.new(0.035, 0.9),
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
                Name = "Painting thingies thingy",
                Type = "Rect",
                ScalePos = vector2.new(0.145, 0.05),
                ScaleSize = vector2.new(0.1, 0.9),
                Color = { 0.8, 0.8, 0.8 },
                Children = {
                    {
                        Name = "PencilButton",
                        Type = "ImageButton",
                        ScalePos = vector2.new(0.02, 0.05),
                        ScaleSize = vector2.new(0.3, 0.4),
                        Image = "",
                        Func = function ()
                            print("Pencil")
                        end
                    },
                    {
                        Name = "BrushButton",
                        Type = "ImageButton",
                        ScalePos = vector2.new(0.35, 0.05),
                        ScaleSize = vector2.new(0.3, 0.4),
                        Image = "",
                        Func = function ()
                            print("Brush")
                        end
                    },
                    {
                        Name = "BrushButton", --TEMPORARY ------------------------------------
                        Type = "Image",
                        ScalePos = vector2.new(0.68, 0.05),
                        ScaleSize = vector2.new(0.3, 0.4),
                        Image = ""
                    }
                }
            },
            {
                Name = "Stats or smth thingy", --shows the brush thickness, current color, and smth else i forgor
                Type = "Rect",
                ScalePos = vector2.new(0.255, 0.05),
                ScaleSize = vector2.new(0.05, 0.9),
                Color = { 1, 0, 0 },
                Children = {
                    {
                        Name = "Idk what here cuz I didnt add a text drawable",
                        Type = "Image",
                        ScalePos = vector2.new(),
                        ScaleSize = vector2.new(1, 1),
                        Image = ""
                    }
                }
            },
            {
                Name = "Color palette",
                Type = "Rect",
                ScalePos = vector2.new(0.315, 0.05),
                ScaleSize = vector2.new(0.15, 0.9),
                Color = { 0.8, 0.8, 0.8 },
                Children = {
                    {
                        Name = "Black",
                        Type = "RectButton",
                        ScalePos = vector2.new(0.02, 0.05),
                        ScaleSize = vector2.new(0.15, 0.4),
                        Color = { 0, 0, 0 },
                        Func = function ()
                            canvas.settings.ActiveColor[1] = 0
                            canvas.settings.ActiveColor[2] = 0
                            canvas.settings.ActiveColor[3] = 0
                        end
                    },
                    {
                        Name = "White",
                        Type = "RectButton",
                        ScalePos = vector2.new(0.02, 0.5),
                        ScaleSize = vector2.new(0.15, 0.4),
                        Color = { 1, 1, 1 },
                        Func = function ()
                            canvas.settings.ActiveColor[1] = 1
                            canvas.settings.ActiveColor[2] = 1
                            canvas.settings.ActiveColor[3] = 1
                        end
                    },
                    {
                        Name = "Red",
                        Type = "RectButton",
                        ScalePos = vector2.new(0.19, 0.05),
                        ScaleSize = vector2.new(0.15, 0.4),
                        Color = { 1, 0, 0 },
                        Func = function ()
                            canvas.settings.ActiveColor[1] = 1
                            canvas.settings.ActiveColor[2] = 0
                            canvas.settings.ActiveColor[3] = 0
                        end
                    },
                    {
                        Name = "Orange",
                        Type = "RectButton",
                        ScalePos = vector2.new(0.19, 0.5),
                        ScaleSize = vector2.new(0.15, 0.4),
                        Color = { 1, 0.5, 0 },
                        Func = function ()
                            canvas.settings.ActiveColor[1] = 1
                            canvas.settings.ActiveColor[2] = 0.5
                            canvas.settings.ActiveColor[3] = 0
                        end
                    },
                    {
                        Name = "Yellow",
                        Type = "RectButton",
                        ScalePos = vector2.new(0.36, 0.05),
                        ScaleSize = vector2.new(0.15, 0.4),
                        Color = { 1, 1, 0 },
                        Func = function ()
                            canvas.settings.ActiveColor[1] = 1
                            canvas.settings.ActiveColor[2] = 1
                            canvas.settings.ActiveColor[3] = 0
                        end
                    },
                    {
                        Name = "Light green",
                        Type = "RectButton",
                        ScalePos = vector2.new(0.36, 0.5),
                        ScaleSize = vector2.new(0.15, 0.4),
                        Color = { 0.56, 0.93, 0.56 },
                        Func = function ()
                            canvas.settings.ActiveColor[1] = 0.56
                            canvas.settings.ActiveColor[2] = 0.93
                            canvas.settings.ActiveColor[3] = 0.56
                        end
                    },
                    {
                        Name = "Dark green",
                        Type = "RectButton",
                        ScalePos = vector2.new(0.53, 0.05),
                        ScaleSize = vector2.new(0.15, 0.4),
                        Color = { 0, 0.39, 0 },
                        Func = function ()
                            canvas.settings.ActiveColor[1] = 0
                            canvas.settings.ActiveColor[2] = 0.39
                            canvas.settings.ActiveColor[3] = 0
                        end
                    },
                    {
                        Name = "Blue",
                        Type = "RectButton",
                        ScalePos = vector2.new(0.53, 0.5),
                        ScaleSize = vector2.new(0.15, 0.4),
                        Color = { 0, 0, 1 },
                        Func = function ()
                            canvas.settings.ActiveColor[1] = 0
                            canvas.settings.ActiveColor[2] = 0
                            canvas.settings.ActiveColor[3] = 1
                        end
                    },
                    {
                        Name = "Dark purple",
                        Type = "RectButton",
                        ScalePos = vector2.new(0.70, 0.05),
                        ScaleSize = vector2.new(0.15, 0.4),
                        Color = { 0.29, 0.1, 0.3 },
                        Func = function ()
                            canvas.settings.ActiveColor[1] = 0.29
                            canvas.settings.ActiveColor[2] = 0.1
                            canvas.settings.ActiveColor[3] = 0.3
                        end
                    },
                    {
                        Name = "Pink",
                        Type = "RectButton",
                        ScalePos = vector2.new(0.70, 0.5),
                        ScaleSize = vector2.new(0.15, 0.4),
                        Color = { 1, 0.77, 0.79 },
                        Func = function ()
                            canvas.settings.ActiveColor[1] = 1
                            canvas.settings.ActiveColor[2] = 0.77
                            canvas.settings.ActiveColor[3] = 0.79
                        end
                    },
                }
            }
        }
    }
}

return iData
