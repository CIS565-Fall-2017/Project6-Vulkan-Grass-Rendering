Vulkan Grass Rendering
======================

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 5**

* Jiahao Liu
* Tested on: **Google Chrome 61.0.3163.100(64 bits)** on
  Windows 10, i7-3920XM CPU @ 2.90GHz 3.10 GHz 16GB, GTX 980m SLI 8192MB (personal computer)

### Demo Video/GIF

![](img/1.gif)

Project Introduction
======================

This project uses Vulkan to implement a grass simulator and renderer. Compute shaders are used 
to perform physics calculations on Bezier curves that represent individual grass blades in the application. 
Grass blades that don't contribute to a given frame is culled.

The remaining blades will be passed to a graphics pipeline, in which involves several shaders.
A vertex shader to transform Bezier control points,a tessellation shaders to dynamically create
the grass geometry from the Bezier curves, and a fragment shader to shade the grass blades are included.

Features Introduction
======================

### Grass Rendering

Refer to the following Paper:

* [Responsive Real-Time Grass Grass Rendering for General 3D Scenes](https://www.cg.tuwien.ac.at/research/publications/2017/JAHRMANN-2017-RRTG/JAHRMANN-2017-RRTG-draft.pdf)
	
Performance Analysis
======================

###	Different running time for different culling methods

![](img/chart1.png)

The time is measured using the average time for computation included (Still computation whether should we use culling) and computation not included(Codes related commented.).

Running time for each culling does not influence too much on the running time, but a clear optimization still works. Frustrum culling has the best effect,
Orientation culling follows and distance culling has the worst effect. Considering the actual range of simulation, the distance culling will not work very well on
small area of simulation. But if we are simulating a grass land, this optimization should have a very good effect.

### Credits

* [Responsive Real-Time Grass Grass Rendering for General 3D Scenes](https://www.cg.tuwien.ac.at/research/publications/2017/JAHRMANN-2017-RRTG/JAHRMANN-2017-RRTG-draft.pdf)
* [CIS565 Vulkan samples](https://github.com/CIS565-Fall-2017/Vulkan-Samples)
* [Official Vulkan documentation](https://www.khronos.org/registry/vulkan/)
* [Vulkan tutorial](https://vulkan-tutorial.com/)
* [RenderDoc blog on Vulkan](https://renderdoc.org/vulkan-in-30-minutes.html)
* [Tessellation tutorial](http://in2gpu.com/2014/07/12/tessellation-tutorial-opengl-4-3/)
