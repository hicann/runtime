# aclopStartDumpArgs

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

调用本接口开启算子信息统计功能，并需与[aclopStopDumpArgs](aclopStopDumpArgs.md)接口配合使用，将算子信息文件输出到path参数指定的目录，一个shape对应一个算子信息文件，文件中包含算子类型、算子属性、算子输入&输出的format/数据类型/shape等信息。

**使用场景：**例如要统计某个模型执行涉及哪些算子，可在模型执行之前调用aclopStartDumpArgs接口，在模型执行之后调用aclopStopDumpArgs接口，接口调用成功后，在path参数指定的目录下生成每个算子shape的算子信息文件。

## 函数原型

```
aclError aclopStartDumpArgs(uint32_t dumpType, const char *path)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| dumpType | 输入 | 指定dump信息的类型。<br>当前仅支持ACL_OP_DUMP_OP_AICORE_ARGS，表示统计所有算子信息。<br>#define ACL_OP_DUMP_OP_AICORE_ARGS 0x00000001U |
| path | 输入 | 指定dump文件的保存路径，支持绝对路径或相对路径（指相对应用可执行文件所在的目录），但用户需确保路径存在或者该路径可以被创建。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

仅支持在单算子API执行（例如，接口名前缀为aclnn的接口）场景下使用本接口，否则无法生成dump文件。

