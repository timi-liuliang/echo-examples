<?xml version = "1.0" encoding = "utf-8"?>
<Shader>
	<VS>
		#version 300

		attribute vec3 a_Position;
		attribute vec2 a_UV;
		attribute vec3 a_Normal;

		uniform mat4  u_WorldViewProjMatrix;
		uniform float u_OutlineWidthCM;

		varying vec2 v_TexCoord;
		varying vec3 v_Normal;

		void main(void)
		{
			gl_Position = u_WorldViewProjMatrix * vec4(a_Position + a_Normal * 0.01 * u_OutlineWidthCM, 1.0);

			v_TexCoord = a_UV;
			v_Normal = a_Normal;
		}
	</VS>
	<PS>
		#version 300
		
		precision mediump float;

		uniform vec4 u_BaseColor;
		
		// varying
		varying vec2 	  v_TexCoord;
		varying vec3      v_Normal;

		void main(void)
		{	
			gl_FragColor = u_BaseColor;
		}
	</PS>
	<BlendState>
	</BlendState>
	<RasterizerState>
		<CullMode value = "CULL_BACK" />
	</RasterizerState>
	<DepthStencilState>
		<WriteDepth value = "true" />
	</DepthStencilState>
	<Macros>
	</Macros>
</Shader>