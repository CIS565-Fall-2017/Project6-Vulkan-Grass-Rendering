#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
//ins
layout(location = 0) in vec3 nortese;
layout(location = 1) in float uvtese_v;


layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
	vec3 lightdir = vec3(0,1,0);

	vec3 basecolor = vec3(0.3, 0.9, 0.5);
	vec3 tipcolor = vec3(0.93, 0.91, 0.67);

	float lambert = clamp(abs(dot(nortese,lightdir)), 0.35, 1.0);//min clamp not 0 for ambient
	float t = uvtese_v*uvtese_v*uvtese_v;//cube it to push tip color closer to tip
	outColor = vec4(lambert*mix(basecolor, tipcolor, t),1.0);
//	outColor = vec4(uvtese_v, uvtese_v, uvtese_v,1.0);//uv test
}
