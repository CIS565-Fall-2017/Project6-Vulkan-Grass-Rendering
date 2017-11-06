#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs

layout(location = 0) in vec4 tcV1[];
layout(location = 1) in vec4 tcV2[];
layout(location = 2) in vec3 tcBladeUp[];
layout(location = 3) in vec3 tcBladeDir[];

layout(location = 0) patch out vec4 teV1;
layout(location = 1) patch out vec4 teV2;
layout(location = 2) patch out vec3 teBladeUp;
layout(location = 3) patch out vec3 teBladeDir;

void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
	
	// TODO: Write any shader outputs
	teV1 = tcV1[0];
	teV2 = tcV2[0];
	teBladeUp = tcBladeUp[0];
	teBladeDir = tcBladeDir[0];
	
	float level = 5.0f;

	// TODO: Set level of tesselation
    gl_TessLevelInner[0] = 1.0f;
    gl_TessLevelInner[1] = level;
    gl_TessLevelOuter[0] = level;
    gl_TessLevelOuter[1] = 1.0f;
    gl_TessLevelOuter[2] = level;
    gl_TessLevelOuter[3] = 1.0f;
	
}

