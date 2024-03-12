/*  
#. 변수 유형 정의.
float : 32bit : 정밀도가 높은 값
half : 16bit : float의 1/2(Metallic, Occlusion에 사용)
fixed : 11bit : (Color, Vector, Albedo, Normal, Emission에 사용)

#. SurfaceOutputStandard 구조체 정의.
struct SurfaceOutputStandard
{
    fixed3 Albedo;      //  물체의 색상(Light에 영향 받음)
    fixed3 Normal;      //  법선
    fixed3 Emission;    //  자체 발광 색상(Light에 영향 안받음)
    half Metallic;      //  금속 재질 여부(0:비금속, 1:금속)
    half Smoothness;    //  재질의 거침 여부
    half Occlusion;     //  차폐되어 어두워지는 강도
    half Alpha;
};

#. 
Diffuse : 물체가 빛을 확산시켜 눈에 들어오는 색상 정도
Albedo : 물체의 색상. Light에 영향을 받음
Emission : 자체 발광의 광원 소스. Light에 영향을 받지 않음.
*/


Shader "Kong/Base"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        // _Glossiness ("Smoothness", Range(0,1)) = 0.5
        // _Metallic ("Metallic", Range(0,1)) = 0.0
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM        
        /////////////////////////////////////////////////////////////////////////
        //  전처리기. 쉐이더의 조명 계산 설정이나, 기타 세부적인 분기를 정해주는 부분.
        //  surface : Surface Shader를 사용하고 함수는 그 뒤의 surf 함수라고 명시
        //  fullforwardshadows : ForwardRendering에서 모든 Light(Spot, Point..)그림자를 그린다. 없으면 DirectionalLight의 그림자만 그린다.
        //  noambient : Ambient Color(주변광)을 적용하지 않는다.
        #pragma surface surf Standard fullforwardshadows// noambient
        #pragma target 3.0
        /////////////////////////////////////////////////////////////////////////

        sampler2D _MainTex;

        /////////////////////////////////////////////////////////////////////////
        //  엔진에서 받아올 데이터.
        struct Input
        {
            float2 uv_MainTex;
        };
        /////////////////////////////////////////////////////////////////////////

        // half _Glossiness;
        // half _Metallic;
        fixed4 _Color;

        /////////////////////////////////////////////////////////////////////////
        //  GPU 인스턴싱 관련
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)
        /////////////////////////////////////////////////////////////////////////

        /////////////////////////////////////////////////////////////////////////
        //  색상이나 이미지를 출력하는 부분
        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            //o.Albedo = c.rgb;
            o.Albedo = float3(1, 0, 0);
            //o.Emission = float3(1, 0, 0);
            // o.Metallic = _Metallic;
            // o.Smoothness = _Glossiness;
            o.Alpha = c.a;
        }
        /////////////////////////////////////////////////////////////////////////
        ENDCG
    }
    FallBack "Diffuse"
}
