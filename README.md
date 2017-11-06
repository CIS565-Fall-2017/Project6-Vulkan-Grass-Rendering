# **University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 6:**

# **Clustered Forward Plus and Deferred Shaders**

Tested on: Windows 10, Intel Core i7-7700HQ CPU @ 2.80 GHz, 8GB RAM, NVidia GeForce GTX 1050

![Built](https://img.shields.io/appveyor/ci/gruntjs/grunt.svg) ![Issues](https://img.shields.io/github/issues-raw/badges/shields/website.svg) ![Vulkan](https://img.shields.io/badge/Vulkan-C++-red.svg?style=flat)  ![Platform](https://img.shields.io/badge/platform-Desktop-bcbcbc.svg)  ![Developer](https://img.shields.io/badge/Developer-Youssef%20Victor-0f97ff.svg?style=flat)




- [Things Done](#things-done)

- [In-Depth](#in-depth)

- [Time Analysis](#time-analysis)
 
- [Final Thoughts](#final-thougts)

 

____________________________________________________


 
The goal of this project was to simulate real time grass movement in Vulkan. This project is an implementation of [this paper](https://www.cg.tuwien.ac.at/research/publications/2017/JAHRMANN-2017-RRTG/JAHRMANN-2017-RRTG-draft.pdf).

![poster](/img/Poster.gif)

### Things Done

#### Core Features

 - [x] Gravity Force Simulation
 - [x] Recovery Force Simulation
 - [x] Wind Force Simulation
 - [x] Orientation Culling
 - [x] View-Frustrum Culling
 - [x] Distance Culling


### In-Depth:

#### Intro:

The hardest part for this project by far, was just getting something to show up. Like, just anything. Because I did not have that much experience with Vulkan going in, debugging errors was annoying. There were many points where my errors were due to me not completely finishing the code but I couldn't figure that out. This caused me to go on a wild goose/bug chase for many hours for no reason. Once I had just basic grass showing, the rest was straight-forward implementation of the paper. It took me 5 days to get this to show up:

![phase 1](/img/phase1.gif)

#### Gravity and Recovery:

Fairly easy and straightforward. Once I had done it, things started to show up. It looked kinda cool at this point, and I was starting to get excited!

![phase 1b](/img/phase1b.gif)

###### Wind:

For wind, I just made up a fairly simple 2D-sin function that attenuates the wind vector, `wi = (1,1,1)` based on the function value. Here is what my wind function looks like, where z is multiplied by `wi`:

![wind](/img/wind.png)

This is what my scene looks like with wind:

![phase 2](/img/phase2.gif)

#### Orientation Culling:

This isn't really that pretty to look at, and it wasn't pretty to write, but here is what it looks like with an extreme culling threshold:

![orientation](/img/orientationculling.gif)

As you can see, as blades become thinner and thinner with respect to the camera they disappear.

##### View-Frustrum Culling:

Again, based on the paper. Anything outside the view frustrum is culled since you don't see it. You also add a tolerance value just in case part of a blade is visible. Modifying that threshold to cull more inside, you can see how view frustrum culling works:

![view](/img/viewculling.gif)

This is when you have the tolerance be negative, in my final code I have it be positive.

#### Distance:

Fairly annoying to get right, but I was able to. First things first, you can set a max distance to cull all blades at:

![dist](/img/distculling.gif)

But then instead, you can just place the blades in buckets, and then cull more or less based on how close you are, with the farther buckets being culled more, here it is in action:

![far blades being culled more](/img/buckets.gif)

In the GIF, the farther away buckets are culled more, here is a better side-by-side view of this:

![bucket blades](/img/buckets.png)![painted over](/img/buckets_labeled.png)

Where as you can see, in the three regions, there is a distinction between the amount of blades we cull. I do this using a pseudo-random function that I got from [this StackOverflow thread](https://stackoverflow.com/questions/4200224/random-noise-functions-for-glsl)


### Final Thoughts

It took me forever to get started with this project. For future projects, I really hope we get more experience with Vulkan before being tasked with an assignment like this! I also had a problem where RenderDoc didn't work on my machine because, I don't know... There was a bug in RenderDoc and I had to message the creator to fix it [as you can see here](https://github.com/baldurk/renderdoc/issues/790). I guess a lot of this was just my dumb luck that RenderDoc only failed on my computer...
