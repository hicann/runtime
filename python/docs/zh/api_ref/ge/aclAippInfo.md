# aclAippInfo

| 静态Aipp配置信息 | 含义 |
| --- | --- |
| inputFormat | AIPP输入图像格式（aclAippInputFormat类型数据）。 |
| srcImageSizeW | 原始图片的宽，对于YUV420SP_U8类型的图像，要求取值是偶数。取值范围：[1,4096] |
| srcImageSizeH | 原始图片的高，对于YUV420SP_U8类型的图像，要求取值是偶数。取值范围：[1,4096] |
| cropSwitch | 是否对图片执行抠图操作，取值范围：<br> 0：不执行抠图操作，设置为0时，则设置cropStartPosW、cropStartPosH、cropSizeW、cropSizeH参数无效。<br>1：执行抠图操作。 |
| loadStartPosW | 抠图时，坐标点起始位置在图中横向的坐标。对于YUV420SP_U8格式的图像，参数取值要求是偶数。取值范围：[0, 4095] |
| loadStartPosH | 抠图时，坐标点起始位置在图中纵向的坐标。对于YUV420SP_U8格式的图像，参数取值要求是偶数。取值范围：[0, 4095] |
| cropSizeW | 抠图区域的宽度。对于YUV420SP_U8格式的图像，参数取值要求是偶数。取值范围：[1, 4096] |
| cropSizeH | 抠图区域的高度。对于YUV420SP_U8格式的图像，参数取值要求是偶数。取值范围：[1, 4096] |
| resizeSwitch | AIPP处理图片时是否支持缩放，保留字段，暂不支持该功能。 |
| resizeOutputW | 缩放后图像的宽度。 |
| resizeOutputH | 缩放后图像的高度。 |
| paddingSwitch | AIPP处理图片时补边功能开关。 |
| leftPaddingSize | W左填充。 |
| rightPaddingSize | W右填充。 |
| topPaddingSize | H上填充。 |
| bottomPaddingSize | H下填充。 |
| cscSwitch | 色域转换开关，静态AIPP配置。 |
| rbuvSwapSwitch | 色域转换前，R通道与B通道交换开关/U通道与V通道交换开关。 |
| axSwapSwitch | 色域转换前，RGBA->ARGB, YUVA->AYUV交换开关。 |
| singleLineMode | 单行处理模式（只处理抠图后的第一行）开关。 |
| matrixR0C0 | 3 * 3 CSC矩阵元素。 |
| matrixR0C1 | 3 * 3 CSC矩阵元素。 |
| matrixR0C2 | 3 * 3 CSC矩阵元素。 |
| matrixR1C0 | 3 * 3 CSC矩阵元素。 |
| matrixR1C1 | 3 * 3 CSC矩阵元素。 |
| matrixR1C2 | 3 * 3 CSC矩阵元素。 |
| matrixR2C0 | 3 * 3 CSC矩阵元素。 |
| matrixR2C1 | 3 * 3 CSC矩阵元素。 |
| matrixR2C2 | 3 * 3 CSC矩阵元素。 |
| outputBias0 | RGB转YUV时的输出偏移。 |
| outputBias1 | RGB转YUV时的输出偏移。 |
| outputBias2 | RGB转YUV时的输出偏移。 |
| inputBias0 | YUV转RGB时的输入偏移。 |
| inputBias1 | YUV转RGB时的输入偏移。 |
| inputBias2 | YUV转RGB时的输入偏移。 |
| meanChn0 | 每个通道的均值。 |
| meanChn1 | 每个通道的均值。 |
| meanChn2 | 每个通道的均值。 |
| meanChn3 | 每个通道的均值。 |
| minChn0 | 每个通道的最小值。 |
| minChn1 | 每个通道的最小值。 |
| minChn2 | 每个通道的最小值。 |
| minChn3 | 每个通道的最小值。 |
| varReciChn0 | 每个通道的方差。 |
| varReciChn1 | 每个通道的方差。 |
| varReciChn2 | 每个通道的方差。 |
| varReciChn3 | 每个通道的方差。 |
| srcFormat | 模型转换前，原始模型的输入format（aclFormat类型数据）。 |
| srcDatatype | 模型转换前，原始模型的输入datatype（aclDataType类型数据）。 |
| srcDimNum | 模型转换前，原始模型输入dims。 |
| shapeCount | 动态Shape（动态Batch或动态分辨率）场景下的档位数。 |
| outDims | 输出数据维度（aclAippDims类型）。 |
| aippExtend | 预留参数。 |
