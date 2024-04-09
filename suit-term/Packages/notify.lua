if script:GetAttribute("StartupMessageEnabled") == true then
    
    print("Notify v5 has sucessfuly ran")
    
end

return function(value: any, errorMessage: string?, warnType: string, continues: boolean)
    
    if typeof(value) == "function" then
        
        value = value()
        
    end
    
    errorMessage = errorMessage or "Something happened but, no output was given."
    
    if not value or value == nil then
        
        if warnType == nil then
            
            warn(errorMessage)
            
        elseif string.lower(warnType) == "error" then
            
            error(errorMessage)
            
            return
            
        elseif string.lower(warnType) == "warn" then
            
            warn(errorMessage)
            
        elseif string.lower(warnType) == "print" then
            
            print(errorMessage)
            
        else
            
            warn(errorMessage)
        
        end
        
        if continues then
            
            return false
            
        else
            
            while wait() do end
            
        end
        
    end
    
    return true
    
end