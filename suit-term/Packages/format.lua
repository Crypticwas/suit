local format = {}

format.color = function(text: string, color: Color3)
    
    return "<mark><font color=\"#"..color:ToHex().."\">"..text.."</font></mark>"
    
end

format.size = function(text: string, size: number)
    
    return "<font size=\""..tostring(size).."\">"..text.."</font>"
    
end

format.stroke = function(text: string, strokecolor: Color3, thickness: number, transperency: number)
    
    return "<stroke color=#\""..strokecolor:ToHex().." joins=\"miter\" thickness=\""..tostring(thickness).."\" transparency=\""..tostring(transperency).."\">"..text.."</stroke>"
    
end

format.transperency = function(text: string, transparency: number)
    
    return "<font transparency=\""..tostring(transparency).."\">"..text.."</font>"
    
end

format.bold = function(text: string)
    
    return "<b>"..text.."</b>"
    
end

format.italic = function(text: string)
    
    return "<i>"..text.."</i>"
    
end

format.underline = function(text: string)
    
    return "<u>"..text.."</u>"
    
end

format.strikethrough = function(text: string)
    
    return "<s>"..text.."</s>"
    
end

format.comment = function(text: string)
    
    return "<!--"..text.."-->"
    
end

return format