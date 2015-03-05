// **************************
// FUNCTIONS AND VARIABLES
// **************************
// Il Bianco e Dolce Cigno (2015)


// Array to store recorded loop durations
~loopRecTime = Array.newClear(7);

// Array to store loop rec states (on/off)
~loopRecState = Array.fill(7, 0);

// Array to store loop synth nodes
~loopSynth = Array.newClear(7);

// =========================
// MEASURE REC TIME FUNCTION
// =========================

/*
This function calculates actually recorded time of a loop. Buffers are allocated with a max size in advance, but we don't want to play them in their entirety. We want to play only the amount that was recorded in the last loop. Thus we need to know the elapsed time between start and stop recording.
*/

~measureRecTime = {arg loopNumber, trig;
	case
	{ trig==1 }
	{
		~loopRecTime[loopNumber] = Main.elapsedTime;
		"Calculating rec time for Loop %...".postf(loopNumber);
	}

	{ trig==0 }
	{
		~loopRecTime[loopNumber] = Main.elapsedTime - ~loopRecTime[loopNumber];
		"Loop % rec time: %".postf(loopNumber, ~loopRecTime[loopNumber]);
	};

	"".postln; // blank line
}; // end of Function

// example:
// ~measureRecTime.value(0, 1);
// ~measureRecTime.value(0, 0);
// ~loopRecTime[0];

// =========================
// START RECORDING FUNCTION
// =========================

~startRecording = {arg loopNumber;
	// Update state
	~loopRecState[loopNumber] = 1;
	// Start measuring time
	~measureRecTime.value(loopNumber, 1);

	// Start appropriate rec synth, and
	// store node into loopSynth array
	~loopSynth[loopNumber] =
	if(loopNumber==0,
		{
			// stop playback in case it was playing (but not at very first rec)
			if(~loopSynth[0].notNil, { ~loopSynth[0].set(\freeMe, 0) });
			Synth("recStereo", target: ~loopGroup)
		},
		{
			Synth("recMono", [
				\inbus, ~micMix[loopNumber],
				\bufnum, ~buffers[loopNumber]],
				target: ~loopGroup)
		}
	);

	// Post info
	"REC START".postln;
};

// ========================
// STOP RECORDING FUNCTION
// ========================

~stopRecording = {arg loopNumber;
	// Update state
	~loopRecState[loopNumber] = 0;
	// Stop measuring time
	~measureRecTime.value(loopNumber, 0);
	// Stop rec synth
	~loopSynth[loopNumber].free;
	// Clean up array
	~loopSynth[loopNumber] = nil;
	// Post info
	"REC STOP".postln;
};

"End of Functions file".postln;
