Vulkan Grass Rendering
======================

### **University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 5**

* YAOYI BAI (pennkey: byaoyi)
* Tested on: Windows 10 Professional, i7-6700HQ  @2.60GHz 16GB, GTX 980M 8253MB (My own Dell Alienware R3)

### (TODO: Your README)

*DO NOT* leave the README to the last minute! It is a crucial part of the
project, and we will not be able to grade you without a good README.

## Video Demo:

[Demo Link](https://youtu.be/u7HdO0uZ2Io)

### 1. Grass Rendering 


#### Basic Feature (Without movement)

![enter image description here](https://lh3.googleusercontent.com/--LwUvS2K_sI/WgEnSPkn0zI/AAAAAAAABN0/nuT0ehBpE9IoRe0xCf84grpuy45MBop4wCLcBGAs/s0/resultNoMovementReduce.gif "resultNoMovementReduce.gif")

#### Gravity and Wind

There is a little bit "earthquake" in the result, I think it is because of the gravity value.

![enter image description here](https://lh3.googleusercontent.com/--3xXRCZjwrY/WgIwTRI6-XI/AAAAAAAABOk/-6fGl0n8_RccadaHWu0LQLLwTMhNDpLFACLcBGAs/s0/resultNoCullingReduced.gif "resultNoCullingReduced.gif")

#### Culling

 - Orientation Culling
 - View Frustum Culling
 - Distance Culling
 
 
 ![enter image description here](https://lh3.googleusercontent.com/-vz9sCG2c2Pc/WgI-oNYC3NI/AAAAAAAABPA/9djbm-UxamkSnegvTBln3o1BImOHhfozwCLcBGAs/s0/resultReduced.gif "resultReduced.gif")

### 2 Performance Analysis

Here is a performance analysis graph that demonstrate the processing time of each time step:

![enter image description here](https://lh3.googleusercontent.com/-TRp2yTn4eWQ/WgI_4N4T00I/AAAAAAAABPQ/PCX2EayFzII_2kc7TrAzf5B9mNUrGYsJwCLcBGAs/s0/Performance.jpg "Performance.jpg")


As you can see from the graph, in each while loop, the processing time is super fast, except the first circle. In my opinion, the first cycle functions as the first time to read the glsl shader into the program, and maybe that would explain why it is rather slow in the first loop. Anyway the result turns to be real-time enough to fulfill the acceleration result. 