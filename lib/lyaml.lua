-- 調用yaml.so實現一個lua-yaml
local yaml = require "yaml"

local _T = {}

function _T.dump(obj, io)
    if io then
        io:write(yaml.dump(obj))
    else
        return yaml.dump(obj)
    end

end

function _T.dump_file(obj, file)
    local f, err = io.open(file, "w")
    if not f then return nil , err end
    f:write(yaml.dump(obj))
    f:close()
end


function _T.load(str)
    return yaml.load(str)
end


function _T.load_file(file)
    local f, err = io.open(file, "r")
    if not f then return nil, err end
    local re = yaml.load(f:read('*all'))
    f:close()
    return re
end


setmetatable(_T, {__index=yaml})

return _T