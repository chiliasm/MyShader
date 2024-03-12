/*  
#. ���� ���� ����.
float : 32bit : ���е��� ���� ��
half : 16bit : float�� 1/2(Metallic, Occlusion�� ���)
fixed : 11bit : (Color, Vector, Albedo, Normal, Emission�� ���)

#. SurfaceOutputStandard ����ü ����.
struct SurfaceOutputStandard
{
    fixed3 Albedo;      //  ��ü�� ����(Light�� ���� ����)
    fixed3 Normal;      //  ����
    fixed3 Emission;    //  ��ü �߱� ����(Light�� ���� �ȹ���)
    half Metallic;      //  �ݼ� ���� ����(0:��ݼ�, 1:�ݼ�)
    half Smoothness;    //  ������ ��ħ ����
    half Occlusion;     //  ����Ǿ� ��ο����� ����
    half Alpha;
};

#. 
Diffuse : ��ü�� ���� Ȯ����� ���� ������ ���� ����
Albedo : ��ü�� ����. Light�� ������ ����
Emission : ��ü �߱��� ���� �ҽ�. Light�� ������ ���� ����.
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
        //  ��ó����. ���̴��� ���� ��� �����̳�, ��Ÿ �������� �б⸦ �����ִ� �κ�.
        //  surface : Surface Shader�� ����ϰ� �Լ��� �� ���� surf �Լ���� ���
        //  fullforwardshadows : ForwardRendering���� ��� Light(Spot, Point..)�׸��ڸ� �׸���. ������ DirectionalLight�� �׸��ڸ� �׸���.
        //  noambient : Ambient Color(�ֺ���)�� �������� �ʴ´�.
        #pragma surface surf Standard fullforwardshadows// noambient
        #pragma target 3.0
        /////////////////////////////////////////////////////////////////////////

        sampler2D _MainTex;

        /////////////////////////////////////////////////////////////////////////
        //  �������� �޾ƿ� ������.
        struct Input
        {
            float2 uv_MainTex;
        };
        /////////////////////////////////////////////////////////////////////////

        // half _Glossiness;
        // half _Metallic;
        fixed4 _Color;

        /////////////////////////////////////////////////////////////////////////
        //  GPU �ν��Ͻ� ����
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)
        /////////////////////////////////////////////////////////////////////////

        /////////////////////////////////////////////////////////////////////////
        //  �����̳� �̹����� ����ϴ� �κ�
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
