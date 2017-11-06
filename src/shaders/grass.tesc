#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs
layout(location = 0) in vec4 control_v1[];
layout(location = 1) in vec4 control_v2[];
layout(location = 2) in vec4 control_up[];
layout(location = 3) in vec4 control_width[];

layout(location = 0) patch out vec4 evaluation_v1;
layout(location = 1) patch out vec4 evaluation_v2;
layout(location = 2) patch out vec4 evaluation_up;
layout(location = 3) patch out vec4 evaluation_Width;


void main() {

	// Don't move the origin location of the patch
	vec4 WorldPosV0 = gl_in[gl_InvocationID].gl_Position;
    gl_out[gl_InvocationID].gl_Position = WorldPosV0;



	// TODO: Write any shader outputs
	evaluation_v1 = control_v1[0];
    evaluation_v2 = control_v2[0];
    evaluation_up = control_up[0];
    evaluation_Width = control_width[0];
	float near = 0.1;
	float far = 25.0;

	float depth = -(camera.view * WorldPosV0).z / (far - near);
	depth = clamp(depth, 0.0, 1.0);

	float maxLevel = 5.0;
	float minLevel = 1.0;

	depth = depth*depth;
	
	float level = mix(maxLevel, minLevel, depth);
	evaluation_Width.w = depth;
	// TODO: Set level of tesselation
    gl_TessLevelInner[0] = 1.0; //horizontal
    gl_TessLevelInner[1] = level; //vertical
    
	gl_TessLevelOuter[0] = level; //vertical
    gl_TessLevelOuter[1] = 1.0; //horizontal
    gl_TessLevelOuter[2] = level; //vertical
    gl_TessLevelOuter[3] = 1.0; //horizontal

	
}