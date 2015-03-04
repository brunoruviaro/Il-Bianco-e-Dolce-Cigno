// =============================== //
// Il Bianco e dolce cigno SET UP
// SCU Chamber Singers
// Premiere on January 29, 2015 with SooperLooper system
// Ported to SuperCollider-only in February
// First performance of SC-only version: March 6, 2015
// =============================== //

// Connect SuperCollider MIDI:
MIDIIn.connectAll;

// Assignment of knob/fader numbers for volumes control
~stereoLoopMasterOutVolumeCCnumber = 17 // knob 8
~monoLoopsMasterOutVolumeCCnum = 14 // knob 7

// Load SuperCollider files one at a time:
"Il-Bianco-Functions.scd".loadRelative;
"Il-Bianco-MIDI-CC-Numbers.scd".loadRelative;"Il-Bianco-MIDI.scd".loadRelative;
"Il-Bianco-Synths.scd".loadRelative;

// Linux Only: reset Jack AUDIO Connections with jmess:
"jmess -D".unixCmd; // disconnect all audio (clean up)
"jmess --connect ~/Music/SuperCollider/Il-Bianco-e-Dolce-Cigno/il-bianco-jmess-connections.xml".unixCmd;

// Linux only:
// Go to Catia or Qjackctl to verify connections
// Use Ctrl+R to refresh Catia

// END
