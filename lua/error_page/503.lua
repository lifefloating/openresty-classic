-- 503

local err_msg = 'Service ' .. ngx.var.app_name .. '  not found!'
local crlf = '\n'

html =
'<html>'.. crlf ..
'<head><title>503 Service Temporarily Unavailable</title></head>'.. crlf ..
'<body bgcolor=\"white\">'.. crlf ..
'<center><h1>503 Service Temporarily Unavailable</h1></center>'.. crlf ..
'<center><h2>'..err_msg.. '</h2></center>'.. crlf ..
'<hr><center>openresty/'..ngx.var.nginx_version..'</center>'.. crlf ..
'</body>'.. crlf ..
'</html>'.. crlf

ngx.status = ngx.HTTP_SERVICE_UNAVAILABLE
ngx.print(html)
