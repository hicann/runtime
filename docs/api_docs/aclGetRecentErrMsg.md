# aclGetRecentErrMsg

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

获取并清空与本接口在同一个进程或线程中的其它acl接口调用失败时的错误描述信息。

获取进程级别、还是线程级别的错误描述信息由[aclInit](aclInit.md)接口中的err\_msg\_mode配置控制，默认线程级别。

建议在每次调用acl接口失败时都调用aclGetRecentErrMsg接口，以便获取调用acl接口异常时的错误描述信息，用于定位问题，否则可能导致错误信息堆积、丢失。同一个进程或线程中多次调用aclGetRecentErrMsg接口后，只有最后一次调用aclGetRecentErrMsg接口返回的错误描述字符串的指针有效，之前aclGetRecentErrMsg接口返回的错误描述字符串指针不能使用，否则可能导致内存非法访问。

## 函数原型

```
const char *aclGetRecentErrMsg()
```

## 参数说明

无

## 返回值说明

返回错误描述字符串的指针。如果通过本接口获取到多条错误描述信息，最上面的错误描述信息为最新的。

获取错误描述信息失败时，返回nullptr。

