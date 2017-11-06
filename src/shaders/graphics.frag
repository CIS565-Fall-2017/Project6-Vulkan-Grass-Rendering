#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 1) uniform sampler2D texSampler;

layout(location = 0) in vec3 fragColor;
layout(location = 1) in vec2 fragTexCoord;

layout(location = 0) out vec4 outColor;

void main() {
	//Yellow Tint
	vec4 TintColor = vec4(0.7,0.7,0.3,1.0);
    outColor = texture(texSampler, fragTexCoord) * TintColor;
}
