# Log Reference

<!-- md-trans-meta sourceCommit=32fc8179c12e522a4ac47fa40f073764efdd2b39 translatedAt=2026-11-11T06:26:28.346Z pushedAt=2026-11-16T03:37:49.982Z nl=2 -->

This topic describes how to configure log levels and where to obtain log files when locating issues. It also introduces the log content format and log configuration to help developers and maintenance personnel quickly locate issues through logs.

- [Log Overview](log_overview.md)
- [Viewing Logs (Ascend EP)](viewing_logs_ep.md)
<!-- npu="310b" id1 -->
- [Viewing Logs (Ascend RC)](viewing_logs_rc.md)
<!-- end id1 -->
<!-- npu="310p" id2 -->
- [Viewing Logs (Control CPU Open Form)](viewing_logs_open_ctrl_cpu.md)
<!-- end id2 -->
- [Setting Log Levels](setting_log_levels.md)
- [Restarting Log Processes](restarting_log_processes.md)
<!-- npu="310p,310b" id3 -->
- [Viewing the Log Configuration File](viewing_config_file.md)
<!-- end id3 -->
- [Viewing Trace Logs](viewing_trace_logs.md)
- [FAQs](faq.md)

## Reading Guide

- **Getting started with logs**: Read [Log Overview](log_overview.md) to learn about log categories and log recording formats, and then read the corresponding log viewing topic based on the product form you are using to obtain the storage path and aging policy of log files.
- **More detailed log information**: Adjust the output level of application logs through [Setting Log Levels](setting_log_levels.md) to obtain more diagnostic information.
<!-- npu="310p,310b" id4 -->
- **Modification of the device-side log configuration**: Refer to [Viewing the Log Configuration File](viewing_config_file.md) to understand the meaning and values of each configuration item, and then follow [Restarting Log Processes](restarting_log_processes.md) to make the configuration take effect.
<!-- end id4 -->
- **Abnormal program execution or log anomalies**: Refer to [Viewing Trace Logs](viewing_trace_logs.md) to analyze the maintenance and testing information written to disk. If logs are not written to disk properly or timestamps are incorrect, see [FAQs](faq.md) for troubleshooting.
