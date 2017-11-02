#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs
layout(location = 0) in vec4 v0_i[];
layout(location = 1) in vec4 v1_i[];
layout(location = 2) in vec4 v2_i[];
//layout(location = 3) in vec4 up_i[]; // not used

layout(location = 0) out vec4 v0_o[];
layout(location = 1) out vec4 v1_o[];
layout(location = 2) out vec4 v2_o[];
//layout(location = 3) out vec4 up_o[]; // not used

void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// TODO: Write any shader outputs
	v0_o[gl_InvocationID] = v0_i[gl_InvocationID];
	v1_o[gl_InvocationID] = v1_i[gl_InvocationID];
	v2_o[gl_InvocationID] = v2_i[gl_InvocationID];
	//up_o[gl_InvocationID] = up_i[gl_InvocationID];
	
	// TODO: Set level of tesselation
	float depth = (camera.proj * camera.view * gl_in[gl_InvocationID].gl_Position).z; // [0, 1]
	float divisions = floor(v1_i[gl_InvocationID].w / depth); // more divisions close to camera

    gl_TessLevelInner[0] = 2.0; // horizonal tessellation
	gl_TessLevelOuter[1] = 2.0; // edge 2-3
    gl_TessLevelOuter[3] = 2.0; // edge 0-1

    gl_TessLevelInner[1] = divisions; // vertical tessellation
    gl_TessLevelOuter[0] = divisions; // edge 0-3
	gl_TessLevelOuter[2] = divisions; // edge 1-2
    
}
