/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef TSD_PACKAGE_VERIFY_H
#define TSD_PACKAGE_VERIFY_H

#include <string>
#include "tsd/status.h"

namespace tsd {
constexpr uint32_t RESERVED0_LEN = 20U;
constexpr uint32_t USERDEFINEDDATA_LEN = 32U;
constexpr uint32_t UCLHASH_LEN = 32U;
constexpr uint32_t ROOTPUBKEYE_LEN = 512U;
constexpr uint32_t ROOTPUBKEY_LEN = 512U;
constexpr uint32_t CODEDERIVESALT_LEN = 32U;
constexpr uint32_t CODEENCRYPTIV_LEN = 16U;
constexpr uint32_t CODEENCRYPTTAG_LEN = 16U;
constexpr uint32_t CODEENCRYPTADD_LEN = 16U;
constexpr uint32_t RESERVED1_LEN = 88U;
constexpr uint32_t RESERVED2_LEN = 20U;
constexpr uint32_t HEADHASH_LEN = 32U;
constexpr uint32_t AISDK_CMSFLAG_LEN = 16U;
constexpr uint32_t AISDK_CODENVCNT_LEN = 8U;
constexpr uint32_t AISDK_CODETAG_LEN = 16U;
constexpr uint32_t ENCHASH_LEN = 32U;
struct SeImageHead {
    uint32_t preamble;
    uint8_t  reserved0[RESERVED0_LEN];
    uint32_t headLen;
    uint32_t userLen;
    uint8_t  userDefineData[USERDEFINEDDATA_LEN];
    uint8_t  ucLHash[UCLHASH_LEN];
    uint32_t subkeyCertOffset;
    uint32_t subkeyCertLen;
    uint32_t rootHashAlo;
    uint32_t codeSignAlgo;
    uint32_t rootPubkeyLen;
    uint8_t  rootPubkey[ROOTPUBKEY_LEN];
    uint8_t  rootPubkeyE[ROOTPUBKEYE_LEN];
    uint32_t codeOffset;
    uint32_t uwLCodeLen;
    uint32_t signOffset;
    uint32_t signLen;
    uint32_t codeEncryptFlag;
    uint32_t codeEncryptAlgo;
    uint8_t  codeDeriveSalt[CODEDERIVESALT_LEN];
    uint32_t kmIretationCnt;
    uint8_t  codeEncryptIv[CODEENCRYPTIV_LEN];
    uint8_t  codeEncryptTag[CODEENCRYPTTAG_LEN];
    uint8_t  codeEncryptAdd[CODEENCRYPTADD_LEN];
    uint8_t  reserved1[RESERVED1_LEN];
    uint32_t h2cEnable;
    uint32_t h2cCertLen;
    uint32_t h2cCertOffset;
    uint32_t rootPubkeyInfo;
    uint8_t  reserved2[RESERVED2_LEN];
    uint32_t headMagic;
    uint8_t  headHash[HEADHASH_LEN];
    uint8_t  aisdkCmsFlag[AISDK_CMSFLAG_LEN];
    uint8_t  aisdkCodeNVCNT[AISDK_CODENVCNT_LEN];
    uint8_t  aisdkCodeTag[AISDK_CODETAG_LEN];
    uint8_t  encHash[ENCHASH_LEN];
    uint32_t certType;
};
class PackageVerify {
public:
    PackageVerify(const std::string &pkgPath) : pkgPath_(pkgPath) {};
    ~PackageVerify() = default;

    TSD_StatusT VerifyPackage() const;
private:
    PackageVerify(PackageVerify const&) = delete;
    PackageVerify& operator=(PackageVerify const&) = delete;
    PackageVerify(PackageVerify&&) = delete;
    PackageVerify& operator=(PackageVerify&&) = delete;

    TSD_StatusT IsPackageValid() const;
    TSD_StatusT ChangePackageMode() const;
    bool IsPackageNeedCmsVerify() const;
    bool IsSupportCmsVerify() const;
    bool IsCmsVerifyPackage() const;
    TSD_StatusT VerifyPackageByCms() const;
    TSD_StatusT VerifyPackageByDrv() const;
    uint32_t GetVerifyDeviceId() const;
    TSD_StatusT GetPkgCodeLen(const std::string &srcPath, uint32_t &mixCodeLen) const;
    TSD_StatusT ProcessSendStepVerify(const std::string &srcPath, const uint32_t codeLen) const;
    TSD_StatusT ReWriteAicpuPackage(const uint8_t * const buf, const uint32_t len,
        const std::string &srcPath) const;

    std::string pkgPath_;
};

} // namespace tsd

#endif // TSD_PACKAGE_VERIFY_H