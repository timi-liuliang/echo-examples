<?xml version="1.0" encoding="utf-8"?>
<res class="ShaderProgram" path="Res://pipeline/postprocess/debug/copy.shader" Type="glsl" VertexShader="#version 450&#10;&#10;layout(binding = 0, std140) uniform UBO&#10;{&#10;    mat4 u_WorldMatrix;&#10;    mat4 u_ViewProjMatrix;&#10;} vs_ubo;&#10;&#10;layout(location = 0) in vec3 a_Position;&#10;layout(location = 7) out vec2 v_UV;&#10;layout(location = 4) in vec2 a_UV;&#10;&#10;void main()&#10;{&#10;    vec4 worldPosition = vs_ubo.u_WorldMatrix * vec4(a_Position, 1.0);&#10;    vec4 clipPosition = vs_ubo.u_ViewProjMatrix * worldPosition;&#10;    gl_Position = clipPosition;&#10;    v_UV = a_UV;&#10;}&#10;&#10;" FragmentShader="#version 450&#10;&#10;layout(binding = 1) uniform sampler2D Base;&#10;&#10;layout(location = 7) in vec2 v_UV;&#10;layout(location = 0) out vec4 o_FragColor;&#10;&#10;void main()&#10;{&#10;    vec4 Base_Color = texture(Base, v_UV);&#10;    vec3 _BaseColor = Base_Color.xyz;&#10;    float _Opacity = 1.0;&#10;    float _Metalic = 0.20000000298023223876953125;&#10;    float _PerceptualRoughness = 0.5;&#10;    o_FragColor = vec4(_BaseColor, _Opacity);&#10;}&#10;&#10;" Graph="{&#10;    &quot;connections&quot;: [&#10;        {&#10;            &quot;in_id&quot;: &quot;{67b71c3a-26a9-4e2f-a681-aff7283d6768}&quot;,&#10;            &quot;in_index&quot;: 0,&#10;            &quot;out_id&quot;: &quot;{53f85400-6b99-42bf-a543-c5faab8d44df}&quot;,&#10;            &quot;out_index&quot;: 1&#10;        }&#10;    ],&#10;    &quot;nodes&quot;: [&#10;        {&#10;            &quot;id&quot;: &quot;{53f85400-6b99-42bf-a543-c5faab8d44df}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Atla&quot;: &quot;false&quot;,&#10;                &quot;Texture&quot;: &quot;&quot;,&#10;                &quot;Type&quot;: &quot;General&quot;,&#10;                &quot;Variable&quot;: &quot;Base&quot;,&#10;                &quot;name&quot;: &quot;Texture&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -382,&#10;                &quot;y&quot;: -45&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{67b71c3a-26a9-4e2f-a681-aff7283d6768}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Variable&quot;: &quot;ShaderTemplate_193&quot;,&#10;                &quot;name&quot;: &quot;ShaderTemplate&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: 0,&#10;                &quot;y&quot;: -13&#10;            }&#10;        }&#10;    ]&#10;}&#10;" CullMode="CULL_BACK" BlendMode="Opaque" Uniforms.Base="">
	<property name="DepthStencilState">
		<obj class="DepthStencilState" DepthEnable="false" WriteDepth="false" />
	</property>
</res>
