#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// DONE: Declare tessellation control shader inputs and outputs
layout(location = 0) in vec4[] v0_in;
layout(location = 1) in vec4[] v1_in;
layout(location = 2) in vec4[] v2_in;
layout(location = 3) in vec4[] vUp_in;
//for .tese
layout(location = 0) out vec4[] v0_out;
layout(location = 1) out vec4[] v1_out;
layout(location = 2) out vec4[] v2_out;
layout(location = 3) out vec4[] vUp_out;

void main() {

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;


	v0_out[gl_InvocationID] = v0_in[gl_InvocationID];
	v1_out[gl_InvocationID] = v1_in[gl_InvocationID];
	v2_out[gl_InvocationID] = v2_in[gl_InvocationID];
	vUp_out[gl_InvocationID] = vUp_in[gl_InvocationID];

	// DONE?: Set level of tesselation
	gl_TessLevelInner[0] = 1.0;
	gl_TessLevelInner[1] = 7.0;
	gl_TessLevelOuter[0] = 7.0;
	gl_TessLevelOuter[1] = 1.0;
	gl_TessLevelOuter[2] = 7.0;
	gl_TessLevelOuter[3] = 1.0;
}
