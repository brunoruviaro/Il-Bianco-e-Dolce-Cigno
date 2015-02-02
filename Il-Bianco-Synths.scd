// **********
// SYNTHS
// **********
// Il Bianco e Dolce Cigno (2015)



// Increase Server Memory

o = Server.local.options;
o.memSize;
o.memSize = 409600;
o.memSize; // verify

s.waitForBoot({

	{
		// Allocate one buffer per loop (generous max dur of 12 sec);
		// First buffer is stereo;
		// Six remaining buffers are mono.
		~buffers = Array.with(
			Buffer.alloc(s, 44100 * 12, 2),
			{ Buffer.alloc(s, 44100 * 12, 1) }.dup(6)).flat;

		// Groups
		~micGroup = Group.new;
		~loopGroup = Group.new(~micGroup, \addAfter);

		s.sync;

		// Create busses to mix mic inputs
		// First bus is stereo
		// Remaining 6 are mono
		~micMix = Array.with(
			Bus.audio(s, 2),
			{ Bus.audio(s, 1) }.dup(6)).flat;

		// To feed loop0
		{ Out.ar(~micMix[0], Splay.ar(SoundIn.ar((0..7)))) }.play(~micGroup);

		// To feed loop1
		{
			Out.ar(~micMix[1], Mix(SoundIn.ar([2, 3])))
		}.play(~micGroup);

		// To feed loop2
		{
			Out.ar(~micMix[2], Mix(SoundIn.ar([4, 5])))
		}.play(~micGroup);

		// To feed loop3
		{
			Out.ar(~micMix[3], Mix(SoundIn.ar([6, 7])))
		}.play(~micGroup);

		// To feed loop4
		{
			Out.ar(~micMix[4], Mix(SoundIn.ar([2, 3])))
		}.play(~micGroup);

		// To feed loop5
		{
			Out.ar(~micMix[5], Mix(SoundIn.ar([4, 5])))
		}.play(~micGroup);

		// To feed loop6
		{
			Out.ar(~micMix[6], Mix(SoundIn.ar([0, 1])))
		}.play(~micGroup);



		SynthDef("recMono", { arg inbus, bufnum;
			RecordBuf.ar(
				inputArray: In.ar(inbus, 1),
				bufnum: bufnum,
				loop: 0);
		}).add;

		SynthDef("recStereo", {
			RecordBuf.ar(
				inputArray: In.ar(~micMix[0], 2),
				bufnum: ~buffers[0], // this synth for buffer 0 only
				loop: 0);
		}).add;

		SynthDef("playMono", { arg amp = 1, bufnum = 1, dur = 1;
			var snd, env, att, rel, sus;
			att = 0.05;
			rel = 0.1;
			sus = dur - att - rel;
			env = Env.linen(att, sus, rel, amp).kr(2);
			snd = PlayBuf.ar(1, 0) * env;
			Out.ar(0, [snd, snd]);
		}).add;

		SynthDef("playStereo", { arg amp = 1, dur = 1, pause = 1, freeMe = 1;
			var snd, env, att, rel, sus, pauseEnv, freeMeEnv;
			// doneAction 1 allows for pausing the UGen
			// pauseEnv avoids clicks at start and end of pause
			pauseEnv = Env.asr(0.1, 1, 0.1).kr(doneAction: 1, gate: pause);
			freeMeEnv = Env.asr(0.0, 1, 0.1).kr(doneAction: 2, gate: freeMe);
			att = 0.05;
			rel = 0.1;
			sus = dur - att - rel;
			env = Env.linen(att, sus, rel, amp).kr;
			snd = PlayBuf.ar(2, ~buffers[0]) * env * pauseEnv * freeMeEnv;
			Out.ar(0, snd);
		}).add;

		// NOTE:
		// The ability to "pause" is only needed in the playStereo.
		// (Only loop 0 will use it)

		"Server on, Synths loaded".postln;

	}.fork;

}); // end of waitForBoot