# aclrtCreateStreamConfigHandle

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | x |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | x |

## 功能说明

创建aclrtStreamConfigHandle类型的数据，表示一个Stream的配置对象。

如需销毁aclrtStreamConfigHandle类型的数据，请参见[aclrtDestroyStreamConfigHandle](aclrtDestroyStreamConfigHandle.md)。

## 函数原型

```
aclrtStreamConfigHandle *aclrtCreateStreamConfigHandle(void)
```

## 参数说明

无

## 返回值说明

-   返回aclrtStreamConfigHandle类型的指针，表示成功。
-   返回NULL，表示失败。

