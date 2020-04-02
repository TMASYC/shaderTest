// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/003"
{
    Properties
    {
        _Color ("Color", Color) = (1, 1, 1, 1)
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
            #include "UnityCG.cginc"
            // POSITION SV_POSITION 语义
            //只有在CGPROGRAM内再次定义一个与属性快内名字与之相同的变量，属性快对应的才会生效
            fixed4 _Color;
            
            struct a2v  //application to vertex
            {
                //用模型定点填充 v变量
                float4 vertex: POSITION;
                //用模型的法线填充normal变量
                float3 normal: NORMAL;
                // 用模型的第一套uv进行填充 texcoord
                float4 texcoord: TEXCOORD0; //第一套UV
            };
            
            struct v2f
            {
                //pos 为裁剪空间中的位置信息 sv_Position 将pos信息告知给unity
                float4 postion: SV_POSITION;
                //color0 语义可以存储颜色信息
                fixed3 color: COLOR0;
            };
            //vert to fragment
            
            
            
            v2f vert(appdata_base v)
            {
                //return UnityObjectToClipPos(v); //矩阵右乘
                
                v2f o;
                o.postion = UnityObjectToClipPos(v.vertex);
                //将（-1，1）转变为（0，1）区间的方法
                o.color = v.normal * 0.5 + fixed3(0.5, 0.5, 0.5);
                
                return o;
            }
            
            
            
            fixed4 fragm(v2f i): SV_TARGET
            {
                fixed3 c = i.color;
                c *= _Color.rgb;
                return fixed4(c, 1);
            }
            
            ENDCG
            
        }
    }
    FallBack "Diffuse"
}
