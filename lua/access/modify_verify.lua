require "conf"
local cjson = require "cjson"
local _M = {}

function _M.method_verify(user_name)
    local uri_method = ngx.req.get_method()
    local app_uri = ngx.var.app_uri

    -- local user_type_is_read_only = false
    local app_uri_in_white_list = false
    local app_uri_in_limit_user = false

    -- for k, v in pairs(READ_ONLY_USER_TYPE) do
    --     if user_name == v then
    --         user_type_is_read_only = true
    --         break
    --     end
    -- end

    for k, v in pairs(WHITE_LIST) do
        if app_uri == v.app_uri and uri_method == v.method then
            app_uri_in_white_list = true
            break
        end
    end

    -- 请求路径限定用户
    for k ,v in pairs(USER_LIMITURL_LIST) do
        if app_uri == v.app_uri and user_name == v.user then
            app_uri_in_limit_user = true
            break
        end
    end

    -- 参考可实现请求的其他限制

    -- 不在白名单 && 用户只读类型&&get method
    -- 请求路径&用户不匹配
    -- if not app_uri_in_white_list and user_type_is_read_only and uri_method ~= "GET" then
    if not app_uri_in_white_list or not app_uri_in_white_list then
        ngx.status = ngx.HTTP_BAD_REQUEST
        ngx.header["content-type"] = "application/json"
        ngx.print(cjson.encode(RESULT))
        ngx.exit(0)
    end
end

return _M
