# ASCEND\_LOG\_SYNC\_SAVE

## 功能描述

指定日志拥塞处理方式。

- 0：默认处理方式，在日志拥塞或IO访问性能差的情况下，为保证业务性能不劣化，系统可能会丢失日志。
- 1：在日志拥塞或IO访问性能差的情况下，不丢失日志。该方式下，为便于问题定位，建议配置为1。

> [!NOTE]说明
>如果用户通过ASCEND\_GLOBAL\_LOG\_LEVEL、ASCEND\_MODULE\_LOG\_LEVEL调整了日志级别，则系统按照不丢失日志处理

## 配置示例

```sh
export ASCEND_LOG_SYNC_SAVE=1
```

## 使用约束

仅适用于Ascend EP形态

## 支持的型号

<!-- npu="910" id1 -->
Atlas 训练系列产品
<!-- end id1 -->

<!-- npu="310p" id2 -->
Atlas 推理系列产品
<!-- end id2 -->

<!-- npu="910b" id3 -->
Atlas A2 训练系列产品/Atlas A2 推理系列产品
<!-- end id3 -->

<!-- npu="A3" id4 -->
Atlas A3 训练系列产品/Atlas A3 推理系列产品
<!-- end id4 -->

<!-- npu="950" id5 -->
Ascend 950PR/Ascend 950DT
<!-- end id5 -->

<!-- npu="310b" id6 -->
Atlas 200I/500 A2 推理产品
<!-- end id6 -->