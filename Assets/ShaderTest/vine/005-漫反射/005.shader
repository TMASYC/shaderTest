// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'
//shader 的 调试方法

Shader "Custom/005"
{
    Properties
    {
        _Diffuse ("Diffuse", Color) = (1, 1, 1, 1)
        //_MainTex ("Albedo (RGB)", 2D) = "white" { }
        //_Glossiness ("Smoothness", Range(0, 1)) = 0.5
        //_Metallic ("Metallic", Range(0, 1)) = 0.0
    }
    SubShader
    {
        Tags { "RenderType" = "Opaque" }
        LOD 200
        
        Pass
        {
            CGPROGRAM
            
            #pragma vertex vert
            #pragma fragment fragm
            #include "Lighting.cginc"
            
            fixed4 _Diffuse;
            
            struct v2f
            {
                float4 vertex: SV_POSITION;
                
                //??
                fixed3 color: COLOR;
            };
            
            v2f vert(appdata_base v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                float3 worldnormal = UnityObjectToWorldNormal(v.normal);
                fixed3 worldlight = normalize(_WorldSpaceLightPos0.xyz);
                
                fixed3 diffuse = _LightColor0.rgb * _Diffuse.rgb * saturate(dot(worldnormal, worldlight));
                
                o.color = diffuse;
                return o;
            }
            
            
            
            fixed4 fragm(v2f i): SV_TARGET
            {
                return fixed4(i.color, 1);
            }
            
            ENDCG
            
        }
    }
    FallBack "Diffuse"
}


/*
cginc 文件
SV SystemValue  尽可能的使用 SV_开头的

基本上 pc所有精度都会被转化为 float  手机上 为 half

不要除0  尽可能不要if else 不要嵌套
*/