// // bubble_bg.fp (再次确认内容)
// varying mediump vec2 var_texcoord0;

// uniform lowp sampler2D tex0;
// uniform lowp vec4 bg_color;
// uniform lowp vec4 params; // x:time, y:scale, z:speed_x, w:speed_y

// void main()
// {
//     // 使用屏幕坐标解决拉伸问题
//     vec2 uv = gl_FragCoord.xy / params.y;
    
//     // 加上时间偏移实现滚动
//     uv += params.x * params.zw;

//     // 采样
//     vec4 tex_sample = texture2D(tex0, uv);

//     // 混合背景色 (假设图片背景透明)
//     gl_FragColor = mix(bg_color, tex_sample, tex_sample.a);
// }

// varying mediump vec2 var_texcoord0;

// uniform lowp sampler2D tex0;
// uniform lowp vec4 bg_color;

// // params 向量定义：
// // x = time (时间)
// // y = size (图案尺寸，值越大图案越大)
// // z = speed_x (X轴速度)
// // w = speed_y (Y轴速度)
// uniform mediump vec4 params;

// // 新增：专门控制透明度的属性
// // x = opacity (图案透明度 0.0 ~ 1.0)
// uniform mediump vec4 opacity_setting; 

// void main()
// {
//     float time = params.x;
//     float size = params.y; // 这里控制尺寸！
//     vec2 speed = params.zw;
//     float opacity = opacity_setting.x; // 获取透明度

//     // --- 核心防拉伸逻辑 ---
//     // gl_FragCoord.xy 是屏幕上的物理像素位置 (例如 x=500, y=300)
//     // 除以 size 后，无论你的 Model 被缩放成什么样（长条、扁条），
//     // 这里的坐标永远是 1:1 的正方形比例。
//     vec2 uv = gl_FragCoord.xy / size;

//     // 添加滚动偏移
//     uv += time * speed;

//     // 采样纹理
//     vec4 tex_sample = texture2D(tex0, uv);

//     // --- 透明度混合逻辑 ---
//     // 计算最终的混合系数 (Alpha)
//     // tex_sample.a 是图片原本的透明度 (0或1)
//     // opacity 是你想要调节的整体透明度 (比如 0.5 半透明)
//     float final_alpha = tex_sample.a * opacity;

//     // 混合背景色和图案
//     // mix(背景, 图案, 混合度)
//     // 当 final_alpha 为 0 时显示背景，为 1 时显示图案，为 0.5 时混合
//     gl_FragColor = mix(bg_color, tex_sample, final_alpha);
// }

varying mediump vec2 var_texcoord0;

uniform lowp sampler2D tex0;
uniform lowp vec4 bg_color;

// 这是一个“超级参数包”，我们把需要的属性都塞进 vec4 里以节省插槽
// layout_props (布局属性):
// x = tile_w (宽缩放/拉伸调整)
// y = tile_h (高缩放/拉伸调整)
// z = gap_x  (左右间隔，0.0-1.0)
// w = gap_y  (上下间隔，0.0-1.0)
uniform mediump vec4 layout_props;

// scroll_props (滚动与错位):
// x = time
// y = stagger (错位程度，0.0=对齐, 0.5=像砖墙一样错开一半)
// z = speed_x
// w = speed_y
uniform mediump vec4 scroll_props;

// opacity (透明度)
uniform mediump vec4 opacity_setting;

void main()
{
    // 1. 获取参数
    vec2 tile_scale = layout_props.xy; 
    vec2 gap = layout_props.zw;
    float time = scroll_props.x;
    float stagger = scroll_props.y;
    vec2 speed = scroll_props.zw;
    float opacity = opacity_setting.x;

    // 2. 基础屏幕空间坐标 (gl_FragCoord)
    // 这里的坐标是基于像素的，除以 scale 可以控制网格大小
    vec2 pos = gl_FragCoord.xy / tile_scale;

    // 3. 应用整体滚动 (Scroll)
    // 注意：负号是为了让直觉更符合(向右滚/向下滚)
    pos -= time * speed;

    // 4. 【核心逻辑：错位 Stagger】
    // floor(pos.y) 告诉我们当前是第几行
    // mod(..., 2.0) 判断是奇数行还是偶数行
    float row_index = floor(pos.y);
    if (mod(row_index, 2.0) > 0.5) {
        // 如果是奇数行，X轴平移 stagger 的距离
        pos.x += stagger;
    }

    // 5. 【核心逻辑：网格化】
    // fract() 取小数部分，让坐标在 0.0 ~ 1.0 之间无限循环
    // tile_uv 就是每个小格子内部的坐标
    vec2 tile_uv = fract(pos);

    // 6. 【核心逻辑：间隔/Padding】
    // 我们定义一个“有效区域”。比如 gap 是 0.1，那么只有 0.05 ~ 0.95 之间的区域显示图片
    // step(edge, x) 函数：如果 x < edge 返回 0，否则返回 1。用来做硬切边。
    vec2 padding_mask = step(gap * 0.5, tile_uv) * step(tile_uv, 1.0 - gap * 0.5);
    float is_visible = padding_mask.x * padding_mask.y;

    // 7. 重新映射 UV (为了防止图片被裁切掉边缘)
    // 我们需要把被裁切后的中心区域重新拉伸回 0~1 以完整显示图片
    vec2 tex_uv = (tile_uv - gap * 0.5) / (1.0 - gap);

    // 8. 采样纹理
    vec4 tex_sample = texture2D(tex0, tex_uv);
    
    // 9. 计算最终混合
    // 逻辑：必须在可视区域内 (is_visible) 且 图片本身不透明 (tex_sample.a)
    float mask = is_visible * tex_sample.a * opacity;

    // 输出颜色
    gl_FragColor = mix(bg_color, tex_sample, mask);
}