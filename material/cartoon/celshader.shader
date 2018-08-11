<?xml version = "1.0" encoding = "utf-8"?>
<Shader>
	<VS>#version 100

		attribute vec3 a_Position;
		attribute vec2 a_UV;
		attribute vec3 a_Normal;

		uniform mat4  u_WorldMatrix;
		uniform mat4  u_WorldViewProjMatrix;

		varying vec2 v_TexCoord;
		varying vec3 v_Normal;

		void main(void)
		{
			gl_Position = u_WorldViewProjMatrix * vec4(a_Position, 1.0);

			v_TexCoord = a_UV;
			v_Normal = mat3(u_WorldMatrix) * a_Normal;
		}
	</VS>
	<PS>#version 100

		precision mediump float;

		// uniforms
		uniform vec3		u_CameraDirection;
		uniform sampler2D 	u_CelShaderSampler;
		uniform float		u_SpecularExp;

		// varying
		varying vec2 	  v_TexCoord;
		varying vec3      v_Normal;

		void main(void)
		{
			vec4 baseColor = vec4(1.0);

			// N - normal direction from surface to out
			// L - light direction from surface to light
			vec3 N = normalize(v_Normal);
			vec3 L = normalize(vec3(1.0, 0.5, 0.0));
			vec3 V = normalize(-u_CameraDirection);
			vec3 H = normalize(V + L);

			// df - diffuse factor
			float df =  ( dot(N, L) + 1.0) * 0.5;
			
			// specular
			float sf = pow(dot( N, H), u_SpecularExp);
			
			vec3 celColor = texture2D( u_CelShaderSampler, vec2( df, 0.5)).xyz;
			vec3 finalColor = celColor * baseColor.xyz + sf;
			
			gl_FragColor = vec4( finalColor, baseColor.a);
		}
		
	</PS>
	<BlendState>
	</BlendState>
	<RasterizerState>
		<CullMode value = "CULL_FRONT" />
	</RasterizerState>
	<DepthStencilState>
		<DepthEnable value="true" />
		<WriteDepth value = "true" />
	</DepthStencilState>
	<Macros>
	</Macros>
</Shader>
