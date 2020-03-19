Shader "Custom/fun"
{
    Properties
    {
        _Color ("Color", Color) = (1, 1, 1, 1)
        _MainTex ("Albedo (RGB)", 2D) = "white" { }
        _Glossiness ("Smoothness", Range(0, 1)) = 0.5
        _Metallic ("Metallic", Range(0, 1)) = 0.0
    }
    
    //可以包含多个 ，先扫描 获取第一个可以在目标平台运行的的subshader块
    SubShader
    {
        //可选 可以在每个pass通道定义  若都有  都执行外面的tag
        // 渲染顺序 （当前shader的渲染顺序）  渲染类型
        // 着色器替换功能
        // 是否进行合批 （做顶点的变幻时 关闭 但不仅仅是这个情况）
        //是否投射阴影
        // 受不受Prejector影响，通常用于透明物体
        //时候用图片的shader 通常用于UI
        // 用作shader面板预览的类型
        
        Tags { "Queue" = "Transparent" "RenderType" = "Opaque" "DisableBatching" = "True" "ForceNoShadowCasting" = "True" "IgnoreProjector" = "True" "CanUseSpriteAtlas" = "True" "PreviewType" = "Plane" }
        //render 设置  可以写在pass 里边或者外边
        
        Cull Off   //裁剪 选择渲染那个面  off  都渲染  back 背面  front 渲染 前面
        ZTest Always //  总是进行深度  默认  LEqual
        ZWrite Off // 深度写入 、
        LOD 100  //不同情况下使用不同的LOD
        
        //各个信息储存在寄存器中  通过语义存储  //  ----  例如： POSITION CORROOD0
        
        //#pragma surface surf
        //必须  可以有多个但并不建议多个pass  ,一个pass就是一个DC
        Pass
        {
            
            Tags { "LightMode" = "ForwardBase" "RequireOptions" = "OnlyDirectional" }
            CGPROGRAM
            
            
            ENDCG
            
        }
    }
    
    //所有subshader 失败后会默认获取fallvback
    FallBack "Diffuse"
}



