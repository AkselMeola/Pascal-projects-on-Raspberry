program raspberry;

{$MODE OBJFPC}

Uses
	hwiringpi, SysUtils;
    	
Const
	Alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	
	Morse : array[1..26] of string = ('.-', '-...', '-.-.', '-..', '.', 
	'..-.','--.','....','..','.---', '-.-', '.-..','--', '-.' , '---', 
	'.--.','--.-','.-.', '...', '-', '..-', '...-', '.--', '-..-', 
	'-.--', '--..' );  

Var
 	pin, lastpin : longint;
	signallen : integer;
	morsebuffer, message : string;
	 
	
	
	
(*
 *	Function converts morse code characters to 
 *	ASCII characters.
 *
 *	@param morsechar - character's morse representation
 *)
function morseToChr( morsechar :string ):char;
Var
	i : byte;
begin
	for i:=1 to 26 do
		if Morse[i] = morsechar then exit(Alphabet[i]);
	exit(chr(0));		
end;
	
	
	
(*
 * Main program
 *
 *)	
begin

	writeln('Morse key reader');

	lastpin := 1;		// Last status of the GPIO pin
	signallen := 0;		// How long the Pin status has been unchanged
	morsebuffer := '';	// hold dashes and dots for letters
	message := '';		// Whole written message

	writeln(message[length(message)]);

	If wiringPiSetup <> -1 then Begin

		// Set to use GPIO pin numbering
		wiringPiGpioMode( WPI_MODE_GPIO );
		
		// Setup as input pin
		pinMode( 2, INPUT );
		
		
		// Use pullup resistor to protect against 
		// interference
		pullUpDnControl(2, PUD_UP);
		
		while true do begin
	
			// Read pin value
			pin := digitalRead(2);
	
			// Test if pin value has changed		
			if pin <> lastpin then begin
								
				// process signal length
				if lastpin = 0 then
					// Dash or dot ?
					if signallen > 30 then morsebuffer := morsebuffer + '-'
					else morsebuffer := morsebuffer + '.';
					
				// Set lastpin to new pin value
				lastpin := pin;
								
				// Reset signal length
				signallen := 0;
				
			end;
			
			// Test for empty signal lengths			
			case signallen of
				// write out the letter if no input change in 80 reads 
				80..250	:	begin
									if morseToChr(morsebuffer) <> chr(0) then
										message := message + morseToChr(morsebuffer); 
									write(morseToChr(morsebuffer));
									morsebuffer := '';
								end;
				// Add space for words if no change in input for 250 reads				
				251..1000:	if message[ Length(message) ] <> ' ' then begin
									message := message + ' ';
									write(' ');
								end;									
								
				// Add end of sentence if no input for 1000 reads				
				1001..4000:	if message[ Length(message) ] <> '.' then begin
									message := message + '.';
									write('.');
								end;	
							
			end;
			
			// Increment signal length			
			inc(signallen);
			
			// Wait a bit
	    	delay( 10 );
	    	
		end;

   End // setup end
   Else
      writeln('Error Setting up the wiringPi');
  	
end.

