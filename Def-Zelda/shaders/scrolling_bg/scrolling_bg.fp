// varying mediump vec4 position;
// varying mediump vec2 var_texcoord0;

// uniform lowp sampler2D texture_sampler;
// uniform lowp vec4 tint;

// void main()
// {
// 	// Pre-multiply alpha since all runtime textures already are
// 	lowp vec4 tint_pm = vec4(tint.xyz * tint.w, tint.w);
// 	gl_FragColor = texture2D(texture_sampler, var_texcoord0.xy) * tint_pm;
// }


// scrolling_bg.fp
varying mediump vec2 var_texcoord0;

// Defold 的 uniform 必须声明为 sampler2D 或 vec4
uniform lowp sampler2D texture_sampler; // 对应 pattern_sampler
uniform lowp vec4 bg_color;             // 对应 bg_color
uniform lowp vec4 pattern_color;        // 对应 pattern_color
uniform lowp vec4 settings;             // 我们将把 time 和 size 打包进这个变量

// settings.x = TIME (由Lua传入)
// settings.y = pattern_size (例如 256.0)

void main()
{
    float time = settings.x;
    float pattern_size = settings.y;

    // 1. 计算 UV。使用 gl_FragCoord 实现屏幕空间纹理 (类似 Godot 的 FRAGCOORD)
    // gl_FragCoord.xy 是当前像素在屏幕上的坐标
    vec2 uv = gl_FragCoord.xy / pattern_size;

    // 2. 添加时间偏移 (TIME * 0.05)
    // 注意：我们需要确保纹理是可重复(Repeat)的，稍后在 Material 设置
    vec2 scrolled_uv = uv + vec2(time * 0.05, 0.0); // 仅在 X 轴滚动，类似 Godot 示例

    // 3. 采样纹理。只取红色通道 (.x 或 .r) 作为混合因子，因为原图可能是黑白的
    float pattern_mask = texture2D(texture_sampler, scrolled_uv).r;

    // 4. 混合颜色 (Mix)
    // mix(x, y, a) = x * (1-a) + y * a
    // 注意：Godot 的 mix 顺序和 GLSL 有时语境不同，这里我们逻辑是：
    // 如果 mask 是 1 (图案)，显示 pattern_color
    // 如果 mask 是 0 (背景)，显示 bg_color
    vec3 final_color = mix(bg_color.rgb, pattern_color.rgb, pattern_mask);

    gl_FragColor = vec4(final_color, 1.0);
}