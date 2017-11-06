#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs
layout(location = 0) in vec4 tv1[];
layout(location = 1) in vec4 tv2[];
layout(location = 2) in vec4 tup[];
layout(location = 3) in vec4 twd[];

layout(location = 0) patch out vec4 _tv1;
layout(location = 1) patch out vec4 _tv2;
layout(location = 2) patch out vec4 _tup;
layout(location = 3) patch out vec4 _twd;


void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// TODO: Write any shader outputs
	_tv1 = tv1[0];
	_tv2 = tv2[0];
	_tup = tup[0];
	_twd = twd[0];

	float near = 0.1;
	float far = 25.0;

	float depth = -(camera.view * gl_in[gl_InvocationID].gl_Position).z / (far - near);
	depth = clamp(depth, 0.0, 1.0);

	float maxLevel = 5.0;
	float minLevel = 1.0;

	depth = depth * depth;

	float level = mix(maxLevel, minLevel, depth);
	_twd.w = depth;


	// TODO: Set level of tesselation
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = level;
    gl_TessLevelOuter[0] = level;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = level;
    gl_TessLevelOuter[3] = 1.0;
}
