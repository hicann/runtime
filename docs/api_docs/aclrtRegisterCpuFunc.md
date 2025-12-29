# aclrtRegisterCpuFunc

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

若使用[aclrtBinaryLoadFromData](aclrtBinaryLoadFromData.md)接口加载AI CPU算子二进制数据，还需配合使用本接口注册AI CPU算子信息，得到对应的funcHandle。

本接口只用于AI CPU算子，其它算子会返回报错ACL\_ERROR\_RT\_PARAM\_INVALID。

## 函数原型

```
aclError aclrtRegisterCpuFunc(const aclrtBinHandle handle, const char *funcName, const char *kernelName, aclrtFuncHandle *funcHandle)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| handle | 输入 | 算子二进制句柄。<br>调用[aclrtBinaryLoadFromData](aclrtBinaryLoadFromData.md)接口获取算子二进制句柄，再将其作为入参传入本接口。 |
| funcName | 输入 | 执行AI CPU算子的入口函数。不能为空。 |
| kernelName | 输入 | AI CPU算子的opType。不能为空。 |
| funcHandle | 输出 | 函数句柄。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

