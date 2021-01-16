<?xml version="1.0" encoding="utf-8"?>
<res class="ShaderProgram" path="Res://pipeline/postprocess/bloom/BrightPass.shader" Type="glsl" VertexShader="#version 450&#10;&#10;layout(binding = 0, std140) uniform UBO&#10;{&#10;    mat4 u_WorldMatrix;&#10;    mat4 u_ViewProjMatrix;&#10;} vs_ubo;&#10;&#10;layout(location = 0) in vec3 a_Position;&#10;layout(location = 7) out vec2 v_UV;&#10;layout(location = 4) in vec2 a_UV;&#10;&#10;void main()&#10;{&#10;    vec4 worldPosition = vs_ubo.u_WorldMatrix * vec4(a_Position, 1.0);&#10;    vec4 clipPosition = vs_ubo.u_ViewProjMatrix * worldPosition;&#10;    gl_Position = clipPosition;&#10;    v_UV = a_UV;&#10;}&#10;&#10;" FragmentShader="#version 450&#10;&#10;layout(binding = 1) uniform sampler2D Albedo;&#10;&#10;layout(location = 7) in vec2 v_UV;&#10;layout(location = 0) out vec4 o_FragColor;&#10;&#10;vec3 SRgbToLinear(vec3 srgbIn)&#10;{&#10;    return srgbIn;&#10;}&#10;&#10;vec3 BrightKeep(vec3 color, float brightPassThreshold)&#10;{&#10;    vec3 luminanceVector = vec3(0.2125000059604644775390625, 0.7153999805450439453125, 0.07209999859333038330078125);&#10;    float luminance = dot(luminanceVector, color);&#10;    luminance = max(0.0, luminance - brightPassThreshold);&#10;    return color * sign(luminance);&#10;}&#10;&#10;vec3 LinearToSRgb(vec3 linearIn)&#10;{&#10;    return linearIn;&#10;}&#10;&#10;void main()&#10;{&#10;    float Float_32_Value = 0.800000011920928955078125;&#10;    vec4 Albedo_Color = texture(Albedo, v_UV);&#10;    vec3 param = Albedo_Color.xyz;&#10;    vec3 _66 = SRgbToLinear(param);&#10;    Albedo_Color = vec4(_66.x, _66.y, _66.z, Albedo_Color.w);&#10;    vec3 param_1 = Albedo_Color.xyz;&#10;    float param_2 = Float_32_Value;&#10;    vec3 GLSL_154 = BrightKeep(param_1, param_2);&#10;    vec3 _BaseColor = GLSL_154;&#10;    float _Opacity = 1.0;&#10;    float _Metalic = 0.20000000298023223876953125;&#10;    float _PerceptualRoughness = 0.5;&#10;    vec3 param_3 = _BaseColor;&#10;    o_FragColor = vec4(LinearToSRgb(param_3), _Opacity);&#10;}&#10;&#10;" Graph="{&#10;    &quot;connections&quot;: [&#10;        {&#10;            &quot;in_id&quot;: &quot;{5c2c52da-edae-4345-83a7-466fe2e8ed12}&quot;,&#10;            &quot;in_index&quot;: 0,&#10;            &quot;out_id&quot;: &quot;{e041c710-4a57-402e-9cbc-ff48b031b042}&quot;,&#10;            &quot;out_index&quot;: 0&#10;        },&#10;        {&#10;            &quot;in_id&quot;: &quot;{e041c710-4a57-402e-9cbc-ff48b031b042}&quot;,&#10;            &quot;in_index&quot;: 1,&#10;            &quot;out_id&quot;: &quot;{8e051cad-00c8-46b8-9d20-cebc7e037cfc}&quot;,&#10;            &quot;out_index&quot;: 0&#10;        },&#10;        {&#10;            &quot;in_id&quot;: &quot;{e041c710-4a57-402e-9cbc-ff48b031b042}&quot;,&#10;            &quot;in_index&quot;: 0,&#10;            &quot;out_id&quot;: &quot;{a11ff1c6-f5f1-42aa-8492-c7c50ea7fef8}&quot;,&#10;            &quot;out_index&quot;: 1&#10;        }&#10;    ],&#10;    &quot;nodes&quot;: [&#10;        {&#10;            &quot;id&quot;: &quot;{5c2c52da-edae-4345-83a7-466fe2e8ed12}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;name&quot;: &quot;ShaderTemplate&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: 0,&#10;                &quot;y&quot;: -13&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{8e051cad-00c8-46b8-9d20-cebc7e037cfc}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Export&quot;: &quot;false&quot;,&#10;                &quot;name&quot;: &quot;Float&quot;,&#10;                &quot;number&quot;: &quot;0.8&quot;,&#10;                &quot;variableName&quot;: &quot;Float_32&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -522,&#10;                &quot;y&quot;: 127&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{e041c710-4a57-402e-9cbc-ff48b031b042}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Code&quot;: &quot;vec3 BrightKeep(vec3 color, float brightPassThreshold)\n{\n\tvec3 luminanceVector = vec3(0.2125, 0.7154, 0.0721);\n    float luminance = dot(luminanceVector, color);\n    luminance = max(0.0, luminance - brightPassThreshold);\n\n\treturn color * sign(luminance);\n}&quot;,&#10;                &quot;FunctionName&quot;: &quot;BrightKeep&quot;,&#10;                &quot;Parameters&quot;: &quot;vec3 color, float brightPassThreshold&quot;,&#10;                &quot;ReturnType&quot;: &quot;vec3&quot;,&#10;                &quot;name&quot;: &quot;GLSL&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -277,&#10;                &quot;y&quot;: 11&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{a11ff1c6-f5f1-42aa-8492-c7c50ea7fef8}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Export&quot;: &quot;true&quot;,&#10;                &quot;isAtla&quot;: &quot;false&quot;,&#10;                &quot;name&quot;: &quot;Texture&quot;,&#10;                &quot;texture&quot;: &quot;Res://icon.png&quot;,&#10;                &quot;type&quot;: &quot;General&quot;,&#10;                &quot;variableName&quot;: &quot;Albedo&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -545,&#10;                &quot;y&quot;: -37&#10;            }&#10;        }&#10;    ]&#10;}&#10;" CullMode="CULL_BACK" BlendMode="Opaque" Uniforms.Albedo="Res://icon.png" />
