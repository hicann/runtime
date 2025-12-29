# aclrtBinaryLoadFromData

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

从内存加载并解析算子二进制数据，同时默认将算子二进制数据拷贝至当前Context对应的Device上，输出指向算子二进制的binHandle。

调用本接口用于加载AI CPU算子信息（aclrtBinaryLoadOption.type包含ACL\_RT\_BINARY\_LOAD\_OPT\_CPU\_KERNEL\_MODE）时，还需配合使用[aclrtRegisterCpuFunc](aclrtRegisterCpuFunc.md)接口注册AI CPU算子。

注意，系统仅将算子加载至当前Context所对应的Device上，因此在调用[aclrtLaunchKernelWithConfig](aclrtLaunchKernelWithConfig.md)接口启动算子计算任务时，所在的Device必须与算子加载时的Device相同。

## 函数原型

```
aclError aclrtBinaryLoadFromData(const void *data, size_t length, const aclrtBinaryLoadOptions *options, aclrtBinHandle *binHandle)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| data | 输入 | 存放算子二进制数据的Host内存地址，不能为空。 |
| length | 输入 | 算子二进制数据的内存大小，必须大于0，单位Byte。 |
| options | 输入 | 加载算子二进制文件的可选参数。 |
| binHandle | 输出 | 标识算子二进制的句柄。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

