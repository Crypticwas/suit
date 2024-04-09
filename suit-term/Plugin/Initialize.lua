local root = script.Parent.Parent

local function init(extern)
        
    local plugin: Plugin = extern
    local toolbar = plugin:CreateToolbar("Suit")

    local tooltip = "Terminal to install, configure and buy external modules"

    local terminal = toolbar:CreateButton("SuitTern", tooltip, "rbxassetid://11419714821")

    terminal.ClickableWhenViewportHidden = true
    terminal.Name = "SuitTerminal"

    -- UI Init --

    local ui = require(root.Plugin.ui)(plugin)

    terminal.Click:Connect(function()
    
        ui.Enabled = not ui.Enabled

        terminal.Enabled = false
        terminal.Enabled = true

    end)

end

return function(extern)
    
    init(extern)

end