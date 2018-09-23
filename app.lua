local lapis = require("lapis")
local app = lapis.Application()

app:get("/", function()
  local csv = require("csv")
  local year = os.date("%Y", os.time())
  local month = os.date("%m", os.time())
  local day = os.date("%d", os.time())
  local hour = os.date("%H", os.time())
  print(os.date("%Y_%m_%d_%H", os.time()))
  local f = csv.open("https://russellthackston.me/etl/sensordata_" .. year .. "_" .. month .. "_" .. day .. "_" .. hour .. ".csv")
  for fields in f:lines() do
    for i, v in ipairs(fields) do
      print(i, v)
    end
  end
  return "Welcome to apps new " .. require("lapis.version")
end)

return app
