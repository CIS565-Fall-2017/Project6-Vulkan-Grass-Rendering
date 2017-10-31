#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs

layout(location = 0) in vec4 Position;
layout(location = 1) in vec3 Normal;
layout(location = 2) in vec3 WindDirection;
layout(location = 3) in vec2 UV;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color

	vec3 upperColor = vec3(0.4,0.9,0.1);
	vec3 lowerColor = vec3(0.0,0.2,0.1);

	vec3 sunDirection = normalize(vec3(-1.0, 5.0, -3.0));

	vec3 upperDarkColor = vec3(0.2,0.45,0.05);
	vec3 lowerDarkColor = vec3(0.0,0.1,0.05);

	float NoL = clamp(dot(Normal, sunDirection), 0.1, 1.0);

	vec3 mixedColor = mix(lowerColor, upperColor, UV.y);

    outColor = vec4(mixedColor*NoL, 1.0);//vec4(  mix( mix(lowerColor, upperColor, UV.y), mix(lowerDarkColor, upperDarkColor, UV.y),  Position.w ), 1.0);	

	//outColor = vec4( (Normal + vec3(1.0)) *0.5, 1.0);
	//outColor = vec4(dot(Normal, sunDirection));
	//outColor = vec4(Position.w);
}
