# 日志参考

本章节介绍定位问题时如何设置日志级别、从何处获取日志文件，同时介绍日志内容格式、日志配置，帮助开发者和维护人员通过日志快速定位问题。

- [日志简介](log_overview.md)
- [查看日志（Ascend EP）](viewing_logs_ep.md)
<!-- npu="310b" id1 -->
- [查看日志（Ascend RC）](viewing_logs_rc.md)
<!-- end id1 -->
<!-- npu="310p" id2 -->
- [查看日志（Control CPU开放形态）](viewing_logs_open_ctrl_cpu.md)
<!-- end id2 -->
- [设置日志级别](setting_log_levels.md)
- [重启日志进程](restarting_log_processes.md)
<!-- npu="310p,310b" id3 -->
- [查看日志配置文件](viewing_config_file.md)
<!-- end id3 -->
- [查看trace日志](viewing_trace_logs.md)
- [FAQ](faq.md)

## 阅读指引

- **首次了解日志**：先阅读[日志简介](log_overview.md)了解日志分类与日志记录格式，再根据所使用的产品形态阅读对应的查看日志章节，获取日志文件的存储路径与老化说明。
- **需要更详细的日志信息**：通过[设置日志级别](setting_log_levels.md)调整应用类日志的输出级别，获取更多定位信息。
<!-- npu="310p,310b" id4 -->
- **修改Device侧日志配置**：参考[查看日志配置文件](viewing_config_file.md)了解各配置项的含义与取值，修改后按[重启日志进程](restarting_log_processes.md)操作使配置生效。
<!-- end id4 -->
- **程序运行异常或日志异常**：参考[查看trace日志](viewing_trace_logs.md)分析落盘的维测信息；遇到日志未正常落盘、时间戳不正确等问题时，查阅[FAQ](faq.md)排查。
