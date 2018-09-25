# Plant Music!

Inflorescent Crescendo is interactive art installation that features plants which make music when touched. Plant Music is the hardware and software code behind the project.

## Scratch Setup

### 0. Requirements
- [Ableton Live](https://www.ableton.com/en/trial/) (To be phased out)
- [Pure-Data](https://puredata.info/downloads)
- [Processing 3](https://processing.org/download/)
- [Arduino IDE](https://www.arduino.cc/en/Main/Software)
- A plant sensor! Ours was built 4 sensors on an Arduino Mega modeling this [Touché tutorial](https://www.instructables.com/id/Touche-for-Arduino-Advanced-touch-sensing/).

### 1. Arduino Code
1. Clone this [SweepingCapSense](https://github.com/Surfincolin/SweepingCapSense) library into your `arduino/libraries` folder
2. Load the **simpler.ino** project onto the arduino.
- If you monitor the serial, remember the baud-rate is set at 19200.

### 2. Interpreter (Processing)
1. Open Processing and make sure the libraries **sound** and **oscP5** are loaded.
2. Open the **interpreter.pde** project in the `processing/interpreter` folder, change the `portSelected` variable to match your serial port setup.
3.  Run
- There are flags in the main file for testing and debugging the project.

### 3. Pure-Data(PD) App
1. Make sure you have a virtual midi driver running on your computer. On Mac, in the **Audio Midi Setup**, you want to click the check box for **Device is online** for **IAC Driver**. On Windows you can use [LoopMIDI](https://www.tobias-erichsen.de/software/loopmidi.html)
2. Open **user-states.pd** in the `pd` folder.
3. In PD, open the **Preferences > MIDI...** settings. Make sure your virtual midi driver is selected in the **Output Devices**. Click **Save All Settings**
4. Open the 'whole_sequence' patch and the 'osc-receiver-vanilla' sub patch. Click the 'Serial Data Toggle' to start seeing input from the interpreter. 
5. Click the 'calibration' patch in 'osc-receiver-vanilla' and in each box set the threshold at which you want to register a touch for each plant.

### 4. Ableton Project
1. Open your Ableton project of choice and click play on the track with instruments you want to play.

### 5. Plant Sensors
- Wire up the sensors to the plant. Tends to work best when copper wire is wrapped around the stalk of a dense plant, but shallowly burring the wire in the moist dirt of an ivy also works. Most ferns don't work well.
- For testing you can use a glass of water.

