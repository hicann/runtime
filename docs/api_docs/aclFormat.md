# aclFormat<a name="ZH-CN_TOPIC_0000001265241354"></a>

```
typedef enum {
    ACL_FORMAT_UNDEFINED = -1,
    ACL_FORMAT_NCHW = 0,
    ACL_FORMAT_NHWC = 1,
    ACL_FORMAT_ND = 2,
    ACL_FORMAT_NC1HWC0 = 3,
    ACL_FORMAT_FRACTAL_Z = 4,
    ACL_FORMAT_NC1HWC0_C04 = 12,
    ACL_FORMAT_HWCN = 16,
    ACL_FORMAT_NDHWC = 27,
    ACL_FORMAT_FRACTAL_NZ = 29,
    ACL_FORMAT_NCDHW = 30,
    ACL_FORMAT_NDC1HWC0 = 32,
    ACL_FRACTAL_Z_3D = 33,
    ACL_FORMAT_NC = 35,
    ACL_FORMAT_NCL = 47,
    ACL_FORMAT_FRACTAL_NZ_C0_16 = 50,  // 当前不支持该类型
    ACL_FORMAT_FRACTAL_NZ_C0_32 = 51,  // 当前不支持该类型
    ACL_FORMAT_FRACTAL_NZ_C0_2 = 52,   // 当前不支持该类型
    ACL_FORMAT_FRACTAL_NZ_C0_4 = 53,   // 当前不支持该类型
    ACL_FORMAT_FRACTAL_NZ_C0_8 = 54,   // 当前不支持该类型
} aclFormat;
```

-   UNDEFINED：未知格式，默认值。
-   NCHW：4维数据格式。
-   NHWC：4维数据格式。
-   ND：表示支持任意格式，除了Square、Tanh等这些单输入对自身处理的算子外，其他算子需谨慎使用。
-   NC1HWC0：5维数据格式。其中，C0与微架构强相关，该值等于cube单元的size，例如16；C1是将C维度按照C0切分：C1=C/C0， 若结果不整除，最后一份数据需要padding到C0。
-   FRACTAL\_Z：卷积的权重的格式。
-   NC1HWC0\_C04：5维数据格式。其中，C0固定为4，C1是将C维度按照C0切分：C1=C/C0， 若结果不整除，最后一份数据需要padding到C0。当前版本不支持。
-   HWCN：4维数据格式。
-   NDHWC：NDHWC格式。对于3维图像就需要使用带D（Depth）维度的格式。
-   FRACTAL\_NZ：内部分形格式。用户目前无需使用。
-   NCDHW：NCDHW格式。对于3维图像就需要使用带D（Depth）维度的格式。
-   NDC1HWC0：6维数据格式。相比于NC1HWC0，仅多了D（Depth）维度。
-   FRACTAL\_Z\_3D：3D卷积权重格式，例如Conv3D/MaxPool3D/AvgPool3D这些算子都需要这种格式来表达。
-   NC：2维数据格式。
-   NCL：3维数据格式。
-   FRACTAL\_NZ\_C0\__\[M\]_：内部用于分形的特殊数据排布格式，_\[M\]_代表C0的数值，当前支持（2, 4, 8, 16, 32）。用户目前无需使用。

**各维度的含义如下**：N（Batch）表示批量大小、H（Height）表示特征图高度、W（Width）表示特征图宽度、C（Channels）表示特征图通道、D（Depth）表示特征图深度、L是特征图长度。

