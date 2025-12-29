# aclFinalizeReference

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

去初始化函数，用于释放进程内acl接口使用的相关资源。

aclFinalizeReference接口内部涉及引用计数的实现，aclInit接口每被调用一次，则引用计数加一，aclFinalizeReference接口每被调用一次，则该引用计数减一，当引用计数减到0时，才会真正去初始化。[aclFinalize](aclFinalize.md)接口与本接口的区别在于，调用aclFinalize接口会将计数清零，直接去初始化。

## 函数原型

```
aclError aclFinalizeReference(uint64_t *refCount)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| refCount | 输入&输出 | 返回调用aclFinalizeReference后的引用计数。<br>若不需要获取引用计数，此处可传nullptr。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

应用进程退出前，应确保已调用[aclFinalize](aclFinalize.md)或aclFinalizeReference接口完成去初始化，否则可能会导致异常，例如应用进程退出时有异常报错。

不建议在析构函数中调用[aclFinalize](aclFinalize.md)或aclFinalizeReference接口，否则在进程退出时可能由于单例析构顺序未知而导致进程异常退出的问题。

