# 如何通过plog日志定位Device侧异常

## 问题现象描述

**现象1：算子执行失败但无法定位错误原因和位置**

Runtime应用在Device侧执行任务时发生异常，Host侧返回错误码，但无法定位具体的错误原因和位置。

报错日志示例如下：
```
[ERROR] RUNTIME(2082291,python3):2024-07-04-14:14:25.036.721 [stars_engine.cc:1321]2082291 ProcLogicCqReport:[INIT][DEFAULT]Task run failed, device_id=0, stream_id=2, task_id=1, sqe_type=0(ffts), errType=0x1(task exception), sqSwStatus=0
[ERROR] RUNTIME(2082291,python3):2024-07-04-14:14:25.050.365 [davinic_kernel_task.cc:1219]2082291 PreCheckTaskErr:[INIT][DEFAULT]Kernel task happen error, retCode=0x31, [vector core exception].
[ERROR] RUNTIME(2082291,python3):2024-07-04-14:14:25.050.941 [davinic_kernel_task.cc:1143]2082291 PrintErrorInfoForDavinciTask:[INIT][DEFAULT]Aicore kernel execute failed, device_id=0, stream_id=2, report_stream_id=2, task_id=1, flip_num=0, fault kernel_name=Add_ee98c6628030785f610b924ab1557b31_high_performance_210000000
```

**现象2：Device侧任务异常退出或内存访问越界**

Device侧任务异常退出、内存访问越界或内核执行超时。

**现象3：需要通过plog日志进行深入分析**

常规错误码不足以定位问题，需要通过plog日志获取Device侧异常的详细信息。

## 可能原因

1. **Device侧硬件异常**：包括向量核异常（vector core exception）、立方核异常（cube core exception）、内存访问异常等。

2. **内核代码错误**：算子内核代码存在逻辑错误，如数组越界访问、空指针解引用、数据类型错误等。

3. **内存问题**：Device内存越界、地址对齐错误、未初始化内存访问等。

4. **资源限制**：任务超时、硬件资源不足、任务队列溢出等。

## 处理步骤

### 步骤1：定位失败的任务和内核

从plog日志中提取关键信息，定位失败的任务：

```bash
# 查找失败的任务信息
grep "Task run failed" plog.log

# 输出示例：
# [ERROR] Task run failed, device_id=0, stream_id=2, task_id=1,
#         sqe_type=0(ffts), errType=0x1(task exception), sqSwStatus=0
#
# 解读：
# - device_id=0: 设备ID为0
# - stream_id=2: 流ID为2
# - task_id=1: 任务ID为1
# - errType=0x1: 任务异常（task exception）
```

```bash
# 查找失败的内核名称
grep "fault kernel_name" plog.log

# 输出示例：
# fault kernel_name=Add_ee98c6628030785f610b924ab1557b31_high_performance_210000000
#
# 解读：
# - 内核名称为 Add_ee98c6628030785f610b924ab1557b31
# - 后缀 _high_performance 表示高性能模式
# - 210000000 为tiling key
```

### 步骤2：分析错误码和错误类型

从plog日志中提取错误码和错误类型：

```bash
# 查找错误码
grep "retCode" plog.log

```

```bash
# 查找错误类型
grep "errType" plog.log

# 常见错误类型：
# task exception - 任务异常
# task timeout - 任务超时
```

### 步骤3：分析Device侧异常详情

从plog日志中提取Device侧异常的详细信息：

```bash
# 查找Device侧异常信息
grep "The error from device" plog.log

# 输出示例：
# The error from device(chipId:3, dieId:0), serial number is 20,
# there is an aivec error exception, core id is 4, error code = 0,
#
# 解读：
# - chipId:3, dieId:0: 芯片和Die编号
# - aivec error exception: AI向量核异常
```

### 步骤4：综合分析与问题定位

综合以上信息进行问题定位：

```bash
# 完整的错误定位流程
echo "=== Device侧异常定位分析 ==="

echo -e "\n[1] 失败任务定位："
grep "Task run failed" plog.log | tail -1

echo -e "\n[2] 失败内核定位："
grep "fault kernel_name" plog.log | tail -1

echo -e "\n[3] 错误码分析："
grep "retCode\|Kernel task happen error" plog.log | tail -1

echo -e "\n[4] Device异常详情："
grep "The error from device" plog.log | tail -1

echo -e "\n[5] 扩展错误信息："
grep "The extend info" plog.log | tail -1

echo -e "\n[6] 内核参数信息："
grep "AIC_INFO" plog.log | tail -3

echo -e "\n=== 分析完成 ==="
```

**典型问题诊断示例**：

**场景1：地址访问越界**
```
错误特征：
- aivec error exception

诊断步骤：
1. 检查内核代码中的数组访问是否越界
2. 检查内存分配大小是否足够
3. 验证tiling参数计算是否正确
```

**场景2：内存对齐错误**
```
错误特征：
- 数据传输失败

诊断步骤：
1. 检查内存地址是否满足对齐要求（通常需要64字节对齐）
2. 检查数据结构定义是否正确
3. 验证内存分配接口的对齐参数
```

**场景3：任务超时**
```
错误特征：
- task timeout
- 任务执行时间过长

诊断步骤：
1. 检查内核是否存在死循环
2. 检查任务计算量是否过大
3. 验证硬件资源是否充足
```

### 步骤5：启用详细日志

如果默认日志信息不够，可以启用更详细的日志级别：

```bash
# 设置日志级别（环境变量方式）
export ASCEND_GLOBAL_LOG_LEVEL=0  # DEBUG级别，输出最详细日志
export ASCEND_SLOG_PRINT_TO_STDOUT=1  # 输出到标准输出

# 或在代码中设置
aclError error = aclInit(nullptr);
// Runtime会自动读取日志级别配置

# 运行程序
./your_program 2>&1 | tee detailed_plog.log
```

**日志级别说明**：
- 0: DEBUG - 详细调试日志
- 1: INFO - 常规信息日志（默认）
- 2: WARNING - 错误和警告日志
- 3: ERROR - 仅错误日志

## 相关 issue

暂无相关Issue。