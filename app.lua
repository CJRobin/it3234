local lapis = require("lapis")
local app = lapis.Application()

app:get("/", function()
  local csv = require("csv")
  local year = os.date("%Y")
  local month = os.date("%m")
  local day = os.date("%d")
  local hour = tonumber(os.date("%H") +1)

  download("https://russellthackston.me/etl/sensordata_" .. year .. "_" .. month .. "_" .. day .. "_" .. hour .. ".csv", "sensordata_" .. year .. "_" .. month .. "_" .. day .. "_" .. hour .. ".csv")
  -- local http = require("socket.http")
  -- local body, code = http.request("https://russellthackston.me/etl/sensordata_" .. year .. "_" .. month .. "_" .. day .. "_" .. hour .. ".csv")
  -- if not body then
  --   error(code)
  -- end
  -- local f = assert(io.open("sensordata_" .. year .. "_" .. month .. "_" .. day .. "_" .. hour .. ".csv", 'wb')) -- open in "binary" mode
  -- f:write(body)
  -- f:close()
  --
  -- local file = io.open("sensordata_" .. year .. "_" .. month .. "_" .. day .. "_" .. hour .. ".csv", "rb")
  -- local content = file:read("*a")
  -- print(content)


  return "Welcome to apps new " .. require("lapis.version")
end)

function download(url, file)
  local content = http.get(url).readAll()
  if not content then
    error("Could not connect to website")
  end
  f = fs.open(file, "w")
  f.write(content)
  print(content);
  f.close()
end

return app
