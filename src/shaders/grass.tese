#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout(location = 0) out vec2 fs_uv;
layout(location = 1) out vec3 fs_normal;
layout(location = 2) out vec4 fs_color;

layout(location = 0) patch in vec4 tese_v1;
layout(location = 1) patch in vec4 tese_v2;
layout(location = 2) patch in vec4 tese_up;
layout(location = 3) patch in vec4 tese_bitangent;
layout(location = 4) patch in vec4 tese_color;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
	mat4 viewProj = camera.proj * camera.view;
	//vec4 worldPos = gl_in[0].gl_Position;
	// hard-coded width for now
	//worldPos.x += 0.12 * (u > 0.5 ? 1.0 : -1.0);
	//worldPos.x = v >= 0.9 ? gl_in[0].gl_Position.x : worldPos.x;
	
	// bezier w/ De Casteljau =================================================
	vec4 bezierA = gl_in[0].gl_Position + v * (tese_v1 - gl_in[0].gl_Position);
	vec4 bezierB = tese_v1 + v * (tese_v2 - tese_v1);
	vec4 bezierC = bezierA + v * (bezierB - bezierA);
	vec4 worldPos = bezierC;

	// move along bitangent, unless at top (being at top == v is 1.0) 
	worldPos.xyz += v >= 0.99 ? vec3(0.0) :
	                            tese_bitangent.xyz *  tese_bitangent.w * (u > 0.5 ? 1.0 : -1.0) * (1.0 - v);
	
	// compute normal
	fs_normal = normalize(cross(normalize(vec3(bezierB - bezierA)), tese_bitangent.xyz));

	// hard-coded height
	//worldPos.y += 2.0 * v;

	//worldPos.z += v <= 0.01 ? 0.0 :
	//              v <= 0.26 ? 0.1 :
	//			  v <= 0.51 ? 0.3 :
	//			  v <= 0.99 ? 0.6 :
	//			              1.0;

	// middle displacement ====================================================
	// TODO
	// d = w n (0.5 - |u - 0.5|(1 - v))
	//vec3 middleDisplacement = tese_bitangent.w * fs_normal * (0.5 - abs(u - 0.5) * (1.0 - v));
	//worldPos.xyz += middleDisplacement;

	gl_Position = viewProj * worldPos;
	fs_color = tese_color;
	fs_uv.x = (0.49 <= u && u <= 0.5) ? 1.0 : 0.0;
	fs_uv.y = (0.24 <= v && v <= 0.26) ? 1.0 : 0.0;
}
