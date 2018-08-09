<?xml version = "1.0" encoding = "utf-8"?>
<Shader>
	<VS>#version 300

		attribute vec3 a_Position;
		attribute vec2 a_UV;
		attribute vec3 a_Normal;

		uniform mat4 u_WVPMatrix;

		varying vec2 v_TexCoord;

		void main(void)
		{
			vec4 position = u_WVPMatrix * vec4(a_Position, 1.0);
			gl_Position = position;

			v_TexCoord = a_UV;
		}
	</VS>
	<PS>#version 300
		
		precision mediump float;

		uniform float     u_Alpha;
		
		// varying
		varying vec2 	  v_TexCoord;

		void main(void)
		{	
			gl_FragColor = vec4(1.0, 1.0, 1.0, 1.0);
		}
	</PS>
	<BlendState>
		<BlendEnable value = "true" />
		<ColorWriteMask value="CMASK_NONE" />
	</BlendState>
	<RasterizerState>
		<CullMode value = "CULL_NONE" />
	</RasterizerState>
	<DepthStencilState>
		<DepthEnable value = "true" />
		<WriteDepth value = "true" />
	</DepthStencilState>
	<Macros>
	</Macros>
</Shader>