WebGL Clustered Deferred and Forward+ Shading
======================

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 5**

Sarah Forcier

Tested on GeForce GTX 1070

![](img/grass_mine.gif)

### Overview

### Simulation

![](img/blade_model.jpg)

Blade data stored in four `vec4`s, with extra data packed in the fourth components, as shown below: 

| x | y | z | w |
| ----------- | ----------- | ----------- | ----------- |
| v0.x | v0.y | v0.z | orientation |
| v1.x | v1.y | v1.z | height |
| v2.x | v2.y | v2.z | width |
| up.x | up.y | up.z | stiffness |

#### Forces

##### Gravity
##### Recovery
##### Wind

#### State Validation


### Culling tests

#### Orientation culling
#### View-frustum culling
#### Distance culling



### Tessellation

### Performance


### Credits

* [Responsive Real-Time Grass Grass Rendering for General 3D Scenes](https://www.cg.tuwien.ac.at/research/publications/2017/JAHRMANN-2017-RRTG/JAHRMANN-2017-RRTG-draft.pdf)