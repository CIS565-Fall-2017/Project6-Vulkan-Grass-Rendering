#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec4 position;
layout(location = 1) in vec4 normal;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color

    vec4 darkGreen = vec4(0.01, 0.061, 0.015, 1.0);
    vec4 lightGreen = vec4(0.01, 0.451, 0.0067, 1.0);
    vec4 color = mix(darkGreen, lightGreen, clamp(normal.w, 0.0, 1.0));

	vec3 lightDir = vec3(0.0, 10.0, 0.0) - position.xyz;
	float lambert = clamp(dot(normal.xyz, normalize(lightDir)), 0.0, 1.0);
    vec4 ambient = vec4(0.1, 0.1, 0.1, 1.0);

    outColor = ambient + color;
}
