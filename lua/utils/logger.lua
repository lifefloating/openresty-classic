-- posix记录系统级日志 一般用不到先注掉了
-- 具体文档https://luaposix.github.io/luaposix/modules/posix.syslog.html

local _M = {}


function _M:flog(file, message, mode)
    mode = mode or 'a+b'
    if type(file) == 'string' then
        file = io.open(file, mode)
    end

    file:write(message..'\n')
end

-- function _M:syslog(facility, message, level)
--     if not ngx.ctx.userid then
--         return
--     end

--     local posix = require("posix")
--     local openlog = posix['openlog']
--     local syslog = posix['syslog']

--     if not posix[facility] or not posix[level] then
--         ngx.log(ngx.ERR, 'Facility: ' .. facility .. ' or Level: ' .. level .. ' error!')
--         return
--     end

--     openlog (ngx.ctx.userid, posix['LOG_PID'], posix[facility])
--     syslog(posix[level], message)
-- end

return _M
