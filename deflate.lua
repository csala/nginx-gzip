-- Debian packages nginx-extras, lua-zlib required

local content_encoding = ngx.req.get_headers()["Content-Encoding"]
if content_encoding ~= "gzip" then
    ngx.req.read_body()
    local data = ngx.req.get_body_data()

    if data ~= nil then
        local deflated = require("zlib").deflate()(data, "finish")

        ngx.req.set_header("Content-Encoding", "gzip")
        ngx.req.set_body_data(deflated)
    end
end
