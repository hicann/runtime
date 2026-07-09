# 查看日志（Control CPU开放形态）

本节介绍Control CPU开放形态下，日志文件存储路径以及各日志文件记录的主要信息。

日志相关说明如下：

- 应用类日志支持老化，默认每个类型日志（debug、run、security）分别支持存储24个“`device-app-pid`”目录，系统每隔15秒对该目录进行一次扫描，如果日志超过配置的存储限制，将会自动删除最早的`device-app-pid`目录。

  存储“`device-app-pid`”目录的数量配置以及每个“`device-app-pid`”目录存储的日志文件的数量和单个日志文件的大小具体请参见[日志配置文件](viewing_config_file.md)。

- 最多支持24个应用进程并发处理，如果超过该数值，可能会导致日志丢失。

**表1**  日志文件介绍

|存储路径|说明|
|--|--|
|`/var/log/npu/slog/debug/device-app-pid/device-app-pid_*.log`|Control CPU上应用进程产生的调试日志。|
|`/var/log/npu/slog/run/device-app-pid/device-app-pid_*.log`|Control CPU上应用进程产生的运行日志。|
|`/var/log/npu/slog/security/device-app-pid/device-app-pid_*.log`|Control CPU上应用进程产生的安全日志。|
|`/var/log/npu/slog/slogd/slogdlog`|维测日志。记录日志工具自身的运行信息，用于日志工具自身问题定位。日志具备老化策略，当slogdlog文件达到规定大小（1MB）后，名称变更为slogdlog.old进行备份（如果已有备份文件，则删除最早的备份文件）。|
|以下文件需要登录Host侧服务器，使用msnpureport工具导出并查看，具体使用方法请参考[《msnpureport 工具使用指南》](https://support.huawei.com/enterprise/zh/ascend-computing/ascend-hdk-pid-252764743?category=reference-guides&subcategory=command-reference)。| -|
|`/var/log/npu/slog/debug/device-os/device-os_*.log`|Control CPU上系统进程产生的调试日志，包括用户态日志和内核态日志。|
|`/var/log/npu/slog/run/event/event_*.log`|Control CPU上系统进程产生的EVENT日志。|
|`/var/log/npu/slog/run/device-os/device-os_*.log`|Control CPU上系统进程产生的运行日志。|
|`/var/log/npu/slog/security/device-os/device-os_*.log`|Control CPU上系统进程产生的安全日志。|
|`/var/log/npu/slog/debug/device-id/device-id_*.log`|非Control CPU上的系统类日志，主要采集TS、TSDUMP、LP等模块的日志。|

上述日志中`id`和`pid`分别代表Device ID和进程ID，请以实际为准；日志文件中的`*`表示该日志文件创建时的时间戳。
