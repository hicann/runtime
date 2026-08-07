/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "package_manager_test_common.h"
#include <fstream>

using namespace tsd;
using namespace tsdtest;
using namespace std;

namespace {
struct LoaderSendCapture {
    int calls = 0;
    int32_t peerNode = -1;
    int32_t deviceId = -1;
    std::string src;
    std::string dst;
};

LoaderSendCapture g_loaderSend;

class LoaderTempFile {
public:
    LoaderTempFile()
    {
        char path[] = "/tmp/package_loader_ut_XXXXXX";
        const int fd = mkstemp(path);
        if (fd >= 0) {
            path_ = path;
            const std::string content = "package payload";
            (void)write(fd, content.data(), content.size());
            (void)close(fd);
        }
    }
    ~LoaderTempFile()
    {
        if (!path_.empty()) {
            (void)remove(path_.c_str());
        }
    }
    const std::string& Path() const { return path_; }

private:
    std::string path_;
};

drvError_t CaptureLoaderTrustedPath(int32_t, int32_t, char* path, uint32_t len)
{
    return strcpy_s(path, len, "/device/trusted") == EOK ? DRV_ERROR_NONE : DRV_ERROR_INVALID_VALUE;
}

drvError_t CaptureLoaderV2Send(
    int32_t peerNode, int32_t deviceIdValue, const char* src, const char* dst, void (*)(struct drvHdcProgInfo*))
{
    ++g_loaderSend.calls;
    g_loaderSend.peerNode = peerNode;
    g_loaderSend.deviceId = deviceIdValue;
    g_loaderSend.src = src;
    g_loaderSend.dst = dst;
    return DRV_ERROR_NONE;
}

int32_t mmScandir2Stub(const char*, mmDirent2*** entryList, mmFilter2, mmSort2)
{
    auto** list = static_cast<mmDirent2**>(malloc(sizeof(mmDirent2*)));
    list[0] = static_cast<mmDirent2*>(malloc(sizeof(mmDirent2)));
    (void)strcpy_s(list[0]->d_name, sizeof(list[0]->d_name), "Ascend910-aicpu_syskernels.tar.gz");
    *entryList = list;
    return 1;
}

int32_t mmScandir2Stub2(const char*, mmDirent2*** entryList, mmFilter2, mmSort2)
{
    auto** list = static_cast<mmDirent2**>(malloc(sizeof(mmDirent2*)));
    list[0] = static_cast<mmDirent2*>(malloc(sizeof(mmDirent2)));
    (void)strcpy_s(list[0]->d_name, sizeof(list[0]->d_name), "Ascend910-driver.run");
    *entryList = list;
    return 1;
}

} // namespace

class PackageLoaderComponentTest : public PackageManagerComponentTest {
protected:
    void SetUp() override
    {
        PackageManagerComponentTest::SetUp();
        g_loaderSend = {};
    }
};

TEST_F(PackageLoaderComponentTest, LoadSysOpKernel_PackagesAvailableAndCheckCodeSucceeds_ReturnsOk)
{
    // send package to device success
    ProcessModeManager processModeManager(deviceId, PROCESS_MODE);
    processModeManager.GetPackageManager().envInfo_.SetPlatInfoMode(static_cast<uint32_t>(ModeType::ONLINE));

    MOCKER_CPP(mmAccess).stubs().will(returnValue(EN_OK));
    MOCKER_CPP(mmIsDir).stubs().will(returnValue(EN_OK));
    MOCKER_CPP(mmScandir2).stubs().will(invoke(mmScandir2Stub));
    MOCKER(mmSleep).stubs().will(returnValue(0));
    MOCKER_CPP(&PackageCheckCodeService::GetDeviceCheckCode).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(CalFileSize).stubs().will(returnValue(1));
    tsd::TSD_StatusT ret = processModeManager.GetPackageManager().LoadSysOpKernel();
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(PackageLoaderComponentTest, LoadSysOpKernel_PackageDirectoryMissing_ReturnsOk)
{
    // package is not exist
    ProcessModeManager processModeManager(deviceId, PROCESS_MODE);
    processModeManager.GetPackageManager().envInfo_.SetPlatInfoMode(static_cast<uint32_t>(ModeType::ONLINE));

    MOCKER_CPP(mmAccess).stubs().will(returnValue(EN_ERROR));
    MOCKER_CPP(mmIsDir).stubs().will(returnValue(EN_ERROR));
    MOCKER(mmSleep).stubs().will(returnValue(0));
    tsd::TSD_StatusT ret = processModeManager.GetPackageManager().LoadSysOpKernel();
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(PackageLoaderComponentTest, LoadSysOpKernel_NoPackageEntryMatches_ReturnsOk)
{
    // send package to device success
    ProcessModeManager processModeManager(deviceId, PROCESS_MODE);
    processModeManager.GetPackageManager().envInfo_.SetPlatInfoMode(static_cast<uint32_t>(ModeType::ONLINE));

    MOCKER_CPP(mmAccess).stubs().will(returnValue(EN_OK));
    MOCKER_CPP(mmIsDir).stubs().will(returnValue(EN_OK));
    MOCKER_CPP(mmScandir2).stubs().will(invoke(mmScandir2Stub2));
    MOCKER(mmSleep).stubs().will(returnValue(0));
    MOCKER_CPP(&PackageCheckCodeService::GetDeviceCheckCode).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(CalFileSize).stubs().will(returnValue(1));
    tsd::TSD_StatusT ret = processModeManager.GetPackageManager().LoadSysOpKernel();
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(PackageLoaderComponentTest, LoadSysOpKernel_OfflineAdcMode_ReturnsOk)
{
    // send package to device success
    ProcessModeManager processModeManager(deviceId, PROCESS_MODE);
    processModeManager.GetPackageManager().envInfo_.SetPlatInfoMode(static_cast<uint32_t>(ModeType::OFFLINE));
    MOCKER(mmSleep).stubs().will(returnValue(0));
    MOCKER_CPP(mmAccess).stubs().will(returnValue(EN_OK));
    MOCKER_CPP(mmIsDir).stubs().will(returnValue(EN_OK));
    MOCKER_CPP(mmScandir2).stubs().will(invoke(mmScandir2Stub));
    MOCKER_CPP(&PackageCheckCodeService::GetDeviceCheckCode).stubs().will(returnValue(TSD_OK));
    tsd::TSD_StatusT ret = processModeManager.GetPackageManager().LoadSysOpKernel();
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(PackageLoaderComponentTest, LoadSysOpKernel_CheckCodeFails_ReturnsDeviceIdError)
{
    // send package to device success
    ProcessModeManager processModeManager(deviceId, PROCESS_MODE);
    processModeManager.GetPackageManager().envInfo_.SetPlatInfoMode(static_cast<uint32_t>(ModeType::ONLINE));

    MOCKER_CPP(mmAccess).stubs().will(returnValue(EN_OK));
    MOCKER_CPP(mmIsDir).stubs().will(returnValue(EN_OK));
    MOCKER_CPP(mmScandir2).stubs().will(invoke(mmScandir2Stub));
    MOCKER(mmSleep).stubs().will(returnValue(0));
    MOCKER_CPP(&PackageCheckCodeService::GetDeviceCheckCode).stubs().will(returnValue(1));
    tsd::TSD_StatusT ret = processModeManager.GetPackageManager().LoadSysOpKernel();
    EXPECT_EQ(ret, tsd::TSD_DEVICEID_ERROR);
}

TEST_F(PackageLoaderComponentTest, LoadSysOpKernel_OfflineMode_PackageCheckSucceeds)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER_CPP(&PackageEnvInfo::CheckPackageExists).stubs().will(returnValue(true));
    MOCKER(mmSleep).stubs().will(returnValue(0));
    processModeManager.GetPackageManager().envInfo_.SetPlatInfoMode(0);
    MOCKER_CPP(&PackageCheckCodeService::GetDeviceCheckCode).stubs().will(returnValue(TSD_OK));
    tsd::TSD_StatusT ret = processModeManager.GetPackageManager().LoadSysOpKernel();
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(PackageLoaderComponentTest, LoadSysOpKernel_TrustedPathFails_ReturnsError)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER_CPP(&PackageEnvInfo::CheckPackageExists).stubs().will(returnValue(true));
    processModeManager.GetPackageManager().envInfo_.SetPlatInfoMode(1);
    MOCKER_CPP(&PackageCheckCodeService::GetDeviceCheckCode).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER(drvHdcGetTrustedBasePath).stubs().will(returnValue(DRV_ERROR_NO_DEVICE));
    MOCKER(mmSleep).stubs().will(returnValue(0));
    tsd::TSD_StatusT ret = processModeManager.GetPackageManager().LoadSysOpKernel();
    EXPECT_NE(ret, tsd::TSD_OK);
}

TEST_F(PackageLoaderComponentTest, LoadSysOpKernel_CheckCodeReturnsLimitError_ReturnsError)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER_CPP(&PackageEnvInfo::CheckPackageExists).stubs().will(returnValue(true));
    processModeManager.GetPackageManager().envInfo_.SetPlatInfoMode(1);
    MOCKER_CPP(&PackageCheckCodeService::GetDeviceCheckCode).stubs().will(returnValue(102U));
    MOCKER(mmSleep).stubs().will(returnValue(0));
    tsd::TSD_StatusT ret = processModeManager.GetPackageManager().LoadSysOpKernel();
    EXPECT_NE(ret, tsd::TSD_OK);
}

TEST_F(PackageLoaderComponentTest, LoadSysOpKernel_ZeroSizePackage_ReturnsOk)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER_CPP(&PackageEnvInfo::CheckPackageExists).stubs().will(returnValue(true));
    MOCKER_CPP(&PackageCheckCodeService::GetDeviceCheckCode).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER(mmSleep).stubs().will(returnValue(0));
    MOCKER(CalFileSize).stubs().will(returnValue(0U));
    tsd::TSD_StatusT ret = processModeManager.GetPackageManager().LoadSysOpKernel();
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(PackageLoaderComponentTest, LoadSysOpKernel_NonzeroSizePackage_ReturnsOk)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER_CPP(&PackageEnvInfo::CheckPackageExists).stubs().will(returnValue(true));
    MOCKER_CPP(&PackageCheckCodeService::GetDeviceCheckCode).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER(CalFileSize).stubs().will(returnValue(1));
    MOCKER(mmSleep).stubs().will(returnValue(0));
    tsd::TSD_StatusT ret = processModeManager.GetPackageManager().LoadSysOpKernel();
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(PackageLoaderComponentTest, LoadSysOpKernel_PackageAlreadyOnDevice_ReturnsOk)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER_CPP(&PackageEnvInfo::CheckPackageExists).stubs().will(returnValue(true));
    MOCKER(mmSleep).stubs().will(returnValue(0));
    processModeManager.GetPackageManager().ctx_.aicpuPackageExistInDevice = true;
    tsd::TSD_StatusT ret = processModeManager.GetPackageManager().LoadSysOpKernel();
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(PackageLoaderComponentTest, ResetClearsAllLoaderState)
{
    ProcessModeManager manager(deviceId, 0);
    auto& packageManager = manager.GetPackageManager();
    packageManager.ctx_.aicpuPackageExistInDevice = true;
    packageManager.loader_.hasSendConfigFile_ = true;
    packageManager.hashStore_.SetHostCommonSinkPackHashValue("pkg", "host");
    packageManager.hashStore_.SetDeviceCommonSinkPackHashValue("pkg", "device");

    packageManager.loader_.Reset();

    EXPECT_FALSE(packageManager.ctx_.aicpuPackageExistInDevice);
    EXPECT_FALSE(packageManager.loader_.hasSendConfigFile_);
    EXPECT_TRUE(packageManager.hashStore_.GetHostCommonSinkPackHashValue("pkg").empty());
    EXPECT_TRUE(packageManager.hashStore_.GetDeviceCommonSinkPackHashValue("pkg").empty());
}

TEST_F(PackageLoaderComponentTest, ShouldLoadLegacyPackage_CommonSinkUnsupported_ReturnsTrue)
{
    ProcessModeManager manager(deviceId, 0);
    MOCKER_CPP(&CapabilityManager::IsSupportCommonSink).stubs().will(returnValue(false));

    EXPECT_TRUE(manager.GetPackageManager().loader_.ShouldLoadLegacyPackage());
}

TEST_F(PackageLoaderComponentTest, ShouldLoadLegacyPackage_CommonSinkConfigMissing_ReturnsTrue)
{
    ProcessModeManager manager(deviceId, 0);
    MOCKER_CPP(&CapabilityManager::IsSupportCommonSink).stubs().will(returnValue(true));

    EXPECT_TRUE(manager.GetPackageManager().loader_.ShouldLoadLegacyPackage());
}

TEST_F(PackageLoaderComponentTest, ShouldLoadLegacyPackage_CommonSinkConfigExists_ReturnsFalse)
{
    ProcessModeManager manager(deviceId, 0);
    manager.GetPackageManager().envInfo_.SetPlatInfoChipType(CHIP_DC);
    PackConfDetail detail;
    detail.hostTruePath = "/tmp/Ascend310P-aicpu_legacy.tar.gz";
    PackageProcessConfig::GetInstance()->configMap_["Ascend310P-aicpu_legacy.tar.gz"] = detail;
    MOCKER_CPP(&CapabilityManager::IsSupportCommonSink).stubs().will(returnValue(true));

    EXPECT_FALSE(manager.GetPackageManager().loader_.ShouldLoadLegacyPackage());
}

TEST_F(PackageLoaderComponentTest, SupportLoadPkgRejectsHccdCompatPackage)
{
    ProcessModeManager manager(deviceId, 0);
    EXPECT_FALSE(manager.GetPackageManager().loader_.SupportLoadPkg("cann-hccd-compat.tar.gz"));
}

TEST_F(PackageLoaderComponentTest, SupportLoadPkgAcceptsHixlOnAscend950)
{
    ProcessModeManager manager(deviceId, 0);
    manager.GetPackageManager().envInfo_.SetPlatInfoChipType(CHIP_ASCEND_950);
    EXPECT_TRUE(manager.GetPackageManager().loader_.SupportLoadPkg("cann-hixl-compat.tar.gz"));
}

TEST_F(PackageLoaderComponentTest, LoadRuntimePkgToDevice_LegacyPackageSizeIsZero_ReturnsOk)
{
    MOCKER_CPP(&PackageCheckCodeService::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&PackageCheckCodeService::WaitPkgRsp).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER(mmAccess).stubs().will(returnValue(EN_OK));
    MOCKER(mmIsDir).stubs().will(returnValue(EN_OK));
    MOCKER(mmIsDir).stubs().will(returnValue(EN_OK));
    MOCKER(tsd::CalFileSize).stubs().will(returnValue(0U));
    MOCKER_CPP(&CapabilityManager::IsSupportCommonSink).stubs().will(returnValue(false));
    ProcessModeManager processModeManager(deviceId, 0);
    (void)InjectPackageStubComm(processModeManager, deviceId);
    auto ret = processModeManager.GetPackageManager().loader_.LoadRuntimePkgToDevice(
        processModeManager.GetTsdController().BuildBaseMessageContext());
    EXPECT_EQ(ret, TSD_OK);
    GlobalMockObject::verify();
}

TEST_F(PackageLoaderComponentTest, LoadRuntimePkgToDevice_CommonSinkConfigMissing_ReturnsError)
{
    MOCKER_CPP(&CapabilityManager::IsSupportCommonSink).stubs().will(returnValue(true));
    ProcessModeManager processModeManager(deviceId, 0);
    (void)InjectPackageStubComm(processModeManager, deviceId);
    MOCKER_CPP(&PackageCheckCodeService::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&PackageCheckCodeService::WaitPkgRsp).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER(mmAccess).stubs().will(returnValue(EN_OK));
    MOCKER(mmIsDir).stubs().will(returnValue(EN_OK));
    MOCKER(mmIsDir).stubs().will(returnValue(EN_OK));
    MOCKER(tsd::CalFileSize).stubs().will(returnValue(1U));
    auto ret = processModeManager.GetPackageManager().loader_.LoadRuntimePkgToDevice(
        processModeManager.GetTsdController().BuildBaseMessageContext());
    EXPECT_NE(ret, TSD_OK);
    GlobalMockObject::verify();
}

TEST_F(PackageLoaderComponentTest, LoadRuntimePkgToDevice_TrustedPathFails_ReturnsError)
{
    MOCKER_CPP(&CapabilityManager::IsSupportCommonSink).stubs().will(returnValue(true));
    ProcessModeManager processModeManager(deviceId, 0);
    (void)InjectPackageStubComm(processModeManager, deviceId);
    MOCKER_CPP(&PackageCheckCodeService::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&PackageCheckCodeService::WaitPkgRsp).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER(mmAccess).stubs().will(returnValue(EN_OK));
    MOCKER(mmIsDir).stubs().will(returnValue(EN_OK));
    MOCKER(mmIsDir).stubs().will(returnValue(EN_OK));
    MOCKER(tsd::CalFileSize).stubs().will(returnValue(1U));
    MOCKER(drvHdcGetTrustedBasePath).stubs().will(returnValue(DRV_ERROR_INVALID_DEVICE));
    auto ret = processModeManager.GetPackageManager().loader_.LoadRuntimePkgToDevice(
        processModeManager.GetTsdController().BuildBaseMessageContext());
    EXPECT_NE(ret, TSD_OK);
    GlobalMockObject::verify();
}

TEST_F(PackageLoaderComponentTest, LoadRuntimePkgToDevice_CompatPackagesAndResponsesValid_ReturnsOk)
{
    ProcessModeManager processModeManager(deviceId, 0);

    PackConfDetail config = {};
    config.decDstDir = DeviceInstallPath::RUNTIME_PATH;
    config.findPath = "compat";
    config.hostTruePath = "test/compat";
    PackageProcessConfig::GetInstance()->configMap_.emplace("cann-udf-compat.tar.gz", config);
    PackConfDetail hccdConfig = {};
    hccdConfig.decDstDir = DeviceInstallPath::RUNTIME_PATH;
    hccdConfig.findPath = "compat";
    hccdConfig.hostTruePath = "test/compat";
    PackageProcessConfig::GetInstance()->configMap_.emplace("cann-hccd-compat.tar.gz", hccdConfig);

    MOCKER_CPP(&CapabilityManager::IsSupportCommonInterface).stubs().will(returnValue(true));
    std::string hashVal = "12345";
    MOCKER(CalFileSha256HashValue).stubs().will(returnValue(hashVal));
    MOCKER_CPP(&PackageCheckCodeService::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&PackageCheckCodeService::WaitPkgRsp).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&PackageCheckCodeService::GetCannHsPkgCheckCode).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&PackageLoader::LoadPackageConfigInfoToDevice).stubs().will(returnValue(tsd::TSD_OK));
    processModeManager.commAgent_.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    processModeManager.GetPackageManager().ctx_.pkgRspCode = ResponseCode::SUCCESS;

    HDCMessage rspMsg = {};
    rspMsg.set_type(HDCMessage::TSD_GET_DEVICE_CANN_HS_CHECKCODE_RSP);
    rspMsg.set_tsd_rsp_code(0U);
    SinkPackageHashCodeInfo* rspCon = rspMsg.add_package_hash_code_list();
    rspCon->set_package_name("cann-hccd-compat.tar.gz");
    rspCon->set_hash_code(hashVal);
    processModeManager.GetPackageManager().SaveDeviceCheckCode(rspMsg);
    auto ret = processModeManager.GetPackageManager().loader_.LoadRuntimePkgToDevice(
        processModeManager.GetTsdController().BuildBaseMessageContext());
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(PackageLoaderComponentTest, LoadRuntimePkgToDevice_TrustedV2PathLookupFails_ReturnsInternalError)
{
    ProcessModeManager processModeManager(deviceId, 0);

    PackConfDetail config = {};
    config.decDstDir = DeviceInstallPath::RUNTIME_PATH;
    config.findPath = "compat";
    config.hostTruePath = "test/compat";
    PackageProcessConfig::GetInstance()->configMap_.emplace("cann-udf-compat.tar.gz", config);

    MOCKER(drvHdcGetTrustedBasePathV2).stubs().will(returnValue(1));
    MOCKER_CPP(&CapabilityManager::IsSupportCommonInterface).stubs().will(returnValue(true));
    MOCKER(mmSleep).stubs().will(returnValue(0));
    std::string hashVal = "12345";
    processModeManager.commAgent_.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    processModeManager.GetPackageManager().ctx_.pkgRspCode = ResponseCode::SUCCESS;

    auto ret = processModeManager.GetPackageManager().loader_.LoadRuntimePkgToDevice(
        processModeManager.GetTsdController().BuildBaseMessageContext());
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(PackageLoaderComponentTest, LoadRuntimePkgToDevice_V2FileSendFails_ReturnsInternalError)
{
    ProcessModeManager processModeManager(deviceId, 0);

    PackConfDetail config = {};
    config.decDstDir = DeviceInstallPath::RUNTIME_PATH;
    config.findPath = "compat";
    config.hostTruePath = "test/compat";
    PackageProcessConfig::GetInstance()->configMap_.emplace("cann-udf-compat.tar.gz", config);

    MOCKER(drvHdcSendFileV2).stubs().will(returnValue(1));
    MOCKER_CPP(&CapabilityManager::IsSupportCommonInterface).stubs().will(returnValue(true));
    std::string hashVal = "12345";
    MOCKER(CalFileSha256HashValue).stubs().will(returnValue(hashVal));
    MOCKER_CPP(&PackageCheckCodeService::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&PackageCheckCodeService::WaitPkgRsp).stubs().will(returnValue(tsd::TSD_OK));
    processModeManager.commAgent_.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    processModeManager.GetPackageManager().ctx_.pkgRspCode = ResponseCode::SUCCESS;

    auto ret = processModeManager.GetPackageManager().loader_.LoadRuntimePkgToDevice(
        processModeManager.GetTsdController().BuildBaseMessageContext());
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(PackageLoaderComponentTest, LoadRuntimePkgToDevice_CompatPackageResponseFails_ReturnsInternalError)
{
    ProcessModeManager processModeManager(deviceId, 0);

    PackConfDetail config = {};
    config.decDstDir = DeviceInstallPath::RUNTIME_PATH;
    config.findPath = "compat";
    config.hostTruePath = "test/compat";
    PackageProcessConfig::GetInstance()->configMap_.emplace("cann-udf-compat.tar.gz", config);

    MOCKER_CPP(&CapabilityManager::IsSupportCommonInterface).stubs().will(returnValue(true));
    std::string hashVal = "123456";
    MOCKER(CalFileSha256HashValue).stubs().will(returnValue(hashVal));
    MOCKER_CPP(&PackageCheckCodeService::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&PackageCheckCodeService::WaitPkgRsp).stubs().will(returnValue(tsd::TSD_OK));
    processModeManager.commAgent_.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    processModeManager.sharedCtx_.rspCode = ResponseCode::FAIL;

    auto ret = processModeManager.GetPackageManager().loader_.LoadRuntimePkgToDevice(
        processModeManager.GetTsdController().BuildBaseMessageContext());
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(PackageLoaderComponentTest, LoadCannHsPkgToDevice_ClientInitializationFails_SkipsMessageAndWait)
{
    ProcessModeManager processModeManager(deviceId, 0);
    auto comm = InjectPackageStubComm(processModeManager, deviceId);

    PackConfDetail config = {};
    config.decDstDir = DeviceInstallPath::RUNTIME_PATH;
    config.findPath = "compat";
    config.hostTruePath = "test/compat";
    PackageProcessConfig::GetInstance()->configMap_.emplace("cann-udf-compat.tar.gz", config);

    MOCKER_CPP(&PackageCheckCodeService::InitTsdClient)
        .expects(once())
        .will(returnValue(static_cast<TSD_StatusT>(TSD_CLT_OPEN_FAILED)));
    MOCKER_CPP(&PackageCheckCodeService::WaitPkgRsp).expects(never());
    MOCKER(CalFileSha256HashValue).stubs().will(returnValue(std::string("123456")));
    MOCKER(drvHdcSendFileV2).expects(once()).will(returnValue(DRV_ERROR_NONE));

    const auto ret = processModeManager.GetPackageManager().loader_.LoadCannHsPkgToDevice(
        "cann-udf-compat.tar.gz", processModeManager.GetTsdController().BuildBaseMessageContext());
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
    EXPECT_EQ(comm->sendCount_, 0);
    EXPECT_EQ(comm->recvCount_, 0);
}

TEST_F(PackageLoaderComponentTest, LoadDShapePkgToDevice_ZeroSizePackage_ReturnsOk)
{
    MOCKER_CPP(&PackageCheckCodeService::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&PackageCheckCodeService::WaitPkgRsp).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER(mmAccess).stubs().will(returnValue(EN_OK));
    MOCKER(mmIsDir).stubs().will(returnValue(EN_OK));
    MOCKER(mmIsDir).stubs().will(returnValue(EN_OK));
    MOCKER(tsd::CalFileSize).stubs().will(returnValue(0U));
    MOCKER_CPP(&CapabilityManager::IsSupportCommonInterface).stubs().will(returnValue(true));
    ProcessModeManager processModeManager(deviceId, 0);
    (void)InjectPackageStubComm(processModeManager, deviceId);
    auto ret = processModeManager.GetPackageManager().loader_.LoadDShapePkgToDevice(
        processModeManager.GetTsdController().BuildBaseMessageContext());
    EXPECT_EQ(ret, TSD_OK);
    GlobalMockObject::verify();
}

TEST_F(PackageLoaderComponentTest, LoadDShapePkgToDevice_NonzeroSizePackage_ReturnsError)
{
    MOCKER_CPP(&CapabilityManager::IsSupportCommonInterface).stubs().will(returnValue(true));
    ProcessModeManager processModeManager(deviceId, 0);
    (void)InjectPackageStubComm(processModeManager, deviceId);
    MOCKER_CPP(&PackageCheckCodeService::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&PackageCheckCodeService::WaitPkgRsp).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER(mmAccess).stubs().will(returnValue(EN_OK));
    MOCKER(mmIsDir).stubs().will(returnValue(EN_OK));
    MOCKER(mmIsDir).stubs().will(returnValue(EN_OK));
    MOCKER(tsd::CalFileSize).stubs().will(returnValue(1U));
    auto ret = processModeManager.GetPackageManager().loader_.LoadDShapePkgToDevice(
        processModeManager.GetTsdController().BuildBaseMessageContext());
    EXPECT_NE(ret, TSD_OK);
    GlobalMockObject::verify();
}

TEST_F(PackageLoaderComponentTest, IsOkToLoadFileToDevice_UnsupportedCapability_ReturnsFalse)
{
    const char_t* fileName = "";
    MOCKER_CPP(&CapabilityManager::IsSupportCommonInterface).stubs().will(returnValue(false));
    ProcessModeManager processModeManager(deviceId, 0);
    auto ret = processModeManager.GetPackageManager().loader_.IsOkToLoadFileToDevice(fileName, 1U);
    EXPECT_EQ(ret, false);
    GlobalMockObject::verify();
}

TEST_F(PackageLoaderComponentTest, LoadSysOpKernel_ExtendPackageSendFails_ReturnsInternalError)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.GetPackageManager().ctx_.aicpuPackageExistInDevice = false;
    processModeManager.commAgent_.tsdSessionId_ = 0U;
    processModeManager.commAgent_.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    HDC_SESSION session = nullptr;
    std::dynamic_pointer_cast<HdcClient>(processModeManager.commAgent_.devCommClient_)->hdcClientSessionMap_[0U] =
        session;
    std::dynamic_pointer_cast<HdcClient>(processModeManager.commAgent_.devCommClient_)->hdcClientVerifyMap_[0U] =
        std::make_shared<VersionVerify>();
    processModeManager.GetPackageManager().envInfo_.GetPackageNameRef(1) = "Ascend-aicpu_extend_syskernels.tar.gz";
    MOCKER_CPP(&PackageEnvInfo::CheckPackageExists).stubs().will(returnValue(true));
    MOCKER_CPP(&PackageCheckCodeService::GetDeviceCheckCode).stubs().will(returnValue(tsd::TSD_OK));
    processModeManager.GetPackageManager().envInfo_.SetPlatInfoMode(1);
    MOCKER_CPP(&HdcCommon::SendNormalMsg).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&PackageSender::SendAICPUPackage).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&PackageSender::SendCommonPackage).stubs().will(returnValue(1U));
    MOCKER(mmSleep).stubs().will(returnValue(0));
    tsd::TSD_StatusT ret = processModeManager.GetPackageManager().LoadSysOpKernel();
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(PackageLoaderComponentTest, LoadSysOpKernel_AicpuSendFails_ReturnsInternalError)
{
    // send package to device success
    ProcessModeManager processModeManager(deviceId, PROCESS_MODE);
    processModeManager.GetPackageManager().envInfo_.SetPlatInfoMode(static_cast<uint32_t>(ModeType::ONLINE));
    MOCKER(&drvHdcGetTrustedBasePath).stubs().will(returnValue(0));
    MOCKER_CPP(&PackageEnvInfo::CheckPackageExists).stubs().will(returnValue(true));
    MOCKER_CPP(&PackageCheckCodeService::GetDeviceCheckCode).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageSender::SendAICPUPackage).stubs().will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    MOCKER(mmSleep).stubs().will(returnValue(0));
    tsd::TSD_StatusT ret = processModeManager.GetPackageManager().LoadSysOpKernel();
    EXPECT_EQ(ret, static_cast<uint32_t>(TSD_INTERNAL_ERROR));
}

TEST_F(PackageLoaderComponentTest, LoadPackageToDeviceByConfig_PackageResponseFails_ReturnsInternalError)
{
    MOCKER_CPP(&CapabilityManager::IsSupportCommonInterface).stubs().will(returnValue(true));
    MOCKER(drvHdcGetTrustedBasePathV2).stubs().will(returnValue(0));
    MOCKER(drvHdcSendFileV2).stubs().will(returnValue(0));
    MOCKER_CPP(&ClientManager::IsAdcEnv).stubs().will(returnValue(false));
    ProcessModeManager processModeManager(deviceId, 0);
    PackageProcessConfig* pkgConInst = PackageProcessConfig::GetInstance();
    std::string pkgName = "LoadPackageToDeviceByConfig_failed_test";
    PackConfDetail packConfDetail;
    packConfDetail.hostTruePath = "tmp123";
    pkgConInst->configMap_[pkgName] = packConfDetail;
    MOCKER_CPP(&PackageLoader::SupportLoadPkg).stubs().will(returnValue(true));
    std::string hashcode = "12345666";
    MOCKER(CalFileSha256HashValue).stubs().will(returnValue(hashcode));
    MOCKER_CPP(&PackageHashStore::IsCommonSinkHostAndDevicePkgSame).stubs().will(returnValue(false));
    MOCKER_CPP(&PackageSender::CompareAndSendCommonSinkPkg).stubs().will(returnValue(tsd::TSD_OK));
    processModeManager.sharedCtx_.rspCode = ResponseCode::FAIL;
    processModeManager.GetPackageManager().ctx_.loadPackageErrorMsg = "test error";
    auto ret = processModeManager.GetPackageManager().LoadPackageToDeviceByConfig();
    EXPECT_EQ(ret, tsd::TSD_INTERNAL_ERROR);
}

TEST_F(PackageLoaderComponentTest, SupportLoadPkg_KnownAndUnknownPackages_ReturnsChipSpecificDecisions)
{
    ProcessModeManager processModeManager(deviceId, 0);
    EXPECT_TRUE(processModeManager.GetPackageManager().loader_.SupportLoadPkg("unknown_pkg"));

    EXPECT_FALSE(processModeManager.GetPackageManager().loader_.SupportLoadPkg("cann-udf-compat.tar.gz"));

    processModeManager.GetPackageManager().envInfo_.SetPlatInfoChipType(static_cast<uint32_t>(tsd::CHIP_DC));
    EXPECT_TRUE(processModeManager.GetPackageManager().loader_.SupportLoadPkg("aicpu_hcomm.tar.gz"));
    EXPECT_FALSE(processModeManager.GetPackageManager().loader_.SupportLoadPkg("cann-tsch-compat.tar.gz"));
}

TEST_F(PackageLoaderComponentTest, LoadPackageToDeviceByConfig_CommonSinkUnsupported_ReturnsOk)
{
    ProcessModeManager processModeManager(deviceId, 0);

    MOCKER_CPP(&CapabilityManager::IsSupportCommonInterface).stubs().will(returnValue(false));
    EXPECT_EQ(processModeManager.GetPackageManager().LoadPackageToDeviceByConfig(), TSD_OK);
}

TEST_F(PackageLoaderComponentTest, LoadPackageToDeviceByConfig_TrustedV2PathLookupFails_ReturnsInternalError)
{
    ProcessModeManager processModeManager(deviceId, 0);
    PackageProcessConfig::GetInstance()->configMap_["test-package.tar.gz"] = {};

    MOCKER_CPP(&CapabilityManager::IsSupportCommonInterface).stubs().will(returnValue(true));
    MOCKER(drvHdcGetTrustedBasePathV2).stubs().will(returnValue(DRV_ERROR_NO_DEVICE));
    EXPECT_EQ(processModeManager.GetPackageManager().LoadPackageToDeviceByConfig(), TSD_INTERNAL_ERROR);
}

TEST_F(PackageLoaderComponentTest, LoadPackageToDeviceByConfig_RealConfigAndHash_SendsExpectedV2File)
{
    LoaderTempFile package;
    ASSERT_FALSE(package.Path().empty());
    ProcessModeManager manager(deviceId, 0);
    auto& packageManager = manager.GetPackageManager();
    packageManager.envInfo_.SetHostSoPath("");
    manager.commAgent_.procSign_.tgid = 8642;
    PackConfDetail detail{};
    detail.validFlag = true;
    detail.loadAsPerSocFlag = true;
    detail.decDstDir = DeviceInstallPath::RUNTIME_PATH;
    detail.hostTruePath = package.Path();
    PackageProcessConfig::GetInstance()->configMap_["runtime-addon.tar.gz"] = detail;
    packageManager.hashStore_.SetDeviceCommonSinkPackHashValue("runtime-addon.tar.gz", "device-hash");
    packageManager.ctx_.pkgRspCode = ResponseCode::SUCCESS;
    MOCKER_CPP(&CapabilityManager::IsSupportCommonSink).stubs().will(returnValue(true));
    MOCKER(drvHdcGetTrustedBasePathV2).expects(once()).will(invoke(CaptureLoaderTrustedPath));
    MOCKER_CPP(&PackageCheckCodeService::GetDeviceCheckCodeRetry).expects(exactly(2)).will(returnValue(TSD_OK));
    MOCKER(drvHdcSendFileV2).expects(once()).will(invoke(CaptureLoaderV2Send));

    EXPECT_EQ(packageManager.LoadPackageToDeviceByConfig(), TSD_OK);
    EXPECT_EQ(
        packageManager.hashStore_.GetHostCommonSinkPackHashValue("runtime-addon.tar.gz"),
        "d062d5f5a69f19c2a56827500cab26e42cd09fa741ed7e091dae9a6e067da9d3");
    EXPECT_EQ(g_loaderSend.calls, 1);
    EXPECT_EQ(g_loaderSend.peerNode, 0);
    EXPECT_EQ(g_loaderSend.deviceId, deviceId);
    EXPECT_EQ(g_loaderSend.src, package.Path());
    EXPECT_EQ(g_loaderSend.dst, "/device/trusted/8642_runtime-addon.tar.gz");
}

TEST_F(PackageLoaderComponentTest, LoadSinglePackageToDevice_HcommCompat_910B_NotSupported_Skip)
{
    // 910B 芯片 + device 不支持 TSD_SUPPORT_CANN_HCOMM_COMPAT_910B 能力位时，
    // cann-hcomm-compat.tar.gz 应被跳过加载，返回 TSD_OK，且不会进入下发流程。
    ProcessModeManager processModeManager(deviceId, 0);
    PackConfDetail detail = {};
    detail.loadAsPerSocFlag = true;
    processModeManager.GetPackageManager().envInfo_.SetPlatInfoChipType(static_cast<uint32_t>(tsd::CHIP_ASCEND_910B));
    MOCKER_CPP(&CapabilityManager::IsSupportCommonInterface).stubs().will(returnValue(false));
    MOCKER_CPP(&PackageProcessConfig::GetPkgHostAndDeviceDstPath).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageSender::CompareAndSendCommonSinkPkg).expects(mockcpp::never()).will(returnValue(TSD_OK));
    EXPECT_EQ(
        processModeManager.GetPackageManager().loader_.LoadSinglePackageToDevice(
            "cann-hcomm-compat.tar.gz", detail, 0, ""),
        TSD_OK);
}

TEST_F(PackageLoaderComponentTest, LoadSinglePackageToDevice_HcommCompat_910B_Supported_PassesGate)
{
    // 910B 芯片 + device 支持该能力位时，不在门控处提前返回，而是继续后续流程；
    // 此处用 GetPkgHostAndDeviceDstPath 返回错误来观测是否“穿过门控”。
    ProcessModeManager processModeManager(deviceId, 0);
    PackConfDetail detail = {};
    detail.loadAsPerSocFlag = true;
    processModeManager.GetPackageManager().envInfo_.SetPlatInfoChipType(static_cast<uint32_t>(tsd::CHIP_ASCEND_910B));
    MOCKER_CPP(&CapabilityManager::IsSupportCommonInterface).stubs().will(returnValue(true));
    MOCKER_CPP(&PackageProcessConfig::GetPkgHostAndDeviceDstPath)
        .stubs()
        .will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    EXPECT_EQ(
        processModeManager.GetPackageManager().loader_.LoadSinglePackageToDevice(
            "cann-hcomm-compat.tar.gz", detail, 0, ""),
        TSD_INTERNAL_ERROR);
}

TEST_F(PackageLoaderComponentTest, LoadSinglePackageToDevice_HcommCompat_NonChip910B_NotGated)
{
    // 非 910B 芯片时不受该能力位门控，即使 device 不支持也应穿过门控继续后续流程。
    ProcessModeManager processModeManager(deviceId, 0);
    PackConfDetail detail = {};
    detail.loadAsPerSocFlag = true;
    processModeManager.GetPackageManager().envInfo_.SetPlatInfoChipType(static_cast<uint32_t>(tsd::CHIP_ASCEND_950));
    MOCKER_CPP(&CapabilityManager::IsSupportCommonInterface).stubs().will(returnValue(false));
    MOCKER_CPP(&PackageProcessConfig::GetPkgHostAndDeviceDstPath)
        .stubs()
        .will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    EXPECT_EQ(
        processModeManager.GetPackageManager().loader_.LoadSinglePackageToDevice(
            "cann-hcomm-compat.tar.gz", detail, 0, ""),
        TSD_INTERNAL_ERROR);
}

TEST_F(PackageLoaderComponentTest, LoadSinglePackageToDevice_OtherPkg_NotGatedByHcommCompatBit)
{
    // 非 cann-hcomm-compat.tar.gz 的包不受该能力位门控，即使在 910B 且 device 不支持也应穿过门控。
    ProcessModeManager processModeManager(deviceId, 0);
    PackConfDetail detail = {};
    detail.loadAsPerSocFlag = true;
    processModeManager.GetPackageManager().envInfo_.SetPlatInfoChipType(static_cast<uint32_t>(tsd::CHIP_ASCEND_910B));
    MOCKER_CPP(&CapabilityManager::IsSupportCommonInterface).stubs().will(returnValue(false));
    MOCKER_CPP(&PackageProcessConfig::GetPkgHostAndDeviceDstPath)
        .stubs()
        .will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    EXPECT_EQ(
        processModeManager.GetPackageManager().loader_.LoadSinglePackageToDevice("aicpu_hcomm.tar.gz", detail, 0, ""),
        TSD_INTERNAL_ERROR);
}

TEST_F(PackageLoaderComponentTest, LoadPackageToDeviceByConfig_PackageUnsupported_SkipsAndReturnsOk)
{
    MOCKER_CPP(&CapabilityManager::IsSupportCommonInterface).stubs().will(returnValue(true));
    MOCKER(drvHdcGetTrustedBasePathV2).stubs().will(returnValue(0));
    MOCKER(drvHdcSendFileV2).stubs().will(returnValue(0));
    MOCKER_CPP(&ClientManager::IsAdcEnv).stubs().will(returnValue(false));
    ProcessModeManager processModeManager(deviceId, 0);
    PackageProcessConfig tempPkgConfig;
    MOCKER_CPP(&PackageProcessConfig::GetInstance).stubs().will(returnValue(&tempPkgConfig));
    std::string pkgName = "not_support_pkg.tar.gz";
    PackConfDetail packConfDetail;
    packConfDetail.hostTruePath = "tmp123";
    tempPkgConfig.configMap_[pkgName] = packConfDetail;
    MOCKER_CPP(&PackageLoader::SupportLoadPkg).stubs().will(returnValue(false));
    std::string hashcode = "12345666";
    MOCKER(CalFileSha256HashValue).stubs().will(returnValue(hashcode));
    MOCKER_CPP(&PackageHashStore::IsCommonSinkHostAndDevicePkgSame).stubs().will(returnValue(false));
    MOCKER_CPP(&PackageSender::CompareAndSendCommonSinkPkg).stubs().will(returnValue(tsd::TSD_OK));
    auto ret = processModeManager.GetPackageManager().LoadPackageToDeviceByConfig();
    EXPECT_EQ(ret, tsd::TSD_OK);
    GlobalMockObject::verify();
}

TEST_F(PackageLoaderComponentTest, LoadPackageToDeviceByConfig_HashMatchesDevice_SkipsAndReturnsOk)
{
    MOCKER_CPP(&CapabilityManager::IsSupportCommonInterface).stubs().will(returnValue(true));
    MOCKER(drvHdcGetTrustedBasePathV2).stubs().will(returnValue(0));
    MOCKER(drvHdcSendFileV2).stubs().will(returnValue(0));
    MOCKER_CPP(&ClientManager::IsAdcEnv).stubs().will(returnValue(false));
    PackageProcessConfig tempPkgConfig;
    MOCKER_CPP(&PackageProcessConfig::GetInstance).stubs().will(returnValue(&tempPkgConfig));
    ProcessModeManager processModeManager(deviceId, 0);
    std::string pkgName = "not_support_pkg.tar.gz";
    PackConfDetail packConfDetail;
    packConfDetail.hostTruePath = "tmp123";
    tempPkgConfig.configMap_[pkgName] = packConfDetail;
    MOCKER_CPP(&PackageLoader::SupportLoadPkg).stubs().will(returnValue(true));
    std::string hashcode = "12345666";
    MOCKER(CalFileSha256HashValue).stubs().will(returnValue(hashcode));
    MOCKER_CPP(&PackageHashStore::IsCommonSinkHostAndDevicePkgSame).stubs().will(returnValue(true));
    MOCKER_CPP(&PackageSender::CompareAndSendCommonSinkPkg).stubs().will(returnValue(tsd::TSD_OK));
    auto ret = processModeManager.GetPackageManager().LoadPackageToDeviceByConfig();
    EXPECT_EQ(ret, tsd::TSD_OK);
    GlobalMockObject::verify();
}

TEST_F(PackageLoaderComponentTest, LoadPackageToDeviceByConfig_SendAndResponseSucceed_ReturnsOk)
{
    MOCKER_CPP(&CapabilityManager::IsSupportCommonInterface).stubs().will(returnValue(true));
    MOCKER(drvHdcGetTrustedBasePathV2).stubs().will(returnValue(0));
    MOCKER(drvHdcSendFileV2).stubs().will(returnValue(0));
    MOCKER_CPP(&ClientManager::IsAdcEnv).stubs().will(returnValue(false));
    PackageProcessConfig tempPkgConfig;
    MOCKER_CPP(&PackageProcessConfig::GetInstance).stubs().will(returnValue(&tempPkgConfig));
    ProcessModeManager processModeManager(deviceId, 0);
    std::string pkgName = "load_finish.tar.gz";
    PackConfDetail packConfDetail;
    packConfDetail.hostTruePath = "tmp123";
    tempPkgConfig.configMap_[pkgName] = packConfDetail;
    MOCKER_CPP(&PackageLoader::SupportLoadPkg).stubs().will(returnValue(true));
    std::string hashcode = "12345666";
    MOCKER(CalFileSha256HashValue).stubs().will(returnValue(hashcode));
    MOCKER_CPP(&PackageHashStore::IsCommonSinkHostAndDevicePkgSame).stubs().will(returnValue(false));
    MOCKER_CPP(&PackageSender::CompareAndSendCommonSinkPkg).stubs().will(returnValue(tsd::TSD_OK));
    processModeManager.GetPackageManager().ctx_.pkgRspCode = ResponseCode::SUCCESS;
    auto ret = processModeManager.GetPackageManager().LoadPackageToDeviceByConfig();
    EXPECT_EQ(ret, tsd::TSD_OK);
    GlobalMockObject::verify();
}

TEST_F(PackageLoaderComponentTest, LoadPackageToDeviceByConfig_CertificateMismatch_ClearsErrorAndReturnsInternalError)
{
    MOCKER_CPP(&CapabilityManager::IsSupportCommonInterface).stubs().will(returnValue(true));
    MOCKER(drvHdcGetTrustedBasePathV2).stubs().will(returnValue(0));
    MOCKER(drvHdcSendFileV2).stubs().will(returnValue(0));
    MOCKER_CPP(&ClientManager::IsAdcEnv).stubs().will(returnValue(false));
    ProcessModeManager processModeManager(deviceId, 0);
    PackageProcessConfig* pkgConInst = PackageProcessConfig::GetInstance();
    std::string pkgName = "LoadPackageToDeviceByConfig_failed_test";
    PackConfDetail packConfDetail;
    packConfDetail.hostTruePath = "tmp123";
    pkgConInst->configMap_[pkgName] = packConfDetail;
    MOCKER_CPP(&PackageLoader::SupportLoadPkg).stubs().will(returnValue(true));
    std::string hashcode = "12345666";
    MOCKER(CalFileSha256HashValue).stubs().will(returnValue(hashcode));
    MOCKER_CPP(&PackageHashStore::IsCommonSinkHostAndDevicePkgSame).stubs().will(returnValue(false));
    MOCKER_CPP(&PackageSender::CompareAndSendCommonSinkPkg).stubs().will(returnValue(tsd::TSD_OK));
    processModeManager.sharedCtx_.rspCode = ResponseCode::FAIL;
    processModeManager.GetPackageManager().ctx_.loadPackageErrorMsg =
        "cms verify failed. certType [XXX] does not match verifyFlag [XXX]";
    auto ret = processModeManager.GetPackageManager().LoadPackageToDeviceByConfig();
    EXPECT_EQ(ret, tsd::TSD_INTERNAL_ERROR);
    EXPECT_TRUE(processModeManager.GetPackageManager().ctx_.loadPackageErrorMsg.empty());
}

TEST_F(PackageLoaderComponentTest, LoadPackageToDeviceByConfig_VerifyFlagNotClose_ClearsErrorAndReturnsInternalError)
{
    MOCKER_CPP(&CapabilityManager::IsSupportCommonInterface).stubs().will(returnValue(true));
    MOCKER(drvHdcGetTrustedBasePathV2).stubs().will(returnValue(0));
    MOCKER(drvHdcSendFileV2).stubs().will(returnValue(0));
    MOCKER_CPP(&ClientManager::IsAdcEnv).stubs().will(returnValue(false));
    ProcessModeManager processModeManager(deviceId, 0);
    PackageProcessConfig* pkgConInst = PackageProcessConfig::GetInstance();
    std::string pkgName = "LoadPackageToDeviceByConfig_failed_test";
    PackConfDetail packConfDetail;
    packConfDetail.hostTruePath = "tmp123";
    pkgConInst->configMap_[pkgName] = packConfDetail;
    MOCKER_CPP(&PackageLoader::SupportLoadPkg).stubs().will(returnValue(true));
    std::string hashcode = "12345666";
    MOCKER(CalFileSha256HashValue).stubs().will(returnValue(hashcode));
    MOCKER_CPP(&PackageHashStore::IsCommonSinkHostAndDevicePkgSame).stubs().will(returnValue(false));
    MOCKER_CPP(&PackageSender::CompareAndSendCommonSinkPkg).stubs().will(returnValue(tsd::TSD_OK));
    processModeManager.sharedCtx_.rspCode = ResponseCode::FAIL;
    processModeManager.GetPackageManager().ctx_.loadPackageErrorMsg =
        "cms verify failed. verifyFlag is not [Close], verifyFlag[XXX]";
    auto ret = processModeManager.GetPackageManager().LoadPackageToDeviceByConfig();
    EXPECT_EQ(ret, tsd::TSD_INTERNAL_ERROR);
    EXPECT_TRUE(processModeManager.GetPackageManager().ctx_.loadPackageErrorMsg.empty());
}

TEST_F(
    PackageLoaderComponentTest,
    LoadPackageToDeviceByConfig_SignatureVerificationFails_ClearsErrorAndReturnsInternalError)
{
    MOCKER_CPP(&CapabilityManager::IsSupportCommonInterface).stubs().will(returnValue(true));
    MOCKER(drvHdcGetTrustedBasePathV2).stubs().will(returnValue(0));
    MOCKER(drvHdcSendFileV2).stubs().will(returnValue(0));
    MOCKER_CPP(&ClientManager::IsAdcEnv).stubs().will(returnValue(false));
    ProcessModeManager processModeManager(deviceId, 0);
    PackageProcessConfig* pkgConInst = PackageProcessConfig::GetInstance();
    std::string pkgName = "LoadPackageToDeviceByConfig_failed_test";
    PackConfDetail packConfDetail;
    packConfDetail.hostTruePath = "tmp123";
    pkgConInst->configMap_[pkgName] = packConfDetail;
    MOCKER_CPP(&PackageLoader::SupportLoadPkg).stubs().will(returnValue(true));
    std::string hashcode = "12345666";
    MOCKER(CalFileSha256HashValue).stubs().will(returnValue(hashcode));
    MOCKER_CPP(&PackageHashStore::IsCommonSinkHostAndDevicePkgSame).stubs().will(returnValue(false));
    MOCKER_CPP(&PackageSender::CompareAndSendCommonSinkPkg).stubs().will(returnValue(tsd::TSD_OK));
    processModeManager.sharedCtx_.rspCode = ResponseCode::FAIL;
    processModeManager.GetPackageManager().ctx_.loadPackageErrorMsg =
        "cms verify failed. Signature verification failed.";
    auto ret = processModeManager.GetPackageManager().LoadPackageToDeviceByConfig();
    EXPECT_EQ(ret, tsd::TSD_INTERNAL_ERROR);
    EXPECT_TRUE(processModeManager.GetPackageManager().ctx_.loadPackageErrorMsg.empty());
}

TEST_F(PackageLoaderComponentTest, IsOkToLoadFileRejectsNullEmptyAndTooLongNames)
{
    ProcessModeManager manager(deviceId, 0);
    const std::string tooLongName(256U, 'n');

    EXPECT_FALSE(manager.GetPackageManager().loader_.IsOkToLoadFileToDevice(nullptr, 1U));
    EXPECT_FALSE(manager.GetPackageManager().loader_.IsOkToLoadFileToDevice("x", 0U));
    EXPECT_FALSE(manager.GetPackageManager().loader_.IsOkToLoadFileToDevice(tooLongName.c_str(), tooLongName.size()));
}

TEST_F(PackageLoaderComponentTest, IsOkToLoadFileAcceptsMaximumValidName)
{
    ProcessModeManager manager(deviceId, 0);
    const std::string maxValidName(255U, 'n');
    MOCKER_CPP(&CapabilityManager::IsSupportCommonInterface).stubs().will(returnValue(true));

    EXPECT_TRUE(manager.GetPackageManager().loader_.IsOkToLoadFileToDevice(maxValidName.c_str(), maxValidName.size()));
}

TEST_F(PackageLoaderComponentTest, LoadOmFileRejectsInvalidPathLengths)
{
    ProcessModeManager manager(deviceId, 0);
    const MessageContext ctx{};
    const std::string tooLongPath(4096U, 'p');

    EXPECT_EQ(
        manager.GetPackageManager().loader_.LoadOmFileToDevice(nullptr, 1U, "model.om", 8U, ctx), TSD_INTERNAL_ERROR);
    EXPECT_EQ(manager.GetPackageManager().loader_.LoadOmFileToDevice("/", 0U, "model.om", 8U, ctx), TSD_INTERNAL_ERROR);
    EXPECT_EQ(
        manager.GetPackageManager().loader_.LoadOmFileToDevice(
            tooLongPath.c_str(), tooLongPath.size(), "model.om", 8U, ctx),
        TSD_INTERNAL_ERROR);
}

TEST_F(PackageLoaderComponentTest, LoadOmFileAcceptsMaximumValidPathBeforeSendFailure)
{
    ProcessModeManager manager(deviceId, 0);
    const std::string maxValidPath(4095U, 'p');
    MOCKER_CPP(&PackageSender::SendFileToDevice)
        .stubs()
        .will(returnValue(static_cast<TSD_StatusT>(TSD_DEVICEID_ERROR)));

    EXPECT_EQ(
        manager.GetPackageManager().loader_.LoadOmFileToDevice(
            maxValidPath.c_str(), maxValidPath.size(), "model.om", 8U, MessageContext{}),
        TSD_DEVICEID_ERROR);
}

TEST_F(PackageLoaderComponentTest, LoadOmFileReturnsInitClientFailureAfterSendingFile)
{
    ProcessModeManager manager(deviceId, 0);
    MOCKER_CPP(&PackageSender::SendFileToDevice).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageCheckCodeService::InitTsdClient)
        .stubs()
        .will(returnValue(static_cast<TSD_StatusT>(TSD_CLT_OPEN_FAILED)));

    EXPECT_EQ(
        manager.GetPackageManager().loader_.LoadOmFileToDevice("/tmp", 4U, "model.om", 8U, MessageContext{}),
        TSD_CLT_OPEN_FAILED);
}

TEST_F(PackageLoaderComponentTest, LoadOmFileRejectsMissingDeviceCommAfterInitialization)
{
    ProcessModeManager manager(deviceId, 0);
    MOCKER_CPP(&PackageSender::SendFileToDevice).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageCheckCodeService::InitTsdClient).stubs().will(returnValue(TSD_OK));

    EXPECT_EQ(
        manager.GetPackageManager().loader_.LoadOmFileToDevice("/tmp", 4U, "model.om", 8U, MessageContext{}),
        TSD_INSTANCE_NOT_FOUND);
}

TEST_F(PackageLoaderComponentTest, LoadOmFileReturnsMessageBuildFailure)
{
    ProcessModeManager manager(deviceId, 0);
    (void)InjectPackageStubComm(manager, deviceId);
    MOCKER_CPP(&PackageSender::SendFileToDevice).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageCheckCodeService::InitTsdClient).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&HdcMessageBuilder::BuildOmFileDecompress)
        .stubs()
        .will(returnValue(static_cast<TSD_StatusT>(TSD_INTERNAL_ERROR)));

    EXPECT_EQ(
        manager.GetPackageManager().loader_.LoadOmFileToDevice("/tmp", 4U, "model.om", 8U, MessageContext{}),
        TSD_INTERNAL_ERROR);
}

TEST_F(PackageLoaderComponentTest, LoadOmFileReturnsMessageSendFailure)
{
    ProcessModeManager manager(deviceId, 0);
    auto comm = InjectPackageStubComm(manager, deviceId);
    comm->commSendMsgRet_ = TSD_HDC_SERVER_CLIENT_SOCKET_CLOSED;
    MOCKER_CPP(&PackageSender::SendFileToDevice).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageCheckCodeService::InitTsdClient).stubs().will(returnValue(TSD_OK));

    EXPECT_EQ(
        manager.GetPackageManager().loader_.LoadOmFileToDevice("/tmp", 4U, "model.om", 8U, MessageContext{}),
        TSD_HDC_SERVER_CLIENT_SOCKET_CLOSED);
    EXPECT_EQ(comm->sendCount_, 1);
    EXPECT_EQ(comm->lastMsg_.type(), HDCMessage::TSD_OM_PKG_DECOMPRESS_STATUS);
}

TEST_F(PackageLoaderComponentTest, LoadOmFileReturnsWaitResponseFailure)
{
    ProcessModeManager manager(deviceId, 0);
    auto comm = InjectPackageStubComm(manager, deviceId);
    MOCKER_CPP(&PackageSender::SendFileToDevice).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageCheckCodeService::InitTsdClient).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageCheckCodeService::WaitPkgRsp)
        .stubs()
        .will(returnValue(static_cast<TSD_StatusT>(TSD_INTERNAL_ERROR)));

    EXPECT_EQ(
        manager.GetPackageManager().loader_.LoadOmFileToDevice("/tmp", 4U, "model.om", 8U, MessageContext{}),
        TSD_INTERNAL_ERROR);
    EXPECT_EQ(comm->sendCount_, 1);
}

TEST_F(PackageLoaderComponentTest, LoadOmFileSendsPidPrefixedNameAndSucceeds)
{
    ProcessModeManager manager(deviceId, 0);
    auto comm = InjectPackageStubComm(manager, deviceId);
    manager.commAgent_.procSign_.tgid = 321;
    MOCKER_CPP(&PackageSender::SendFileToDevice).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageCheckCodeService::InitTsdClient).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageCheckCodeService::WaitPkgRsp).stubs().will(returnValue(TSD_OK));

    EXPECT_EQ(
        manager.GetPackageManager().loader_.LoadOmFileToDevice("/tmp", 4U, "model.om", 8U, MessageContext{}), TSD_OK);
    EXPECT_EQ(comm->lastMsg_.omfile_name(), "321_model.om");
}

TEST_F(PackageLoaderComponentTest, LoadFileDispatchesRuntimeAndDshapePackages)
{
    ProcessModeManager manager(deviceId, 0);
    const std::string runtimePkg = "Ascend-runtime_device-minios.tar.gz";
    const std::string dshapePkg = "Ascend-opp_rt-minios.aarch64.tar.gz";
    MOCKER_CPP(&CapabilityManager::IsSupportCommonInterface).stubs().will(returnValue(true));
    MOCKER_CPP(&PackageLoader::LoadRuntimePkgToDevice)
        .stubs()
        .will(returnValue(static_cast<TSD_StatusT>(TSD_DEVICEID_ERROR)));
    MOCKER_CPP(&PackageLoader::LoadDShapePkgToDevice)
        .stubs()
        .will(returnValue(static_cast<TSD_StatusT>(TSD_INTERNAL_ERROR)));

    EXPECT_EQ(
        manager.GetPackageManager().loader_.LoadFileToDevice(
            "/tmp", 4U, runtimePkg.c_str(), runtimePkg.size(), MessageContext{}),
        TSD_DEVICEID_ERROR);
    EXPECT_EQ(
        manager.GetPackageManager().loader_.LoadFileToDevice(
            "/tmp", 4U, dshapePkg.c_str(), dshapePkg.size(), MessageContext{}),
        TSD_INTERNAL_ERROR);
}

TEST_F(PackageLoaderComponentTest, LoadFileDispatchesOmPackageThroughFullSendFlow)
{
    ProcessModeManager manager(deviceId, 0);
    auto comm = InjectPackageStubComm(manager, deviceId);
    MOCKER_CPP(&CapabilityManager::IsSupportCommonInterface).stubs().will(returnValue(true));
    MOCKER_CPP(&PackageSender::SendFileToDevice).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageCheckCodeService::InitTsdClient).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageCheckCodeService::WaitPkgRsp).stubs().will(returnValue(TSD_OK));

    EXPECT_EQ(
        manager.GetPackageManager().loader_.LoadFileToDevice("/tmp", 4U, "network.om", 10U, MessageContext{}), TSD_OK);
    EXPECT_EQ(comm->sendCount_, 1);
}

TEST_F(PackageLoaderComponentTest, LoadFileRejectsNullFileNameBeforeDispatch)
{
    ProcessModeManager manager(deviceId, 0);

    EXPECT_EQ(
        manager.GetPackageManager().loader_.LoadFileToDevice("/tmp", 4U, nullptr, 1U, MessageContext{}),
        TSD_INTERNAL_ERROR);
}

TEST_F(PackageLoaderComponentTest, SendAllPackagesReturnsAscendCppFailure)
{
    ProcessModeManager manager(deviceId, 0);
    MOCKER(drvHdcGetTrustedBasePath).stubs().will(returnValue(DRV_ERROR_NONE));
    MOCKER_CPP(&PackageSender::SendAICPUPackage).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageSender::SendCommonPackage)
        .stubs()
        .will(returnValue(TSD_OK))
        .then(returnValue(static_cast<TSD_StatusT>(TSD_INTERNAL_ERROR)));

    EXPECT_EQ(manager.GetPackageManager().loader_.SendAllPackagesToPeer(), TSD_INTERNAL_ERROR);
}

TEST_F(PackageLoaderComponentTest, LoadFileAndWaitRspReturnsSendAndCheckCodeFailures)
{
    ProcessModeManager manager(deviceId, 0);
    MOCKER_CPP(&PackageSender::SendAICPUPackageSimple)
        .stubs()
        .will(returnValue(static_cast<TSD_StatusT>(TSD_DEVICEID_ERROR)))
        .then(returnValue(TSD_OK));
    MOCKER_CPP(&PackageCheckCodeService::GetCannHsPkgCheckCode)
        .stubs()
        .will(returnValue(static_cast<TSD_StatusT>(TSD_INTERNAL_ERROR)));

    EXPECT_EQ(
        manager.GetPackageManager().loader_.LoadFileAndWaitRsp(
            "pkg.tar.gz", "hash", 0, "/tmp/pkg.tar.gz", "/device", MessageContext{}),
        TSD_INTERNAL_ERROR);
    EXPECT_EQ(
        manager.GetPackageManager().loader_.LoadFileAndWaitRsp(
            "pkg.tar.gz", "hash", 0, "/tmp/pkg.tar.gz", "/device", MessageContext{}),
        TSD_INTERNAL_ERROR);
}

TEST_F(PackageLoaderComponentTest, LoadCannHsPackageSkipsMissingOptionalPackage)
{
    ProcessModeManager manager(deviceId, 0);
    MOCKER_CPP(&PackageProcessConfig::GetPkgHostAndDeviceDstPath)
        .expects(once())
        .with(eq(std::string("optional.tar.gz")), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(TSD_OK));
    MOCKER(CalFileSha256HashValue).expects(never());
    MOCKER_CPP(&PackageSender::SendAICPUPackageSimple).expects(never());
    MOCKER_CPP(&PackageCheckCodeService::GetCannHsPkgCheckCode).expects(never());
    MOCKER_CPP(&PackageCheckCodeService::WaitPkgRsp).expects(never());

    EXPECT_EQ(manager.GetPackageManager().loader_.LoadCannHsPkgToDevice("optional.tar.gz", MessageContext{}), TSD_OK);
}

TEST_F(PackageLoaderComponentTest, LoadCannHsPackageRejectsDeviceResponseError)
{
    ProcessModeManager manager(deviceId, 0);
    PackConfDetail config{};
    config.hostTruePath = "/tmp/pkg.tar.gz";
    PackageProcessConfig::GetInstance()->configMap_["pkg.tar.gz"] = config;
    MOCKER(CalFileSha256HashValue).stubs().will(returnValue(std::string("hash")));
    MOCKER_CPP(&PackageHashStore::IsCommonSinkHostAndDevicePkgSame).stubs().will(returnValue(false));
    MOCKER_CPP(&PackageLoader::LoadFileAndWaitRsp).stubs().will(returnValue(TSD_OK));
    manager.GetPackageManager().ctx_.pkgRspCode = ResponseCode::FAIL;

    EXPECT_EQ(
        manager.GetPackageManager().loader_.LoadCannHsPkgToDevice("pkg.tar.gz", MessageContext{}), TSD_INTERNAL_ERROR);
}

TEST_F(PackageLoaderComponentTest, LoadRuntimePackageReportsSecondCompatPackageFailure)
{
    ProcessModeManager manager(deviceId, 0);
    MOCKER_CPP(&CapabilityManager::IsSupportCommonSink).stubs().will(returnValue(true));
    MOCKER_CPP(&PackageLoader::LoadPackageConfigInfoToDevice).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageLoader::LoadCannHsPkgToDevice)
        .expects(once())
        .with(eq(std::string("cann-udf-compat.tar.gz")), mockcpp::any())
        .will(returnValue(TSD_OK))
        .id("load_udf");
    MOCKER_CPP(&PackageLoader::LoadCannHsPkgToDevice)
        .expects(once())
        .with(eq(std::string("cann-hccd-compat.tar.gz")), mockcpp::any())
        .after("load_udf")
        .will(returnValue(static_cast<TSD_StatusT>(TSD_INTERNAL_ERROR)));

    EXPECT_EQ(manager.GetPackageManager().loader_.LoadRuntimePkgToDevice(MessageContext{}), TSD_INTERNAL_ERROR);
}

TEST_F(PackageLoaderComponentTest, LoadHsPackageReturnsMissingFileFailure)
{
    ProcessModeManager manager(deviceId, 0);
    MOCKER(mmAccess).stubs().will(returnValue(EN_OK)).then(returnValue(EN_ERROR));
    MOCKER(mmIsDir).stubs().will(returnValue(EN_OK));

    EXPECT_EQ(
        manager.GetPackageManager().loader_.LoadHsPkgToDevice(
            "pkg.tar.gz", "runtime/lib64/", TsdLoadPackageType::TSD_PKG_TYPE_RUNTIME,
            HDCMessage::TSD_GET_DEVICE_RUNTIME_CHECKCODE, MessageContext{}),
        TSD_INTERNAL_ERROR);
}

TEST_F(PackageLoaderComponentTest, LoadHsPackageReturnsCheckCodeResponseFailure)
{
    ProcessModeManager manager(deviceId, 0);
    MOCKER(mmAccess).stubs().will(returnValue(EN_OK));
    MOCKER(mmIsDir).stubs().will(returnValue(EN_OK));
    MOCKER(CalFileSize).stubs().will(returnValue(1U));
    MOCKER_CPP(&PackageSender::SendFileToDevice).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageCheckCodeService::GetDeviceHsPkgCheckCode)
        .stubs()
        .will(returnValue(static_cast<TSD_StatusT>(TSD_INTERNAL_ERROR)));

    EXPECT_EQ(manager.GetPackageManager().loader_.LoadDShapePkgToDevice(MessageContext{}), TSD_INTERNAL_ERROR);
}

TEST_F(PackageLoaderComponentTest, LoadPackageConfigSkipsUnsupportedAdcAndRepeatedSend)
{
    ProcessModeManager manager(deviceId, 0);
    auto& loader = manager.GetPackageManager().loader_;
    MOCKER_CPP(&CapabilityManager::IsSupportCommonSink).stubs().will(returnValue(false));
    EXPECT_EQ(loader.LoadPackageConfigInfoToDevice(false), TSD_OK);

    GlobalMockObject::reset();
    MOCKER_CPP(&CapabilityManager::IsSupportCommonSink).stubs().will(returnValue(true));
    manager.GetPackageManager().envInfo_.isAdcEnv_ = true;
    EXPECT_EQ(loader.LoadPackageConfigInfoToDevice(false), TSD_OK);

    manager.GetPackageManager().envInfo_.isAdcEnv_ = false;
    loader.hasSendConfigFile_ = true;
    EXPECT_EQ(loader.LoadPackageConfigInfoToDevice(false), TSD_OK);
    EXPECT_TRUE(loader.hasSendConfigFile_);
}

TEST_F(PackageLoaderComponentTest, LoadPackageConfigReturnsInitAndMissingCommFailures)
{
    ProcessModeManager manager(deviceId, 0);
    MOCKER_CPP(&CapabilityManager::IsSupportCommonSink).stubs().will(returnValue(true));
    MOCKER_CPP(&PackageCheckCodeService::InitTsdClient)
        .stubs()
        .will(returnValue(static_cast<TSD_StatusT>(TSD_CLT_OPEN_FAILED)))
        .then(returnValue(TSD_OK));

    EXPECT_EQ(manager.GetPackageManager().loader_.LoadPackageConfigInfoToDevice(false), TSD_INTERNAL_ERROR);
    EXPECT_EQ(manager.GetPackageManager().loader_.LoadPackageConfigInfoToDevice(false), TSD_INSTANCE_NOT_FOUND);
}

TEST_F(PackageLoaderComponentTest, LoadPackageConfigReturnsParseAndBuildFailures)
{
    ProcessModeManager manager(deviceId, 0);
    (void)InjectPackageStubComm(manager, deviceId);
    MOCKER_CPP(&CapabilityManager::IsSupportCommonSink).stubs().will(returnValue(true));
    MOCKER_CPP(&PackageCheckCodeService::InitTsdClient).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageProcessConfig::ParseConfigDataFromFile)
        .stubs()
        .will(returnValue(static_cast<TSD_StatusT>(TSD_INTERNAL_ERROR)))
        .then(returnValue(TSD_OK));
    MOCKER_CPP(&PackageProcessConfig::RefreshHostPluginVersions).stubs();
    MOCKER_CPP(&HdcMessageBuilder::BuildUpdatePackageConfig)
        .stubs()
        .will(returnValue(static_cast<TSD_StatusT>(TSD_INTERNAL_ERROR)));

    EXPECT_EQ(manager.GetPackageManager().loader_.LoadPackageConfigInfoToDevice(false), TSD_INTERNAL_ERROR);
    EXPECT_EQ(manager.GetPackageManager().loader_.LoadPackageConfigInfoToDevice(true), TSD_INTERNAL_ERROR);
}

TEST_F(PackageLoaderComponentTest, LoadPackageConfigReturnsSendFailure)
{
    ProcessModeManager manager(deviceId, 0);
    auto comm = InjectPackageStubComm(manager, deviceId);
    comm->commSendMsgRet_ = TSD_INTERNAL_ERROR;
    MOCKER_CPP(&CapabilityManager::IsSupportCommonSink).stubs().will(returnValue(true));
    MOCKER_CPP(&PackageCheckCodeService::InitTsdClient).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageProcessConfig::ParseConfigDataFromFile).stubs().will(returnValue(TSD_OK));

    EXPECT_EQ(manager.GetPackageManager().loader_.LoadPackageConfigInfoToDevice(false), TSD_INTERNAL_ERROR);
    EXPECT_EQ(comm->sendCount_, 1);
    EXPECT_FALSE(manager.GetPackageManager().loader_.hasSendConfigFile_);
}

TEST_F(PackageLoaderComponentTest, LoadSinglePackageSkipsOptionalAndPluginStrategyPackages)
{
    ProcessModeManager manager(deviceId, 0);
    PackConfDetail detail{};
    detail.loadAsPerSocFlag = true;
    PackConfDetail optionalConfig{};
    optionalConfig.optionalFlag = true;
    PackageProcessConfig::GetInstance()->configMap_["optional.tar.gz"] = optionalConfig;
    EXPECT_EQ(
        manager.GetPackageManager().loader_.LoadSinglePackageToDevice("optional.tar.gz", detail, 0, "/dst"), TSD_OK);

    PackConfDetail pluginConfig{};
    pluginConfig.hostTruePath = "/tmp/pkg.tar.gz";
    PackageProcessConfig::GetInstance()->configMap_["plugin.tar.gz"] = pluginConfig;
    MOCKER(CalFileSha256HashValue).stubs().will(returnValue(std::string("hash")));
    MOCKER_CPP(&PluginVersionManager::IsCompatPluginPackage).stubs().will(returnValue(true));
    MOCKER_CPP(&PluginVersionManager::ShouldLoadCompatPluginPkg).stubs().will(returnValue(false));
    EXPECT_EQ(
        manager.GetPackageManager().loader_.LoadSinglePackageToDevice("plugin.tar.gz", detail, 0, "/dst"), TSD_OK);
}

TEST_F(PackageLoaderComponentTest, LoadSinglePackageReturnsCompareAndSendFailure)
{
    ProcessModeManager manager(deviceId, 0);
    PackConfDetail detail{};
    detail.loadAsPerSocFlag = true;
    PackConfDetail config{};
    config.hostTruePath = "/tmp/pkg.tar.gz";
    PackageProcessConfig::GetInstance()->configMap_["pkg.tar.gz"] = config;
    MOCKER(CalFileSha256HashValue).stubs().will(returnValue(std::string("hash")));
    MOCKER_CPP(&PluginVersionManager::IsCompatPluginPackage).stubs().will(returnValue(false));
    MOCKER_CPP(&PackageHashStore::IsCommonSinkHostAndDevicePkgSame).stubs().will(returnValue(false));
    MOCKER_CPP(&PackageSender::CompareAndSendCommonSinkPkg)
        .stubs()
        .will(returnValue(static_cast<TSD_StatusT>(TSD_INTERNAL_ERROR)));

    EXPECT_EQ(
        manager.GetPackageManager().loader_.LoadSinglePackageToDevice("pkg.tar.gz", detail, 0, "/dst"),
        TSD_INTERNAL_ERROR);
}

TEST_F(PackageLoaderComponentTest, LoadPackageByConfigReturnsTrustedPathFailure)
{
    ProcessModeManager manager(deviceId, 0);
    MOCKER_CPP(&CapabilityManager::IsSupportCommonSink).stubs().will(returnValue(true));
    MOCKER_CPP(&PackageEnvInfo::GetTrustedBasePathFromDevice)
        .stubs()
        .will(returnValue(static_cast<TSD_StatusT>(TSD_INTERNAL_ERROR)));

    EXPECT_EQ(manager.GetPackageManager().loader_.LoadPackageToDeviceByConfig(), TSD_INTERNAL_ERROR);
}
