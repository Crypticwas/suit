export type argument = {
    Name : string,
    Description : string,
    CommandType : "direct" | "argumented",
    ExpectedType : string,
    DefaultValue : any
}

export type command = {
    Command : string,
    Aliases : {string},
    Description : string,
    Args : {
        {
            Name : string,
            Description : string,
            CommandType : "direct" | "argumented",
            ExpectedType : string,
            DefaultValue : any
        }
    },
    LinkedFunction : (argc : number , argv : { [string] : any | any }) -> (any)
}

export type commandgroup = {
    command
}

local commands = {}
local options = require(script.Parent.Options)

local function InsertCommand(...)
    
    if ... then
        
        local args = {...}
    
        for i,v in pairs(args) do
            
            table.insert(commands, v)
            
        end
        
    end
    
end

local version = {
    Command = "version",
    Aliases = {"ver", "--ver", "--version"},
    Description = "Show the version of Termina",
    LinkedFunction = function()

        return "Termina v1.0.0\n----------------\nProvided by Lopixel Studios"

    end
} :: command

local help = {
    Command = "help",
    Aliases = {"--help"},
    Description = "Open up the help menu to show each command and a description",
    
    LinkedFunction = function(argc, argv)
        
        local menu = ""

        if argc == 1 then

            for i,v in pairs(commands) do
                
                local iscmd = false
                
                if v.Command ~= argv[1] then
                    
                    for i,v in pairs(v.Aliases) do
                        
                        if v == argv[1] then
                            
                            iscmd = true
                            break
                            
                        end
                        
                    end
                    
                elseif v.Command == argv[1] then
                    
                    iscmd = true
                    
                end
                
                print(iscmd)
                
                if iscmd then
                    
                    menu = menu..v.Command.."\n"
                    if v.Description then
                        menu = menu..v.Description
                    else
                        menu = menu.."No Description"
                    end
                    
                    if v.Args ~= nil then
                    
                        menu = menu.."\n------------------------------\n"
                        menu = menu.."Arguments:"
                        
                        for y,x in pairs(v.Args) do
                            
                            if x.Name and x.Description then
                            
                                menu = menu.."\nName: "..x.Name.."\n"
                                menu = menu.."Description: "..x.Description.."\n"
                                if x.ExpectedType then
                                    menu = menu.."Type: "..x.ExpectedType.."\n"
                                end
                                if x.DefaultValue then
                                    menu = menu.."Defaults to: "..x.DefaultValue.."\n"
                                end
                                
                            else
                                
                                menu = menu.."\nNo data for argument #"..y.."\n"
                                
                            end
                            
                        end
                        
                    end
                    
                    return menu
                
                end
                
            end

        elseif argc >= 2 then

            return "Too many parameters were given"

        elseif argc == 0 then
            
            local menu = ""
            
            menu = menu.."Help Menu:\n"
            
            for i,v in pairs(commands) do
                
                local args = ""
                
                menu = menu..v.Command.." | "..v.Description
                
                if v.Args then
                    
                    for i,y in pairs(v.Args) do
                        
                        if y.Name then
                        
                            args = args..y.Name..", "
                            
                        else
                            
                            args = args.."arg"..i..", "
                            
                        end
                        
                    end
                    
                    args = args:sub(0, args:len() - 2)
                    
                    menu = menu.." | "..args.."\n"
                    
                else
                    
                    menu = menu.."\n"
                    
                end
                
            end
            
            return menu
            
        end

    end,
    Args = {
        {
            Name = "search",
            Description = "Search for a command from the command list",
            CommandType = "direct",
            ExpectedType = "string",
            DefaultValue = "help"
            
        }
    }
} :: command

local out = {
    Command = "out",
    Aliases = {"print", "echo"},
    Description = "Output text to the terminal",
    Args = {
        {
            Name = "Text",
            Description = "The text that will be outputed",
            CommandType = "direct",
            ExpectedType = "string"
        }
    },
    LinkedFunction = function(argc, argv)
        
        if argc == 1 then
            
            local text = tostring(argv[1])
            
            return text
            
        elseif argc >= 2 then
            
            local text = ""
            
            for i,v in argv do
                text = text..v.."\n"
            end
            
            return text:sub(0, text:len() - 1)
            
        elseif argc == 0 then
            
            return "No text was given.\n"
            
        end
        
    end
} :: command

local quit = {
    Command = "quit",
    Aliases = {"exit", "q!"},
    Description = "Quit the terminal",
    LinkedFunction = function()
        local ui = game:GetService("PluginGuiService"):FindFirstChild("suitterm")
        if ui then
            ui.Enabled = false
        end
    end
}

local run = {
    Command = "run",
    Aliases = {},
    Description = "Run a app from terminal",
    LinkedFunction = function()
        
    end
}

InsertCommand(version)
InsertCommand(help)
InsertCommand(out)
InsertCommand(quit)
--InsertCommand(nf, rf, of, wf)

for i,v in pairs(options.CommandsDir:GetDescendants()) do
    
    if v:HasTag(options.CommandsTag) and v.ClassName == "ModuleScript" then
        
        InsertCommand(require(v))
        
    end
    
end

return commands