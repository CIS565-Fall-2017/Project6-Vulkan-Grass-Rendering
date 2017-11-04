#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs

// input from tessellation evaluation

layout(location = 0) in vec4 pos;
layout(location = 1) in vec3 nor;
layout(location = 2) in vec3 forward;
layout(location = 3) in vec2 uv;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color

	vec3 upperColor = vec3(0.2,1.0,0.2);

	vec3 lowerColor = vec3(0.0,0.3,0.1);

	// a blend effect grass color
	vec3 mixedColor = mix(lowerColor, upperColor, uv.y);

	vec3 PointLightPos = normalize(vec3(-1.0, 5.0, -3.0));

	float LambertTerm = clamp(dot(nor, PointLightPos), 0, 1.0) + 0.15; //simple Lambert shading + ambient light

    outColor = vec4(mixedColor * LambertTerm, 1.0);
}
