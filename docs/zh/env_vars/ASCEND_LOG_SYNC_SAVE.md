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

全量芯片支持
