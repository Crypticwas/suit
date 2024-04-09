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


local get = {

    Command = "",
    Description = "online package manager/installer. uses a mixture of github and roblox toolbox",
    Aliases = {"cpm", "pm"},
    Args = {
        {
            Name = "get",
            Description = "The package you are installing",
            CommandType = "direct",
            ExpectedType = "string"
        },
        {
            Name = "list",
            Description = "Get all the installed packages",
            CommandType = "direct",
            ExpectedType = "string"
        },
        {
            Name = "remove",
            Description = "Remove a package",
            CommandType = "direct",
            ExpectedType = "string"
        }
    },
    LinkedFunction = function(argc, argv)
        
        if argc >= 1 then
            
            if argc[1] == "get" and argc[2] then
                
            
                
            elseif argc[1] == "remove" and argc[2] then
                
            end
            
            if argc[1] == "list" then
                
            else
                
                return "The given command/argument is not valid"
                
            end
            
        end
        
    end
    
} :: command

return get