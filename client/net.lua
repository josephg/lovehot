--local baseURL = 'http://localhost:2000'
local baseURL = 'http://sephsmac.local:2000'

local http = require('socket.http')
--http.TIMEOUT = 1

love.filesystem.setRequirePath(love.filesystem.getRequirePath()..';_bundle/?.lua;_bundle/?/init.lua')

local function makeDirs(fullpath)
  local pathsep = string.sub(fullpath, 1, string.match(fullpath, '()/[%w. -]*$'))
  love.filesystem.createDirectory(pathsep)
end

local function getBundle()
  local bundle, code, h = http.request(baseURL..'/contents')
  if code ~= 200 then error('blerp') end

  local sep = h['x-sep']

  local files = {}

  local iter = 0
  
  local seps = {}
  local nextPos = 1
  repeat
    local e, filename, p = string.match(bundle, "()"..sep.." (%g+)()", nextPos, true)
    if p ~= nil then
      nextPos = p + 1
      seps[#seps+1] = {e, filename, p+1}
    end
  until p == nil

  local dest = '_bundle' --love.filesystem.getSaveDirectory() .. '/_bundle'
  if not love.filesystem.createDirectory(dest) then
    error('Could not create output dir '..dest)
  end

  for i,s in ipairs(seps) do
    local _, filename, startContent = unpack(s)
    --local startContent = string.find(bundle, '\n', pos, true) + 1
    local c = string.sub(bundle, startContent, seps[i+1] and seps[i+1][1]-2 or -2)
    
    local destFilename = dest..'/'..filename

    makeDirs(destFilename)
    local result, err = love.filesystem.write(destFilename, c)
    if not result then error(err) end

    print('wrote '..#c..' bytes to '..destFilename)

    --print(filename, startContent, "'"..c.."'")
  end
end

local callbacks = {"load", "update", "draw", "keypressed", "keyreleased",
  "mousepressed", "mousereleased", "mousemoved", "wheelmoved", "touchpressed"}
local function empty() end
local function runFromBundle()
  -- Save which modules were loaded before the game
  local loaded = {}
  for lib in pairs(package.loaded) do
    loaded[lib] = true
  end

	for i, v in ipairs(callbacks) do love[v] = empty end
  love.filesystem.load('_bundle/main.lua')()

  love.graphics.setBackgroundColor(0, 0, 0)
  love.graphics.setColor(255, 255, 255)
  love.graphics.setLineWidth(1)
  love.graphics.setLineStyle("smooth")
  love.graphics.setBlendMode("alpha")
  love.mouse.setVisible(true)

  local function reload()
    for lib in pairs(package.loaded) do
      if not loaded[lib] then
        package.loaded[lib] = nil
      end
    end

    getBundle()
    runFromBundle()
  end
  -- Install refresh handlers
  local _keypressed = love.keypressed
  function love.keypressed(k, ...)
    if k == 'r' and love.keyboard.isDown('lshift') then
      reload()
    else
      _keypressed(k, ...)
    end

  end

  local _touchpressed = love.touchpressed
  function love.touchpressed(...)
    print('touchpressed', #love.touch.getTouches())
    if #love.touch.getTouches() == 5 then
      reload()
    else
      _touchpressed(...)
    end
  end
  

  love.load()
end

getBundle()
runFromBundle()
