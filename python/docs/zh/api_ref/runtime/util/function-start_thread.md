# 函数：start\_thread

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

创建线程，在线程中执行传入的Python函数。

## 函数原型

```python
thr_id, ret = acl.util.start_thread(thr_func, args_list)
```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| thr_func | Python函数对象，表示用户自定义的Python函数。<br>例如：<br>def thr_func(args_list):<br>pass |
| args_list | list，表示用户自定义的Python函数（thr_func）需要的传入参数。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| thr_id | int，线程ID号。 |
| ret | int，错误码。<br>返回0表示成功。<br>返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

新建线程，无法自动获取Context，需要调用[acl.rt.set\_context](../context/function-set_context.md)接口显式指定Context。
