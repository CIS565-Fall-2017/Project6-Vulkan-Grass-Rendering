Instructions - Vulkan Grass Rendering
========================

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 6**

* Daniel McCann
* Tested on: Windows 10, i7-5700HQ CPU @ 2.70GHz, GeForce GTX 970M, 16 GB RAM

T![](./img/grass1.gif)

### Overview

This project was an introduction to using the Vulkan graphics API with multiple pipelines to create animated grass. The compute pipeline moves all of the grass blades according to gravity, stiffness, and wind, then hides blades that are too far, are perpendicular to the camera, or are outside of the view. The blades now exists as a single vertex each plus two more points to make a bezier curve. In the graphics pipeline, each base vertex is tesselated into a quad with a number of triangles based on distance from the camera, then shaped into a blade and shaded.

### Features

T![](./img/blade_model.jpg)

## Culling

Before creating the mesh and shading, useless blades of grass are culled.

# Orientation

Grass blades that face a direction perpendicular to the camera become too thin and create badly aliased lines of pixels. Therefore if their orientation is within a threshold, they are culled.

# Distance

Blades that are too far from the camera are not displayed. All blades have a chance to be culled based on their unique ID and their distance, with blades over a maximum distance always being culled. To account for the effect of occlusion of grass blades, this culling effect is more severe as the camera gets closer to the ground plane.

# View Frustum

If none of the three bezier points for the grass blade fall within the view frustum, the blade is culled.

## Forces

Each blade is represented as a quadratic bezier curve. The root is stationary, forces act on the tip, and the center control point adjusts itself to make the length of the curve constant.

# Recovery

The blade will try to reorient itself to its original position based on a stiffness parameter.

# Gravity

The blade is subject to gravity. There is also a "forward gravity" to encourage the blade to fall in the direction it is oriented.

# Wind

I apply an arbitrary wind as a function of time and position. The wind for the gif above is as follows:

vec3 wind = 2.5 * 
  (1.0 + 
  sin(0.4 * totalTime + 0.06 * blade.v0.x + 0.05 * blade.v0.z) + 
  0.4 * cos(1.7 * totalTime + 0.4 * blade.v0.x) + 
  0.2 * sin(3.0 * totalTime + 0.5 * blade.v0.z)) * 
  normalize(vec3(-1, 0, -1));

## Shading

# Tesselation

Before shading, the culled grassblades are a mesh consisting of a set of vertices, representing the base of each blade.
Each vertex becomes a quad in the tesselation control shader. Then the quad vertices are reshaped into the curved blade shape in the tesselation evaluation shader.

# Color

The grass is shaded with a single directional light and a blinn-phong shader model. This color is shaded with a fake ambient occlusion effect that darkens the center line and lower portion of each blade.
I also apply a back-scatter approximation to simulate light bleeding through the foliage. 
