Vulkan Grass Rendering
========================

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 6**

* LINSHEN XIAO
* Tested on: Windows 10, Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz, 16.0GB, NVIDIA GeForce GTX 970M (Personal computer)

## Overview

In this project, I used Vulkan to implement a grass simulator and renderer. I
used compute shaders to perform physics calculations on Bezier curves that represent individual grass blades. Since rendering every grass blade on every frame will is fairly inefficient, I also use compute shaders to cull grass blades that don't contribute to a given frame. The remaining blades will be passed to a graphics pipeline, in which I wrote several shaders. I wrote a vertex shader to transform Bezier control points, tessellation shaders to dynamically create
the grass geometry from the Bezier curves, and a fragment shader to shade the grass blades.

## Features

* Compute shader 
* Grass pipeline stages
	* Vertex shader
	* Tessellation control shader
	* Tessellation evaluation shader
	* Fragment shader
* Simulating Forces
	* Gravity
	* Recovery
	* Wind
	* State Validation
* Culling tests
	* Orientation
	* View-frustum
	* Distance

## Result

![](img/grass2.gif)

## Implementation

This project is an implementation of the paper, [Responsive Real-Time Grass Rendering for General 3D Scenes](https://www.cg.tuwien.ac.at/research/publications/2017/JAHRMANN-2017-RRTG/JAHRMANN-2017-RRTG-draft.pdf).
The paper does a great job of explaining the key algorithms and math I used. Below is a brief description of the different components in chronological order of how your renderer will execute, but feel free to develop the components in whatever order you prefer.

### Representing Grass as Bezier Curves

In this project, grass blades will be represented as Bezier curves while performing physics calculations and culling operations. 
Each Bezier curve has three control points.
* `v0`: the position of the grass blade on the geomtry
* `v1`: a Bezier curve guide that is always "above" `v0` with respect to the grass blade's up vector (explained soon)
* `v2`: a physical guide for which we simulate forces on
* `up`: the blade's up vector, which corresponds to the normal of the geometry that the grass blade resides on at `v0`
* Orientation: the orientation of the grass blade's face
* Height: the height of the grass blade
* Width: the width of the grass blade's face
* Stiffness coefficient: the stiffness of our grass blade, which will affect the force computations on our blade

![](img/blade_model.jpg)

### Simulating Forces

#### Gravity
Total gravity on the grass blade: environmental gravity + front gravity, which is the contribution of the gravity with respect to the front facing direction of the blade.

#### Recovery

Recovery corresponds to the counter-force that brings our grass blade back into equilibrium. This is derived in the paper using Hooke's law.
Compare the current position of `v2` to its original position before
simulation started, `iv2`, and compute the recovery forces as `r = (iv2 - v2) * stiffness`.

#### Wind

The wind function depends on the position of `v0` and a function that changes with time, combined with cosine function, which will determine a wind direction that is affecting the blade, and the wind has a larger impact on grass blades whose forward directions are parallel to the wind direction.

### Culling tests

Ingore blades that we won't need to render due to a variety of reasons.

#### Orientation culling

When Front face direction of the grass blade is perpendicular to the view vector, as our grass blades won't have width, we will end up trying to render parts of the grass that are actually smaller than the size of a pixel, which could lead to aliasing artifacts. We can cull these blades.

#### View-frustum culling

We can also cull blades that are outside of the view-frustum, 

#### Distance culling

Similarly to orientation culling, we can end up with grass blades that at large distances are smaller than the size of a pixel. This could lead to additional artifacts in our renders. We can cull grass blades as a function of their distance from the camera.

Here is a simple demonstration:

![](img/grass4.gif)

## Performance Analysis

![](img/chart.png)

| NUM_BLADES | None | Orientation | View-frustum | Distance | All  |
|------------|------|-------------|--------------|----------|------|
| 1 << 16    | 4.8  | 3.8         | 4.0          | 4.1      | 2.7  |
| 1 << 17    | 8.7  | 6.7         | 7.2          | 7.5      | 4.5  |
| 1 << 18    | 16.9 | 12.5        | 13.5         | 13.8     | 8.3  |
| 1 << 19    | 31.2 | 22.0        | 25.0         | 25.6     | 14.9 |

Test window size: Width: 1129; Height: 701;

Though the result shows that among 3 different methods, orientation one is better than view-frustum one, view-frustum one is better than distance one, the efficiency of these culling methods strongly depends on the camera. For example, if the camera is close enough, then lots of grass will be outside the view-frustum. However, if the camera is too far, then all the grass will be inside the view-frustum, so it won't be as good as other methods under such circumstance.






