#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs

layout(location = 0) in vec2 dimensions[];
layout(location = 1) in vec3 orientation[];
layout(location = 2) in vec4 tescV0[];
layout(location = 3) in vec4 tescV1[];
layout(location = 4) in vec4 tescV2[];
layout(location = 5) in vec4 tescUp[];


layout(location = 0) out vec2 teseDimensions[];
layout(location = 1) out vec3 teseOrientation[];
layout(location = 2) out vec4 teseV0[];
layout(location = 3) out vec4 teseV1[];
layout(location = 4) out vec4 teseV2[];
layout(location = 5) out vec4 teseUp[];


void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
	// TODO: Write any shader outputs
	teseDimensions[gl_InvocationID] = dimensions[gl_InvocationID];
	teseOrientation[gl_InvocationID] = orientation[gl_InvocationID];
	teseV0[gl_InvocationID] = tescV0[gl_InvocationID];
	teseV1[gl_InvocationID] = tescV1[gl_InvocationID];
	teseV2[gl_InvocationID] = tescV2[gl_InvocationID];
	teseUp[gl_InvocationID] = tescUp[gl_InvocationID];


	 //TODO: Set level of tesselation
     gl_TessLevelInner[0] = 16.0;
     gl_TessLevelInner[1] = 4.0;
     gl_TessLevelOuter[0] = 16.0;
     gl_TessLevelOuter[1] = 4.0;
     gl_TessLevelOuter[2] = 16.0;
     gl_TessLevelOuter[3] = 4.0;
}
