// =============================== //
// Il Bianco e dolce cigno SET UP
// Concert on January 29, 2015
// SCU Chamber Singers
// =============================== //

// Connect SuperCollider MIDI
MIDIIn.connectAll;

// Load SuperCollider files
"Il-Bianco-Functions.scd".loadRelative;
"Il-Bianco-MIDI.scd".loadRelative;
"Il-Bianco-Synths.scd".loadRelative;

s.plotTree


// Jack AUDIO Connections with jmess (Linux only)
"jmess -D".unixCmd; // disconnect all audio (clean up)
"jmess --connect ~/Music/SuperCollider/Il-Bianco-e-Dolce-Cigno/chamber-singers-v4-jmess.xml".unixCmd;

// Go to Catia or Qjackctl to verify connections
// Use Ctrl+R to refresh Catia


// END
