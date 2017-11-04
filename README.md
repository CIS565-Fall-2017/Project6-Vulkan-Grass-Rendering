WebGL Clustered Deferred and Forward+ Shading
======================

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 5**

Sarah Forcier

Tested on GeForce GTX 1070

![](img/grass_mine.gif)

### Overview

This project implements a grass simulator and renderer using Vulkan. Each grass blade is represented by a quadratic Bezier curve, and physics calculations are performed on these control points in a compute shader. Since rendering every grass blade is computationally expensive, grass blade that do not contribute to a frame are culled in the computer shader. Visible bezier representaions of grass blades are sent to a grass graphics pipeline where the Bezier control points are transofmred, geometry is created in tesselations shaders, and the grass is shaded in the fragment shader. 

### Simulation

As mentioned above, a grass blade is represented by a Bezier curve where the first control point is fixed on the plane, and the physics calculations are performed on the third control point. Along with the three control points, a blade is also defined by an up vector and scalar height, orientation, width, and stiffness coefficient. See the diagram below for how the blade is represented.  

![](img/blade_model.jpg)

All the blade data can be stored in four `vec4`s by packing the scalar values into the fourth component of the control points and up vectors.  

| x | y | z | w |
| ----------- | ----------- | ----------- | ----------- |
| v0.x | v0.y | v0.z | orientation |
| v1.x | v1.y | v1.z | height |
| v2.x | v2.y | v2.z | width |
| up.x | up.y | up.z | stiffness |

#### Forces

Forces are first applied to the `v2` control point and then corrected for potential errors in the state validation step (see next section). The total force applied is the sum of the gravity, recovery, and wind forces.  

##### Gravity

The total force due to gravity is the sum of the environmental gravity and the front gravity, which is the gravity with respect to the front facing direction of the blade - computed by the orientation. 

`gE = normalize(D.xyz) * D.w`
`gF = (1/4) * ||gE|| * f`
`g = gE + gF`

##### Recovery

Grass blades act like springs, so according to Hooke's law, there is a force that brings the blade back to equilibrium. This force acts in the direction of the original `v2` position, or `iv2`, and is scaled by the stiffness coefficient. The larger the stiffness coefficient, the more force pushing the blade back to equilibrium. 

`r = (iv2 - v2) * stiffness`

##### Wind

There are many different possible wind forces. A naive approach is for all grass blades to receive the same wind force. Adding noise to this simulation gives a better look. Another scenario simulates a radial wind, like the wind blown from a landing helicopter. The wind strength and wind direction are parameters that can be changed to create a variety of scenarios. 

#### State Validation

Before `v2` can be translated, the new state must first be corrected for errors. First, `v2` must remain above `v0` because the blade cannot intersect the ground plane. In addition, the system insures that each blade always has a slight curvature, and the length of the Bezier curve is not longer than the fixed blade height. 

### Culling tests

Simulating and rendering many instances of a object is computationally expensive, so some instances are culled before rendering to optimize the algorithm. 

#### Orientation culling

Grass blades have a marginal depth, so when the blades are viewed perpendicular to the front facing vector, the blades cannot be seen at all or the rendered parts of the blades are smaller than a pixel and will cause aliasing artifacts. Therefore blades oriented as such are culled before rendering.

#### View-frustum culling

We also want to cull blades 

#### Distance culling

### Tessellation

### Performance


### Credits

* [Responsive Real-Time Grass Grass Rendering for General 3D Scenes](https://www.cg.tuwien.ac.at/research/publications/2017/JAHRMANN-2017-RRTG/JAHRMANN-2017-RRTG-draft.pdf)