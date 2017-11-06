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

void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// TODO: Write any shader outputs
	v0_tese[gl_InvocationID] = v0_tesc[gl_InvocationID];
	v1_tese[gl_InvocationID] = v1_tesc[gl_InvocationID];
	v2_tese[gl_InvocationID] = v2_tesc[gl_InvocationID];

	// Set level of tesselation
    gl_TessLevelInner[0] = 1; 
    gl_TessLevelInner[1] = 9;
    gl_TessLevelOuter[0] = 9;
    gl_TessLevelOuter[1] = 1;
    gl_TessLevelOuter[2] = 9;
    gl_TessLevelOuter[3] = 1;
}
