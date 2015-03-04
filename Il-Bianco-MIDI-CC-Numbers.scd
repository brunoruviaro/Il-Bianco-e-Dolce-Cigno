// *****************************
// MIDI CC Numbers - assignment
// *****************************

// Il Bianco e Dolce Cigno (2015)

// This file is for preparatory set-up only. No need to open it at time of performance.
// Use the MIDIFunc lines below to test your MIDI controller and find out the CC numbers of specific knobs or faders.

// Connect SuperCollider MIDI, if you haven't already:
MIDIIn.connectAll;

// Run the line below to find you CC numbers of your MIDI controller
MIDIFunc.trace(true); // turn trace on

// Run the line below to stop tracing:
MIDIFunc.trace(false); // turn trace off

// *****************************
// MIDI CC Numbers - assignment
// *****************************

// Once you know the number of your knobs and faders, choose two of them to control volumes.
// Type in their numbers below.

// Volume control of all stereo loops
// (choose a knob or a fader from your MIDI controller)
~stereoLoopMasterOutVolumeCCnumber = 17 // knob 8

// Volume control of mono loops (measures 54-86)
// (choose a knob or fader from your MIDI controller)
~monoLoopsMasterOutVolumeCCnum = 14 // knob 7