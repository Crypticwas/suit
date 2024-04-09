local root = script.Parent.Parent.Parent

local opt = {
    
    TextSpacing = 1,
    TextSize = 14,
    MaxLine = 5000,
    DefaultName = "TerminaUI",
    RootDir = game.ReplicatedStorage:WaitForChild("suit", math.huge),
    SyntaxHighlight = true,
    CommandsDir = script.Parent.Parent,
    CommandsTag = "_command"
}

return opt