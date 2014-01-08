print ('starting', collectgarbage('count') )

package.path = package.path .. ";;;/semi/?.lua"
local sched = require 'sched'

print ('sched loaded', collectgarbage('count') )

local led1 = mbed.pio.LED1
local led2 = mbed.pio.LED2
local led3 = mbed.pio.LED3
pio.pin.setdir(pio.OUTPUT, led1)
pio.pin.setdir(pio.OUTPUT, led2)
pio.pin.setdir(pio.OUTPUT, led3)

-- this task will toggle led1 at 2Hz
sched.run(function()
  while true do
    pio.pin.sethigh(led1)
    sched.sleep(500000) -- delay is in usecs
    pio.pin.setlow(led1)
    sched.sleep(500000) -- delay is in usecs
    print ('running', collectgarbage('count') )
  end
end)

-- this task will emit a signal with each char arrived from terminal
sched.run(function()
  while true do
    local char = term.getchar(term.NOWAIT)
    if char > -1 then
      sched.signal(string.char(char))
    end
    sched.wait()
  end
end)

-- when catching a signal with specific chars, toggle some leds.
sched.sigrun({'q', 'Q'}, function()
    pio.pin.setval( 1-pio.pin.getval(led2), led2)
end)
sched.sigrun({'w', 'W'}, function()
    pio.pin.setval( 1-pio.pin.getval(led3), led3)
end)

print ('ready to run', collectgarbage('count') )

sched.loop()
