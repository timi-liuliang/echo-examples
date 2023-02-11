<?xml version="1.0" encoding="utf-8"?>
<res class="ShaderProgram" path="Res://Blur/gaussian-blur.shader" Type="glsl" VertexShader="#version 450&#10;&#10;layout(binding = 0, std140) uniform UBO&#10;{&#10;    mat4 u_WorldMatrix;&#10;    mat4 u_ViewProjMatrix;&#10;} vs_ubo;&#10;&#10;layout(location = 0) in vec3 a_Position;&#10;layout(location = 7) out vec2 v_UV;&#10;layout(location = 4) in vec2 a_UV;&#10;&#10;void main()&#10;{&#10;    vec4 worldPosition = vs_ubo.u_WorldMatrix * vec4(a_Position, 1.0);&#10;    vec4 clipPosition = vs_ubo.u_ViewProjMatrix * worldPosition;&#10;    gl_Position = clipPosition;&#10;    v_UV = a_UV;&#10;}&#10;&#10;" FragmentShader="#version 450&#10;&#10;layout(binding = 1) uniform sampler2D Albedo;&#10;&#10;layout(location = 7) in vec2 v_UV;&#10;layout(location = 0) out vec4 o_FragColor;&#10;&#10;vec3 GaussianBlur(sampler2D tex, vec2 uv, float radius, float dirs, float samples, float weight, float strength)&#10;{&#10;    float _step = (1.0 / samples) * radius;&#10;    vec4 origin = texture(tex, uv);&#10;    vec4 color = origin;&#10;    float count = 1.0;&#10;    for (float pi = 6.283185482025146484375, directions = dirs, d = 0.0; d &lt; pi; d += (pi / directions))&#10;    {&#10;        for (float i = 1.0; i &lt;= samples; i += 1.0)&#10;        {&#10;            float weight_1 = pow(1.0 - (i / samples), weight);&#10;            color += (texture(tex, uv + ((vec2(cos(d), sin(d)) * _step) * i)) * weight_1);&#10;            count += weight_1;&#10;        }&#10;    }&#10;    color /= vec4(count);&#10;    return mix(origin.xyz, color.xyz, vec3(strength));&#10;}&#10;&#10;void main()&#10;{&#10;    float Float_206_Value = 0.0;&#10;    float Float_193_Value = 1.0;&#10;    float Float_203_Value = 0.0199900008738040924072265625;&#10;    float Float_204_Value = 8.0;&#10;    float Float_205_Value = 8.0;&#10;    vec2 param = v_UV;&#10;    float param_1 = Float_203_Value;&#10;    float param_2 = Float_204_Value;&#10;    float param_3 = Float_205_Value;&#10;    float param_4 = Float_206_Value;&#10;    float param_5 = Float_193_Value;&#10;    vec3 GaussianBlur_189 = GaussianBlur(Albedo, param, param_1, param_2, param_3, param_4, param_5);&#10;    vec3 _BaseColor = GaussianBlur_189;&#10;    float _Opacity = 1.0;&#10;    float _Metalic = 0.20000000298023223876953125;&#10;    float _PerceptualRoughness = 0.5;&#10;    o_FragColor = vec4(_BaseColor, _Opacity);&#10;}&#10;&#10;" Graph="{&#10;    &quot;connections&quot;: [&#10;        {&#10;            &quot;in_id&quot;: &quot;{b7f7e787-366b-4d5a-b8f5-2168aa67d467}&quot;,&#10;            &quot;in_index&quot;: 0,&#10;            &quot;out_id&quot;: &quot;{e3a8d1f4-22c5-426b-90c7-1aea5fd8687a}&quot;,&#10;            &quot;out_index&quot;: 0&#10;        },&#10;        {&#10;            &quot;in_id&quot;: &quot;{e3a8d1f4-22c5-426b-90c7-1aea5fd8687a}&quot;,&#10;            &quot;in_index&quot;: 6,&#10;            &quot;out_id&quot;: &quot;{b82276e2-314f-4d3d-9de2-839ad6610afc}&quot;,&#10;            &quot;out_index&quot;: 0&#10;        },&#10;        {&#10;            &quot;in_id&quot;: &quot;{e3a8d1f4-22c5-426b-90c7-1aea5fd8687a}&quot;,&#10;            &quot;in_index&quot;: 2,&#10;            &quot;out_id&quot;: &quot;{af352433-690e-49a1-af9e-6cde04334a7b}&quot;,&#10;            &quot;out_index&quot;: 0&#10;        },&#10;        {&#10;            &quot;in_id&quot;: &quot;{e3a8d1f4-22c5-426b-90c7-1aea5fd8687a}&quot;,&#10;            &quot;in_index&quot;: 4,&#10;            &quot;out_id&quot;: &quot;{2b00a369-1a93-45f5-99f6-644959227281}&quot;,&#10;            &quot;out_index&quot;: 0&#10;        },&#10;        {&#10;            &quot;in_id&quot;: &quot;{e3a8d1f4-22c5-426b-90c7-1aea5fd8687a}&quot;,&#10;            &quot;in_index&quot;: 0,&#10;            &quot;out_id&quot;: &quot;{831c51b6-ccae-4af6-b402-f4b6fd8397e5}&quot;,&#10;            &quot;out_index&quot;: 0&#10;        },&#10;        {&#10;            &quot;in_id&quot;: &quot;{e3a8d1f4-22c5-426b-90c7-1aea5fd8687a}&quot;,&#10;            &quot;in_index&quot;: 5,&#10;            &quot;out_id&quot;: &quot;{cba53beb-afa8-4774-9d3d-8c6a5266a502}&quot;,&#10;            &quot;out_index&quot;: 0&#10;        },&#10;        {&#10;            &quot;in_id&quot;: &quot;{e3a8d1f4-22c5-426b-90c7-1aea5fd8687a}&quot;,&#10;            &quot;in_index&quot;: 3,&#10;            &quot;out_id&quot;: &quot;{2a759d05-9b8c-4cad-ae39-7bd7c52d363c}&quot;,&#10;            &quot;out_index&quot;: 0&#10;        },&#10;        {&#10;            &quot;in_id&quot;: &quot;{e3a8d1f4-22c5-426b-90c7-1aea5fd8687a}&quot;,&#10;            &quot;in_index&quot;: 1,&#10;            &quot;out_id&quot;: &quot;{8b0caea3-a688-465f-9841-ce8cc3f32bd7}&quot;,&#10;            &quot;out_index&quot;: 0&#10;        }&#10;    ],&#10;    &quot;nodes&quot;: [&#10;        {&#10;            &quot;id&quot;: &quot;{cba53beb-afa8-4774-9d3d-8c6a5266a502}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Value&quot;: &quot;0.0&quot;,&#10;                &quot;Variable&quot;: &quot;Float_206&quot;,&#10;                &quot;name&quot;: &quot;Float&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -564,&#10;                &quot;y&quot;: 530&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{b82276e2-314f-4d3d-9de2-839ad6610afc}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Value&quot;: &quot;1.0&quot;,&#10;                &quot;Variable&quot;: &quot;Float_193&quot;,&#10;                &quot;name&quot;: &quot;Float&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -565,&#10;                &quot;y&quot;: 593&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{831c51b6-ccae-4af6-b402-f4b6fd8397e5}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Atla&quot;: &quot;false&quot;,&#10;                &quot;Texture&quot;: &quot;Res://Blur/albedo.png&quot;,&#10;                &quot;Type&quot;: &quot;General&quot;,&#10;                &quot;Variable&quot;: &quot;Albedo&quot;,&#10;                &quot;name&quot;: &quot;Texture&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -586,&#10;                &quot;y&quot;: 132&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{b7f7e787-366b-4d5a-b8f5-2168aa67d467}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Variable&quot;: &quot;ShaderTemplate_185&quot;,&#10;                &quot;name&quot;: &quot;ShaderTemplate&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: 29,&#10;                &quot;y&quot;: 261&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{af352433-690e-49a1-af9e-6cde04334a7b}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Value&quot;: &quot;0.01999&quot;,&#10;                &quot;Variable&quot;: &quot;Float_203&quot;,&#10;                &quot;name&quot;: &quot;Float&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -564,&#10;                &quot;y&quot;: 350&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{8b0caea3-a688-465f-9841-ce8cc3f32bd7}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Attribute&quot;: &quot;uv0&quot;,&#10;                &quot;Variable&quot;: &quot;VertexAttribute_187&quot;,&#10;                &quot;name&quot;: &quot;VertexAttribute&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -643,&#10;                &quot;y&quot;: 277&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{e3a8d1f4-22c5-426b-90c7-1aea5fd8687a}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Code&quot;: &quot;vec3 GaussianBlur(sampler2D tex,vec2 uv, float radius, float dirs, float samples, float weight, float strength)\n{\n\t// https://www.shadertoy.com/view/Xltfzj\n\tfloat pi = 6.28318530718;\n\tfloat directions = dirs;\t// blur directions (default 16.0 - more is better but slower)\n\tfloat step = 1.0 / samples * radius;\n\tvec4 origin = texture(tex, uv);\n\tvec4 color = origin;\n\tfloat count = 1.0;\n\t\n\tfor (float d = 0.0; d &lt; pi; d += pi / directions)\n\t{\n\t\tfor (float i = 1.0; i &lt;= samples; i += 1.0)\n\t\t{\n\t\t\tfloat weight = pow(1.0 - i / samples, weight);\n\t\t\tcolor += texture(tex, uv + vec2(cos(d), sin(d)) * step * i) * weight;\n\t\t\tcount += weight;\n\t\t}\n\t}\n\n\tcolor /= count;\n\n\treturn mix(origin.xyz, color.xyz, strength);\n}&quot;,&#10;                &quot;FunctionName&quot;: &quot;GaussianBlur&quot;,&#10;                &quot;Parameters&quot;: &quot;sampler2D tex,vec2 uv, float radius, float dirs, float samples, float weight, float strength&quot;,&#10;                &quot;ReturnType&quot;: &quot;vec3&quot;,&#10;                &quot;Variable&quot;: &quot;GaussianBlur_189&quot;,&#10;                &quot;name&quot;: &quot;GaussianBlur&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -227,&#10;                &quot;y&quot;: 260&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{2a759d05-9b8c-4cad-ae39-7bd7c52d363c}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Value&quot;: &quot;8.0&quot;,&#10;                &quot;Variable&quot;: &quot;Float_204&quot;,&#10;                &quot;name&quot;: &quot;Float&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -565,&#10;                &quot;y&quot;: 408&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{2b00a369-1a93-45f5-99f6-644959227281}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Value&quot;: &quot;8.0&quot;,&#10;                &quot;Variable&quot;: &quot;Float_205&quot;,&#10;                &quot;name&quot;: &quot;Float&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -564,&#10;                &quot;y&quot;: 468&#10;            }&#10;        }&#10;    ]&#10;}&#10;" CullMode="CULL_BACK" BlendMode="Opaque" Uniforms.Albedo="Res://Blur/albedo.png" />