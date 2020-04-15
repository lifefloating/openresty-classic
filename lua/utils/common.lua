require "conf"
local cjson = require "cjson"
local yaml = require "lyaml"

-- 一些可能会用到的通用方法

local _M = {}
local methods = {
    GET = ngx.HTTP_GET,
    HEAD =  ngx.HTTP_HEAD,
    PUT = ngx.HTTP_PUT,
    POST =  ngx.HTTP_POST,
    DELETE =  ngx.HTTP_DELETE,
    OPTIONS =  ngx.HTTP_OPTIONS,
    PATCH =  ngx.HTTP_PATCH,
    TRACE =  ngx.HTTP_TRACE,
    MKCOL =  ngx.HTTP_MKCOL,
    COPY  = ngx.HTTP_COPY,
    MOVE  =  ngx.HTTP_MOVE,
    PROPFIND =  ngx.HTTP_PROPFIND,
    PROPPATCH =  ngx.HTTP_PROPPATCH,
    LOCK =  ngx.HTTP_LOCK,
    UNLOCK =  ngx.HTTP_UNLOCK
}

--  如果后台服务已经对返回格式处理 这里就不再统一处理

-- function _M.json_success(data, msg)

--     return cjson.encode({
--         STATUS = true,
--         DATA = data,
--         STATUS_CH = msg,
--     })
-- end


-- function _M.json_fail(data, msg)

--     return cjson.encode({
--         STATUS = true,
--         DATA = data,
--         STATUS_CH = msg,
--     })
-- end


function _M.table_len(t)
    local leng=0
    for k, v in pairs(t) do
        leng=leng+1
    end
    return leng
end

function _M.string_split(str, reps)
    local resultStrList = {}
    string.gsub(str,'[^'..reps..']+',function (w)
        table.insert(resultStrList,w)
    end)
    return resultStrList
end

function _M.urlEncode(s)
     s = string.gsub(s, "([^%w%.%- ])", function(c) return string.format("%%%02X", string.byte(c)) end)
    return string.gsub(s, " ", "+")
end

function _M.urlDecode(s)
    s = string.gsub(s, '%%(%x%x)', function(h) return string.char(tonumber(h, 16)) end)
    return s
end

function _M.ngx_method_to_lua(ngx_method)
    ngx_method = string.upper(ngx_method)
    if not methods[ngx_method] then
        return methods['GET']
    end

    return methods[ngx_method]
end

return _M
