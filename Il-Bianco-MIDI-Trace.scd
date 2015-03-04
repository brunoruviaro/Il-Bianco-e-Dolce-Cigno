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

// Once you now the CC numbers of your faders/knobs, open the file Il-Bianco-MIDI.scd and change the relevant lines (line numbers 154 and 162).