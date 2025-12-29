# aclFinalize

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

去初始化函数，用于释放进程内acl接口使用的相关资源。

对于涉及Device业务日志回传到Host的场景，本接口默认增加2000ms延时（实际最大延时可达2000ms），以确保ERROR级别和EVENT级别日志完整回传，防止不丢失。您可以将ASCEND\_LOG\_DEVICE\_FLUSH\_TIMEOUT环境变量设置为0（命令示例：export ASCEND\_LOG\_DEVICE\_FLUSH\_TIMEOUT=0），来取消该默认延时。关于ASCEND\_LOG\_DEVICE\_FLUSH\_TIMEOUT环境变量的详细描述请参见《环境变量参考》中的。

## 函数原型

```
aclError aclFinalize()
```

## 参数说明

无

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

应用进程退出前，应确保已调用aclFinalize或[aclFinalizeReference](aclFinalizeReference.md)接口完成去初始化，否则可能会导致异常，例如应用进程退出时有异常报错。

不建议在析构函数中调用aclFinalize或[aclFinalizeReference](aclFinalizeReference.md)接口，否则在进程退出时可能由于单例析构顺序未知而导致进程异常退出的问题。

