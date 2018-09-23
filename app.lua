local lapis = require("lapis")
local app = lapis.Application()

app:get("/", function()
  local csv = require("csv")
  local year = os.date("%Y")
  local month = os.date("%m")
  local day = os.date("%d")
  local hour = tonumber(os.date("%H") +1)
  print(hour)
  local f = csv.open("https://russellthackston.me/etl/sensordata_" .. year .. "_" .. month .. "_" .. day .. "_" .. hour .. ".csv")
  for fields in f:lines() do
    for i, v in ipairs(fields) do
      print(i, v)
    end
  end
  return "Welcome to apps new " .. require("lapis.version")
end)

return app
