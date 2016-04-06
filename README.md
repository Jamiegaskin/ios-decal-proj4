# Synthesize Me
## Authors
- James Gaskin

## Purpose
An app that will let you record/sample on the fly and gives playback and 
manipulation tools.
## Features
- Record audio to use as a sample.
- Playback using a keyboard which will alter pitch based on the note pressed.
- Monophonic and Polyphonic modes.
- Volume and sample-pitch parameters.
- Basic effects (reverb, delay, cutoff, and maybe eq, distortion, and 
modulation). This would depend a lot on what is readily available.
- Store samples for later use.
- Delete previously created samples.

## Control Flow
- Initial screen is the keyboard with controls for volume and effects. This 
would come with a pre-loaded sound
- A button in the upper right would add a new sample by bringing up the 
microphone.
- A button in the upper left would take you to a list of samples to select 
from as well as give the option of deleting them.

## Implementation
### Model
- sample.swift
- effects.swift

### View
- keyboardView
- addNewSampleView
- sampleListView

### Controller
- keyboardViewController
- addNewSampleViewController
- sampleListViewController
