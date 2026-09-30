# aclFormat

各维度的含义如下：N（Batch）表示批量大小、H（Height）表示特征图高度、W（Width）表示特征图宽度、C（Channels）表示特征图通道、D（Depth）表示特征图深度。

| 数据格式 | 说明 |
| --- | --- |
| ACL_FORMAT_UNDEFINED = -1 | 未知数据类型，默认值。 |
| ACL_FORMAT_NCHW = 0 | NCHW格式。 |
| ACL_FORMAT_NHWC = 1 | NHWC格式。 |
| ACL_FORMAT_ND = 2 | 表示支持任意格式，除了Square、Tanh等这些单输入对自身处理的算子外，其他算子需谨慎使用。 |
| ACL_FORMAT_NC1HWC0 = 3 | 5维数据格式。其中，C0与微架构强相关，该值等于cube单元的size，例如16；C1是将C维度按照C0切分：C1=C/C0， 若结果不整除，最后一份数据需要填充到C0。 |
| ACL_FORMAT_FRACTAL_Z = 4 | 卷积的权重的格式。 |
| ACL_FORMAT_NC1HWC0_C04 = 12 | 5维数据格式。其中，C0固定为4，C1是将C维度按照C0切分：C1=C/C0， 若结果不整除，最后一份数据需要padding到C0。当前版本不支持。 |
| ACL_FORMAT_HWCN = 16 | HWCN格式。 |
| ACL_FORMAT_NDHWC = 27 | NDHWC格式。对于3维图像就需要使用带D（Depth）维度的格式。 |
| ACL_FORMAT_FRACTAL_NZ = 29 | 内部格式，用户目前无需使用。 |
| ACL_FORMAT_NCDHW = 30 | NCDHW格式。对于3维图像就需要使用带D（Depth）维度的格式。 |
| ACL_FORMAT_NDC1HWC0 = 32 | 6维数据格式。相比于NC1HWC0，仅多了D（Depth）维度。 |
| ACL_FRACTAL_Z_3D = 33 | 3D卷积权重格式，例如Conv3D/MaxPool3D/AvgPool3D这些算子均需以这种格式来表达。 |
| ACL_FORMAT_NC = 35 | 2维数据格式。 |
| ACL_FORMAT_NCL = 47 | 3维数据格式。 |
