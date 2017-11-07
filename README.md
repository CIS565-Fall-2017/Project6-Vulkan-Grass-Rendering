Vulkan Grass Rendering
========================

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 5**

* Yuxin Hu
* Tested on: Windows 10, i7-6700HQ @ 2.60GHz 8GB, GTX 960M 4096MB (Personal Laptop)

### Demo Video/GIF

![](img/YuxinGrass.gif)

### Overview
In this project I implemented a grass renderer based on paper [Responsive Real-Time Grass Rendering for General 3D Scenes](https://www.cg.tuwien.ac.at/research/publications/2017/JAHRMANN-2017-RRTG/JAHRMANN-2017-RRTG-draft.pdf). in Vulkan. I used Bezier curve to represent each grass blade, and applied forces to ajust Bezier curve control points, then used tessellation to generate grass shape from 3 control points of the Bezier curve. The base code of setting up Vulkan pipeline for plane renderer were provided by class 2017 CIS565 GPU programming. 

### Features implemented:
* Vertex Shader to pass in blade struct.
  * The vertex shader for grass blade takes in for vec4s: v0, v1, v2, and up. Where v0.xyz is the Bezier Curve v0 position, v1.xyz is the Bezier Curve v1 position, and v2.xyz is the Bezier curve v2 position. up.xyz stores blade up vector. In addition to three control points, we need an orientation to represent the facing direction of each grass blade, and that is stored in v0.w. v1.w stores blade height. v2.w stores blade width, and up.w stores stiffness coefficient. v1, and v2 will be updated by compute shader every simulation step, so we can see grass moving by wind nicely. v0, v1, v2, and up are passed onto tessellation control shader.

* Tessellation control shader to set tessellation inner and outer levels.
  * Inside tessellation control shader, I set the inner vertical level to be 8, and innter horizontal level to be 2. And the outer level to be 8,2,8,2 for 4 egdes. This should subdivide a patch into enough detailed shapes to show the curvature of grass blade.

* Tessellation evaluation shader to generate new vertex with tessellation uv coordinates.
  * The tessellation evaluation shader will compute the world space vertex position based on tessellation uv coordinates and convert it from world space to screen space. Here we used De Casteljau to interpolate the point on the Bezier curve controlled by v0, v1, and v2, using tessellation v coordinates as the interpolation parameters. Since we have level of 8 along v direction, we should get a nice bezier curve with 8 points. Then we treat the patch as a triangle and we use triangle interpolation to get a final vertex position based on u and v. Finally we pass the new vertex position as well as the normal vector of the vertex to fragment shader.

* fragment shader to color the fragment with Lambert shading model.
  * Inside fragment shader, I assume there is a virtual light source with light direction pointing to (-1,-1,0). I give grass blades a base color of (0.18, 0.48, 0.04), and multiplies it with the clamp(0.2, 1, dot(lightDir, vertexNormal)).

* Compute Shader to apply forces to generate updated Bezier curve shape, and cull blades that won't be rendered on     screen based on orientation, frustum visibility and distance visibility. 
  * I use 3 control points, a width direction, and a height to represent each grass blade, as shown in the graph below:
    ![](img/blade_model.jpg)
  * I computed three forces that affect grass blade in compute shader: gravity, wind and recorver force.
  * Gravity force is composed of gE = 0.001*(0,-9.8,0) and gF = 0.25*length(gE)*bladeFace. Because the gravity affect more on where the blade is facing.
  * Wind force is a sin wave function: 5*sin(time.totalTime) * vec3(1,0,0). Then I take into account the direction alignment and height ratio factor to reflect the wind force affect on grass blade more accurately.
  * Recovery force always points from current v2 position to initial v2 position, and it is proportional to stiffness coefficient of grass blade.
  * Once we have all three forces we add them up together and update v2 position. Then we do a test to make sure v2 is above the ground and grass blade height remains the same to adjust v1 and v2 with a final value. They are now ready to be pass to vertex shader for rendering.
  * To improve the render efficiency we will cull blades if it meets one of the conditions: 1) out of camera frustum. 2) a blade with facing direction perpendicular to camera view direction. 3) far from camera.

* Vulkan compute shader and grass render pipeline setup.
Inside render.cpp, I created Compute DescriptorSetLayout, which defines the three bindings compute shader will need: input blades buffer binding, culled blades buffer binding, and BladeDrawIndirect buffer binding. I also bind these three buffers in createComputeDescriptorSet. I bind the model matrix of blades in CreateGrassDescriptorSets. Inside RecordComputeCommandBuffer() I bind the computeDescriptorSets I created and dispatch the commands with NUM_BLADES / WORKGROUP_SIZE, which acts similar to kernal calls in CUDA. This will fill the scene->GetBlades()[j]->GetCulledBladesBuffer() with the culled grass blades affected by gravity, wind and recovery forces. Now we are ready to pass culledBladesBuffer to render pipeline. Inside RecordCommandBuffers(), after we bind the grass render pipeline, I populate vertexBuffers with scene->GetBlades()[j]->GetCulledBladesBuffer(), and use vkCmdDrawIndirect command to draw the grass blades.

### Performance Analysis
![Performance](/img/performance.PNG)
<p align="center"><b>Grass Renderer Performance Analysis</b></p>
* The timer were added to compute how much time each frame takes to render. With culling methods, the render efficiency improves as the blades number goes up. But when blades number is below 2^17, there is no much difference between culling blades and no culling. I set the far culling distance to be 14.f, so it will cull all blades fall inside the depth betwwen 14.f and 15.f in this render scene setup, which leads to best performance improvement among all culling methods. 

* Future Improvement work
  The renderer works well for blades numbers up to 2^19. Starting from 2^21 the frame rate is so low that the grass movements are not smooth natural anymore. As the blades number goes up, the grass will also occlude each other, leading to unnatural visual effect. When the grass number increases, adjacent grass blades collide with each other, and the rendered result showing grass blades going into each other.
