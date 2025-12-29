# aclrtAllocatorCreateDesc

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

创建aclrtAllocatorDesc类型的数据，表示Allocator描述信息，主要用于注册回调函数。

## 函数原型

```
aclrtAllocatorDesc aclrtAllocatorCreateDesc()
```

## 返回值说明

-   返回aclrtAllocatorDesc类型的指针，表示成功。
-   返回NULL，表示失败。

