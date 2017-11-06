#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs
layout(location = 0) in vec4 tesc1[];
layout(location = 1) in vec4 tesc2[];
layout(location = 2) in vec4 tescup[];
layout(location = 3) in vec4 tescwdir[];

layout(location = 0) patch out vec4 tess1;
layout(location = 1) patch out vec4 tess2;
layout(location = 2) patch out vec4 tessup;
layout(location = 3) patch out vec4 tesswdir;


void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// TODO: Write any shader outputs
	tess1 = tesc1[0];
    tess2 = tesc2[0];
    tessup = tescup[0];
    tesswdir = tescwdir[0];
	float near = 0.1;
	float far = 25.0;
	float lh = 5.0;
	float lw = 1.0;
	float numerator = -(camera.view * gl_in[gl_InvocationID].gl_Position).z;
	float denominator = far - near;
	float depth = clamp(numerator / denominator, 0.0, 1.0) * clamp(numerator / denominator, 0.0, 1.0);
	float level = mix(lh, lw, depth);
	tesswdir.w = depth;

	// TODO: Set level of tesselation
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = level;
    gl_TessLevelOuter[0] = level;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = level;
    gl_TessLevelOuter[3] = 1.0;
}
