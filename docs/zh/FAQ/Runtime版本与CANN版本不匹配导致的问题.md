# Runtime版本与CANN版本不匹配导致的问题

## 问题现象描述

**现象1：接口返回功能不支持错误码**

调用 Runtime 接口时返回 ACL_ERROR_RT_FEATURE_NOT_SUPPORT（错误码 207000），表示当前版本不支持该功能。

报错日志示例如下：
```
aclrtGetVersion failed, ret = 207000, feature not supported
```

**现象2：接口行为异常**

接口参数不兼容或返回值不符合预期，运行时库版本与编译时版本不一致导致行为差异。

典型场景示例：
```c
// 编译时使用新版本头文件，运行时加载旧版本库
aclError ret = aclrtGetVersion(&major, &minor, &patch);  // 返回值与预期不符
```

**现象3：编译链接错误**

编译时找不到某些接口定义，头文件版本与库文件版本不匹配。

报错日志示例如下：
```
undefined reference to `aclrtGetVersion'
```

## 可能原因

1. **不同 CANN 版本的 API 差异**：新版本引入新接口、旧版本不支持某些功能。
2. **运行时库版本不一致**：编译时链接的库版本与运行时加载的库版本不同。
3. **环境变量配置错误**：ASCEND_HOME、LD_LIBRARY_PATH 等指向错误的版本目录。

## 处理步骤

### 原因1：不同 CANN 版本的 API 差异

**解决方法**：
- 检查版本信息：使用 aclrtGetVersion 查询当前 Runtime 版本
- 参考 API 文档：确认接口在不同版本的支持情况
- 升级或降级版本：根据需求调整 CANN 版本

版本查询示例：
```c
size_t majorVersion = 0;
size_t minorVersion = 0;
size_t patchVersion = 0;
aclError ret = aclrtGetVersion(&majorVersion, &minorVersion, &patchVersion);
printf("Runtime version: %zu.%zu.%zu\n", majorVersion, minorVersion, patchVersion);
```

### 原因2：运行时库版本不一致

**解决方法**：
- 检查编译链接库：确认编译时链接的 libascendcl.so 版本
- 检查运行时加载库：使用 `ldd` 命令查看实际加载的库路径
- 确保版本一致：编译和运行时使用相同的 CANN 版本

命令示例：
```bash
# 查看可执行文件链接的库
ldd your_program | grep ascendcl

# 查看 CANN 安装版本
cat /usr/local/Ascend/version.info
```

### 原因3：环境变量配置错误

**解决方法**：
- 检查 ASCEND_HOME：确认指向正确的 CANN 安装目录
- 检查 LD_LIBRARY_PATH：确保包含正确的库路径
- 更新环境变量：修改 ~/.bashrc 或 ~/.bash_profile

命令示例：
```bash
# 查看环境变量
echo $ASCEND_HOME
echo $LD_LIBRARY_PATH

# 设置环境变量（示例）
export ASCEND_HOME=/usr/local/Ascend
export LD_LIBRARY_PATH=$ASCEND_HOME/lib64:$LD_LIBRARY_PATH
```

## 相关 issue

暂无相关Issue。