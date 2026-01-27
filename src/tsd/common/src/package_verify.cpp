/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "inc/package_verify.h"

#include <unistd.h>
#include <fstream>
#include "mmpa/mmpa_api.h"
#include "inc/log.h"
#include "inc/tsd_util.h"
#include "inc/weak_ascend_hal.h"
#include "inc/internal_api.h"
#include "inc/package_process_config.h"

namespace tsd {
namespace {
    using VerifyImgFunc = int32_t(*)(HAL_VERIFY_TYPE, HAL_IMG_ID, const char_t *, int32_t);
    constexpr uint32_t CMS_HEAD_FIX_PACKET_LEN = (4U + 4U) * 1024U;
    constexpr uint32_t CMS_IMG_DESC_LEN = 256U;
    constexpr uint32_t ALIGN_PADDING_SIZE = 32U;
    constexpr uint32_t CMS_ALIGN_PADDING_SIZE = 16U;
} // namespace

TSD_StatusT PackageVerify::VerifyPackage() const
{
    TSD_INFO("Start verify package, path=%s", pkgPath_.c_str());

    TSD_StatusT ret = IsPackageValid();
    if (ret != TSD_OK) {
        TSD_ERROR("Verify package failed by path is invalid, ret=%u, path=%s", ret, pkgPath_.c_str());
        return TSD_VERIFY_OPP_FAIL;
    }

    ret = ChangePackageMode();
    if (ret != TSD_OK) {
        TSD_ERROR("Verify package failed by change mode failed, ret=%u, path=%s", ret, pkgPath_.c_str());
        return TSD_VERIFY_OPP_FAIL;
    }

    ret = IsPackageNeedCmsVerify() ? VerifyPackageByCms() : VerifyPackageByDrv();
    if (ret != TSD_OK) {
        TSD_ERROR("Verify package failed, ret=%u, path=%s", ret, pkgPath_.c_str());
        return TSD_VERIFY_OPP_FAIL;
    }

    TSD_INFO("End verify package, ret=%u, path=%s", ret, pkgPath_.c_str());

    return TSD_OK;
}

TSD_StatusT PackageVerify::IsPackageValid() const
{
    if (pkgPath_.empty()) {
        TSD_ERROR("Package path is empty");
        return TSD_INTERNAL_ERROR;
    }

    const int32_t ret = access(pkgPath_.c_str(), F_OK);
    if (ret != EOK) {
        TSD_ERROR("File can not access, ret=%d, path=%s, reason=%s",
                  ret, pkgPath_.c_str(), SafeStrerror().c_str());
        return TSD_INTERNAL_ERROR;
    }

    return TSD_OK;
}

TSD_StatusT PackageVerify::ChangePackageMode() const
{
    // package must have write auth, because need rewrite to remove signature
    const int32_t ret = chmod(pkgPath_.c_str(), (S_IRWXU|S_IRGRP|S_IXGRP));
    if (ret != EOK) {
        TSD_ERROR("Change package mode failed, ret=%d, path=%s, reason=%s",
                  ret, pkgPath_.c_str(), SafeStrerror().c_str());
        return TSD_INTERNAL_ERROR;
    }

    return TSD_OK;
}

bool PackageVerify::IsPackageNeedCmsVerify() const
{
    if ((IsSupportCmsVerify()) && (IsCmsVerifyPackage())) {
        return true;
    }

    return false;
}

bool PackageVerify::IsSupportCmsVerify() const
{
#if (defined CMS_CBB_VERIFY_PKT) || (defined TSD_HOST_LIB)
    return true;
#else
    return false;
#endif
}

bool PackageVerify::IsCmsVerifyPackage() const
{
    if ((pkgPath_.find("Ascend-aicpu_syskernels.tar.gz") != std::string::npos) ||
        (pkgPath_.find("_Ascend-runtime_device-minios.tar.gz") != std::string::npos) ||
        (pkgPath_.find("_Ascend-opp_rt-minios.aarch64.tar.gz") != std::string::npos) ||
        (pkgPath_.find("Ascend-aicpu_extend_syskernels.tar.gz") != std::string::npos) ||
        (pkgPath_.find("Ascend-device-sw-plugin.tar.gz") != std::string::npos) ||
        (pkgPath_.find("transformer_tile_fwk_aicpu_kernel.tar.gz") != std::string::npos)) {
        return true;
    }

    PackageProcessConfig *pkgConf = PackageProcessConfig::GetInstance();
    if (pkgConf->IsConfigPackageInfo(pkgPath_)) {
        return true;
    }

    return false;
}

TSD_StatusT PackageVerify::VerifyPackageByDrv() const
{
    const std::string soName = "libascend_drvupgrade.so";
    const std::string soPath = "/usr/lib64/" + soName;
    void *handle = mmDlopen(soPath.c_str(), MMPA_RTLD_LAZY);
    if (handle == nullptr) {
        handle = mmDlopen(soName.c_str(), MMPA_RTLD_LAZY);
        if (handle == nullptr) {
            TSD_ERROR("Open %s failed, reason=%s, dlerror=%s", soName.c_str(), SafeStrerror().c_str(), dlerror());
            return TSD_INTERNAL_ERROR;
        }
    }
    const ScopeGuard closeGuard([handle]() { (void)mmDlclose(handle); });

    const std::string apiName = "halVerifyImg";
    void * const tempFunc = mmDlsym(handle, apiName.c_str());
    if (tempFunc == nullptr) {
        TSD_ERROR("Get api %s in %s failed", apiName.c_str(), soName.c_str());
        return TSD_INTERNAL_ERROR;
    }

    const VerifyImgFunc verifyImg = reinterpret_cast<VerifyImgFunc>(tempFunc);
    const int32_t ret = verifyImg(VERIFY_TYPE_SOC, ITEE_IMG_ID, pkgPath_.c_str(),
                                  static_cast<int32_t>(HAL_VERIFY_MODE_COVER_WITH_HEAD_OFF));
    if (ret != 0) {
        TSD_ERROR("Check head tag failed, ret=%d, path=%s", ret, pkgPath_.c_str());
        return TSD_VERIFY_OPP_FAIL;
    }

    return TSD_OK;
}

uint32_t PackageVerify::GetVerifyDeviceId() const
{
    TSD_INFO("use tsdclient to verify package");
    return 0U;
}

TSD_StatusT PackageVerify::VerifyPackageByCms() const
{
    TSD_INFO("[CMSCBB_VERIFY] verify pkg[%s] by cms start", pkgPath_.c_str());
    uint32_t codeLen = 0U;
    TSD_StatusT ret = GetPkgCodeLen(pkgPath_, codeLen);
    if (ret != TSD_OK) {
        TSD_ERROR("[CMSCBB_VERIFY] get cmsInfo offset failed");
        return static_cast<uint32_t>(TSD_START_FAIL);
    }
    ret = ProcessSendStepVerify(pkgPath_, codeLen);
    if (ret != TSD_OK) {
        TSD_ERROR("[CMSCBB_VERIFY] ProcessSendStepVerify failed");
        return static_cast<uint32_t>(TSD_START_FAIL);
    }
    TSD_INFO("[CMSCBB_VERIFY] verify pkg[%s] by cms end", pkgPath_.c_str());
    return TSD_OK;
}

TSD_StatusT PackageVerify::GetPkgCodeLen(const std::string &srcPath, uint32_t &mixCodeLen) const
{
    TSD_INFO("[CMSCBB_VERIFY] GetPkgCodeLen start");
    FILE *fp = fopen(srcPath.c_str(), "r");
    if (fp == nullptr) {
        TSD_ERROR("[CMSCBB_VERIFY] fopen failed. path[%s]", srcPath.c_str());
        return static_cast<uint32_t>(TSD_START_FAIL);
    }
    const ScopeGuard closeFileGuard([&fp]() { (void)fclose(fp); });
    const int32_t ret = fseek(fp, 0, SEEK_END);
    if (ret != 0) {
        TSD_ERROR("[CMSCBB_VERIFY] fseek failed. path[%s]", srcPath.c_str());
        return static_cast<uint32_t>(TSD_START_FAIL);
    }
    const int64_t fileLen = ftell(fp);
    if (fileLen <= static_cast<int64_t>(CMS_IMG_DESC_LEN + CMS_HEAD_FIX_PACKET_LEN)) {
        TSD_ERROR("[CMSCBB_VERIFY] file length invalid. path[%s], len[%lld]", srcPath.c_str(), fileLen);
        return static_cast<uint32_t>(TSD_START_FAIL);
    }
    rewind(fp);
    std::unique_ptr<SeImageHead> pktHeaderPtr(new (std::nothrow) SeImageHead());
    if (pktHeaderPtr == nullptr) {
        TSD_ERROR("[CMSCBB_VERIFY] new SeImageHead failed");
        return static_cast<uint32_t>(TSD_START_FAIL);
    }
    SeImageHead * const pktHeader = pktHeaderPtr.get();
    if (pktHeader == nullptr) {
        TSD_ERROR("[CMSCBB_VERIFY] malloc failed");
        return static_cast<uint32_t>(TSD_START_FAIL);
    }

    const uint32_t freadBytes = fread(pktHeader, sizeof(uint8_t), sizeof(SeImageHead), fp);
    if (freadBytes != sizeof(SeImageHead)) {
        TSD_ERROR("[CMSCBB_VERIFY] fread fileHead failed. readn[%d]", freadBytes);
        return static_cast<uint32_t>(TSD_START_FAIL);
    }
    mixCodeLen = pktHeader->uwLCodeLen;
    if (mixCodeLen <= CMS_IMG_DESC_LEN) {
        TSD_ERROR("[CMSCBB_VERIFY] invalid code length:%u", mixCodeLen);
        return static_cast<uint32_t>(TSD_START_FAIL);
    }
    mixCodeLen = mixCodeLen - CMS_IMG_DESC_LEN;
    TSD_RUN_INFO("[CMSCBB_VERIFY] GetPkgCodeLen end, mixCodeLen[%u]", mixCodeLen);
    return TSD_OK;
}

TSD_StatusT PackageVerify::ProcessSendStepVerify(const std::string &srcPath, const uint32_t codeLen) const
{
    TSD_INFO("[CMSCBB_VERIFY] verify code len[%u] start", codeLen);
    FILE *fp = fopen(srcPath.c_str(), "r");
    if (fp == nullptr) {
        TSD_ERROR("[CMSCBB_VERIFY] fopen failed. path[%s]", srcPath.c_str());
        return static_cast<uint32_t>(TSD_START_FAIL);
    }
    const ScopeGuard closeFileGuard([&fp]() { (void)fclose(fp); });
    const int32_t ret = fseek(fp, CMS_HEAD_FIX_PACKET_LEN, SEEK_SET);
    if (ret != 0) {
        TSD_ERROR("[CMSCBB_VERIFY] fseek failed. path[%s]", srcPath.c_str());
        return static_cast<uint32_t>(TSD_START_FAIL);
    }
    const uint32_t fileTotalLen = codeLen + CMS_IMG_DESC_LEN;
    std::unique_ptr<uint8_t []> srcFilePtr(new (std::nothrow) uint8_t[fileTotalLen]);
    if (srcFilePtr == nullptr) {
        TSD_ERROR("[CMSCBB_VERIFY] new srcFilePtr failed");
        return static_cast<uint32_t>(TSD_START_FAIL);
    }
    uint8_t *srcFile = srcFilePtr.get();
    if (srcFile == nullptr) {
        TSD_ERROR("[CMSCBB_VERIFY] new srcFilePtr failed");
        return static_cast<uint32_t>(TSD_START_FAIL);
    }
    const uint32_t freadBytes = fread(srcFile, sizeof(uint8_t), fileTotalLen, fp);
    if (freadBytes != fileTotalLen) {
        TSD_ERROR("[CMSCBB_VERIFY] fread failed. readn[%d], totalLen:%u", freadBytes, fileTotalLen);
        return static_cast<uint32_t>(TSD_START_FAIL);
    }

    const TSD_StatusT res = ReWriteAicpuPackage(srcFile + CMS_IMG_DESC_LEN, codeLen, srcPath);
    if (res != TSD_OK) {
        TSD_ERROR("[CMSCBB_VERIFY] ReWriteAicpuPackage failed");
        return static_cast<uint32_t>(TSD_START_FAIL);
    }
    TSD_INFO("[CMSCBB_VERIFY] verify ProcessSendStepVerify end");
    return TSD_OK;
}

TSD_StatusT PackageVerify::ReWriteAicpuPackage(const uint8_t * const buf, const uint32_t len,
                                               const std::string &srcPath) const
{
    TSD_INFO("[CMSCBB_VERIFY] start write new file");
    FILE *fp = fopen(srcPath.c_str(), "w");
    if (fp == nullptr) {
        TSD_ERROR("[CMSCBB_VERIFY] fopen failed. path[%s]", srcPath.c_str());
        return static_cast<uint32_t>(TSD_START_FAIL);
    }
    const ScopeGuard closeFileGuard([&fp]() { (void)fclose(fp); });
    const size_t writeRet = fwrite(buf, len, 1, fp);
    if (writeRet != 1) {
        TSD_ERROR("[CMSCBB_VERIFY] fwrite failed writeRet[%u]", writeRet);
        return static_cast<uint32_t>(TSD_START_FAIL);
    }
    TSD_INFO("[CMSCBB_VERIFY] end write new file:%s, len:%u", srcPath.c_str(), len);
    return TSD_OK;
}

} // namespace tsd