







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