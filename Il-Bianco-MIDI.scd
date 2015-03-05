// *******
// MIDI
// *******
// Il Bianco e Dolce Cigno (2015)

// MIDIDefs

// REC for all loops
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

// PAUSE for loop0 only
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

// ONCE for loop0 only
MIDIdef.noteOn(\loop0once, {
	// ONCE pressed while loop0 is recording or playing?
	// stop recording or playing.
	// Then play the loop right away.

	if(~loopSynth[0].notNil, // is it doing something? (playing or recording?)
		{
			if(~loopRecState[0]==1, // if recording...
				{ ~stopRecording.value(0) }, // ...then stop recording
				{ ~loopSynth[0].set(\freeMe, 0) } // ... else, stop playing
			)
		}
	);

	 // Now start playing from beginning:
	~loopSynth[0] = Synth("playStereo", [
		\dur, ~loopRecTime[0],
		\amp, 1 ],
		target: ~loopGroup);
	},
	noteNum: [50, 51]);
// end of MIDIdef loop0once (also D# to mimic SooperLooper)





// OVERDUB key

~overdubOnOff = 0;
~overdubNode = nil;

MIDIdef.noteOn(\overdub, {
	// E natural (midi 52) triggers the overdub moment.
	// All happens automatically in the Synth:
	// start overdub synth, fadeIn input volume,
	// start playback soon after, stop overdub, stop playback, etc.
	// This MIDIdef starts the synth if it was off;
	// or frees the synth if it was running.

	if(~overdubOnOff==0,
		{
			~overdubNode = Synth("recStereoOverdub", target: ~loopGroup);
			~overdubOnOff = 1;
			"Starting rec overdub...".postln;
		},
		{
			~overdubNode.release;
			~overdubOnOff = 0;
			"Overdubbed note released".postln;
		}
	);
	},
	noteNum: 52);
// end of MIDIdef overdub





// Synth playDelays:
// Sharp keys trigger playback with delay line for mono loops
MIDIdef.noteOn(\onces, {arg vel, note;
	var loopNumber;
	case
	{note==54} { loopNumber = 1 }
	{note==56} { loopNumber = 2 }
	{note==58} { loopNumber = 3 }
	{note==61} { loopNumber = 4 }
	{note==63} { loopNumber = 5 }
	{note==66} { loopNumber = 6 };

	Synth("playDelay", [
		\bufnum, ~buffers[loopNumber],
		\delayTime, rrand(3, 8),
		\decayTime, vel.linlin(0, 127, 15, 40),
		\amp, vel/127,
		\dur, ~loopRecTime[loopNumber],
	], target: ~loopGroup);

	[note, "looping!"].postln;
	},
	noteNum: [54, 56, 58, 61, 63, 66]; // only listen to these
);
// End of playDelays

// Stereo Loop master volume output:
MIDIdef.cc(\stereoLoopOutVolume, {arg val;
	~stereoLoopMasterOutVolume.value = val/127;
	["main volume", val].postln;
	},
	ccNum: 7;
);

// Mono Loops master volume output:
MIDIdef.cc(\monoLoopsOutVolume, {arg val;
	~monoLoopsMasterOutVolume.value = val/127;
	["aleatoric loops volume", val].postln;
	},
	ccNum: 1;
);

/*
// DEPRECATED
// Input level of loop0 input bus (stereo mix of all mics)
// This is for the smooth sustained chord moment
MIDIdef.cc(\loop0inVolume, {arg val;
	~stereoLoopInputBusVolume.value = val/127;
	},
	ccNum: 73 // knob 1
);
*/

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

