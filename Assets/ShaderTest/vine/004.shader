// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'
//shader 的 调试方法

Shader "Custom/004"
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
            
            
            struct v2f
            {
                //pos 为裁剪空间中的位置信息 sv_Position 将pos信息告知给unity
                float4 postion: SV_POSITION;
                //color0 语义可以存储颜色信息
                fixed3 color: COLOR0;
            };
            //vert to fragment
            
            
            
            v2f vert(appdata_full v)
            {
                //return UnityObjectToClipPos(v); //矩阵右乘
                
                //
                
                v2f o;
                o.postion = UnityObjectToClipPos(v.vertex);
                //将（-1，1）转变为（0，1）区间的方法  法线
                o.color = v.normal * 0.5 + fixed3(0.5, 0.5, 0.5);
                
                
                // 切线
                
                o.color = v.tangent.xyz * 0.5 + fixed3(0.5, 0.5, 0.5);
                
                // uv
                
                o.color = fixed4(v.texcoord.xy, 0, 1);
                
                //顶点颜色
                
                o.color = v.color;
                return o;
            }
            
            
            
            fixed4 fragm(v2f i): SV_TARGET
            {
                fixed3 c = i.color;
                c *= _Color.rgb;
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