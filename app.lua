local lapis = require("lapis")
local app = lapis.Application()

app:get("/", function()
  return "Welcome to app " .. require("lapis.version")
end)

return app
