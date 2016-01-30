-- Debian packages nginx-extras, lua-zlib required

local content_encoding = ngx.req.get_headers()["Content-Encoding"]
if content_encoding == "gzip" then
    ngx.req.read_body()
    local data = ngx.req.get_body_data()

    if data ~= nil then
        local inflated = require("zlib").inflate()(data, "finish")

        ngx.req.clear_header("Content-Encoding")
        ngx.req.clear_header("Content-Length")
        ngx.req.set_body_data(inflated)
    end
end
