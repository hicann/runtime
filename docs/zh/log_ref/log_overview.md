# 日志简介

请根据产品型号选择对应章节进行查看。

<!-- npu="950,A3,910b,910,310p,310b" id9 -->
- [查看日志（Ascend EP）](./viewing_logs_ep.md)：涉及的产品型号如下：
  <!-- npu="950" id1 -->
  - Ascend 950PR/Ascend 950DT
  <!-- end id1 -->
  <!-- npu="A3" id2 -->
  - Atlas A3 训练系列产品/Atlas A3 推理系列产品
  <!-- end id2 -->
  <!-- npu="910b" id3 -->
  - Atlas A2 训练系列产品/Atlas A2 推理系列产品
  <!-- end id3 -->
  <!-- npu="910" id6 -->
  - Atlas 训练系列产品
  <!-- end id6 -->
  <!-- npu="310b" id4 -->
  - Atlas 200I/500 A2 推理产品
  <!-- end id4 -->
  <!-- npu="310p" id5 -->
  - Atlas 推理系列产品
  <!-- end id5 -->
<!-- npu="310b" id7 -->
<!-- end id9 -->
- [查看日志（Ascend RC）](./viewing_logs_rc.md)：当前仅涉及Atlas 200I/500 A2 推理产品。
<!-- end id7 -->
<!-- npu="310p" id8 -->
- [查看日志（Control CPU开放形态）](./viewing_logs_open_ctrl_cpu.md)：当前仅涉及Atlas 推理系列产品。
<!-- end id8 -->

## 日志分类

日志主要用于记录系统的运行过程及异常信息，帮助用户快速定位系统运行过程中出现的问题以及开发过程中的程序调试问题。日志分为如下几类：

- **系统类日志**：系统运行时在Device侧产生的日志。主要包括：
  - Control CPU上的系统类日志，包括内核态日志和系统进程运行产生的用户态日志，主要反映AI处理器的整体运行情况。
  - 非Control CPU（例如低功耗）上的系统类日志，主要反映低功耗、Task Scheduler、ISP等组件的运行情况。

- **应用类日志**：AI应用程序运行产生的日志。主要包括：
  - Host侧AscendCL、GE、Runtime、HCCL等组件打印的日志。
  - Device侧AI CPU进程打印的日志。

本文中出现的日志文件名中的`id`和`pid`分别代表Device ID和业务进程ID，请以实际为准。

程序运行过程中，还会将软件栈的维测信息记录在内存中，当程序运行出错或进程结束时落盘到文件，以免在程序运行过程中频繁产生和记录日志文件，影响性能，这部分信息保存在trace日志中，trace日志的产生机制比较独立，详细请参见[查看trace日志](viewing_trace_logs.md)。

## 日志记录格式

日志样例如下：

```sh
[ERROR] TEFUSION(12940,atc):2021-10-17-05:54:07.599.074 [tensor_engine/te_fusion/pywrapper.cc:33]InitPyLogger Failed to import te.platform.log_util
```

日志格式如下：

```sh
[Level] ModuleName(PID,PName):DateTimeMS [FileName:LineNumber]LogContent
```

**表1**  日志字段说明

|字段|说明|
|--|--|
|Level|日志级别，包括以下几种：ERROR、WARNING、INFO、DEBUG。|
|ModuleName|产生日志的模块的名称。|
|PID|模块进程ID。|
|PName|模块进程名称。|
|DateTimeMS|日志打印时间，格式为：yyyy-mm-dd-hh:mm:ss.fff.zzz（年-月-日-时:分:秒:毫秒:微秒）。|
|FileName:LineNumber|调用日志打印接口的文件及对应的行号。|
|LogContent|各模块具体的日志内容。|
