<?xml version = "1.0" encoding = "utf-8"?>
<Shader>
	<VS>
		#version 300

		attribute vec3 a_Position;
		attribute vec2 a_UV;

		uniform mat4 u_WVPMatrix;

		varying vec2 v_TexCoord;

		void main(void)
		{
			vec4 position = u_WVPMatrix * vec4(a_Position, 1.0);
			gl_Position = position;

			v_TexCoord = a_UV;
		}
	</VS>
	<PS>
		#version 300
		
		precision mediump float;

		uniform sampler2D u_BaseColorTexture;
		
		// varying
		varying vec2 	  v_TexCoord;

		void main(void)
		{
			vec4  baseColor = texture2D(u_BaseColorTexture, v_TexCoord);
			float gray = dot(baseColor.xyz, vec3(0.299, 0.587, 0.114));
			
			gl_FragColor = vec4( gray, gray, gray, baseColor.a);
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
		<DepthEnable value = "false" />
		<WriteDepth value = "false" />
	</DepthStencilState>
	<Macros>
		<Macro name="GRAY_ENABLE" default="true" />
	</Macros>
</Shader>