#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs

// input from control shader
layout(location = 0) patch in vec4 tessellation_eval_v1;
layout(location = 1) patch in vec4 tessellation_eval_v2;
layout(location = 2) patch in vec4 tessellation_eval_up;
layout(location = 3) patch in vec4 tessellation_eval_forward;

layout(location = 0) out vec4 pos;
layout(location = 1) out vec3 nor;
layout(location = 2) out vec3 forward;
layout(location = 3) out vec2 uv;



void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
	
	// construct blade geometry	
	vec3 a = gl_in[0].gl_Position.xyz + v * (tessellation_eval_v1.xyz - gl_in[0].gl_Position.xyz);
	vec3 b = tessellation_eval_v1.xyz + v * (tessellation_eval_v2.xyz - tessellation_eval_v1.xyz);
	vec3 c = a + v * (b - a);

	vec3 t1 = cross(tessellation_eval_up.xyz, tessellation_eval_forward.xyz); 
	vec3 wt1 = t1 * tessellation_eval_v2.w * 0.5;

    vec3 c0 = c - wt1;
	vec3 c1 = c + wt1;

    vec3 t0 = normalize(b - a);
	nor = normalize(cross(t1, t0));

    uv = vec2(u, v);

	// triagnle 
	float t = u + 0.5 * v - u * v;
    pos.xyz = (1.0 - t) * c0 + t * c1;
	pos = camera.proj * camera.view * vec4(pos.xyz, 1.0);

	forward = tessellation_eval_forward.xyz;

    gl_Position = pos;


	//gl_Position = camera.proj * camera.view * (gl_in[0].gl_Position + vec4(1.0 - u, v, 0.0, 0.0));

}
