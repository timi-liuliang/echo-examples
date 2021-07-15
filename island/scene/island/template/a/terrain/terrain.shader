<?xml version="1.0" encoding="utf-8"?>
<res class="ShaderProgram" path="Res://island/heart/terrain/terrain.shader" Type="glsl" VertexShader="#version 450&#10;&#10;layout(binding = 0, std140) uniform UBO&#10;{&#10;    mat4 u_WorldMatrix;&#10;    mat4 u_ViewProjMatrix;&#10;} vs_ubo;&#10;&#10;layout(location = 0) in vec3 a_Position;&#10;&#10;void main()&#10;{&#10;    vec4 worldPosition = vs_ubo.u_WorldMatrix * vec4(a_Position, 1.0);&#10;    vec4 clipPosition = vs_ubo.u_ViewProjMatrix * worldPosition;&#10;    gl_Position = clipPosition;&#10;}&#10;&#10;" FragmentShader="#version 450&#10;&#10;layout(location = 0) out vec4 o_FragColor;&#10;&#10;void main()&#10;{&#10;    vec4 Color_158_Value = vec4(0.0, 0.0, 0.0, 1.0);&#10;    vec3 _BaseColor = Color_158_Value.xyz;&#10;    float _Opacity = 1.0;&#10;    float _Metalic = 0.20000000298023223876953125;&#10;    float _PerceptualRoughness = 0.5;&#10;    o_FragColor = vec4(_BaseColor, _Opacity);&#10;}&#10;&#10;" Graph="{&#10;    &quot;connections&quot;: [&#10;        {&#10;            &quot;in_id&quot;: &quot;{6673183f-819d-4ebb-9a31-9aa576363e38}&quot;,&#10;            &quot;in_index&quot;: 0,&#10;            &quot;out_id&quot;: &quot;{6e25e178-1467-43ce-9b70-03c49740275a}&quot;,&#10;            &quot;out_index&quot;: 0&#10;        }&#10;    ],&#10;    &quot;nodes&quot;: [&#10;        {&#10;            &quot;id&quot;: &quot;{6673183f-819d-4ebb-9a31-9aa576363e38}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Variable&quot;: &quot;ShaderTemplate_157&quot;,&#10;                &quot;name&quot;: &quot;ShaderTemplate&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: 0,&#10;                &quot;y&quot;: 304&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{6e25e178-1467-43ce-9b70-03c49740275a}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Color&quot;: &quot;0 0 0 1 &quot;,&#10;                &quot;Variable&quot;: &quot;Color_158&quot;,&#10;                &quot;name&quot;: &quot;Color&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -235,&#10;                &quot;y&quot;: 319&#10;            }&#10;        }&#10;    ]&#10;}&#10;" CullMode="CULL_BACK" BlendMode="Opaque">
	<property name="DepthStencilState">
		<obj class="DepthStencilState" DepthEnable="true" WriteDepth="true" />
	</property>
</res>