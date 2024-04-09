if not plugin then
    return
end

local init = require(script.Initialize)
local options = require(script.Options)
--local secure = require(script.securclone)

init(plugin)

if options.DevMode then
    
    require(script.devbuild)()
    require(script.fdebug)()

end