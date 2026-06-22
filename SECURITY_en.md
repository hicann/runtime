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
| Dependency | Not applicable | cmake/makeself-fetch.cmake | https://gitcode.com/cann-src-third-party/makeself/releases/download/release-2.5.0-patch1.0/makeself-release-2.5.0-patch1.tar.gz | Download makeself source code from gitcode, used as build dependency |
| Dependency | Not applicable | build_third_party.sh | https://gitcode.com/cann-src-third-party/json/releases/download/v3.11.3/include.zip | Download json source code from gitcode, used as build dependency |
| Dependency | Not applicable | build_third_party.sh | https://gitcode.com/cann-src-third-party/googletest/releases/download/v1.14.0/googletest-1.14.0.tar.gz | Download gtest source code from gitcode, used as build dependency |
| Dependency | Not applicable | cmake/third_party/mockcpp.cmake | https://gitcode.com/cann-src-third-party/mockcpp/releases/download/v2.7-h1/mockcpp-2.7_py3.patch | Download mockcpp patch source code from gitcode, used as build dependency |
| Dependency | Not applicable | cmake/third_party/mockcpp.cmake | https://gitcode.com/cann-src-third-party/mockcpp/releases/download/v2.7-h1/mockcpp-2.7.tar.gz | Download mockcpp source code from gitcode, used as build dependency |
| Dependency | Not applicable | cmake/third_party/boost.cmake | https://gitcode.com/cann-src-third-party/boost/releases/download/v1.87.0/boost_1_87_0.tar.gz | Download boost source code from gitcode, used as build dependency |
| Dependency | Not applicable | cmake/third_party/acl_compat.cmake | https://cann-3rd.obs.cn-north-4.myhuaweicloud.com/cann/acl-compat/acl-compat_9.1.0_linux-${TARGET_ARCH}.tar.gz | Download binary dependencies from huaweicloud |
| Dependency | Not applicable | cmake/third_party/csec.cmake | https://gitcode.com/cann-src-third-party/libboundscheck/releases/download/v1.1.16/libboundscheck-v1.1.16.tar.gz | Download libboundscheck source code from gitcode, used as build dependency |
| Dependency | Not applicable | cmake/third_party/eigen.cmake | https://gitcode.com/cann-src-third-party/eigen/releases/download/5.0.0-h0.trunk/eigen-5.0.0.tar.gz | Download eigen source code from gitcode, used as build dependency |
| Dependency | Not applicable | cmake/third_party/protobuf.cmake | https://gitcode.com/cann-src-third-party/protobuf/releases/download/v25.1/protobuf-25.1.tar.gz | Download protobuf source code from gitcode, used as build dependency |
| Dependency | Not applicable | cmake/third_party/seccomp.cmake | https://gitcode.com/cann-src-third-party/libseccomp/releases/download/v2.5.4/libseccomp-2.5.4.tar.gz | Download libseccomp source code from gitcode, used as build dependency |
| Dependency | Not applicable | install_deps.sh | https://apt.kitware.com/keys/kitware-archive-latest.asc | Download cmake software from kitware, used as build dependency |
| Dependency | Not applicable | install_deps.sh | https://apt.kitware.com/ubuntu/ | Download cmake software from kitware, used as build dependency |
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