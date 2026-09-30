# 函数：start\_dump\_args

## 产品支持情况

<!-- npu="950" id1 -->
- Ascend 950PR&950DT系列产品：支持
<!-- end id1 -->
<!-- npu="A3" id2 -->
- Atlas A3系列产品：支持
<!-- end id2 -->
<!-- npu="910b" id3 -->
- Atlas A2系列产品：支持
<!-- end id3 -->
<!-- npu="310b" id4 -->
- Atlas 200I/500 A2推理产品：不支持
<!-- end id4 -->
<!-- npu="310p" id5 -->
- Atlas推理系列产品：不支持
<!-- end id5 -->
<!-- npu="910" id6 -->
- Atlas训练系列产品：支持
<!-- end id6 -->

## 功能说明

调用本接口开启算子信息统计功能，并需与[函数：stop\_dump\_args](function-stop_dump_args.md)接口配合使用，将算子信息文件输出到path参数指定的目录，一个shape对应一个算子信息文件，文件中包含算子类型、算子属性、算子输入&输出的format/数据类型/shape等信息。

**使用场景：**例如要统计某个模型执行涉及哪些算子，可在模型执行之前调用acl.op.start\_dump\_args接口，在模型执行之后调用acl.op.stop\_dump\_args接口，接口调用成功后，在path参数指定的目录下生成每个算子shape的算子信息文件。

## 函数原型

- **C函数原型**

    ```c
    aclError aclopStartDumpArgs(uint32_t dumpType, const char *path)
    ```

- **python函数**

    ```python
    ret = acl.op.start_dump_args(dump_type, path)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| dumpType | int，指定dump信息的类型。<br>当前仅支持ACL_OP_DUMP_OP_AICORE_ARGS，表示统计所有算子信息。<br>0x00000001：ACL_OP_DUMP_OP_AICORE_ARGS |
| path | str，指定dump文件的保存路径，支持绝对路径或相对路径（指相对应用可执行文件所在的目录），但用户需确保路径存在或者该路径可以被创建。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

仅支持在单算子API执行场景下使用本接口，否则无法生成dump文件。
