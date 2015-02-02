// *******
// MIDI
// *******
// Il Bianco e Dolce Cigno (2015)



// MIDIDefs

MIDIdef.noteOn(\loopRec, {arg val, note;
	var loopNumber = case
	{note==48} {0}
	{note==53} {1}
	{note==55} {2}
	{note==57} {3}
	{note==60} {4}
	{note==62} {5}
	{note==65} {6};

	"loop number % %\n".postf(loopNumber);

	case
	{ ~loopRecState[loopNumber]==0 }
	{ ~startRecording.value(loopNumber) }

	{ ~loopRecState[loopNumber]==1 }
	{ ~stopRecording.value(loopNumber) };
},
	// for recording, listen only for the following MIDI notes:
	noteNum: [48, 53, 55, 57, 60, 62, 65]
); // end of MIDIdef loopRec

// A variable to keep state of pause:
~loop0pause = 0;

MIDIdef.noteOn(\loop0pause, {
	// Pause pressed while loop0 is recording?
	// stop recording, do nothing else.
	//
	// Pause pressed while loop0 is playing?
	// pause it.
	//
	// Pause pressed while loop0 is paused?
	// resume from where it left off.

	case
	{ ~loopRecState[0]==1 }
	{ ~stopRecording.value(0) }

	{~loop0pause==0}
	{ // Pause
		~loopSynth[0].set(\pause, 0);
		~loop0pause = 1;
		"PAUSE".postln;
	}

	{~loop0pause==1}
	{ // Unpause
		~loopSynth[0].run(true);
		~loopSynth[0].set(\pause, 1);
		~loop0pause = 0;
		"UNPAUSE".postln;
	}; // end case
},
	noteNum: 49); // end of MIDIdef loop0pause

MIDIdef.noteOn(\loop0once, {
	// ONCE pressed while loop0 is recording?
	// stop recording.
	//
	// ONCE pressed while loop0 is playing?
	// release it, restart from beginning.

	if(~loopRecState[0]==1, { ~stopRecording.value(0) });

	~loopSynth[0].set(\freeMe, 0); // stop and free node if it was playing
	~loopSynth[0] = Synth("playStereo", [
		\dur, ~loopRecTime[0],
		\amp, 1 ],
	target: ~loopGroup);
	},
	noteNum: [50, 51]); // end of MIDIdef loop0once (also D# to mimic SooperLooper)


// Play silent higher notes just to test MIDI connection

MIDIdef.noteOn(\test, {arg val, note;
	var noteName =
	case
	{note==67} {"G5"}
	{note==68} {"G#5"}
	{note==69} {"A5"}
	{note==70} {"Bb5"}
	{note==71} {"B5"}
	{note==72} {"C6"};

	"TEST: % %\n".postf(noteName);
	},
	noteNum: [67, 68, 69, 70, 71, 72]
);


"End of MIDIdefs file; play a key between G5-C6 for a silent test.".postln;
 // end of MIDI block

