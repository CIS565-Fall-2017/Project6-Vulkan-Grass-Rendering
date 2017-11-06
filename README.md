Vulkan - Grass Rendering
======================

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 6**

* Fengkai Wu
* Tested on: Windows 10, i7-4700HQ @ 2.40GHz 4GB, GEFORCE 745M 2048MB (Personal)

## Demo GIF

[![](https://github.com/wufk/Project6-Vulkan-Grass-Rendering/blob/master/img/mygrass.gif)]()

Simulation of grass motion under gravity, recover and wind. 

## Project Features

### Compute shader
* Simulating forces on Bezier-curved blades
* Culling techniques: orientation culling, frustum culling and distance culling
### Grass Tessellation
* Tessellation control shader and tessellation evaluation shader

## Overview
[![](https://github.com/wufk/Project6-Vulkan-Grass-Rendering/blob/master/img/blade_model.jpg)]()

This project implements a grass renderer using Vulkan. The principles are based on the paper: [Responsive Real-Time Grass Rendering for General 3D Scenes](https://www.cg.tuwien.ac.at/research/publications/2017/JAHRMANN-2017-RRTG/JAHRMANN-2017-RRTG-draft.pdf). The grass is treated as a Bezier curve, which is shown on the figure above. The triangular shape grass blades are generated in a tessellation process. Variuos culling techniques are implimented to improve render performance.

## Analysis

### Culling 

[![](https://github.com/wufk/Project6-Vulkan-Grass-Rendering/blob/master/img/Performance_culling.PNG)]()

Performance of different techniques

Three major culling techniques are used in this project. The orientation test culls the blades that has a width direction almost parrallel to the view direction, which avoid unwanted aliasing effects. The frustum test simply leaves out the blades are out of the view frustum. Finally, the distance test culls the blades are far from the position of the camera, saving the time for calculating those are too far to fit in a single pixel. 

From the figure above, the distance test contributes most to the performance. It makes sense in that the number of blades to be culled increases very fast as the total number of grass blades grows. All the blades beyond a certain distance are eliminated(shown in the figure below). While for other techniques such as orientation test, the contribution is limited since those blades that are parrallel to the camera view direction is evenly distributed and the number culled are linear to the total number of blades.

[![](https://github.com/wufk/Project6-Vulkan-Grass-Rendering/blob/master/img/distance.PNG)]()
Effect of distance culling

### Tessellation

[![](https://github.com/wufk/Project6-Vulkan-Grass-Rendering/blob/master/img/TriangleNoTess.PNG)]()
[![](https://github.com/wufk/Project6-Vulkan-Grass-Rendering/blob/master/img/TriangleTess.PNG)]()

Effect of tessellation

The figures above shows the effect of the simulation with tessellation and without tessellation in triangle shape. It clearly illustrates that without tessellation, the bending blades are like rigid spikes. By tessellation, the curve and shape of the grass are interpolated and look more vivid and close to life.
