#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;


layout (location = 0) in vec4 [] v0in;
layout (location = 1) in vec4 [] v1in;
layout (location = 2) in vec4 [] v2in;
layout (location = 3) in vec4 [] v3in;

layout (location = 0) out vec4 [] v0;
layout (location = 1) out vec4 [] v1;
layout (location = 2) out vec4 [] v2;
layout (location = 3) out vec4 [] v3;

// TODO: Declare tessellation control shader inputs and outputs

void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// TODO: Write any shader outputs
	v0[gl_InvocationID] = v0in[gl_InvocationID];
	v1[gl_InvocationID] = v1in[gl_InvocationID];
	v2[gl_InvocationID] = v2in[gl_InvocationID];
	v3[gl_InvocationID] = v3in[gl_InvocationID];

	// TODO: Set level of tesselation
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;
    gl_TessLevelOuter[0] = 5.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 5.0;
    gl_TessLevelOuter[3] = 1.0;

}
