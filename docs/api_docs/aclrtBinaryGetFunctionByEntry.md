# aclrtBinaryGetFunctionByEntry

**须知：本接口为预留接口，暂不支持。**

## 功能说明

根据Function Entry获取核函数句柄。

对于同一个binHandle，首次调用aclrtBinaryGetFunctionByEntry接口时，会默认将binHandle关联的算子二进制数据拷贝至当前Context对应的Device上。

## 函数原型

```
aclError aclrtBinaryGetFunctionByEntry(aclrtBinHandle binHandle, uint64_t funcEntry, aclrtFuncHandle *funcHandle)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| binHandle | 输入 | 算子二进制句柄。<br>调用[aclrtBinaryLoadFromFile](aclrtBinaryLoadFromFile.md)接口或[aclrtBinaryLoadFromData](aclrtBinaryLoadFromData.md)接口获取算子二进制句柄，再将其作为入参传入本接口。 |
| funcEntry | 输入 | 标识核函数的关键字。 |
| funcHandle | 输出 | 核函数句柄。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

