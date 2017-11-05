#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;


// Inputs: Tesselation Evaluation Shader Input
layout(location = 0) in vec2 uv;
layout(location = 1) in vec3 pos;
layout(location = 2) in vec3 nor;
layout(location = 3) in vec3 wind;

layout(location = 0) out vec4 outColor;

void main() {

	// Chaparal Color Palette:
	// https://orig00.deviantart.net/65ab/f/2010/303/d/1/minecraft_grass_swatches_by_quorong-d31ut89.png
	
    vec3 col1 = vec3( 56/255.0,  76/255.0, 34/255.0);
    vec3 col2 = vec3(106/255.0, 143/255.0, 63/255.0);
    
    outColor = vec4(mix(col1, col2, uv.y), 1.0);
}
