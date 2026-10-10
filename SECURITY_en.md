# Security Statement

## User Running Recommendations

For security reasons, it is not recommended to use root or other administrator-type accounts to execute any commands. Follow the principle of least privilege.

## File Permission Control

- It is recommended that users set the running system umask value to 0027 or higher on the host (including the host machine) and in containers, ensuring that new folders have a default maximum permission of 750 and new files have a default maximum permission of 640.
- It is recommended that users implement permission control and other security measures for sensitive content such as personal privacy data, business assets, source files, and various files saved during Runtime development. For example, for permission control of this project's installation directory and input public data files, refer to [A-Recommended Maximum Permissions for Files/Folders in Various Scenarios](#a-recommended-maximum-permissions-for-filesfolders-in-various-scenarios).
- Users should implement proper permission control during installation and usage. Refer to [A-Recommended Maximum Permissions for Files/Folders in Various Scenarios](#a-recommended-maximum-permissions-for-filesfolders-in-various-scenarios) for file permission settings.

## Build Security Statement

When compiling and installing this project from source code, you need to compile it yourself. Some intermediate files will be generated during compilation. It is recommended that you implement permission control for intermediate files after compilation to ensure file security.

## Runtime Security Statement

- When Runtime encounters runtime exceptions, it will exit the process and print error messages. This is a normal phenomenon. It is recommended that users locate specific error causes based on error prompts, including viewing CANN logs and analyzing generated Core Dump files.

## Public Network Address Statement

The public network addresses included in this project code are shown below:

| Type | Open Source Code Address | File Name | Public IP Address/Public URL Address/Domain Name/Email Address/Compressed File Address | Usage Description |
| :------------: |:------------------------------------------------------------------------------------------:|:----------------------------------------------------------| :---------------------------------------------------------- |:-----------------------------------------|
| Dependency | Not applicable | download_3rd_party.sh | https://cann-3rd.obs.cn-north-4.myhuaweicloud.com/abseil-cpp/abseil-cpp-20230802.1.tar.gz | Download Abseil source code from Huawei Cloud for building |
| Dependency | Not applicable | download_3rd_party.sh | https://gitcode.com/cann-src-third-party/abseil-cpp/releases/download/20230802.1-h0/backport-CVE-2025-0838.patch | Download the Abseil patch from GitCode for building |
| Dependency | Not applicable | download_3rd_party.sh | https://cann-3rd.obs.cn-north-4.myhuaweicloud.com/cann/acl-compat/acl-compat_9.2.0_linux-x86_64.tar.gz | Download the ACL compatibility binary dependency for x86_64 from Huawei Cloud for building |
| Dependency | Not applicable | download_3rd_party.sh | https://cann-3rd.obs.cn-north-4.myhuaweicloud.com/cann/acl-compat/acl-compat_9.2.0_linux-aarch64.tar.gz | Download the ACL compatibility binary dependency for aarch64 from Huawei Cloud for building |
| Dependency | Not applicable | download_3rd_party.sh | https://cann-3rd.obs.cn-north-4.myhuaweicloud.com/boost/boost_1_87_0.tar.gz | Download Boost source code from Huawei Cloud for building |
| Dependency | Not applicable | download_3rd_party.sh | https://cann-3rd.obs.cn-north-4.myhuaweicloud.com/eigen/eigen-5.0.0.tar.gz | Download Eigen source code from Huawei Cloud for building |
| Dependency | Not applicable | download_3rd_party.sh | https://cann-3rd.obs.cn-north-4.myhuaweicloud.com/googletest/googletest-1.14.0.tar.gz | Download GoogleTest source code from Huawei Cloud for building |
| Dependency | Not applicable | download_3rd_party.sh | https://cann-3rd.obs.cn-north-4.myhuaweicloud.com/json/json-3.12.0.tar.gz | Download JSON source code from Huawei Cloud for building |
| Dependency | Not applicable | download_3rd_party.sh | https://cann-3rd.obs.cn-north-4.myhuaweicloud.com/libboundscheck/libboundscheck-v1.1.16.tar.gz | Download libboundscheck source code from Huawei Cloud for building |
| Dependency | Not applicable | download_3rd_party.sh | https://cann-3rd.obs.cn-north-4.myhuaweicloud.com/libseccomp/libseccomp-2.5.4.tar.gz | Download libseccomp source code from Huawei Cloud for building |
| Dependency | Not applicable | download_3rd_party.sh | https://cann-3rd.obs.cn-north-4.myhuaweicloud.com/mockcpp/mockcpp-2.7.tar.gz | Download mockcpp source code from Huawei Cloud for building |
| Dependency | Not applicable | download_3rd_party.sh | https://gitcode.com/cann-src-third-party/mockcpp/releases/download/v2.7-h5/mockcpp-2.7-h5.patch | Download the mockcpp patch from GitCode for building |
| Dependency | Not applicable | download_3rd_party.sh | https://cann-3rd.obs.cn-north-4.myhuaweicloud.com/protobuf/protobuf-25.1.tar.gz | Download Protobuf source code from Huawei Cloud for building |
| Dependency | Not applicable | download_3rd_party.sh | https://cann-3rd.obs.cn-north-4.myhuaweicloud.com/makeself/makeself-release-2.5.0.tar.gz | Download makeself source code from Huawei Cloud for building |
| Dependency | Not applicable | download_3rd_party.sh | https://cann-3rd.obs.cn-north-4.myhuaweicloud.com/makeself/fix/makeself-2.5.0.patch | Download the makeself patch from Huawei Cloud for building |
| Dependency | Not applicable | download_3rd_party.sh | https://raw.gitcode.com/cann/cmake/archive/refs/heads/master-059.tar.gz | Download the cann/cmake master-059 build configuration from GitCode for building |
| Dependency | Not applicable | cmake/third_party/acl_compat.cmake | https://cann-3rd.obs.cn-north-4.myhuaweicloud.com/cann/acl-compat/acl-compat_9.2.0_linux-${TARGET_ARCH}.tar.gz | Download ACL compatibility binary dependencies for the target architecture from Huawei Cloud |
| Dependency | Not applicable | cmake/fetch_cann_cmake.cmake | https://gitcode.com/cann/cmake.git | Fetch the cann/cmake master-059 build configuration online |
| Dependency | Not applicable | install_deps.sh | https://apt.kitware.com/keys/kitware-archive-latest.asc | Download the signing key for the Kitware APT repository |
| Dependency | Not applicable | install_deps.sh | https://apt.kitware.com/ubuntu/ | Install the CMake build dependency from the Kitware APT repository |

---

## Vulnerability Mechanism Description

[Vulnerability Management](https://gitcode.com/cann/community/blob/master/security/security.md)

## Appendix

### A-Recommended Maximum Permissions for Files/Folders in Various Scenarios

| Type | Linux Permission Reference Maximum Value |
| -------------- | -------------- |
| User home directory | 750 (rwxr-x---) |
| Program files (including script files, library files, and so on) | 550 (r-xr-x---) |
| Program file directory | 550 (r-xr-x---) |
| Configuration files | 640 (rw-r-----) |
| Configuration file directory | 750 (rwxr-x---) |
| Log files (completed recording or archived) | 440 (r--r-----) |
| Log files (currently recording) | 640 (rw-r-----) |
| Log file directory | 750 (rwxr-x---) |
| Debug files | 640 (rw-r-----) |
| Debug file directory | 750 (rwxr-x---) |
| Temporary file directory | 750 (rwxr-x---) |
| Maintenance upgrade file directory | 770 (rwxrwx---) |
| Business data files | 640 (rw-r-----) |
| Business data file directory | 750 (rwxr-x---) |
| Key components, private keys, certificates, encrypted file directory | 700 (rwx---) |
| Key components, private keys, certificates, encrypted ciphertext | 600 (rw-------) |
| Encryption/decryption interfaces, encryption/decryption scripts | 500 (r-x------) |