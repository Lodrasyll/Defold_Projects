varying mediump vec4 position;
varying mediump vec2 var_texcoord0;

// Defold 常量
uniform lowp vec4 color_one;
uniform lowp vec4 color_two;
uniform mediump vec4 time;       // 建议用 mediump
uniform mediump vec4 resolution; // 建议用 mediump

#define angle -20.0
#define line_count 80.0
#define speed 5.0
#define blur 0.0

vec2 rotate(vec2 uv, float rotation_angle) {
	float radians_angle = radians(rotation_angle);
	float cos_angle = cos(radians_angle);
	float sin_angle = sin(radians_angle);
	// GLSL ES 1.0/2.0 标准矩阵构造
	mat2 rotation_matrix = mat2(cos_angle, -sin_angle, sin_angle, cos_angle);
	return uv * rotation_matrix;
}

float stripe(vec2 uv) {
	// 关键修正：使用 time.x，确保参与运算的是 float
	return cos(uv.x * 0.0 - time.x * speed + uv.y * -line_count / 2.0);
}

void main()
{
	vec2 uv = var_texcoord0.xy;

	// 分辨率适配
	float aspect = resolution.x / resolution.y;
	uv.x *= aspect;

	// 旋转
	uv = rotate(uv, angle);

	// 生成条纹值
	float g = stripe(uv);

	// 关键修正：mix 结果取 .xyz 赋值给 vec3，或者直接处理 vec4
	float edge = smoothstep(0.0, blur, g);
	vec3 col = mix(color_one.xyz, color_two.xyz, edge);

	// Defold 通常需要考虑 alpha，这里暂定为 1.0
	gl_FragColor = vec4(col, 0.6);
}