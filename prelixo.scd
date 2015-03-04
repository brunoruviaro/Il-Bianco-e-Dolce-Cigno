SynthDef("recStereoOverdub", {

	var recFadeIn = Line.kr(start: 0, end: 1, dur: 2);
	var recDur = 6; // total fixed duration of recording/overdubbing
	var snd, playEnv;

	RecordBuf.ar(
		inputArray: In.ar(~micMix[0], 2) * recFadeIn,
		bufnum: ~buffers[7], // shorter buffer for overdub part
		recLevel: 0.75,
		preLevel: 0.75,
		run: Env.new([1, 1, 0], [recDur, 1]).kr, // turn rec off
		loop: 1);

	// this playEnv expects a manual release message
	// playEnv = Env.asr(3, 1, 8).kr(doneAction: 2, gate: 1);

	// this playEnv does it all automatically (fixed times)
	playEnv = Env.new([0, 1, 1, 0], [3, 10, 6]).kr(doneAction: 2);

	snd = PlayBuf.ar(2, b, loop: 1) * playEnv;

	Out.ar(0, snd);

}).add;



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
		},
		{
			~overdubNode.free;
			~overdubOnOff = 0;
		}
	);
	},
	noteNum: 52);
// end of MIDIdef overdub






// create a shorter buffer for overdub only (4-6 sec?)

// Note E (midi 52) triggers the synth above
// Note E (midi 52) when played again sends gate=0 to stop it

// SynthDef should do it all:

// start recording with volume zero
// loop: 1
// recLevel: 0.5, preLevel: 0.5 (overdub)
// ramp up input from 0 to 1 over about 2-3 seconds?
// when it reaches max, stay there for about 3 sec
// then synth stops recording
// all the time synth is playing back buffer (perhaps also with ramp 0-1 at first)
// it should remain playing for a while, then fade down automatically over X seconds


Synth("recStereoOverdub"); // starts rec fade in 0-1

/*
(
b.free;
b = Buffer.alloc(s, 44100 * 4);
)
(
{
RecordBuf.ar(
inputArray: SinOsc.ar(mul: LFPulse.kr(0.9,0,0.05)),
bufnum: b,
recLevel: 0.5,
preLevel: 0.5,
run: Env.new([1, 1, 0], [8, 0]).kr,
loop: 1);

Out.ar(5, PlayBuf.ar(1, b, loop: 1));

}.scope;
)

b.plot;

s.plotTree


*/