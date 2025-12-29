# aclrtMemSetAccess

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

设置内存的访问权限。

## 函数原型

```
aclError aclrtMemSetAccess(void* virPtr, size_t size, aclrtMemAccessDesc* desc, size_t count)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| virPtr | 输入 | 虚拟内存的起始地址。<br>必须与[aclrtMapMem](aclrtMapMem.md)接口的virPtr地址相同。 |
| size | 输入 | 虚拟内存的长度。<br>必须与[aclrtMapMem](aclrtMapMem.md)接口的size相同。 |
| desc | 输入 | 内存访问的配置信息，包含内存访问保护标志、内存所在位置等。 |
| count | 输入 | desc数组长度。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

