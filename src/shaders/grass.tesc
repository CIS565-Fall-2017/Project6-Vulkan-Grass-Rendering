#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs

layout (location = 0) in vec4 tessellation_control_v1[];
layout (location = 1) in vec4 tessellation_control_v2[];
layout (location = 2) in vec4 tessellation_control_up[];
layout (location = 3) in vec4 tessellation_control_forward[];

layout(location = 0) patch out vec4 tessellation_eval_v1;
layout(location = 1) patch out vec4 tessellation_eval_v2;
layout(location = 2) patch out vec4 tessellation_eval_up;
layout(location = 3) patch out vec4 tessellation_eval_forward;


void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// TODO: Write any shader outputs
	// So far, just pass through
	tessellation_eval_v1 = tessellation_control_v1[0];
	tessellation_eval_v2 = tessellation_control_v2[0];
	tessellation_eval_up = tessellation_control_up[0];
	tessellation_eval_forward = tessellation_control_forward[0];



	// TODO: Set level of tesselation
	gl_TessLevelInner[0] = 1.0;
	gl_TessLevelInner[1] = 5.0;

	gl_TessLevelOuter[0] = 5.0;
	gl_TessLevelOuter[1] = 1.0;
	gl_TessLevelOuter[2] = 5.0;
	gl_TessLevelOuter[3] = 1.0;
}
