# 设置日志级别

## 简介

日志记录了运行环境的运行情况和功能流程的处理情况，是维护人员查看系统状态、进行问题定位的重要工具和手段。日志模块根据系统设置的日志级别，记录不同详细程度的内容，满足不同系统维护需求。

日志级别等级由低到高顺序：DEBUG < INFO < WARNING < ERROR，级别越低，输出日志越详细。

- 0：DEBUG,调试级别。该级别的日志记录了调试信息，便于开发人员或维护人员定位问题。
- 1：INFO,正常级别。记录系统正常运行的信息。
- 2：WARNING,警告级别。记录系统和预期的状态不一致，但不影响整个系统运行的信息。
- 3：ERROR,一般错误级别。该级别的日志记录了如下错误：
  - 非预期的数据或者事件。
  - 影响面较大且模块内部能够处理的错误。
  - 限制在模块内的错误。
  - 对其他模块有轻微影响的错误，例如统计任务创建失败。
  - 引起调用失败的错误。
  - 在业务逻辑错误的情况下记录错误状态的信息及造成错误的可能原因。
- 4：NULL,NULL级别。不输出日志。

调试日志默认为ERROR级别，且支持调整日志级别；安全日志默认为DEBUG级别，运行日志默认为INFO级别，且均不支持调整日志级别。

下面介绍设置日志级别的具体方法，相关环境变量的具体说明请参考[《环境变量参考》](https://hiascend.com/document/redirect/CannCommunityEnvRef)。

## 设置应用类日志级别

- 通过ASCEND\_GLOBAL\_LOG\_LEVEL设置全局日志级别：

  ```sh
  export ASCEND_GLOBAL_LOG_LEVEL=1
  ```

- 通过ASCEND\_MODULE\_LOG\_LEVEL设置模块日志级别：

  ```sh
  export ASCEND_MODULE_LOG_LEVEL=TDT=0:DRV=0
  ```

- 通过ASCEND\_GLOBAL\_EVENT\_ENABLE设置是否开启Event日志：

  ```sh
  export ASCEND_GLOBAL_EVENT_ENABLE=0
  ```

## 设置系统类日志级别

Ascend EP形态，通过msnpureport工具设置，具体方法请参见[《msnpureport 工具使用指南》](https://support.huawei.com/enterprise/zh/ascend-computing/ascend-hdk-pid-252764743?category=reference-guides&subcategory=command-reference)。

<!-- npu="310b" id1 -->
Ascend RC形态，对于Atlas 200I/500 A2 推理产品，通过`/etc/slog.conf`配置文件设置全局日志级别、模块日志级别和是否开启Event日志，具体请参见[查看日志配置文件](viewing_config_file.md)，设置后需重启slogd进程使配置生效，具体请参见[重启日志进程](restarting_log_processes.md)。
<!-- end id1 -->
