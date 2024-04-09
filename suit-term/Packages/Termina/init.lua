local termina = {}

local frontend = require(script.Frontend)
local options = require(script.Options)

termina.Init = function(Parent: GuiObject, opt : {
    
    Name : string,
    PosX : number,
    PosY : number,
    SizeX : number,
    SizeY : number,
    Font : Enum.Font,
    FontWeight : Enum.FontWeight,
    Theme : string,
    ColorScheme : {
        BGColor : Color3,
        TextColor : Color3,
        TextTransperency : number,
        
    }

})
    
    opt = opt or {}
    
    local ContainerFrame = Instance.new("ScrollingFrame")
    
    ContainerFrame.Name = opt.Name or options.DefaultName or "TerminaUI"
    ContainerFrame.Position = UDim2.fromOffset(opt.PosX or 0, opt.PosY or 0)
    ContainerFrame.Size = UDim2.new(0, opt.SizeX or 640, 0, opt.SizeY or 480)
    ContainerFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    ContainerFrame.CanvasSize = UDim2.new()
    
    local UIListLayout = Instance.new("UIListLayout")
    
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Parent = ContainerFrame
    
    local UIPadding = Instance.new("UIPadding")
    
    UIPadding.PaddingTop = UDim.new(0, 5)
    UIPadding.PaddingBottom = UDim.new(0, 5)
    UIPadding.PaddingLeft = UDim.new(0, 5)
    UIPadding.PaddingRight = UDim.new(0, 5)
    UIPadding.Parent = ContainerFrame
    
    local InputLine = Instance.new("TextBox")
    
    InputLine.ClearTextOnFocus = false
    InputLine.LayoutOrder = options.MaxLine or 5000
    InputLine.Size = UDim2.new(1, 0, 0, ((options.TextSpacing * 2) + options.TextSize) or 16)
    InputLine.Font = opt.Font or Enum.Font.Gotham
    InputLine.FontFace.Weight = opt.FontWeight or Enum.FontWeight.Regular
    InputLine.TextSize = options.TextSize or 14
    InputLine.TextWrapped = true
    InputLine.TextXAlignment = Enum.TextXAlignment.Left
    InputLine.Parent = ContainerFrame
    
    
    ContainerFrame.Parent = Parent
    
    
    frontend.Init(InputLine, ContainerFrame)
    
end

termina.InitPremadeUI = function(display: GuiObject)

    frontend.Init(display:FindFirstChild("InputLine"), display)

end

termina.Options = options

return termina