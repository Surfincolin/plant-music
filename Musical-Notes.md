
##Music for 18 Musicians.
###Chord
- C# F# G#
F2# B2 -- D4 A4 D5 E5 A5 D6
42  47	  62 69 74 76 81 86
--
B2  F3# -- D4 E4 A4 D5 E5 A5 D6
--

--
F2# C3# -- E4 A4 B4 E5 A5 B5 E6
30  37     52 57 59 64 69 71 76
--
D2 A2 -- E4 F4# G4# B4 E5 B5
26 33    52 54  56 59 64 71
--
A2 E3 -- E4 F4# G4# B4 C5# E5 B5
33 40    52 54  56  59 61  64 71
--
C3# F3# -- F4# G4# A4 C5# A5 C6#
37  42     54  56  57 61  69 73
--
F2# C3# -- F4# G4# A4 B4 C5# F5#
30  37     54  56  57 59 61  
--
E2 A2 -- C4 F4# G4# A4 B4 E5 G5# B5 E6

--
D2 A2 -- F4 G4# A4 E5 A5 E6

--
A2 D3 -- E4 F4# A4 E5 A5


1
"F2# B2 D4 A4 D5 E5 A5 D6"
"30 35 50 57 62 64 69 74"
2
"B2 F3# D4 E4 A4 D5 E5 A5 D6"
"35 42 50 52 57 62 64 69 74"
3
"F2# C3# E4 A4 B4 E5 A5 B5 E6"
"30 37 52 57 59 64 69 71 76"
4
"D2 A2 E4 F4# G4# B4 E5 B5"
"26 33 52 54 56 59 64 71"
5
"A2 E3 E4 F4# G4# B4 C5# E5 B5"
"33 40 52 54 56 59 61 64 71"
6
"C3# F3# F4# G4# A4 C5# A5 C6#"
"37 42 54 56 57 61 69 73"
7
"F2# C3# F4# G4# A4 B4 C5# F5#"
"30 37 54 56 57 59 61 66"
8
"E2 A2 C4 F4# G4# A4 B4 E5 G5# B5 E6"
"28 33 48 54 56 57 59 64 68 71 76"
9
"D2 A2 F4 G4# A4 E5 A5 E6"
"26 33 53 56 57 64 69 76"
10
"A2 D3 E4 F4# A4 E5 A5"
"33 38 52 54 57 64 69"
+_+_+_+_+_+_+_+_+_
+_+_+_+_+_+_+_+_+_
_+_+_+_+_+_+_+_+_+
_+_+_+_+_+_+_+_+_+

var sets = [['F2# B2 D4 A4 D5 E5 A5 D6'],
['B2 F3# D4 E4 A4 D5 E5 A5 D6'],
['F2# C3# E4 A4 B4 E5 A5 B5 E6'],
['D2 A2 E4 F4# G4# B4 E5 B5'],
['A2 E3 E4 F4# G4# B4 C5# E5 B5'],
['C3# F3# F4# G4# A4 C5# A5 C6#'],
['F2# C3# F4# G4# A4 B4 C5# F5# '],
['E2 A2 C4 F4# G4# A4 B4 E5 G5# B5 E6'],
['D2 A2 F4 G4# A4 E5 A5 E6'],
['A2 D3 E4 F4# A4 E5 A5']];

var Notes = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B'];
var count = 127;
var octave = -1;

var all = {};

for ( var i = 0; i <= count; i++) {
  var n = i % Notes.length;
  if (n == 0) { octave++ };
  
  var curN = Notes[n].split('#');
  
  var noteString = (curN.length > 1) ? curN[0] + octave + '#' : curN[0] + octave;
  
  all[noteString] = i;
  
  
}

//Print Out

function printSet(noteArray, name) {
  console.log(name);
  console.log(noteArray.join(" "));
  var midiNotes = [];
  for (var i in noteArray) {
    var n = noteArray[i];
    midiNotes.push(all[n]);
  }
  console.log(midiNotes.join(" "));
  
}

function setToArrays(stringSet) {
  var results = [];
  for (var i=0; i < stringSet.length; i++) {
    var s = stringSet[i];
    results.push(s.split(" "));
  }
  return results;
}

var sets = ['F2# B2 D4 A4 D5 E5 A5 D6',
'B2 F3# D4 E4 A4 D5 E5 A5 D6',
'F2# C3# E4 A4 B4 E5 A5 B5 E6',
'D2 A2 E4 F4# G4# B4 E5 B5',
'A2 E3 E4 F4# G4# B4 C5# E5 B5',
'C3# F3# F4# G4# A4 C5# A5 C6#',
'F2# C3# F4# G4# A4 B4 C5# F5#',
'E2 A2 C4 F4# G4# A4 B4 E5 G5# B5 E6',
'D2 A2 F4 G4# A4 E5 A5 E6',
'A2 D3 E4 F4# A4 E5 A5'];

var setArrays = setToArrays(sets);

for (var i in setArrays) {
  var curSet = setArrays[i];
  printSet(curSet, Number(i)+1 );
}