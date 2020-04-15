LOG_RESP = false

HTTP_TIME_OUT = 60000

SLEEP_TIME = 300
LICENSE_CACHE = false

-- 这里格式需和后台统一
RESULT = {}
RESULT["STATUS"] = "NO_PERMISSION"
RESULT["DESCRIPTION"] = ""
RESULT["STATUS_CH"] = "没有权限"
RESULT["STATUS_EN"] = "no permission"

-- 可设置只读用户权限
-- 用户类型
READ_ONLY_USER_TYPE = {1}

-- 白名单
WHITE_LIST = {
    {method = "POST", app_uri = "/v1/admin/test"}
}
