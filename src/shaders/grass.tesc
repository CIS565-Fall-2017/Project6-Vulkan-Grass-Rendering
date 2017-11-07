#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs
//ins
layout(location = 0) in vec4 v1tesc[];
layout(location = 1) in vec4 v2tesc[];
layout(location = 2) in vec3 uptesc[];
layout(location = 3) in vec3 bitantesc[];

//if no patch designation need []
//outs
layout(location = 0) patch out vec4 v1tese;
layout(location = 1) patch out vec4 v2tese;
layout(location = 2) patch out vec3 uptese;
layout(location = 3) patch out vec3 bitantese;

void main() {
	// Don't move the origin location of the patch
	mat4 viewproj = camera.proj*camera.view;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// TODO: Write any shader outputs
	v1tese		= v1tesc[gl_InvocationID];
	v2tese 		= v2tesc[gl_InvocationID];
	uptese 		= uptesc[gl_InvocationID];
	bitantese	= bitantesc[gl_InvocationID];

	// TODO: Set level of tesselation
	//http://in2gpu.com/2014/07/12/tessellation-tutorial-opengl-4-3

	//to set level dynamically, you can find persp z (0-1) and use that to interp (mix) between tess levels (say 5 for close 1 for far)
	vec4 ndc = viewproj*vec4(gl_in[0].gl_Position.xyz,1.0);
	float t = -ndc.z / ndc.w;
	int mintess = 1;
	int maxtess = 10;
//	float level = mix(maxtess, mintess, t);
	float level = 10;

	//controls inner tesselation. 0 == horiz tess, 1 == vert tess
    gl_TessLevelInner[0] = 1;
    gl_TessLevelInner[1] = level;

	//proceeds clockwise around quad, while vert indices are going ccw
	//edge 0 to 3 (left)
    gl_TessLevelOuter[0] = level;
	//edge 3 to 2 (top)
    gl_TessLevelOuter[1] = 1;
	//edge 2 to 1 (right)
    gl_TessLevelOuter[2] = level;
	//edge 1 to 0 (bot)
    gl_TessLevelOuter[3] = 1;
}
