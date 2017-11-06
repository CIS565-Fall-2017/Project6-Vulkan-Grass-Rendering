Vulkan Grass Rendering
========================

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 4**
* Timothy Clancy (clancyt)
* Tested on: Windows 10, i5-4590 @ 3.30GHz 8GB, GTX 970 4GB (Personal)

## Features

*A GPU-accelerated real time grass renderer implemented in Vulkan.*

|![Unculled grass in quad shape.](img/grass_unculled_quad.gif)|![Unculled grass in triangle shape.](img/grass_unculled_tri.gif)|
|:-:|:-:|
|Unculled grass in quad shape.|Unculled grass in triangle shape.|

This implementation features a full Vulkan rendering pipeline for generating a field brimming with blades of grass whose motion is realistically simulated according to gravity, blade stiffness, and wind. The implementation is drawn from the paper [Responsive Real-Time Grass Rendering for General 3D Scenes](https://www.cg.tuwien.ac.at/research/publications/2017/JAHRMANN-2017-RRTG/JAHRMANN-2017-RRTG-draft.pdf).
