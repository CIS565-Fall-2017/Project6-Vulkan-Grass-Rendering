#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs
layout(location = 0) in vec4 tesc_v1[];
layout(location = 1) in vec4 tesc_v2[];
layout(location = 2) in vec4 tesc_up[];
layout(location = 3) in vec4 tesc_widthDir[];

layout(location = 0) patch out vec4 tese_v1;
layout(location = 1) patch out vec4 tese_v2;
layout(location = 2) patch out vec4 tese_up;
layout(location = 3) patch out vec4 tese_widthDir;


void main() {

	// Don't move the origin location of the patch
	vec4 WorldPosV0 = gl_in[gl_InvocationID].gl_Position;
    gl_out[gl_InvocationID].gl_Position = WorldPosV0;



	// TODO: Write any shader outputs
	tese_v1 = tesc_v1[0];
    tese_v2 = tesc_v2[0];
    tese_up = tesc_up[0];
    tese_widthDir = tesc_widthDir[0];

	float near = 0.1;
	float far = 25.0;

	float depth = -(camera.view * WorldPosV0).z / (far - near);
	depth = clamp(depth, 0.0, 1.0);

	float maxLevel = 5.0;
	float minLevel = 1.0;

	depth = depth*depth;

	float level = mix(maxLevel, minLevel, depth);

	tese_widthDir.w = depth;
	//tese_widthDir.w = cos(abs(dot( normalize(vec3(1.0,0.0,1.0)), vec3(WorldPosV0.x, 0.0, WorldPosV0.z))));

	// TODO: Set level of tesselation
    gl_TessLevelInner[0] = 1.0; //horizontal
    gl_TessLevelInner[1] = level; //vertical
    
	gl_TessLevelOuter[0] = level; //vertical
    gl_TessLevelOuter[1] = 1.0; //horizontal
    gl_TessLevelOuter[2] = level; //vertical
    gl_TessLevelOuter[3] = 1.0; //horizontal

	
}