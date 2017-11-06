
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

layout(location = 0) out vec4 tv1;
layout(location = 1) out vec4 tv2;
layout(location = 2) out vec4 tup;
layout(location = 3) out vec4 twd;


out gl_PerVertex {
    vec4 gl_Position;
};

void main() {
	// TODO: Write gl_Position and any other shader outputs
	
	vec4 _v0 = model * vec4(v0.xyz, 1.0);
	vec4 _v1 = model * vec4(v1.xyz, 1.0);
	vec4 _v2 = model * vec4(v2.xyz, 1.0);

	tv1 = vec4(_v1.xyz, v1.w);
	tv2 = vec4(_v2.xyz, v2.w);
	tup = vec4(normalize(up.xyz), tup.w);

	vec3 dir = normalize(cross(tup.xyz, vec3(sin(v0.w), 0, cos(v0.w))));
	twd = vec4(normalize(cross(dir, tup.xyz)), v1.w * 0.4);
	
	gl_Position = _v0;
}
