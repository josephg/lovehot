function love.conf(t)
  t.console = true
  t.identity = "hot"
  t.window.title = "hot"
  t.window.resizable = true
  --t.window.fullscreen = true

  t.modules.joystick = false
  t.modules.physics = false
  t.modules.video = false
  
  t.window.width = 1024
  t.window.height = 768
end
