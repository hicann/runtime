# aclrtDestroyEvent

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

销毁Event，支持在Event未完成前调用本接口销毁Event。此时，本接口不会阻塞线程等Event完成，Event相关资源会在Event完成时被自动释放。

## 函数原型

```
aclError aclrtDestroyEvent(aclrtEvent event)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| event | 输入 | 待销毁的Event。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

在调用aclrtDestroyEvent接口销毁指定Event时，需确保其它接口没有正在使用该Event。

