-- 网关错误

local err_msg = 'Service ' .. ngx.var.app_name .. ' failed!'
local crlf = '\n'

html =
'<html>'.. crlf ..
'<head><title>502 Bad Gateway</title></head>'.. crlf ..
'<body bgcolor=\"white\">'.. crlf ..
'<center><h1>502 Bad Gateway</h1></center>'.. crlf ..
'<center><h2>'..err_msg.. '</h2></center>'.. crlf ..
'<hr><center>openresty/'..ngx.var.nginx_version..'</center>'.. crlf ..
'</body>'.. crlf ..
'</html>'.. crlf

ngx.status = ngx.HTTP_BAD_GATEWAY
ngx.print(html)