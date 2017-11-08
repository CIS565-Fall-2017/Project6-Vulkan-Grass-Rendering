#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs
layout(location = 0) in vec4 v1[];
layout(location = 1) in vec4 v2[];
layout(location = 2) in vec4 up[];
layout(location = 3) in vec4 bladeBit[];


//layout(location = 0) out vec4 v1_out;
//layout(location = 1) out vec4 v2_out;
//layout(location = 2) out vec4 up_out;
//layout(location = 3) out vec4 bladeBit_out;

layout(location = 0) patch out vec4 v1_out;
layout(location = 1) patch out vec4 v2_out;
layout(location = 2) patch out vec4 up_out;
layout(location = 3) patch out vec4 bladeBit_out;

void main() {
	// Don't move the origin location of the patch
	vec4 pos=gl_in[gl_InvocationID].gl_Position;
    gl_out[gl_InvocationID].gl_Position = pos;
	vec4 cameraPos=camera.view * pos;

	// TODO: Write any shader outputs

	v1_out = v1[0];
	v2_out = v2[0];
	up_out = up[0];
	bladeBit_out = bladeBit[0];
	float LevelUpBound=5.0;
	float LevelLowBound=1.0;

 	float depth = -cameraPos.z / (30.0 - 0.1);
 	depth = clamp(depth, 0.0, 1.0);
	
 	//float tes_level= (LevelUpBound-LevelLowBound)*depth+LevelLowBound;
	//float tes_level = mix(LevelUpBound, LevelLowBound, depth);

	float tes_level = mix(LevelUpBound, LevelLowBound, depth*depth);
 
	
 	//bladeBit_out.w = depth;
	bladeBit_out.w = depth*depth;
	// TODO: Set level of tesselation
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = tes_level;
    gl_TessLevelOuter[0] = tes_level;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = tes_level;
    gl_TessLevelOuter[3] = 1.0;
}
