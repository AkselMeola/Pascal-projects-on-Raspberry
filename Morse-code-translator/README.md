# Morse code translator

# How it works
Program uses a button that is connected to the GPIO pins and acts as a morse key.
Main loop checks if button is pressed and if so, measures the length of time it is pressed. When button is released again it decides if it was a dash or dot. Time is measured by incrementing signallen variable on every iteration the button state is read as on/pushed.  
Dashes and dots are collected to buffer string and when nothing is read from button for some 
time it finishes the reading of one letter and translates the dashes and dots in buffer string to ASCII character.  
On longer delays it adds a space between letters/words and when waiting even longer it finishes the sentence with a dot.
Program also checks what character was inserted last so it will not add duplicate spaces or dots when button is not pressed for a very long time.


### RaspBerry Model
This program was made on raspberry model B. 

### wiringPI and lazwiringpi
WiringPi library makes it really easy to get started on GPIO and Pascal.

lazwiringpi.pas: Pascal wrapper unit for Gordon Henderson wiringPi library. 
The source can be found at https://projects.drogon.net/raspberry-pi/wiringpi/. 
Wrapper by Alex Schaller.

See hwiringpi-readme.txt for more info and compiling the wiringPi.c file for your projects.
  
