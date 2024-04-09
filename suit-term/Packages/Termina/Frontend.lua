local termina = {}

local backend = require(script.Parent.Backend)
local linecap = require(script.Parent.Options).MaxLine

local function getdir()
    
    local dir = ""
    local p = game.ReplicatedStorage:WaitForChild("suit", math.huge)
    
    while p.Name ~= "suit" do
        dir = p.Name.."/"..dir
        p = p.Parent
    end
    
    return "root@suit/"..dir..">"
end

termina.Init = function(InputLine: TextBox, ContainerFrame: ScrollingFrame)
    
    local CurrentLine = 0
    local dir = getdir()
    local conn

    InputLine.LayoutOrder = linecap
    
    conn = game:GetService("RunService").Heartbeat:Connect(function()
        
        if InputLine.CursorPosition < dir:len() + 2 then
            
            InputLine.CursorPosition = dir:len() + 2
            
        end

        if InputLine.ContentText:len() < dir:len() + 1 then

            InputLine.Text = dir

        end

    end)
    
    InputLine.Text = dir
    
    InputLine.FocusLost:Connect(function(enter)
        
        if enter then

            if CurrentLine >= linecap then

                local OutputText = Instance.new("TextLabel")
                OutputText.TextWrapped = true
                OutputText.Size = UDim2.new(1, 0, 0, 16)
                OutputText.LayoutOrder = CurrentLine
                OutputText.BackgroundTransparency = 1
                OutputText.Font = InputLine.Font
                OutputText.TextXAlignment = Enum.TextXAlignment.Left
                OutputText.TextSize = InputLine.TextSize
                OutputText.TextColor3 = InputLine.TextColor3
                OutputText.AutomaticSize = Enum.AutomaticSize.Y

                OutputText.Parent = ContainerFrame
                OutputText.Text = "The Linecap has been reached.\nEnding all input and console interactions"
                
                InputLine:Destroy()
                conn:Disconnect()
                
                return

            end

            InputLine.Visible = false

            local InputText = Instance.new("TextLabel")
            InputText.Text = InputLine.Text
            InputText.TextWrapped = true
            InputText.Size = UDim2.new(1, 0, 0, 16)
            InputText.Parent = ContainerFrame
            InputText.LayoutOrder = CurrentLine
            InputText.BackgroundTransparency = 1
            InputText.Font = InputLine.Font
            InputText.TextXAlignment = Enum.TextXAlignment.Left
            InputText.TextSize = InputLine.TextSize
            InputText.TextColor3 = InputLine.TextColor3
            
            local text = InputText.ContentText
            local output = backend:ProcessCommand(text:sub(dir:len() + 1, -1))
            
            if output == nil then

                CurrentLine += 1

                InputLine.Visible = true
                InputLine.LayoutOrder = CurrentLine

                InputLine:CaptureFocus()
                
                InputLine.Text = ""

                return
                
            end

            CurrentLine += 1

            local OutputText = Instance.new("TextLabel")
            OutputText.TextWrapped = true
            OutputText.Size = UDim2.new(1, 0, 0, 16)
            OutputText.LayoutOrder = CurrentLine
            OutputText.BackgroundTransparency = 1
            OutputText.Font = InputText.Font
            OutputText.TextXAlignment = Enum.TextXAlignment.Left
            OutputText.TextSize = InputLine.TextSize
            OutputText.TextColor3 = InputLine.TextColor3
            OutputText.AutomaticSize = Enum.AutomaticSize.Y

            OutputText.Parent = ContainerFrame
            OutputText.Text = output.."\n"

            CurrentLine += 1
            
            InputLine.Visible = true
            InputLine.LayoutOrder = CurrentLine
            
            InputLine:CaptureFocus()
            
            InputLine.Text = ""
            
        end
            
    end)
    
end

return termina