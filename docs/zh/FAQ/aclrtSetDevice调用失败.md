# aclrtSetDevice调用失败

## 问题现象描述

**现象1：调用aclrtSetDevice接口返回设备ID无效错误码**

调用 aclrtSetDevice 接口失败，返回 ACL_ERROR_RT_INVALID_DEVICEID（错误码 107001），表示设备ID无效。

报错日志示例如下：
```
aclrtSetDevice failed, ret = 107001, deviceId=5
```

**现象2：调用aclrtSetDevice接口失败且驱动未正确加载**

当 NPU 驱动未安装或未正确加载时，调用 aclrtSetDevice 接口也会失败，可能返回 ACL_ERROR_RT_INVALID_DEVICEID（错误码 107001）。

报错日志示例如下：
```
aclrtSetDevice failed, ret = 107001, deviceId=0
[ERROR] RUNTIME: Failed to get phy dev id by logic dev id, driver may not be loaded
```

## 可能原因

1. **Device ID 超出可用范围**：指定的设备ID超过了系统实际可用的设备数量。
2. **驱动未正确加载**：NPU驱动未安装或未正确加载到系统。

## 处理步骤

### 原因1：Device ID 超出可用范围

**解决方法**：
- 查询可用设备数量：调用 aclrtGetDeviceCount 获取系统中的设备总数
- 使用正确的设备ID：设备ID从0开始编号，范围为 `[0, deviceCount-1]`

示例代码：
```c
uint32_t deviceCount = 0;
aclError ret = aclrtGetDeviceCount(&deviceCount);
if (ret == ACL_SUCCESS) {
    // 设备ID范围：0 到 deviceCount-1
    int32_t deviceId = 0;  // 使用有效的设备ID
    ret = aclrtSetDevice(deviceId);
}
```

### 原因2：驱动未正确加载

**解决方法**：
- 检查驱动安装：确认 CANN 驱动已正确安装
- 查看驱动状态：使用系统命令检查驱动加载情况
- 重装驱动：如驱动未加载，参考昇腾社区文档重新安装驱动

命令示例：
```bash
# 查看驱动版本
cat /usr/local/Ascend/version.info

# 查看驱动加载状态
lsmod | grep ascend
```

## 相关 issue

暂无相关Issue。