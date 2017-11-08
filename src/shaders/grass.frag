#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs

//layout(location = 0) in vec3 fragColor;

layout(location = 0) in vec3 nor;
layout(location = 1) in vec2 uv;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color

	vec3 upColor = vec3(0.4,0.9,0.3);
	vec3 lowColor = vec3(0.3,0.7,0.0);
	vec3 lightDir = normalize(vec3(1.0, 0.0, -1.0));
	vec3 finalColor = mix(lowColor, upColor, uv.y);
	outColor = vec4(finalColor * max(dot(lightDir, nor),0.0), 1.0);
    //outColor = vec4(1.0);
	
}
