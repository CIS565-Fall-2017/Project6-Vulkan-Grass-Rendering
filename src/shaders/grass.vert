
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// TODO: Declare vertex shader inputs and outputs
//ins
layout(location = 0) in vec4 v0;
layout(location = 1) in vec4 v1;
layout(location = 2) in vec4 v2;
layout(location = 3) in vec4 up;

//outs
layout(location = 0) out vec4 v1tesc;
layout(location = 1) out vec4 v2tesc;
layout(location = 2) out vec3 uptesc;
layout(location = 3) out vec3 bitantesc;


out gl_PerVertex {
    vec4 gl_Position;
};

void main() {
	// TODO: Write gl_Position and any other shader outputs
	vec4 v0worldpos = model * vec4(v0.xyz, 1.0);
	vec4 v1worldpos = model * vec4(v1.xyz, 1.0);
	vec4 v2worldpos = model * vec4(v2.xyz, 1.0);
	vec4 upworld	= model * vec4(up.xyz, 0.0);

	v1tesc = vec4(v1worldpos.xyz, v1.w);
	v2tesc = vec4(v2worldpos.xyz, v2.w);
	uptesc = normalize(upworld.xyz);
	float angle = v0.w;
	vec3 tandir = normalize( vec3(sin(angle), 0, cos(angle)) );
	bitantesc = normalize(cross(uptesc.xyz,tandir));

	gl_Position = v0worldpos;
}
