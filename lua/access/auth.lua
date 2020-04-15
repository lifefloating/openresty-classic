require "conf"
local http = require "resty.http"
local cjson = require "cjson"
local method_verify = require "access.method_verify"
local httpc = http.new()
local common = require "utils.common"

httpc:set_timeout(HTTP_TIME_OUT)

-- 鉴权流程
-- login后将sessionid或token 存于localstorage (只能login获取)
-- 前端请求给token/sessionid放于headers里 Authorization
-- 先请求鉴权api 通过 => 走通过的逻辑 白名单 只读用户 等  未通过 => 请求停止

local res, err =
    httpc:request_uri(
    "http://" .. ngx.var.auth_host,
    {
        version = 1.1,
        path = "/auth",
        method = "GET",
        query = ngx.var.args,
        keepalive_timeout = 60,
        keepalive_pool = 10
    }
)

if not res then
    ngx.var.app_name = "auth"
    ngx.exit(ngx.HTTP_BAD_GATEWAY)
end

local args = ngx.req.get_uri_args()
if args["token"] then
    args["token"] = nil
    ngx.req.set_uri_args(args)
end

if res.status == ngx.HTTP_OK then
    local data = cjson.decode(res.body)["DATA"]

    method_verify.method_verify(data["real_user_type"])

    ngx.req.set_header("X-User-Id", data["id"])
    ngx.req.set_header("X-User-Email", common.urlEncode(data["email"]))
    ngx.req.set_header("X-User-Name", common.urlEncode(data['username']))
    ngx.req.set_header("X-User-Type", data["user_type"])
    ngx.req.set_header("X-User-State", data["state"])

    ngx.ctx.userid = data["id"]
    ngx.ctx.user_email = data["email"]
    ngx.ctx.username = data["username"]
    ngx.ctx.user_type = data["user_type"]
    ngx.ctx.user_state = data["state"]

    return
end

ngx.status = res.status
for k, v in pairs(res.headers) do
    ngx.header[k] = v
end
ngx.print(res.body)
