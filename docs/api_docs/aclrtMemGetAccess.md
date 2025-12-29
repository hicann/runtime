# aclrtMemGetAccess

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

获取内存的访问权限。

## 函数原型

```
aclError aclrtMemGetAccess(void *virPtr, aclrtMemLocation *location, uint64_t *flag)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| virPtr | 输入 | 虚拟内存的起始地址。<br>必须与[aclrtMapMem](aclrtMapMem.md)接口的virPtr地址相同。 |
| location | 输入 | 内存所在位置。<br>当前仅支持将aclrtMemLocation.type设置为ACL_MEM_LOCATION_TYPE_HOST或ACL_MEM_LOCATION_TYPE_DEVICE。当aclrtMemLocation.type为ACL_MEM_LOCATION_TYPE_HOST时，aclrtMemLocation.id无效，固定设置为0即可。 |
| flag | 输出 | 内存访问保护标志。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

