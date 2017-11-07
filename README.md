**University of Pennsylvania, CIS 565: GPU Programming and Architecture,
Project 6 - Vulkan Grass Rendering**

* Josh Lawrence
* Tested on: Windows 10, i7-6700HQ @ 2.6GHz 8GB, GTX 960M 2GB  Personal

**Overview**<br />
For implementation details see:
https://www.cg.tuwien.ac.at/research/publications/2017/JAHRMANN-2017-RRTG/JAHRMANN-2017-RRTG-draft.pdfs

For tesselation details see:
http://in2gpu.com/2014/07/12/tessellation-tutorial-opengl-4-3/
http://prideout.net/blog/?p=48#levels


**Highlights**<br />
Several culling optimizations were used to reduce computation cost: orientation culling, frustum culling and distance culling. To reduce triangle count, tesselation level is reduced the further the blade is away from the camera. Performance comparisons between culling techniques are sensitive to the setup of the scene but provide insight into how much work is being removed by these culling techniques.
<br />
<br />

**Vulkan Grass Rendering**<br />
![](img/thegrass.gif)

**Screenshot**
![](img/grass.png)

**Data**<br />
**Performance improvement due to all culling techniques**<br />
![](img/graphcullvsnocull.png)

**Performance comparison between culling techniques**<br />
![](img/graphcullcompare.png)

**Performance comparison between tesselation falloff vs no falloff**<br />
![](img/graphfalloffvsnofalloff.png)

**Table of data used for graph**<br />
![](img/data.png)


**GPU Device Properties**<br />
https://devblogs.nvidia.com/parallelforall/5-things-you-should-know-about-new-maxwell-gpu-architecture/<br />
cuda cores 640<br />
mem bandwidth 86.4 GB/s<br />
L2 cache size 2MB<br />
num banks in shared memory 32<br />
number of multiprocessor 5<br />
max blocks per multiprocessor 32<br />
total shared mem per block 49152 bytes<br />
total shared mem per MP 65536 bytes<br />
total regs per block and MP 65536<br />
max threads per block 1024<br />
max threads per mp 2048<br />
total const memory 65536<br />
max reg per thread 255<br />
max concurrent warps 64<br />
total global mem 2G<br />
<br />
max dims for block 1024 1024 64<br />
max dims for a grid 2,147,483,647 65536 65536<br />
clock rate 1,097,5000<br />
texture alignment 512<br />
concurrent copy and execution yes<br />
major.minor 5.0<br />
