-- hello.lua
local _M = {}

function _M.welcome()
    ngx.say("Welcome to the OpenResty app!")
end

function _M.hello()
    ngx.say("Hello from sandhra!")
end

return _M
