// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/002"
{
    Properties
    {
        ///_Color ("Color", Color) = (1, 1, 1, 1)
        _MainTex ("Albedo (RGB)", 2D) = "white" { }
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
            
            // POSITION SV_POSITION 语义
            
            float4 vert(float4 v: POSITION): SV_POSITION
            {
                //return UnityObjectToClipPos(v); //矩阵右乘
                
                return UnityObjectToClipPos(v);
            }
            
            
            
            fixed4 fragm(): SV_TARGET
            {
                return fixed4(1, 1, 1, 1);
            }
            
            ENDCG
            
        }
    }
    FallBack "Diffuse"
}
