FPGA-based Digital Piano Emulation
CS207 Digital Logic Course Project
Fall 2023

Team Members:
Harrold Tok Kwan Hang
Student ID: 12212025
Contribution: Learn Mode, Free Play, Report Composition

Huimin Liang
Student ID: 12210161
Contribution: Auto-play, Recording, Report Composition

Institution:
Southern University of Science and Technology (SUSTech), China
Department of Computer Science

Project Overview
Project Description
This project involves the development of a digital piano emulation using a Field-Programmable Gate Array (FPGA) board. The goal is to replicate the authentic piano-playing experience by combining FPGA’s programmable logic with advanced digital signal processing. The emulation includes real-time synthesis of lifelike piano sounds, responsive key interactions, and visual features, providing users with a versatile and fun digital piano alternative.

Project Background
Relevance
In today’s day and age, technology is integrated in all walks of life from healthcare to business to any form of entertainment, including music. This project combines the musical element of a traditional piano and the programmability of FPGA technology.

Objectives
Accurate emulation of piano key interactions and dynamics.
Real-time synthesis of authentic piano sounds through FPGA-based digital signal processing.
Provide the user with a bug-free experience.
Variability in terms of different modes to play.
Considerations

Sound Synthesis: Implement high-quality sound synthesis algorithms that correctly reproduce the characteristics of traditional piano tones.
Resource Optimization: Optimize the utilization of FPGA resources to ensure efficient implementation of piano emulation algorithms.

User Experience (UX): Prioritize the user experience to make the piano emulation accessible and enjoyable. Consider factors such as ease of use, visual feedback, and button placement to enhance the overall user experience.

Responsiveness: Ensure responsive feedback to key presses, including considerations for unnecessary bounces of the button. Minimize latency in sound generation and key responsiveness to enhance the experience of the piano emulation.
Hardware Design Approach

Ego1 Development Board and Other Hardware
FPGA Board: Xilinx xc7a35tcsg324-1
Microphone: N/A
Input/Output Value Assignment
The project utilizes various input and output signals for different functions, including clock signal, reset signal, switches, buttons, LEDs, and seven-segment displays. Detailed hardware design information and diagrams are included in the project report.

Code Implementation Approach
Key Input and Output Signals
The project uses key input and output signals to manage different functionalities and modes such as auto-play, learn mode, free play, and recording.

Top-Level Module
The top-level module integrates all submodules and manages the state transitions between different modes. Detailed RTL circuit diagrams and state machine descriptions are included in the project report.

System Functions
Modes Description
Free Play: Users have the freedom to play notes without any constraints.

Auto Play: Pre-determined songs provide an automated musical experience.

Learn Mode: Guides users through structured songs to foster musical learning and skill development.

Recording Mode: Allows users to create and playback their own musical sequences.

Bonus Implementations
Variable Duration for Each Note: Enhanced musical expressiveness.

Recording Mode: Enables users to record and playback their own compositions.
Project Summary and Conclusion

The project successfully demonstrates the emulation of a digital piano using an FPGA board, incorporating various play modes and features to enhance user experience. Future project ideas and improvements are discussed in the project report.****
