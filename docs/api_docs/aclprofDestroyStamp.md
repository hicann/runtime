# aclprofDestroyStamp

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

释放msproftx事件标记。

## 函数原型

```
void aclprofDestroyStamp(void *stamp)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| stamp | 输入 | Stamp指针，指代msproftx事件标记。<br>指定[aclprofCreateStamp](aclprofCreateStamp.md)接口的指针。 |

## 返回值说明

无

## 约束说明

与[aclprofCreateStamp](aclprofCreateStamp.md)接口配对使用，在[aclprofStop](aclprofStop.md)接口前调用。

