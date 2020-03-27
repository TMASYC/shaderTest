using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Doc : MonoBehaviour {

}
//叉乘后可以获得 垂直与 叉乘两向量形成的平面
//向量N在 某向量A上的投影 （A点乘N）N

//矩阵相乘的条件  矩阵1 的行需要与 矩阵2的列 的长度相同

// 2X4 * 3X2  矩阵  结果是  3*4矩阵

// 满足结合律 但交换律 只在被交换的是 常数时满足

// AB矩阵相乘的矩阵的转置矩阵 == b的 转置 * A的 转置矩阵

//左乘  向量在左  右乘相反 （切记 矩阵相乘的条件）

// 行向量 左乘矩阵  和 列向量右乘矩阵 是有意义的 。其他的组合无意义

//  计算出来的 向量 并不能通过转置 相等
//大部分情况下都是  行向量  乘 矩阵   ABC v 

//DX 行向量  OpenGL  列向量

// 三阶行列式的 叉乘  右对角线  加   - 左对角线 减

    //叉乘公式  相当于  行列式  a向量 * b 向量 