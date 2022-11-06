<?xml version="1.0" encoding="utf-8"?>
<res class="ShaderProgram" Type="glsl" Domain="Surface" CullMode="CULL_NONE" BlendMode="Opaque">
	<property name="VertexShader"><![CDATA[#version 450

struct Position
{
    vec3 local;
    vec3 world;
    vec3 view;
};

layout(binding = 0, std140) uniform UBO
{
    mat4 u_WorldMatrix;
    mat4 u_ViewProjMatrix;
} vs_ubo;

layout(location = 0) in vec3 a_Position;
layout(location = 0) out Position v_Position;
layout(location = 3) out vec3 v_Normal;
layout(location = 1) in vec3 a_Normal;
layout(location = 4) out vec3 v_NormalLocal;

void main()
{
    vec4 worldPosition = vs_ubo.u_WorldMatrix * vec4(a_Position, 1.0);
    vec4 clipPosition = vs_ubo.u_ViewProjMatrix * worldPosition;
    v_Position.local = a_Position;
    v_Position.world = worldPosition.xyz;
    v_Position.view = ((clipPosition.xyz / vec3(clipPosition.w)) + vec3(1.0)) * 0.5;
    gl_Position = clipPosition;
    v_Normal = normalize(vec3((vs_ubo.u_WorldMatrix * vec4(a_Normal, 0.0)).xyz));
    v_NormalLocal = a_Normal;
}

]]></property>
	<property name="FragmentShader"><![CDATA[#version 450

struct Position
{
    vec3 local;
    vec3 world;
    vec3 view;
};

layout(binding = 1, std140) uniform UBO
{
    vec3 u_CameraPosition;
} fs_ubo;

layout(location = 3) in vec3 v_Normal;
layout(location = 0) out vec4 o_FragColor;
layout(location = 1) out vec4 o_FragPosition;
layout(location = 0) in Position v_Position;
layout(location = 2) out vec4 o_FragNormal;
layout(location = 3) out vec4 o_FragMetalicRoughnessShadingModelID;
layout(location = 4) in vec3 v_NormalLocal;

void main()
{
    vec4 Color_247_Value = vec4(1.0);
    vec3 _BaseColor = Color_247_Value.xyz;
    vec3 _Normal = v_Normal;
    float _Opacity = 1.0;
    float _Metalic = 0.20000000298023223876953125;
    float _PerceptualRoughness = 0.5;
    float _AmbientOcclusion = 1.0;
    o_FragColor = vec4(_BaseColor, _Opacity);
    o_FragPosition = vec4(v_Position.world.x, v_Position.world.y, v_Position.world.z, o_FragPosition.w);
    vec3 _50 = (_Normal + vec3(1.0)) * 0.5;
    o_FragNormal = vec4(_50.x, _50.y, _50.z, o_FragNormal.w);
    o_FragMetalicRoughnessShadingModelID = vec4(_Metalic, _PerceptualRoughness, 1.0, _AmbientOcclusion);
}

]]></property>
	<property name="Graph"><![CDATA[{
    "connections": [
        {
            "in_id": "{d70b0349-bb41-40e7-95c1-a22d0e012a12}",
            "in_index": 0,
            "out_id": "{e99debbb-8f6c-4552-b65a-415d2e8b0890}",
            "out_index": 0
        },
        {
            "in_id": "{d70b0349-bb41-40e7-95c1-a22d0e012a12}",
            "in_index": 2,
            "out_id": "{4edc5472-997f-44e8-82f7-74a5840f1da5}",
            "out_index": 0
        }
    ],
    "nodes": [
        {
            "id": "{d70b0349-bb41-40e7-95c1-a22d0e012a12}",
            "model": {
                "Variable": "ShaderTemplateOpaque_246",
                "name": "ShaderTemplateOpaque"
            },
            "position": {
                "x": 0,
                "y": 304
            }
        },
        {
            "id": "{e99debbb-8f6c-4552-b65a-415d2e8b0890}",
            "model": {
                "Color": "1 1 1 1 ",
                "Uniform": "false",
                "Variable": "Color_247",
                "name": "Color"
            },
            "position": {
                "x": -304,
                "y": 317
            }
        },
        {
            "id": "{4edc5472-997f-44e8-82f7-74a5840f1da5}",
            "model": {
                "Attribute": "normal(world)",
                "Variable": "VertexAttribute_248",
                "name": "VertexAttribute"
            },
            "position": {
                "x": -447,
                "y": 422
            }
        }
    ]
}
]]></property>
	<property name="DepthStencilState">
		<obj class="DepthStencilState" DepthEnable="true" WriteDepth="true" />
	</property>
</res>
