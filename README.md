# IXALS Hub - ARCHEMARA

IXALS Hub is a performance-oriented utility script designed for the Roblox engine, focusing on movement physics, environment lighting, and animation manipulation. This project is hosted on GitHub to support seamless remote execution and version control for the user IXALS.

## Feature Overview

The current version (V16) includes the following functional modules:

* **Movement Physics**: Integrated Fly Mode with adjustable speed multipliers, Noclip for bypassing part collisions, and Anti-Fall damage state management.
* **Animation Tweaker**: Real-time modification of animation tracks, specifically targeting 'Action' priority sequences for increased execution speed.
* **Environment Control**: Global lighting override featuring a Full Bright system that disables shadows, fog, and forces a static day-time cycle.
* **Utility**: Automated stamina and energy value management, combined with customizable UI keybinds for accessibility.

## User Interface

The script utilizes a custom Glassmorphism UI framework. Key design elements include:
* **Visual Clarity**: Translucent background with Cyan (Neon) accent strokes.
* **Interactivity**: Event-driven buttons and real-time text input for speed variables.
* **Efficiency**: Toggle-based system to ensure low overhead during intensive gameplay.

## Installation and Execution

To initialize the Hub, execute the following loadstring in a compatible environment:

```lua
loadstring(game:HttpGet("[https://raw.githubusercontent.com/IXALS/ARCHEMARA---IXALS/refs/heads/main/Main.lua](https://raw.githubusercontent.com/IXALS/ARCHEMARA---IXALS/refs/heads/main/Main.lua)"))()

Technical Architecture
Core Engine: Built on Luau (Roblox's derivative of Lua).

Task Scheduling: Uses RunService.RenderStepped for frame-perfect visual updates and RunService.Stepped for physics-synced logic.

Memory Management: Optimized to reduce footprint on Client Memory Usage.

Input Handling: Managed via UserInputService to support dynamic keybinding.

Academic Context
This project serves as a practical implementation of software engineering principles, specifically regarding memory mapping, process manipulation, and real-time rendering synchronization. It reflects an ongoing interest in PC hardware performance and software-engine interactions.

Disclaimer
This repository is for educational purposes only. It demonstrates the technical capabilities of the Luau language and the internal workings of the Roblox physics engine. Use responsibly.
