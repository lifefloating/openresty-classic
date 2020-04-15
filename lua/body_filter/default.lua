require "conf"
-- 用于logger的处理 响应内容写入resp
if not LOG_RESP then
    ngx.ctx.resp = '-'
    return
end

local chunk = ngx.arg[1]

if (string.len(chunk) > 0) then
    ngx.ctx.resp = chunk
end
