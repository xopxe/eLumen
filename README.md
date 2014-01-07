eLumen
======

Coroutine based scheduler for eLua.

This is basically the [Lumen](https://github.com/xopxe/Lumen) scheduler after being pruned from the less used stuff. There is space for more prunning, tough.

The main difference is that unlike Lumen, were signals are a event plus a vararg of parameters, in eLumen signals are a event plus a single parameter (you can send a table if you wish, of course).

This is tested on a MBED board. To port to another board, the only change neede is in the get_time() function. You must provide a method for reading the time (for example, on MBED it is doing  _return tmr.read(0)_).

There is a test.lua script (also for MBED). It will blink led1 at 1Hz, and togle led2 and led3 with the keys "q" and "a" respectivelly. It will aslo print memory usage, at the script starting time, after loading the scheduler, after setting up the tasks, and then while running once a second.


TODO
----

* Think what more functionality to cull, or restore.
* Update inline docs.
* Look into idle() function, perhaps do semething smarter than busy waiting.


