Vulkan Grass Rendering
================

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 6**

* Xincheng Zhang
* Tested on:
  *Windows 10, i7-4702HQ @ 2.20GHz 8GB, GTX 870M 3072MB (Personal Laptop)


### Description&Features
-------------
**In this project, I use Vulkan to implement a grass simulator and renderer. I also use compute shaders to perform physics calculations on Bezier curves that represent individual grass blades in my application. Since rendering every grass blade on every frame will is fairly inefficient, I also use compute shaders to cull grass blades that don't contribute to a given frame. The remaining blades are passed to a graphics pipeline, in which I write several shaders. I write a vertex shader to transform Bezier control points, tessellation shaders to dynamically create the grass geometry from the Bezier curves, and a fragment shader to shade the grass blades.**

Task Done:
* Simulate gravity force
* Simulate wind force (sinusoidal function)
* Simulate recovery force
* Culling test (orientation, frustum, distance)
* Tessellating Bezier curves into grass blades


.
### Result in Progress
-------------
**Result GIF**

* Overall Result overview
(2^20 grass blades.)

![](https://github.com/XinCastle/Project6-Vulkan-Grass-Rendering/blob/master/img/grass%20blade%20sim.gif)


* Distance Culling Result
(2^15 blades in the scene.)
(far plane set to be 5 to make it obvious)

![](https://github.com/XinCastle/Project6-Vulkan-Grass-Rendering/blob/master/img/distance%20cull.gif)


* Frustum Culling Result

![](https://github.com/XinCastle/Project6-Vulkan-Grass-Rendering/blob/master/img/frustum%20cull.gif)



.
**Implementation**
* External Forces
* Reference: Responsive Real-Time Grass Rendering for General 3D Scenes
* site: https://www.cg.tuwien.ac.at/research/publications/2017/JAHRMANN-2017-RRTG/JAHRMANN-2017-RRTG-draft.pdf


.
### Performance Analysis
-------------
* When the number of blades are smaller than 2^13, the difference between w/ culling and without culling is not obvious. Then culling significantly decreses render time when the number of blades is over 2^16. Here is the chart:

![](https://github.com/XinCastle/Project6-Vulkan-Grass-Rendering/blob/master/img/with%20and%20without%20culling.png)

* Render time Comparison between three culling tests. Compared to orientation and frustum, distance cullling seems better at high number of blades (or it's just because I filtered out too many blades as a result of distance setting):

![](https://github.com/XinCastle/Project6-Vulkan-Grass-Rendering/blob/master/img/culling%20comparison.png)
