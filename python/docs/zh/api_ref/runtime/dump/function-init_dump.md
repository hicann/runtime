# 函数：init\_dump

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
- Atlas 200I/500 A2推理产品：支持
<!-- end id4 -->
<!-- npu="310p" id5 -->
- Atlas推理系列产品：支持
<!-- end id5 -->
<!-- npu="910" id6 -->
- Atlas训练系列产品：支持
<!-- end id6 -->

## 功能说明

Dump初始化。

## 函数原型

- **C函数原型**

    ```c
    aclError aclmdlInitDump()
    ```

- **python函数**

    ```python
    ret = acl.mdl.init_dump()
    ```

## 参数说明

无

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

- [acl.mdl.init\_dump](function-init_dump.md)接口需要与[acl.mdl.set\_dump](function-set_dump.md)接口、[acl.mdl.finalize\_dump](function-finalize_dump.md)接口配合使用，用于将Dump数据记录到文件中。一个进程内，可以根据需求多次调用这些接口，基于不同的Dump配置信息，获取Dump数据。
- 场景举例：
  - 两次模型执行，需要设置不同的Dump配置信息，接口调用顺序：[acl.init](../init/function-init.md)接口 --\> acl.mdl.init\_dump接口 --\>  [acl.mdl.set\_dump](function-set_dump.md)接口 --\> 模型加载 --\> 模型执行 --\>  [acl.mdl.finalize\_dump](function-finalize_dump.md)接口 --\> 模型卸载 --\>  [acl.mdl.init\_dump](function-init_dump.md)接口 --\>  [acl.mdl.set\_dump](function-set_dump.md)接口 --\> 模型加载 --\> 模型执行 --\>  [acl.mdl.finalize\_dump](function-finalize_dump.md)接口 --\> 模型卸载 --\> 执行其它任务 --\>  [acl.finalize](../init/function-finalize.md)接口
  - 同一个模型执行两次，第一次需要Dump，第二次无需Dump，接口调用顺序：[acl.init](../init/function-init.md)接口 --\> acl.mdl.init\_dump接口 --\>  [acl.mdl.set\_dump](function-set_dump.md)接口 --\> 模型加载 --\> 模型执行 --\>  [acl.mdl.finalize\_dump](function-finalize_dump.md)接口 --\> 模型卸载 --\> 模型加载 --\> 模型执行 --\> 执行其它任务 --\>  [acl.finalize](../init/function-finalize.md)接口

- 对于模型Dump配置、单算子Dump配置、溢出算子Dump配置，如果已经通过[acl.init](../init/function-init.md)接口配置了dump信息，则调用acl.mdl.init\_dump接口时会返回失败。
- 必须在调用[acl.init](../init/function-init.md)接口之后、模型加载接口之前调用[acl.mdl.init\_dump](function-init_dump.md)接口。

## 资源参考

还提供了[acl.init](../init/function-init.md)接口，在初始化阶段，通过\*.json文件传入Dump配置信息，运行应用后获取Dump数据的方式。该种方式，一个进程内，只能调用一次[acl.init](../init/function-init.md)接口，如果要修改Dump配置信息，需修改\*.json文件中的配置。
