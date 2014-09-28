
This Lazarus project contains a wrapper unit (hwiringpi.pas) for Gordon Henderson's wiringPi library,
and a small Lazarus console example program.

Gordon's library allows access to some of the Hardware features on the RaspberryPi.  

The wrapper unit allows freepascal access to the GPIO pins for input and output, and pwm output on 
pin 12 (GPIO-18) on the RaspberryPi.

The source file for Gordon's library is inside the wiringPi subdirectory. You can recompile 
the library by executing a simple gcc -c wiringPi.c. 
The resulting wiringPi.o file is whats used by pascal.

Check Gordon's site for more info (https://projects.drogon.net/raspberry-pi/wiringpi).

The hwiringoi.pas file also includes constants to access the pins according to their number on the P1  
connector instead of the the numbering used by the wiringPi library.

Do not use this Library on anything but the RaspberryPi.
Please head over to Gordon's site and drop him a Thank You for his work.

