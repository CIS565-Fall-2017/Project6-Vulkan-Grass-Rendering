Vulkan Grass Rendering
======================

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 6**

* Ricky Rajani
* Tested on: Windows 10, i5-6200U @ 2.30GHz, Intel(R) HD Graphics 520 4173MB (Personal Computer)

[![](img/videoScreenshot.PNG)](https://youtu.be/9Tq2PVa3FSU)

### Features
- Compute shader
	- Perform physics calculations on Bezier curves that represent individual grass blades
	- Culling tests (orientation, view-frustum, distance)
- Grass pipeline stages
	- Vertex shader to transform Bezier control points
	- Tessellation shaders (control and evaluation) to dynamically create the grass geometry from the Bezier curves
	- Fragment shader to shade the grass blades

### Performance Analysis

![](img/numBladesGraph.PNG)

![](img/cullingTestsGraph.PNG)

Clearly, as the number of blades increases, the performance of the renderer decreases. And using the culling tests improves performance significantly. The orientation test checks if a grass blade is culled if the front face direction is perpendicular to te view vector. In other words, since the grass blades won't have width then it is futile to render parts of the grass that are actually smaller than the size of a pixel.This test is the most effective culling test. Whereas the distance test doesn't seem to improve performance. This could be attributed to the plane dimensions not being large enough such that any far off blades are culled. Likewise with the view-frustum test there isn't a huge performance improvement because the plane dimensions are not big enough to cull many grass blades from the scene.

### Credits

* [Responsive Real-Time Grass Grass Rendering for General 3D Scenes](https://www.cg.tuwien.ac.at/research/publications/2017/JAHRMANN-2017-RRTG/JAHRMANN-2017-RRTG-draft.pdf)
* [Vulkan tutorial](https://vulkan-tutorial.com/)
* [Tessellation tutorial](http://in2gpu.com/2014/07/12/tessellation-tutorial-opengl-4-3/)