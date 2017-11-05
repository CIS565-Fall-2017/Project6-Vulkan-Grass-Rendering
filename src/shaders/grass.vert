
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// DONE: Declare vertex shader inputs and outputs
layout (location = 0) in vec4 v0;
layout (location = 1) in vec4 v1;
layout (location = 2) in vec4 v2;
layout (location = 3) in vec4 up;

// Output: Tesselation Control Shader Inputs
layout(location = 0) out vec4 ts_v1;
layout(location = 1) out vec4 ts_v2;
layout(location = 2) out vec4 ts_up;
layout(location = 3) out vec4 ts_t1; //The bitangent


out gl_PerVertex {
    vec4 gl_Position;
};

void main() {
    // DONE: Write gl_Position and any other shader outputs
	// We can pack all this data into four vec4s, such that 
	// v0.w holds orientation, 
	// v1.w holds height, 
	// v2.w holds width, 
	// up.w holds the stiffness coefficient.

	ts_v1 = vec4(vec3(model * vec4(v1.xyz, 1.0)), v1.w);
    ts_v2 = vec4(vec3(model * vec4(v2.xyz, 1.0)), v2.w);
	ts_up = normalize(up);
    
    vec3 tangent = cross(ts_up.xyz, vec3(sin(v0.w), 0, cos(v0.w)));
    ts_t1.xyz = normalize( cross(tangent, ts_up.xyz));

	gl_Position = model * vec4(v0.xyz, 1.0);
}
