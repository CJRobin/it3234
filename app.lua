local lapis = require("lapis")
local app = lapis.Application()

app:get("/", function()
  return "Welcome to apps " .. require("lapis.version")
end)

return app
