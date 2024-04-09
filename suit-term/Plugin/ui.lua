local root = script.Parent.Parent

return function (plugin: Plugin)
    
    local core = game:GetService("CoreGui")
    local info = DockWidgetPluginGuiInfo.new(
        Enum.InitialDockState.Float, 
        false,
        false,
        640,
        480,
        640,
        480
    )

    local win = plugin:CreateDockWidgetPluginGui("SuitTerminal", info)
    
    win.Name = "suitterm"
    win.Title = "SuitTerminal"
    
    local assets = script.Parent.assets
    local ui = assets.TerminaContainer:Clone()
    
    ui.Parent = win

    win:BindToClose(function()

        for i,v: Instance in pairs(ui:GetChildren()) do
            
            if v.ClassName == "TextLabel" then
                
                v:Destroy()

            end

        end

    end)
    
    require(root.Packages.Termina).InitPremadeUI(ui)
    
    return win

end