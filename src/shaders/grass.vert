
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};


// TODO: Declare vertex shader inputs and outputs
layout(location = 0) in vec4 v0;
layout(location = 1) in vec4 v1;
layout(location = 2) in vec4 v2;
layout(location = 3) in vec4 up;

layout(location = 0) out vec4 tess1;
layout(location = 1) out vec4 tess2;
layout(location = 2) out vec4 tessup;
layout(location = 3) out vec4 tesswdir;

out gl_PerVertex {
    vec4 gl_Position;
};

void main() {
	// TODO: Write gl_Position and any other shader outputs
	vec4 wv0 = model * vec4(v0.xyz, 1.0);
	tess1 = vec4((model * vec4(v1.xyz, 1.0)).xyz, v1.w);
	tess2 = vec4((model * vec4(v2.xyz, 1.0)).xyz, v2.w);
	tessup.xyz = normalize(up.xyz);

	float angle = v0.w;
	float sina = sin(angle);
	float cosa = cos(angle);
	vec3 nor = normalize(cross(tessup.xyz, vec3(sina, 0, cosa)));

	tesswdir.xyz = normalize( cross(nor, tessup.xyz));
	gl_Position = wv0;
}
