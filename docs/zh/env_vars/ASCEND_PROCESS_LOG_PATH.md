# ASCEND\_PROCESS\_LOG\_PATH

## 功能描述

设置日志落盘路径。

日志存储时如果不存在该目录，会自动创建该目录；如果存在则直接存储。

> [!NOTE]说明
>
>- 通过执行**echo $ASCEND\_PROCESS\_LOG\_PATH**命令可以查看环境变量设置的路径。
>- 日志落盘优先级为：ASCEND\_PROCESS\_LOG\_PATH \> ASCEND\_WORK\_PATH \> 日志默认存储路径（$HOME/ascend/log）

## 配置示例

```sh
export ASCEND_PROCESS_LOG_PATH=$HOME/log/
```

可指定日志落盘路径为任意有读写权限的目录。

## 使用约束

仅适用于Ascend EP模式

## 支持的型号

全量芯片支持
