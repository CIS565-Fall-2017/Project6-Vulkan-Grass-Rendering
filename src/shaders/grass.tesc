#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs

layout(location = 0) in vec2 dimensions[];
layout(location = 1) in vec3 v2Pos[];
layout(location = 2) in vec3 orientation[];

layout(location = 0) out vec2 teseDimensions[];
layout(location = 1) out vec3 teseV2Pos[];
layout(location = 2) out vec3 teseOrientation[];

void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
	// TODO: Write any shader outputs
	teseDimensions[gl_InvocationID] = dimensions[gl_InvocationID];
	teseV2Pos[gl_InvocationID] = v2Pos[gl_InvocationID];
	teseOrientation[gl_InvocationID] = orientation[gl_InvocationID];


	 //TODO: Set level of tesselation
     gl_TessLevelInner[0] = 2.0;
     gl_TessLevelInner[1] = 2.0;
     gl_TessLevelOuter[0] = 2.0;
     gl_TessLevelOuter[1] = 2.0;
     gl_TessLevelOuter[2] = 2.0;
     gl_TessLevelOuter[3] = 2.0;
}
