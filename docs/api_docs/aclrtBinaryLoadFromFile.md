# aclrtBinaryLoadFromFile

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

从文件加载并解析算子二进制文件，输出指向算子二进制的binHandle。

对于AI Core算子，若使用本接口加载并解析算子二进制文件，需配套使用[aclrtLaunchKernelWithConfig](aclrtBinaryLoadFromFile.md)、[aclrtLaunchKernelV2](aclrtLaunchKernelV2.md)或[aclrtLaunchKernelWithHostArgs](aclrtLaunchKernelWithHostArgs.md)接口下发计算任务。

## 函数原型

```
aclError aclrtBinaryLoadFromFile(const char* binPath, aclrtBinaryLoadOptions *options, aclrtBinHandle *binHandle)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| binPath | 输入 | 算子二进制文件（*.o文件）的路径，要求绝对路径。<br>对于AI CPU算子，该参数支持传算子信息库文件（*.json）。 |
| options | 输入 | 加载算子二进制文件的可选参数。 |
| binHandle | 输出 | 标识算子二进制的句柄。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

针对某一型号的产品，编译生成的算子二进制文件，必须在相同型号的产品上使用。

