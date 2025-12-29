# aclrtBinaryGetDevAddress

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

获取算子二进制数据在Device上的内存地址及内存大小。

## 函数原型

```
aclError aclrtBinaryGetDevAddress(const aclrtBinHandle binHandle, void **binAddr, size_t *binSize)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| binHandle | 输入 | 算子二进制句柄。<br>调用[aclrtBinaryLoadFromFile](aclrtBinaryLoadFromFile.md)接口或[aclrtBinaryLoadFromData](aclrtBinaryLoadFromData.md)接口获取算子二进制句柄，再将其作为入参传入本接口。 |
| binAddr | 输出 | 算子二进制数据在Device上的内存地址。<br>如果加载算子二进制时设置了懒加载标识（将aclrtBinaryLoadOptions.aclrtBinaryLoadOption.isLazyLoad设置为1），那么调用本接口获取到的binAddr为空指针。 |
| binSize | 输出 | 算子二进制数据的大小，单位Byte。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

