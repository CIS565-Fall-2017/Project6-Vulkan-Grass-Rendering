Vulkan Grass Rendering
======================

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 6**

* Joseph Klinger
* Tested on: Windows 10, i5-7300HQ (4 CPUs) @ ~2.50GHz, GTX 1050 6030MB (Personal Machine)

### Demo Video

[Link.](https://vimeo.com/242475364)

### README

This week, I worked on implementing a published paper on the efficient rendering of grass for 3d scenes. The project was also intended to be an introduction to Vulkan
 and tesselation and compute shaders in GLSL. As a brief summary, the paper represents a blade of grass as a 3-point, quadratic Bezier curve. Tesselation shaders are used to create 
 geometry, ultimately creating 2D geometry in a 3D scene. A compute shader is used to cull grass blades that are otherwise unnecessary to render.

# Features

Compute shader - implemented basic physically based computations to animate the grass blades. Forces included wind, gravity and stiffness/recovery. Additionally, the compute shader is 
responsible for culling unnecessary grass blades based on orientation (grass blade is angled ~90 in relation to the camera, which can create artifacts during rasterization), the view frustum itself, 
and distance (far away grass blades don't need to be rendered).

Tesselation shader - based on the three Bezier control points, created renderable geometry in tesselation control/evaluation shaders. Note that there is actually a small, unresolved bug that causes geometry to be shaded
black.

Vertex/fragment shader - Passes information further down the graphics pipeline and performs basic lambertian shading.