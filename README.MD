=== Digimon World - reverse engineered code ===

Goal of this project is to reverse engineer the code of Digimon World in a readable, but not compilable, format.

The syntax is C-Style inspired, but omitting ';'.
Functions, their parameters and their addresses are references in memoryMap.txt.
Exception are the store(target, value) and load(target) functions, which refer to load and write instructions.