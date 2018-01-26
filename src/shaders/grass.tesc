#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs
layout(location = 0) in vec4 v0_tesc[];
layout(location = 1) in vec4 v1_tesc[];
layout(location = 2) in vec4 v2_tesc[];

layout(location = 0) out vec4 v0_tese[];
layout(location = 1) out vec4 v1_tese[];
layout(location = 2) out vec4 v2_tese[];

void main() 
{
	// Don't move the original location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	v0_tese[gl_InvocationID] = v0_tesc[gl_InvocationID];
	v1_tese[gl_InvocationID] = v1_tesc[gl_InvocationID];
	v2_tese[gl_InvocationID] = v2_tesc[gl_InvocationID];

	// Set level of tesselation
    gl_TessLevelInner[0] = 1; //horizontal
    gl_TessLevelInner[1] = 5; //vertical
    gl_TessLevelOuter[0] = 5; //edge 0-3
    gl_TessLevelOuter[1] = 1; //edge 3-2
    gl_TessLevelOuter[2] = 5; //edge 2-1
    gl_TessLevelOuter[3] = 1; //edge 1-0
}
