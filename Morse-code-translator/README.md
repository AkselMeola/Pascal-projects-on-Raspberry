#Morse code translator

#How it works
Program uses a button that is connected to the GPIO pins. Button acts as a morse key.
Program measures the length of time the button was pressed and then decides if it was
dash or dot. Dashes and dots are added to buffer and when nothing is read from button for some 
time it translates the dashes and dots to ASCII character. 

Time is measured by incrementing signallen variable. 


WiringPi library makes it really easy to get started on GPIO and Pascal.


###RaspBerry Model
This program was made on raspberry model B. 

###wiringPI and lazwiringpi
lazwiringpi.pas: Pascal wrapper unit for Gordon Henderson wiringPi library. 
The source can be found at https://projects.drogon.net/raspberry-pi/wiringpi/. 
Wrapper by Alex Schaller.

See hwiringpi-readme.txt for more info and compiling the wiringPi.c file for your projects.
  
