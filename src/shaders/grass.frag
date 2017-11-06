#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec4 Position;
layout(location = 1) in vec3 Normal;
layout(location = 2) in vec3 Wind;
layout(location = 3) in vec2 UV;

layout(location = 0) out vec4 outColor;

void main() {
	vec3 upper  = vec3(151.0 / 255.0, 250.0 / 255.0, 86.0 / 255.0);
	vec3 lower  = vec3(124.0 / 255.0, 214.0 / 255.0, 68.0 / 255.0);
	vec3 sun    = normalize(vec3(0.0, 5.0, -3.0));

	vec3 upDark = vec3(105.0 / 255.0, 191.0 / 255.0, 51.0 / 255.0);
	vec3 lowDark= vec3(89.0 / 255.0, 168.0 / 255.0, 40.0 / 255.0);

	float NoL = clamp(dot(Normal, sun), 0.3, 1.0);
	vec3  mix = mix(lower, upper, UV.y);

    outColor = vec4(mix * NoL, 1.0);
}
