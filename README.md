
WebGL Clustered Deferred and Forward+ Shading
======================

![grass gif](img/demo.gif)

**A realtime grass simulation making use of Vulkan's compute, tesselation, and rendering capabilities.**
**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 6**

* Daniel Daley-Mongtomery
* Tested on: MacBook Pro, OSX 10.12, i7 @ 2.3GHz, 16GB RAM, GT 750M 2048MB (Personal Machine)

### Demo Link

[![YouTube Link](img/youtubelink.PNG)](https://www.youtube.com/watch?v=rpcss9_z4yU)

### Implementation

##### 1: The Pipelines
Generated a ton of blades and bound them as described below, can be generated in any pattern.

![Look a Sphere](img/Sphere.png)

Vulkan has us bind memory to specific types of buffers for device use and then special descriptor sets for each type of shader. compose them into micromanaged pipelines I decided to generate this representative scene to test on with sin()s and such

![The Test Scene](img/scene.PNG)

##### 2: Compute Shader
- Followed [this](https://www.cg.tuwien.ac.at/research/publications/2017/JAHRMANN-2017-RRTG/JAHRMANN-2017-RRTG-draft.pdf) paper, short summary like in instructions
- this is where the culling took place

Distance Culling | Orientation Culling | Frustum Culling
--- | --- | ---
A brief description about what I decided to do | A brief description about what I decided to do | A brief description about what I decided to do

Culling meant not adding the blade to the out buffer and not incrementing the out count. Here's how that worked out with the same test scene:

![Culling Stats](img/Culling.png)

##### 3: Tesselation Shaders

this is how tesselation works and why it can save time for tasks like these. I settled on 7 but here are the stats and some visuals. This used the test scene again, the visuals are just for inmproved clarity

![Tesselation Stats](img/1.jpg)

Oh look at that

##### 4: Rendering

The normal of the blade can be derived from the tess eval and sent over. I build a giant mesh out some of the blade locations and rendered a grass texture to it, and that got huge. By the time the test scene made it out of the grass rendering, these were our results with same test scene:

![Number blades stats](img/NumBlades.png)

Linear, and that's a good thing. 

### Credits

* [Responsive Real-Time Grass Grass Rendering for General 3D Scenes](https://www.cg.tuwien.ac.at/research/publications/2017/JAHRMANN-2017-RRTG/JAHRMANN-2017-RRTG-draft.pdf)
* [CIS565 Vulkan samples](https://github.com/CIS565-Fall-2017/Vulkan-Samples)
* [Official Vulkan documentation](https://www.khronos.org/registry/vulkan/)
* [Vulkan tutorial](https://vulkan-tutorial.com/)
