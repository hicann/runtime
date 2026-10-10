# 安全声明

## 运行用户建议

基于安全性角度考虑，不建议使用root等管理员类型账户执行任何命令，遵循权限最小化原则。

## 文件权限控制

- 建议用户在主机（包括宿主机）及容器中设置运行系统umask值为0027及以上，保障新增文件夹默认最高权限为750，新增文件默认最高权限为640。
- 建议用户对个人隐私数据、商业资产、源文件和Runtime开发过程中保存的各类文件等敏感内容做好权限控制等安全措施。例如涉及本项目安装目录权限管控、输入公共数据文件权限管控，设定的权限建议参考[A-文件（夹）各场景权限管控推荐最大值](#a-文件夹各场景权限管控推荐最大值)。
- 用户安装和使用过程需要做好权限控制，建议参考[A-文件（夹）各场景权限管控推荐最大值](#a-文件夹各场景权限管控推荐最大值)文件权限参考进行设置。

## 构建安全声明

在源码编译安装本项目时，需要您自行编译，编译过程中会生成一些中间文件，建议您在编译完成后，对中间文件做好权限控制，以保证文件安全。

## 运行安全声明

- Runtime在运行异常时会退出进程并打印报错信息，属于正常现象。建议用户根据报错提示定位具体错误原因，包括查看CANN日志、解析生成的Core Dump文件等方式。

## 公网地址声明

本项目代码中包含的公网地址声明如下所示：

|      类型      |                                           开源代码地址                                           |                            文件名                             |             公网IP地址/公网URL地址/域名/邮箱地址/压缩文件地址             |                   用途说明                    |
| :------------: |:------------------------------------------------------------------------------------------:|:----------------------------------------------------------| :---------------------------------------------------------- |:-----------------------------------------|
| 依赖 | 不涉及 | download_3rd_party.sh | https://cann-3rd.obs.cn-north-4.myhuaweicloud.com/abseil-cpp/abseil-cpp-20230802.1.tar.gz | 从Huawei Cloud下载Abseil源码，用作编译依赖 |
| 依赖 | 不涉及 | download_3rd_party.sh | https://gitcode.com/cann-src-third-party/abseil-cpp/releases/download/20230802.1-h0/backport-CVE-2025-0838.patch | 从GitCode下载Abseil补丁，用作编译依赖 |
| 依赖 | 不涉及 | download_3rd_party.sh | https://cann-3rd.obs.cn-north-4.myhuaweicloud.com/cann/acl-compat/acl-compat_9.2.0_linux-x86_64.tar.gz | 从Huawei Cloud下载ACL兼容库（x86_64）二进制依赖，用作编译依赖 |
| 依赖 | 不涉及 | download_3rd_party.sh | https://cann-3rd.obs.cn-north-4.myhuaweicloud.com/cann/acl-compat/acl-compat_9.2.0_linux-aarch64.tar.gz | 从Huawei Cloud下载ACL兼容库（aarch64）二进制依赖，用作编译依赖 |
| 依赖 | 不涉及 | download_3rd_party.sh | https://cann-3rd.obs.cn-north-4.myhuaweicloud.com/boost/boost_1_87_0.tar.gz | 从Huawei Cloud下载Boost源码，用作编译依赖 |
| 依赖 | 不涉及 | download_3rd_party.sh | https://cann-3rd.obs.cn-north-4.myhuaweicloud.com/eigen/eigen-5.0.0.tar.gz | 从Huawei Cloud下载Eigen源码，用作编译依赖 |
| 依赖 | 不涉及 | download_3rd_party.sh | https://cann-3rd.obs.cn-north-4.myhuaweicloud.com/googletest/googletest-1.14.0.tar.gz | 从Huawei Cloud下载GoogleTest源码，用作编译依赖 |
| 依赖 | 不涉及 | download_3rd_party.sh | https://cann-3rd.obs.cn-north-4.myhuaweicloud.com/json/json-3.12.0.tar.gz | 从Huawei Cloud下载JSON源码，用作编译依赖 |
| 依赖 | 不涉及 | download_3rd_party.sh | https://cann-3rd.obs.cn-north-4.myhuaweicloud.com/libboundscheck/libboundscheck-v1.1.16.tar.gz | 从Huawei Cloud下载libboundscheck源码，用作编译依赖 |
| 依赖 | 不涉及 | download_3rd_party.sh | https://cann-3rd.obs.cn-north-4.myhuaweicloud.com/libseccomp/libseccomp-2.5.4.tar.gz | 从Huawei Cloud下载libseccomp源码，用作编译依赖 |
| 依赖 | 不涉及 | download_3rd_party.sh | https://cann-3rd.obs.cn-north-4.myhuaweicloud.com/mockcpp/mockcpp-2.7.tar.gz | 从Huawei Cloud下载mockcpp源码，用作编译依赖 |
| 依赖 | 不涉及 | download_3rd_party.sh | https://gitcode.com/cann-src-third-party/mockcpp/releases/download/v2.7-h5/mockcpp-2.7-h5.patch | 从GitCode下载mockcpp补丁，用作编译依赖 |
| 依赖 | 不涉及 | download_3rd_party.sh | https://cann-3rd.obs.cn-north-4.myhuaweicloud.com/protobuf/protobuf-25.1.tar.gz | 从Huawei Cloud下载Protobuf源码，用作编译依赖 |
| 依赖 | 不涉及 | download_3rd_party.sh | https://cann-3rd.obs.cn-north-4.myhuaweicloud.com/makeself/makeself-release-2.5.0.tar.gz | 从Huawei Cloud下载makeself源码，用作编译依赖 |
| 依赖 | 不涉及 | download_3rd_party.sh | https://cann-3rd.obs.cn-north-4.myhuaweicloud.com/makeself/fix/makeself-2.5.0.patch | 从Huawei Cloud下载makeself补丁，用作编译依赖 |
| 依赖 | 不涉及 | download_3rd_party.sh | https://raw.gitcode.com/cann/cmake/archive/refs/heads/master-059.tar.gz | 从GitCode下载cann/cmake master-059构建配置，用作编译依赖 |
| 依赖 | 不涉及 | cmake/third_party/acl_compat.cmake | https://cann-3rd.obs.cn-north-4.myhuaweicloud.com/cann/acl-compat/acl-compat_9.2.0_linux-${TARGET_ARCH}.tar.gz | 从Huawei Cloud下载目标架构的ACL兼容二进制依赖 |
| 依赖 | 不涉及 | cmake/fetch_cann_cmake.cmake | https://gitcode.com/cann/cmake.git | 在线获取cann/cmake master-059构建配置 |
| 依赖 | 不涉及 | install_deps.sh | https://apt.kitware.com/keys/kitware-archive-latest.asc | 下载Kitware APT仓库签名密钥 |
| 依赖 | 不涉及 | install_deps.sh | https://apt.kitware.com/ubuntu/ | 从Kitware APT仓库安装CMake编译依赖 |

---

## 漏洞机制说明

[漏洞管理](https://gitcode.com/cann/community/blob/master/security/security.md)

## 附录

### A-文件（夹）各场景权限管控推荐最大值

| 类型           | Linux权限参考最大值 |
| -------------- | ---------------  |
| 用户主目录                        |   750（rwxr-x---）            |
| 程序文件(含脚本文件、库文件等)       |   550（r-xr-x---）             |
| 程序文件目录                      |   550（r-xr-x---）            |
| 配置文件                          |  640（rw-r-----）             |
| 配置文件目录                      |   750（rwxr-x---）            |
| 日志文件(记录完毕或者已经归档)        |  440（r--r-----）             |
| 日志文件(正在记录)                |    640（rw-r-----）           |
| 日志文件目录                      |   750（rwxr-x---）            |
| Debug文件                         |  640（rw-r-----）         |
| Debug文件目录                     |   750（rwxr-x---）  |
| 临时文件目录                      |   750（rwxr-x---）   |
| 维护升级文件目录                  |   770（rwxrwx---）    |
| 业务数据文件                      |   640（rw-r-----）    |
| 业务数据文件目录                  |   750（rwxr-x---）      |
| 密钥组件、私钥、证书、密文文件目录    |  700（rwx—----）      |
| 密钥组件、私钥、证书、加密密文        | 600（rw-------）      |
| 加解密接口、加解密脚本            |   500（r-x------）        |