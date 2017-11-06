#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec4 pos;
layout(location = 1) in vec3 nor;
layout(location = 2) in vec3 winddir;
layout(location = 3) in vec2 UV;

layout(location = 0) out vec4 col;

void main() {
    // TODO: Compute fragment color
	vec3 ambientdir = normalize(vec3(-1.0, 5.0, -3.0));
	vec3 col1 = vec3(0.0,0.98,0.0);
	vec3 col2 = vec3(0.0,0.98,0.0);
	vec3 col3 = vec3(0.0,0.98,0.0);
	vec3 col4 = vec3(0.0,0.98,0.0);
	float clampnor = clamp(dot(nor, ambientdir), 0.4, 0.7);
	vec3 mixcol = mix(col1, col2, UV.y);
    col = vec4(mixcol*clampnor, 1.0);
}
