# ASCEND\_GLOBAL\_EVENT\_ENABLE

## 功能描述

设置应用类日志是否开启Event日志。

取值为：

- 0：关闭Event日志。
- 1：开启Event日志，默认值为1。
- 其他值为非法值。

> [!NOTE]说明
>
>- 通过执行**echo $ASCEND\_GLOBAL\_EVENT\_ENABLE**命令可以查看环境变量设置的值。
>- 若环境变量未配置/配置为非法值/配置为空，采用默认值。

## 配置示例

```sh
export ASCEND_GLOBAL_EVENT_ENABLE=0
```

## 使用约束

无

## 支持的型号

全量芯片支持
