-- app文件日志

require "conf"
local cjson = require "cjson"
local common = require "utils.common"

if (not ngx.var.app_addr or string.len(ngx.var.app_addr) == 0) then
    return
end

local Logger = require "utils.logger"

-- file log
local logpth = LOG_DIR .. string.format('app.log.%s', os.date("%Y-%m-%d", os.time()))
local app_url = '-'
if (ngx.var.app_uri) then
    app_url = 'http://' .. (ngx.var.upstream_addr or '')
    .. ngx.var.app_uri
    .. (ngx.var.is_args or '')
    .. (ngx.var.args or '')
end

local req_body, req_body_len = "-", string.len((ngx.var.request_body or ''))
if req_body_len > 0 and req_body_len < 1024 then
    req_body = ngx.var.request_body
end

local msg = string.format(
'[%s] [%s] %s %s %s %d %ss %s Request[%s]: %s Response[%s]: %s',
ngx.var.app_name or '-',
ngx.var.time_local,
ngx.var.remote_addr,
ngx.ctx.username or '-',
ngx.var.request_method,
ngx.var.status,
(ngx.var.upstream_response_time or 0),
app_url,
req_body_len,
req_body,
ngx.var.body_bytes_sent,
ngx.ctx.resp or '-'
)
Logger:flog(logpth, msg)
