Shader "Kong/Mix"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Tex1 (RGB)", 2D) = "white" {}
        _MainTex2 ("Tex2 (RGB)", 2D) = "white" {}
        _Ratio ("Ratio", Range(0, 1)) = 0.5
    }

    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent" }
        LOD 200

        CGPROGRAM        
        #pragma surface surf Standard
        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _MainTex2;
        float _Ratio;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_MainTex2;
        };

        fixed4 _Color;

        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            fixed4 d = tex2D (_MainTex2, IN.uv_MainTex2);

            o.Albedo = lerp(c.rgb, d.rgb, _Ratio);
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
