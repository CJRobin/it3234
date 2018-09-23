local lapis = require("lapis")
local app = lapis.Application()

app:get("/", function()
  local csv = require("csv")
  local year = os.date("%Y")
  local month = os.date("%m")
  local day = os.date("%d")
  local hour = os.date("%H")
  local f = csv.open("https://russellthackston.me/etl/sensordata_" .. year .. "_" .. month .. "_" .. day .. "_" .. hour .. ".csv")
  for fields in f:lines() do
    for i, v in ipairs(fields) do 
      return i .. "_" .. v
    end
  end
end)

return app
