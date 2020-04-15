-- 超时处理

local err_msg = ' Timeout for reading a response from ' .. ngx.var.app_name
if ngx.var.upstream_response_time then
     err_msg = err_msg .. ' ('.. ngx.var.upstream_response_time ..'s)'
end
local crlf = '\n'

html =
'<html>'.. crlf ..
'<head><title>504 Gateway Time-out</title></head>'.. crlf ..
'<body bgcolor=\"white\">'.. crlf ..
'<center><h1>504 Gateway Time-out</h1></center>'.. crlf ..
'<center><h2>'..err_msg.. '</h2></center>'.. crlf ..
'<hr><center>openresty/'..ngx.var.nginx_version..'</center>'.. crlf ..
'</body>'.. crlf ..
'</html>'.. crlf

ngx.status = ngx.HTTP_GATEWAY_TIMEOUT
ngx.print(html)