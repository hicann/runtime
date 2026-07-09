# FAQ

## 日志没有正常落盘

### Ascend EP标准形态

#### 通过msnpureport工具导出Device侧系统日志失败

如果通过msnpureport工具导出Device侧系统日志失败，请参照如下步骤处理：

1. 在Host侧执行msnpureport工具命令后，查看打印的提示信息定位问题。

    若未能解决问题，请执行2。

2. 在Host侧执行如下命令查看Host侧日志存放路径（运行msnpureport工具所在路径）所在的磁盘空间是否已满。

    ```sh
    df -h
    ```

3. 若未能解决问题，您可以获取日志后单击[support](https://www.hiascend.com/support)联系技术支持。

#### 应用类日志没有正常落盘

如果应用类日志没有正常落盘（包括“$HOME/ascend/log/”目录下`plog`日志和`device-id`日志），请参照如下步骤处理：

1. 执行如下命令查看Host侧“/var/log/messages”文件中是否有相关的错误日志。

    aarch64架构：

    ```sh
    cat /var/log/messages
    ```

    x86\_64架构：

    ```sh
    cat /var/log/syslog
    ```

    若未能解决问题，请执行2。

2. 在Host侧执行如下命令查看日志落盘路径（“$HOME/ascend/log/”）所在的磁盘空间是否已满。

    ```sh
    df -h
    ```

    若未能解决问题，请执行3。

3. 在Host侧通过msnpureport工具导出Device侧系统日志，查看是否有相关的错误日志。

    通过msnpureport工具导出Device侧系统日志的方法请参见[《msnpureport 工具使用指南》](https://support.huawei.com/enterprise/zh/ascend-computing/ascend-hdk-pid-252764743?category=reference-guides&subcategory=command-reference)。

4. 若未能解决问题，您可以获取日志后单击[support](https://www.hiascend.com/support)联系技术支持。

<!-- npu="310p" id1 -->
### Control CPU开放形态

#### 应用类日志没有正常落盘

如果应用类日志没有正常落盘，请参照如下步骤处理：

1. 执行如下命令查看应用进程依赖的动态库是否正确。

    ```sh
    ldd xxx
    ```

   `xxx`为二进制应用进程。

2. 执行如下命令查看日志落盘路径（“/var/log/npu/slog”）所在的磁盘空间是否已满。

    ```sh
    df -h
    ```

3. 执行如下命令查看slogd进程是否存在。

    ```sh
    ps -elf | grep slogd
    ```

    若返回slogd进程相关信息，说明slogd进程存在。

4. 若以上均无问题，但应用类日志仍没有正常落盘，可以尝试[重启日志进程](restarting_log_processes.md)。

#### 系统类日志没有正常落盘

如果系统类日志没有正常落盘，请参照如下步骤处理：

1. 执行如下命令查看相关日志进程（slogd、sklogd）是否存在。

    ```sh
    ps -elf | grep log
    ```

    若显示进程相关信息，说明相关日志进程已存在。

2. 执行如下命令查看日志落盘路径（“/var/log/npu/slog”）所在的磁盘空间是否已满。

    ```sh
    df -h
    ```

3. 若以上均无问题，但系统类日志仍没有正常落盘，可以尝试[重启日志进程](restarting_log_processes.md)。
<!-- end id1 -->

<!-- npu="310b" id2 -->
### Ascend RC形态

#### 应用类日志没有正常落盘

如果应用类日志没有正常落盘，请参照如下步骤处理：

1. 执行如下命令查看应用进程依赖的动态库是否正确。

    ```sh
    ldd xxx
    ```

   `xxx`为二进制应用进程。

2. 执行如下命令查看日志落盘路径（“/var/log/npu/slog”）所在的磁盘空间是否已满。

    ```sh
    df -h
    ```

3. 执行如下命令查看slogd进程是否存在。

    ```sh
    ps -elf | grep slogd
    ```

    若返回slogd进程相关信息，说明slogd进程存在。

    <!-- npu="310b" id3 -->
    对于Atlas 200I/500 A2 推理产品，若slogd进程不存在，您可以获取日志后单击[support](https://www.hiascend.com/support)联系技术支持。
    <!-- end id3 -->

4. 若以上均无问题，但应用类日志仍没有正常落盘，可以尝试参考[重启日志进程](restarting_log_processes.md)内容处理日志进程启动异常。

#### 系统类日志没有正常落盘

如果系统类日志没有正常落盘，请参照如下步骤处理：

1. 执行如下命令查看相关日志进程（slogd、sklogd）是否存在。

    ```sh
    ps -elf | grep log
    ```

    若显示进程相关信息，说明相关日志进程已存在。

    <!-- npu="310b" id4 -->
    对于Atlas 200I/500 A2 推理产品，若进程不存在，您可以获取日志后单击[support](https://www.hiascend.com/support)联系技术支持。
    <!-- end id4 -->

2. 执行如下命令查看日志落盘路径（“/var/log/npu/slog”）所在的磁盘空间是否已满。

    ```sh
    df -h
    ```

3. 若以上均无问题，但系统类日志仍没有正常落盘，可以尝试参考[重启日志进程](restarting_log_processes.md)内容处理日志进程启动异常。
<!-- end id2 -->

## 修改环境时区后，日志打印的时间戳不正确

**异常现象**

日志打印信息中时间戳与系统环境的时间不一致。

**可能原因**

产生该问题的可能原因是用户启动了AI任务后修改了系统环境的时区。

**处理方式**

方法一：重新启动AI任务。

方法二：修改系统环境时区。

```sh
# 查看当前时区设置
timedatectl
# 以Asia/Shanghai为例，设置新时区
sudo timedatectl set-timezone Asia/Shanghai
```

## 未设置日志打印环境变量，但是在屏幕上仍有日志显示

**异常现象**

用户未设置日志打印环境变量（`export ASCEND_SLOG_PRINT_TO_STDOUT=1`），但是在屏幕上仍有日志显示。

**可能原因**

日志模块收到日志消息后，首先根据环境变量判断是否打印到屏幕上，若不需要打印到屏幕上，则创建Socket与slogd进程建立连接，将日志发送给slogd进程，由slogd进程落盘。但是如果创建Socket失败，则会将日志打印到屏幕上。

**处理方式**

创建Socket失败的原因一般是用户在执行用例时，打开文件的数量超过了系统默认的最大数量。可以通过`ulimit -a`和`lsof | wc -l`命令分别查看系统默认打开文件的最大数量（即`open files`字段的取值）以及当前已经打开的文件数量，查看当前已经打开的文件数量是否超过了限制值。如果超过限制值，可以通过`ulimit -n <num>`命令设置打开文件的最大数量，保证当前已经打开的文件数量不超过限制值。
