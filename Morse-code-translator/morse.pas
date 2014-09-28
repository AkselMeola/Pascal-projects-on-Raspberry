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
	
	LETTEREND 	= 80;
	WORDEND 		= 250;
	SENTENCEEND = 1000;

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
	
			{ Test for pin status change }		
			if pin <> lastpin then begin
								
				// if pin status change indicates 
				// that button was released 
				if lastpin = 0 then 
					// Is it dash or dot then ?
					if signallen > 30 then morsebuffer := morsebuffer + '-'
					else morsebuffer := morsebuffer + '.';
					
				// Set lastpin to new pin status
				lastpin := pin;
								
				// Reset signal length
				signallen := 0;
				
			end;
			
			
			{ Tests for signal length }
			// Write out letter when there is no signal change in LETTEREND reads			
			if (signallen > LETTEREND ) and (morseToChr(morsebuffer)<>chr(0)) then begin
				message := message + morseToChr(morsebuffer); 
				write(morseToChr(morsebuffer));
				morsebuffer := '';
			end
			// Write out space when there is no signal change for WORDEND reads. 
			// If last caharacter of message is allready space then don't add any more. 
			else if (signallen > WORDEND ) and (message[ Length(message) ] <> ' ') then begin
				message := message + ' ';
				write(' ');			
			end
			// Write out dot(.) when there is no signal change for SENTENCEEND reads. 
			// If last caharacter of message is allready dot then don't add any. 
			else if (signallen > SENTENCEEND) and (message[ Length(message) ] <> '.') then begin
				message := message + '.';
				write('. ');			
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

