# Il-Bianco-e-Dolce-Cigno
Piece for choir and live looping by Scot Hanna-Weir (based on Arcadelt). Electronics by Bruno Ruviaro.

To-do:

* update PDFs score and midi mappings to include in repo
* Make a nice clean version of Jeff's drawing (hardware connections diagram)

## About This Piece

Check out the score (PDF here -- add link).
Check out these pictures:
Check out this video recording:

## Equipment we used in 2015

* 8 condenser microphones
* 1 eight-channel audio interface (PreSonus 1818 VSL USB)
* 1 Linux laptop running SuperCollider 3.6.6
* 1 small mixer

## MIDI mapping

You need a standard MIDI keyboard with at least two octaves available.
The piece uses midinotes between 48 (C3) and 66 (F#4) to trigger loop recording and playback. Midinotes between 67 and 72 can be used for silent MIDI testing just before performance.

In addition, your MIDI keyboard should have two knobs or faders availables for volume control.

One of your faders/knobs (called stereoLoopOutVolume) will control the playback volume of all playback events except for the aleatoric section starting in m. 69. The other fader/knob (called monoLoopOutVolume) will control the playback volume of the loops in the aleatoric section (mm. 69-86).

Use the file Il-Bianco-MIDI-CC-Numbers.scd to find out the Continuous Control Number (CC number) of each knob/fader available on your MIDI keyboard. Then open the file Il-Bianco-MIDI.scd and change the relevant lines (line numbers 154 and 162) to reflect the CC numbers of the desired knob/faders.

## Microphones Routing

| Microphone | SuperCollider Input |
| ---------- | ------------------- |
| Mic 1 (soprano 1) | SoundIn.ar(0) |
| Mic 2 (soprano 2) | SoundIn.ar(1) |
| Mic 3 (alto 1) | SoundIn.ar(2) |
| Mic 4 (alto 2) | SoundIn.ar(3) |
| Mic 5 (tenor 1) | SoundIn.ar(4) |
| Mic 6 (tenor 2) | SoundIn.ar(5) |
| Mic 7 (bass 1) | SoundIn.ar(6) |
| Mic 8 (bass 2) | SoundIn.ar(7) |

## SuperCollider internal routing

| Input Bus | Loop(s) |
| --------- | ------- |
| SoundIn.ar(0) | feeds loop6 (mono), loop0 (left) |
| SoundIn.ar(1) | feeds loop6 (mono), loop0 (left) |
| SoundIn.ar(2) | feeds loop1 (mono), loop4 (mono), loop0 (left) |
| SoundIn.ar(3) | feeds loop1 (mono), loop4 (mono), loop0 (left) |
| SoundIn.ar(4) | feeds loop2 (mono), loop5 (mono), loop0 (right) |
| SoundIn.ar(5) | feeds loop2 (mono), loop5 (mono), loop0 (right) |
| SoundIn.ar(6) | feeds loop3 (mono), loop0 (right) |
| SoundIn.ar(7) | feeds loop3 (mono), loop0 (right) |

In other words:

**loop0** and **loop7** (stereo) receives sound from all microphones, panned evenly across the stereo field. Soprano mics to the left, bass mics to the right. Loop 7 is for overdub section (bar 52). Code:

    Splay.ar(SoundIn.ar([0, 1, 2, 3, 4, 5, 6, 7]));

**loop1** (mono) receives sound from altos (microphones 3 & 4):

    Mix(SoundIn.ar([2, 3]);

**loop2** (mono) receives sound from tenors (microphones 5 & 6):

    Mix(SoundIn.ar([4, 5]);

**loop3** (mono) receives sound from basses (microphones 7 & 8):

    Mix(SoundIn.ar([6, 7]);

**loop4** (mono) receives sound from altos again (microphones 3 & 4):

    Mix(SoundIn.ar([2, 3]);

**loop5** (mono) receives sound from tenors again (microphones 5 & 6):

    Mix(SoundIn.ar([4, 5]);

**loop6** (mono) receives sound from sopranos (microphones 1 & 2):

    Mix(SoundIn.ar([0, 1]);



* Explain where to change MIDI knob mappings for use of a different keyboard (and/or tell which numbers we are using so anyone could change their keyboard to use those numbers)




    <output>sooperlooper:common_out_1</output>
    <input>calf:reverb_in_l</input>
  </connection>
  <connection>
    <output>sooperlooper:common_out_2</output>
    <input>calf:reverb_in_r</input>
  </connection>


<connection>
    <output>sooperlooper:loop1_out_1</output>
    <input>SuperCollider:in_1</input>
  </connection>
  <connection>
    <output>sooperlooper:loop2_out_1</output>
    <input>SuperCollider:in_2</input>
  </connection>
  <connection>
    <output>sooperlooper:loop3_out_1</output>
    <input>SuperCollider:in_3</input>
  </connection>
  <connection>
    <output>sooperlooper:loop4_out_1</output>
    <input>SuperCollider:in_4</input>
  </connection>
  <connection>
    <output>sooperlooper:loop5_out_1</output>
    <input>SuperCollider:in_5</input>
  </connection>
  <connection>
    <output>sooperlooper:loop6_out_1</output>
    <input>SuperCollider:in_6</input>
  </connection>
  <connection>
    <output>sooperlooper:loop7_out_1</output>
    <input>system:playback_1</input>
  </connection>
  <connection>
    <output>sooperlooper:loop7_out_2</output>
    <input>system:playback_2</input>
  </connection>
  <connection>
    <output>SuperCollider:out_1</output>
    <input>system:playback_1</input>
  </connection>
  <connection>
    <output>SuperCollider:out_2</output>
    <input>system:playback_2</input>
  </connection>
  <connection>
    <output>SuperCollider:out_3</output>
    <input>system:playback_3</input>
  </connection>
  <connection>
    <output>SuperCollider:out_4</output>
    <input>system:playback_4</input>
  </connection>
  <connection>
    <output>SuperCollider:out_5</output>
    <input>system:playback_5</input>
  </connection>
  <connection>
    <output>SuperCollider:out_6</output>
    <input>system:playback_6</input>
  </connection>
  <connection>
    <output>SuperCollider:out_7</output>
    <input>system:playback_7</input>
  </connection>
  <connection>
    <output>SuperCollider:out_8</output>
    <input>system:playback_8</input>
  </connection>
  <connection>
    <output>calf:reverb_out_l</output>
    <input>system:playback_1</input>
  </connection>
  <connection>
    <output>calf:reverb_out_r</output>
    <input>system:playback_2</input>
  </connection>
</jmess>
