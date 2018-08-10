<?xml version = "1.0" encoding = "utf-8"?>
<Shader>
	<VS>#version 300

		attribute vec3 a_Position;
		attribute vec2 a_UV;
		attribute vec3 a_Normal;

		uniform mat4 u_WorldViewProjMatrix;

		varying vec2 v_TexCoord;

		void main(void)
		{
			vec4 position = u_WorldViewProjMatrix * vec4(a_Position, 1.0);
			gl_Position = position;

			v_TexCoord = a_UV;
		}
	</VS>
	<PS>#version 300
		
		precision mediump float;

		uniform float     u_Alpha;
		uniform sampler2D u_BaseColorTexture;
		
		// varying
		varying vec2 	  v_TexCoord;

		void main(void)
		{
			vec4  baseColor = texture2D(u_BaseColorTexture, v_TexCoord);
			baseColor.w = 0.25;
		
			gl_FragColor = baseColor;
		}
	</PS>
	<BlendState>
		<BlendEnable value = "true" />
		<SrcBlend value = "BF_SRC_ALPHA" />
		<DstBlend value = "BF_INV_SRC_ALPHA" />
	</BlendState>
	<RasterizerState>
		<CullMode value = "CULL_NONE" />
	</RasterizerState>
	<DepthStencilState>
		<DepthEnable value = "true" />
		<WriteDepth value = "false" />
		<DepthFunc value="CF_LESS_EQUAL" />
	</DepthStencilState>
	<Macros>
	</Macros>
</Shader>