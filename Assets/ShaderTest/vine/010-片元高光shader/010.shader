﻿// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'
//shader 的 调试方法

Shader "Custom/010"
{
    Properties
    {
        _Diffuse ("Diffuse", Color) = (1, 1, 1, 1)
        //_MainTex ("Albedo (RGB)", 2D) = "white" { }
        //_Glossiness ("Smoothness", Range(0, 1)) = 0.5
        //_Metallic ("Metallic", Range(0, 1)) = 0.0
        _Specular ("Specular", Color) = (1, 1, 1, 1)
        _Gloss ("Glossiness", Range(1, 256)) = 5
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
            float _Gloss;
            fixed4 _Specular;
            
            
            struct v2f
            {
                float4 vertex: SV_POSITION;
                
                //??
                fixed3 worldNormal: TEXCOORD0;
                float3 worldPos: TEXCOORD1;
            };
            
            v2f vert(appdata_base v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                o.worldPos = UnityObjectToWorldDir(v.vertex);
                return o;
            }
            
            
            
            fixed4 fragm(v2f i): SV_TARGET
            {
                
                fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;
                
                
                //漫反射
                fixed3 worldLightDir = normalize(_WorldSpaceLightPos0.xyz);
                //fixed3 worldLight = UnityWorldToObjectDir(worldPos);
                
                fixed3 diffuse = _LightColor0.rgb * _Diffuse.rgb * max(0, dot(worldLightDir, i.worldPos));
                
                fixed3 reflectDir = normalize(reflect(-worldLightDir, i.worldNormal));
                
                fixed3 viewDir = UnityWorldSpaceViewDir(i.worldPos);
                
                fixed3 specular = _LightColor0.rgb * _Specular.rgb * pow(max(0, dot(reflectDir, viewDir)), _Gloss);
                
                fixed3 color = diffuse + ambient + specular;
                
                return fixed4(color, 1);
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