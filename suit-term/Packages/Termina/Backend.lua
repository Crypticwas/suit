local Termina = {}
Termina.Command = {}

-- Types --------

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
    LinkedFunction : (argc : number , argv : { [string] : any | any }) -> (string)
}

-- Commands -----

local commands = require(script.Parent.Internal)

-- Main ---------

function Termina:ProcessCommand(text: string)
    
    local splitstr = text:split(" ")
    local command = splitstr[1]
    local param = splitstr
    
    table.remove(param, 1)

    local iscmd = false
    local cmd
    
    for i,v in pairs(commands) do
        
        if command ~= v.Command then
            
            for _,x in pairs(v.Aliases) do
                
                if command == x then
                    
                    iscmd = true
                    cmd = v.LinkedFunction
                    
                end
                
            end
            
        elseif command == v.Command then
            
            iscmd = true
            cmd = v.LinkedFunction

        end
        
        if iscmd then
            break
        end
        
    end

    if iscmd then

        return cmd(#param, param)

    end
    
    if text:len() == 0 then
        
        return nil
        
    end
    
    local returnval = string.format("The given command \"%s\" is not a valid command.\nIf you need help use the \"help\" command.", command)
    
    return returnval

end

return Termina