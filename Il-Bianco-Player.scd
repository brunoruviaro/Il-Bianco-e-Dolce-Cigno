// =============================== //
// Il Bianco e Dolce Cigno
// SCU Chamber Singers
// Premiere on January 29, 2015 with SooperLooper system
// Ported to SuperCollider-only in February
// First performance of SC-only version: March 6, 2015
// =============================== //

// Connect SuperCollider MIDI:
MIDIIn.connectAll;

// Load SuperCollider files one at a time:
"Il-Bianco-Functions.scd".loadRelative;
"Il-Bianco-MIDI.scd".loadRelative;
"Il-Bianco-Synths.scd".loadRelative;

// END
