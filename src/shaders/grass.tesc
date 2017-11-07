#version 450
#extension GL_ARB_separate_shader_objects : enable

//only need one vertex position in the evaluation shader(v0)
layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs
layout(location = 0) in vec4 tesc_v1[];
layout(location = 1) in vec4 tesc_v2[];
layout(location = 2) in vec4 tesc_up[];
layout(location = 3) in vec4 tesc_width_dir[];

layout(location = 0) patch out vec4 tese_v1;
layout(location = 1) patch out vec4 tese_v2;
layout(location = 2) patch out vec4 tese_up;
layout(location = 3) patch out vec4 tese_width_dir;

void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// TODO: Write any shader outputs 
	// only need one vertex data
	tese_v1 = tesc_v1[0];
	tese_v2 = tesc_v2[0];
	tese_up = tesc_up[0];
	tese_width_dir = tesc_width_dir[0];

	// TODO: Set level of tesselation
	// horizontal tesellation
    gl_TessLevelInner[0] = 1.0;
    // vertical tesellation
	gl_TessLevelInner[1] = 7.0;
    // vertical
	gl_TessLevelOuter[0] = 7.0;
    // horizontal
	gl_TessLevelOuter[1] = 1.0;
    // vertical
	gl_TessLevelOuter[2] = 7.0;
    // horizontal
	gl_TessLevelOuter[3] = 1.0;
}
