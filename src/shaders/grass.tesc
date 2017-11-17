#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

// Declare tessellation control shader inputs and outputs

layout (location = 0) in vec4[] v1; // becomes an array in the tesselation shader despite being passed in as a vec4 from the vertex shader? magic!
layout (location = 1) in vec4[] v2;

layout (location = 0) out vec4[] v1Array;
layout (location = 1) out vec4[] v2Array;

void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// Writ shader outputs
    v1Array[gl_InvocationID] = v1[gl_InvocationID];
    v2Array[gl_InvocationID] = v2[gl_InvocationID];

	// Set level of tesselation - make quads
    gl_TessLevelInner[0] = 3;
    gl_TessLevelInner[1] = 3;

    gl_TessLevelOuter[0] = 5;
    gl_TessLevelOuter[1] = 4;
    gl_TessLevelOuter[2] = 6;
    gl_TessLevelOuter[3] = 7;
}
