/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "info_json.h"
#include "inttypes.h"
#include "json_generator.h"
#include "json_parser.h"
#include "utils/utils.h"
#include "logger/logger.h"
#include "errno/error_code.h"
#include "osal/osal_mem.h"
#include "osal/osal.h"
#include "transport/uploader.h"
#include "hal/hal_dsmi.h"
#include "platform/platform.h"

static InfoAttr *g_infoJson = NULL;

const char *const PROF_NET_CARD = "/sys/class/net";
const char *const PROF_PROC_MEM = "/proc/meminfo";
const char *const PROF_PROC_UPTIME = "/proc/uptime";
const char *const PROC_NET_SPEED = "speed";
const char *const PROF_START_INFO = "start_info";
const char *const PROF_END_INFO = "end_info";

typedef struct {
    int32_t id;
    char name[CPU_TYPE_NAME_LEN];
} CpuTypes;

static const CpuTypes CPU_TYPES[] = {
    {0x41d03, "ARMv8_Cortex_A53"},
    {0x41d05, "ARMv8_Cortex_A55"},
    {0x41d07, "ARMv8_Cortex_A57"},
    {0x41d08, "ARMv8_Cortex_A72"},
    {0x41d09, "ARMv8_Cortex_A73"},
    {0x48d01, "TaishanV110"},
};

/**
 * @brief Calloc for info json
 * @return PROFILING_SUCCESS
           PROFILING_FAILED
 */
static int32_t InitInfoJson(void)
{
    if (g_infoJson != NULL) {
        MSPROF_LOGW("Info json pointer is not null, may retain latest info.");
    }
    g_infoJson = (InfoAttr*)OsalCalloc(sizeof(InfoAttr));
    if (g_infoJson == NULL) {
        MSPROF_LOGE("Failed to calloc info attribute.");
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

/**
 * @brief Get cpu id string
 * @param [out] cpuStr    : cpu id string
 * @param [in]  cpuStrLen : size of cpu id string space
 * @param [in]  begin     : begin id of cpu
 * @param [in]  num       : max number of cpu id
 */
static void CreateCpuIdString(char* cpuStr, size_t cpuStrLen, int64_t begin, int64_t num)
{
    errno_t ret;
    for (int64_t id = begin; id < num; ++id) {
        char* str = TransferUint32ToString((uint32_t)id);
        ret = strcat_s(cpuStr, cpuStrLen, str);
        OSAL_MEM_FREE(str);
        PROF_CHK_EXPR_ACTION(ret != EOK, return, "Faild to strcat_s for CreateCpuIdString.");
    }
}

/**
 * @brief Get device and host freq string
 * @param [in] deviceId : device id
 */
static void CreateFreqString(uint32_t deviceId)
{
    // ai core freq 驱动暂不支持动态获取频率
    char* aicFreq = TransferUint32ToString(PlatformGetAicFreq());
    errno_t ret = strcat_s(g_infoJson->deviceInfos.aicFrequency, MAX_FREQ_LEN, aicFreq);
    OSAL_MEM_FREE(aicFreq);
    PROF_CHK_EXPR_ACTION(ret != EOK, return, "Faild to strcat_s for aicFreq: %u.",
        PlatformGetAicFreq());
    char* aivFreq = TransferUint32ToString(PlatformGetAivFreq());
    ret = strcat_s(g_infoJson->deviceInfos.aivFrequency, MAX_FREQ_LEN, aivFreq);
    OSAL_MEM_FREE(aivFreq);
    PROF_CHK_EXPR_ACTION(ret != EOK, return, "Faild to strcat_s for aivFreq: %u.",
        PlatformGetAivFreq());
    // hwts freq
    char* hwtsFreq = TransferFloatToString(PlatformGetDevFreq(deviceId));
    ret = strcat_s(g_infoJson->deviceInfos.hwtsFrequency, MAX_FREQ_LEN, hwtsFreq);
    OSAL_MEM_FREE(hwtsFreq);
    PROF_CHK_EXPR_ACTION(ret != EOK, return, "Faild to strcat_s for hwtsFreq: %.4f.",
        PlatformGetDevFreq(deviceId));
}

/**
 * @brief Get device info attributes
 * @param [in]  deviceId : device id
 * @param [out] devInfo  : device info pointer
 * @return PROFILING_SUCCESS
           PROFILING_FAILED
 */
static int32_t GetDevInfo(uint32_t deviceId, DeviceInfo *devInfo)
{
    int64_t ret = HalGetEnvType(deviceId);
    PROF_CHK_EXPR_ACTION(ret == PROFILING_FAILED, return PROFILING_FAILED,
        "Failed to HalGetEnvType, deviceId: %d", deviceId);
    devInfo->envType = ret;
    ret = HalGetCtrlCpuId(deviceId);
    PROF_CHK_EXPR_ACTION(ret == PROFILING_FAILED, return PROFILING_FAILED,
        "Failed to HalGetCtrlCpuId, deviceId: %d", deviceId);
    devInfo->ctrlCpuId = ret;
    ret = HalGetCtrlCpuCoreNum(deviceId);
    PROF_CHK_EXPR_ACTION(ret == PROFILING_FAILED, return PROFILING_FAILED,
        "Failed to HalGetCtrlCpuCoreNum, deviceId: %d", deviceId);
    devInfo->ctrlCpuCoreNum = ret;
    ret = HalGetCtrlCpuEndianLittle(deviceId);
    PROF_CHK_EXPR_ACTION(ret == PROFILING_FAILED, return PROFILING_FAILED,
        "Failed to HalGetCtrlCpuEndianLittle, deviceId: %d", deviceId);
    devInfo->ctrlCpuEndianLittle = ret;
    ret = HalGetAiCpuCoreNum(deviceId);
    PROF_CHK_EXPR_ACTION(ret == PROFILING_FAILED, return PROFILING_FAILED,
        "Failed to HalGetAiCpuCoreNum, deviceId: %d", deviceId);
    devInfo->aiCpuCoreNum = ret;
    if (devInfo->aiCpuCoreNum != 0) {
        ret = HalGetAiCpuCoreId(deviceId);
        PROF_CHK_EXPR_ACTION(ret == PROFILING_FAILED, return PROFILING_FAILED,
            "Failed to HalGetAiCpuCoreId, deviceId: %d", deviceId);
        devInfo->aiCpuCoreId = ret;
    }
    ret = HalGetAiCpuOccupyBitmap(deviceId);
    PROF_CHK_EXPR_ACTION(ret == PROFILING_FAILED, return PROFILING_FAILED,
        "Failed to HalGetAiCpuOccupyBitmap, deviceId: %d", deviceId);
    devInfo->aiCpuOccupyBitMap = ret;
    ret = HalGetTsCpuCoreNum(deviceId);
    PROF_CHK_EXPR_ACTION(ret == PROFILING_FAILED, return PROFILING_FAILED,
        "Failed to HalGetTsCpuCoreNum, deviceId: %d", deviceId);
    devInfo->tsCpuCoreNum = ret;
    ret = HalGetAiCoreId(deviceId);
    PROF_CHK_EXPR_ACTION(ret == PROFILING_FAILED, return PROFILING_FAILED,
        "Failed to HalGetAiCoreId, deviceId: %d", deviceId);
    devInfo->aiCoreId = ret;
    ret = HalGetAiCoreNum(deviceId);
    PROF_CHK_EXPR_ACTION(ret == PROFILING_FAILED, return PROFILING_FAILED,
        "Failed to HalGetAiCoreNum, deviceId: %d", deviceId);
    devInfo->aiCoreNum = ret;
    ret = HalGetAiVectorCoreNum(deviceId);
    PROF_CHK_EXPR_ACTION(ret == PROFILING_FAILED, return PROFILING_FAILED,
        "Failed to HalGetAiVectorCoreNum, deviceId: %d", deviceId);
    devInfo->aivNum = ret;
    return PROFILING_SUCCESS;
}

/**
 * @brief Get total memory information from /proc/meminfo
 */
static void CreateMemTotal()
{
#if (defined(linux) || defined(__linux__))
    char buf[MAX_MEM_TOTAL_BUF] = { 0 };
    uint64_t memTotal = 0;
    FILE *file = fopen(PROF_PROC_MEM, "r");
    PROF_CHK_WARN_ACTION(file == NULL, return, "Unable to open file %s", PROF_PROC_MEM);

    while (fgets(buf, sizeof(buf), file) != NULL) {
        if (sscanf_s(buf, "MemTotal: %llu", &memTotal) == 1) {
            g_infoJson->memoryTotal = memTotal;
            break;
        }
    }
    (void)fclose(file);
#endif
}

/**
 * @brief Get system clock freq and cpu nums
 */
static void CreateSysConf(void)
{
#if (defined(linux) || defined(__linux__))
    long tck = sysconf(_SC_CLK_TCK);
    PROF_CHK_WARN_ACTION(tck == -1, return, "The system clock cannot be obtained, code: %d.", OsalGetErrorCode());
    g_infoJson->sysClockFreq = (uint32_t)tck;

    long cpu = sysconf(_SC_NPROCESSORS_CONF);
    PROF_CHK_WARN_ACTION(cpu == -1, return, "The system cpu num cannot be obtained, code: %d.", OsalGetErrorCode());
    g_infoJson->cpuNums = (uint32_t)cpu;
#endif
}

/**
 * @brief Get system time from /proc/uptime
 */
static void CreateSysTime()
{
#if (defined(linux) || defined(__linux__))
    char buf[MAX_UP_TIME_LEN] = { 0 };
    FILE *file = fopen(PROF_PROC_UPTIME, "r");
    PROF_CHK_WARN_ACTION(file == NULL, return, "Unable to open file %s.", PROF_PROC_UPTIME);

    if (fgets(buf, sizeof(buf), file)) {
        errno_t ret = strcat_s(g_infoJson->upTime, MAX_UP_TIME_LEN, buf);
        PROF_CHK_EXPR_NO_ACTION(ret != EOK, "Failed to strcat_s for upTime.");
    }
    (void)fclose(file);
#endif
}

/**
 * @brief Get net card information
 */
static void CreateNetCardInfo(void)
{
    return;
}

/**
 * @brief Get cpu information
 * @return PROFILING_SUCCESS
           PROFILING_FAILED
 */
static int32_t CreateCpuInfo(void)
{
    OsalCpuDesc *cpuInfo = NULL;
    int32_t cpuNum = 0;
    int32_t retVal = OsalGetCpuInfo(&cpuInfo, &cpuNum);
    if (retVal != OSAL_EN_OK || cpuNum <= 0) {
        MSPROF_LOGE("Failed to get cpu info, ret: %d.", retVal);
        return PROFILING_FAILED;
    }
    errno_t ret = strcat_s(g_infoJson->hwtype, MAX_HW_TYPE_LEN, cpuInfo[0].arch);
    PROF_CHK_EXPR_ACTION_TWICE(ret != EOK, OsalCpuInfoFree(cpuInfo, cpuNum),
        return PROFILING_FAILED, "Failed to strcat_s for hwtype.");
    g_infoJson->cpuCores = (uint32_t)cpuNum;
    g_infoJson->infoCpus = (CpuInfo*)OsalCalloc(sizeof(CpuInfo) * cpuNum);
    PROF_CHK_EXPR_ACTION_TWICE(g_infoJson->infoCpus == NULL, OsalCpuInfoFree(cpuInfo, cpuNum),
        return PROFILING_FAILED, "Failed to malloc for infoCpus.");
    for (int32_t i = 0; i < cpuNum; i++) {
        g_infoJson->infoCpus[i].id = i;
        ret = strcat_s(g_infoJson->infoCpus[i].name, MAX_CPU_INFO_LEN, cpuInfo[i].manufacturer);
        PROF_CHK_EXPR_ACTION_NODO(ret != EOK, break, "Failed to strcat_s for infoCpus name.");
        uint64_t hostFreqNum = PlatformGetHostFreq();
        if (hostFreqNum > 0) {
            char* hostFreq = TransferUint64ToString(hostFreqNum);
            ret = strcat_s(g_infoJson->infoCpus[i].frequency, MAX_CPU_INFO_LEN, hostFreq);
            OSAL_MEM_FREE(hostFreq);
            PROF_CHK_EXPR_ACTION_NODO(ret != EOK, break, "Failed to strcat_s for infoCpus frequency.");
        }
        char* nthreads = NULL;
        if (cpuInfo[i].nthreads == 0) {
            nthreads = TransferUint32ToString((uint32_t)cpuInfo[i].ncounts);
        } else {
            nthreads = TransferUint32ToString((uint32_t)cpuInfo[i].nthreads);
        }
        ret = strcat_s(g_infoJson->infoCpus[i].logicalCpuCount, MAX_NUMBER_LEN, nthreads);
        OSAL_MEM_FREE(nthreads);
        PROF_CHK_EXPR_ACTION_NODO(ret != EOK, break, "Failed to strcat_s for infoCpus logicalCpuCount.");
        ret = strcat_s(g_infoJson->infoCpus[i].type, MAX_CPU_INFO_LEN, cpuInfo[i].version);
        PROF_CHK_EXPR_ACTION_NODO(ret != EOK, break, "Failed to strcat_s for infoCpus type.");
    }
    OsalCpuInfoFree(cpuInfo, cpuNum);
    return PROFILING_SUCCESS;
}

/**
 * @brief Get pid
 */
static void CreatePidInfo(void)
{
    int32_t pid = OsalGetPid();
    errno_t ret;
    static const int32_t INVALID_PID = -1;
    if (pid == INVALID_PID) {
        ret = strcat_s(g_infoJson->pid, MAX_NUMBER_LEN, "NA");
    } else {
        char* pidStr = TransferUint32ToString((uint32_t)pid);
        ret = strcat_s(g_infoJson->pid, MAX_NUMBER_LEN, pidStr);
        OSAL_MEM_FREE(pidStr);
    }
    PROF_CHK_EXPR_ACTION(ret != EOK, return, "Failed to strcat_s for pid info: %d.", pid);
}

/**
 * @brief Get rank id
 */
static void CreateRankId(void)
{
    static const int32_t INVALID_RANK_ID = -1;
    g_infoJson->rankId = INVALID_RANK_ID;
}

/**
 * @brief Get platform chip type
 */
static void CreatePlatFormVersion(void)
{
    // TODO
    errno_t ret = strcat_s(g_infoJson->jobInfo, MAX_JOB_INFO_LEN, "NA");
    PROF_CHK_EXPR_ACTION(ret != EOK, return, "Failed to strcat_s for job info.");
    // add chip id
    char* chipIdStr = TransferUint32ToString(HalGetChipVersion());
    ret = strcat_s(g_infoJson->platformVersion, MAX_PLAT_VER_LEN, chipIdStr);
    OSAL_MEM_FREE(chipIdStr);
    PROF_CHK_EXPR_ACTION(ret != EOK, return, "Failed to strcat_s for chip id.");
}

/**
 * @brief Get platform version info
 */
static void CreateVersionInfo(void)
{
    errno_t ret = strcat_s(g_infoJson->version, MAX_VER_INFO_LEN, PlatformGetVersionInfo());
    PROF_CHK_EXPR_ACTION(ret != EOK, return, "Failed to strcat_s for chip id.");
}

/**
 * @brief Get driver api version info
 */
static void CreateDrvVersion(void)
{
    g_infoJson->drvVersion = HalGetApiVersion();
}

/**
 * @brief Get device ids
 */
static void CreateDevices(void)
{
    uint32_t devNum = HalGetDeviceNumber();
    if (devNum == 0) {
        return;
    }
    uint32_t devIds[MAX_DEVICE_NUMS] = { 0 };
    uint32_t retVal = HalGetDeviceIds(devNum, devIds, MAX_DEVICE_NUMS);
    if (retVal == 0) {
        return;
    }
    errno_t ret;
    for (int32_t id = 0; id < MAX_DEVICE_NUMS; ++id) {
        if (devIds[id] == 0 && id != 0) {
            break;
        }
        char* devStr = TransferUint32ToString(devIds[id]);
        ret = strcat_s(g_infoJson->devices, MAX_DEV_CAT_LEN, devStr);
        OSAL_MEM_FREE(devStr);
        PROF_CHK_EXPR_ACTION(ret != EOK, return, "Failed to strcat_s for devices.");
    }
}

/**
 * @brief Get device information
 * @param [in] deviceId : device id
 * @return PROFILING_SUCCESS
           PROFILING_FAILED
 */
static int32_t AddDeviceInfo(uint32_t deviceId)
{
    if (deviceId == DEFAULT_HOST_ID) {
        return PROFILING_SUCCESS;
    }
    errno_t ret;
    DeviceInfo devInfo = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
    // device info
    if (GetDevInfo(deviceId, &devInfo) != PROFILING_SUCCESS) {
        MSPROF_LOGE("Faild to get device info.");
        return PROFILING_FAILED;
    }
    // ctrl cpu id
    for (uint32_t j = 0; j < sizeof(CPU_TYPES)/sizeof(CPU_TYPES[0]); ++j) {
        if (devInfo.ctrlCpuId == CPU_TYPES[j].id) {
            ret = strcat_s(g_infoJson->deviceInfos.ctrlCpuId,
                CPU_TYPE_NAME_LEN, CPU_TYPES[j].name);
            PROF_CHK_EXPR_ACTION(ret != EOK, return PROFILING_FAILED,
                "Faild to strcat_s for ctrlCpuId.");
        }
    }
    // ctrl cpu
    CreateCpuIdString(g_infoJson->deviceInfos.ctrlCpu, CPU_ID_STRING_LEN, 0,
        devInfo.ctrlCpuCoreNum);
    // ai cpu
    CreateCpuIdString(g_infoJson->deviceInfos.aiCpu, CPU_ID_STRING_LEN, devInfo.aiCpuCoreId,
        (devInfo.ctrlCpuCoreNum + devInfo.aiCpuCoreNum));
    // config
    g_infoJson->deviceInfos.id = deviceId;
    g_infoJson->deviceInfos.envType = devInfo.envType;
    g_infoJson->deviceInfos.ctrlCpuCoreNum = devInfo.ctrlCpuCoreNum;
    g_infoJson->deviceInfos.ctrlCpuEndianLittle = devInfo.ctrlCpuEndianLittle;
    g_infoJson->deviceInfos.tsCpuCoreNum = devInfo.tsCpuCoreNum;
    g_infoJson->deviceInfos.aiCpuCoreNum = devInfo.aiCpuCoreNum;
    g_infoJson->deviceInfos.aiCoreNum = devInfo.aiCoreNum;
    g_infoJson->deviceInfos.aiCpuCoreId = devInfo.aiCpuCoreId;
    g_infoJson->deviceInfos.aiCoreId = devInfo.aiCoreId;
    g_infoJson->deviceInfos.aiCpuOccupyBitMap = devInfo.aiCpuOccupyBitMap;
    g_infoJson->deviceInfos.aivNum = devInfo.aivNum;
    CreateFreqString(deviceId);
    return PROFILING_SUCCESS;
}

/**
 * @brief Get host information
 * @return PROFILING_SUCCESS
           PROFILING_FAILED
 */
static int32_t AddHostInfo()
{
    char str[MAX_PATH_LEN] = { 0 };
    int32_t retVal = OsalGetOsVersion(str, MAX_PATH_LEN);
    PROF_CHK_WARN_NO_ACTION(retVal != OSAL_EN_OK,
        "An exception was detected when obtaining os version, ret is %d.", retVal);
    errno_t ret = strcat_s(g_infoJson->os, MAX_PATH_LEN, str);
    PROF_CHK_EXPR_ACTION(ret != EOK, return PROFILING_FAILED, "Failed to strcat_s for os.");
    (void)memset_s(str, MAX_PATH_LEN, 0, MAX_PATH_LEN);

    ret = strcat_s(g_infoJson->hostname, MAX_PATH_LEN, "LiteOs");
    PROF_CHK_EXPR_ACTION(ret != EOK, return PROFILING_FAILED, "Failed to strcat_s for hostname.");

    // fetch and set memory, clock freq, uptime, netcard info, logical cpu nums
    CreateMemTotal();
    CreateSysConf();
    CreateSysTime();
    CreateNetCardInfo();
    // add cpu info
    return CreateCpuInfo();
}

/**
 * @brief Get other information
 * @return PROFILING_SUCCESS
           PROFILING_FAILED
 */
static int32_t AddOtherInfo(void)
{
    CreatePidInfo();
    CreateRankId();
    CreatePlatFormVersion();
    CreateVersionInfo();
    CreateDrvVersion();
    CreateDevices();
    return PROFILING_SUCCESS;
}

/**
 * @brief Set device information to sub json object
 * @param [out] obj : sub json object
 */
static void SetDeviceInfoSubObject(JsonObj *obj)
{
    obj->SetValueByKey(obj, "id",
        (JsonObj){{.intValue = g_infoJson->deviceInfos.id}, .type = CJSON_INT})
        ->SetValueByKey(obj, "env_type",
        (JsonObj){{.intValue = g_infoJson->deviceInfos.envType}, .type = CJSON_INT})
        ->SetValueByKey(obj, "ctrl_cpu_core_num",
        (JsonObj){{.intValue = g_infoJson->deviceInfos.ctrlCpuCoreNum}, .type = CJSON_INT})
        ->SetValueByKey(obj, "ctrl_cpu_endian_little",
        (JsonObj){{.intValue = g_infoJson->deviceInfos.ctrlCpuEndianLittle}, .type = CJSON_INT})
        ->SetValueByKey(obj, "ts_cpu_core_num",
        (JsonObj){{.intValue = g_infoJson->deviceInfos.tsCpuCoreNum}, .type = CJSON_INT})
        ->SetValueByKey(obj, "ai_cpu_core_num",
        (JsonObj){{.intValue = g_infoJson->deviceInfos.aiCpuCoreNum}, .type = CJSON_INT})
        ->SetValueByKey(obj, "ai_core_num",
        (JsonObj){{.intValue = g_infoJson->deviceInfos.aiCoreNum}, .type = CJSON_INT})
        ->SetValueByKey(obj, "ai_cpu_core_id",
        (JsonObj){{.intValue = g_infoJson->deviceInfos.aiCpuCoreId}, .type = CJSON_INT})
        ->SetValueByKey(obj, "aicpu_occupy_bitmap",
        (JsonObj){{.intValue = g_infoJson->deviceInfos.aiCpuOccupyBitMap}, .type = CJSON_INT})
        ->SetValueByKey(obj, "aiv_num",
        (JsonObj){{.intValue = g_infoJson->deviceInfos.aivNum}, .type = CJSON_INT})
        ->SetValueByKey(obj, "ctrl_cpu_id",
        (JsonObj){{.stringValue = g_infoJson->deviceInfos.ctrlCpuId}, .type = CJSON_STRING})
        ->SetValueByKey(obj, "ctrl_cpu",
        (JsonObj){{.stringValue = g_infoJson->deviceInfos.ctrlCpu}, .type = CJSON_STRING})
        ->SetValueByKey(obj, "ai_cpu",
        (JsonObj){{.stringValue = g_infoJson->deviceInfos.aiCpu}, .type = CJSON_STRING})
        ->SetValueByKey(obj, "hwts_frequency",
        (JsonObj){{.stringValue = g_infoJson->deviceInfos.hwtsFrequency}, .type = CJSON_STRING})
        ->SetValueByKey(obj, "aic_frequency",
        (JsonObj){{.stringValue = g_infoJson->deviceInfos.aicFrequency}, .type = CJSON_STRING})
        ->SetValueByKey(obj, "aiv_frequency",
        (JsonObj){{.stringValue = g_infoJson->deviceInfos.aivFrequency}, .type = CJSON_STRING});
}

/**
 * @brief Set host cpu information to sub json object
 * @param [out] obj : sub json object
 * @param [in]  i   : cpu index
 */
static void SetHostCpuSubObject(JsonObj *obj, size_t i)
{
    obj->SetValueByKey(obj, "Id",
        (JsonObj){{.intValue = g_infoJson->infoCpus[i].id}, .type = CJSON_INT})
        ->SetValueByKey(obj, "Name",
        (JsonObj){{.stringValue = g_infoJson->infoCpus[i].name}, .type = CJSON_STRING})
        ->SetValueByKey(obj, "Frequency",
        (JsonObj){{.stringValue = g_infoJson->infoCpus[i].frequency}, .type = CJSON_STRING})
        ->SetValueByKey(obj, "Logical_CPU_Count",
        (JsonObj){{.stringValue = g_infoJson->infoCpus[i].logicalCpuCount}, .type = CJSON_STRING})
        ->SetValueByKey(obj, "Type",
        (JsonObj){{.stringValue = g_infoJson->infoCpus[i].type}, .type = CJSON_STRING});
}

static void DataFilling(JsonObj *obj, JsonObj *cpuArr)
{
    obj->SetValueByKey(obj, "version", (JsonObj){{.stringValue = g_infoJson->version}, .type = CJSON_STRING})
        ->SetValueByKey(obj, "jobInfo", (JsonObj){{.stringValue = g_infoJson->jobInfo}, .type = CJSON_STRING})
        ->SetValueByKey(obj, "OS", (JsonObj){{.stringValue = g_infoJson->os}, .type = CJSON_STRING})
        ->SetValueByKey(obj, "hostname", (JsonObj){{.stringValue = g_infoJson->hostname}, .type = CJSON_STRING})
        ->SetValueByKey(obj, "hwtype", (JsonObj){{.stringValue = g_infoJson->hwtype}, .type = CJSON_STRING})
        ->SetValueByKey(obj, "devices", (JsonObj){{.stringValue = g_infoJson->devices}, .type = CJSON_STRING})
        ->SetValueByKey(obj, "platform_version",
        (JsonObj){{.stringValue = g_infoJson->platformVersion}, .type = CJSON_STRING})
        ->SetValueByKey(obj, "pid", (JsonObj){{.stringValue = g_infoJson->pid}, .type = CJSON_STRING})
        ->SetValueByKey(obj, "upTime", (JsonObj){{.stringValue = g_infoJson->upTime}, .type = CJSON_STRING})
        ->SetValueByKey(obj, "memoryTotal", (JsonObj){{.uintValue = g_infoJson->memoryTotal}, .type = CJSON_UINT})
        ->SetValueByKey(obj, "cpuNums", (JsonObj){{.uintValue = g_infoJson->cpuNums}, .type = CJSON_UINT})
        ->SetValueByKey(obj, "sysClockFreq", (JsonObj){{.uintValue = g_infoJson->sysClockFreq}, .type = CJSON_UINT})
        ->SetValueByKey(obj, "cpuCores", (JsonObj){{.uintValue = g_infoJson->cpuCores}, .type = CJSON_UINT})
        ->SetValueByKey(obj, "drvVersion", (JsonObj){{.uintValue = g_infoJson->drvVersion}, .type = CJSON_UINT})
        ->SetValueByKey(obj, "rank_id", (JsonObj){{.intValue = g_infoJson->rankId}, .type = CJSON_INT})
        ->SetValueByKey(obj, "CPU", *cpuArr);
}

/**
 * @brief Encode all information to json string
 * @param [out] content  : info json string
 * @param [in]  deviceId : device id
 * @return PROFILING_SUCCESS
           PROFILING_FAILED
 */
static int32_t EncodeInfoToJson(char **content, uint32_t deviceId)
{
    if (g_infoJson == NULL) {
        return PROFILING_FAILED;
    }
    int32_t ret = PROFILING_FAILED;
    JsonObj *devArr = JsonInit();
    JsonObj *cpuArr = JsonInit();
    JsonObj *obj = JsonInit();
    do {
        // DeviceInfo
        PROF_CHK_EXPR_ACTION_NODO(devArr == NULL, break, "Failed to init devArr.");
        PROF_CHK_EXPR_ACTION_NODO(cpuArr == NULL, break, "Failed to init cpuArr.");
        PROF_CHK_EXPR_ACTION_NODO(obj == NULL, break, "Failed to init info json obj.");
        if (deviceId != DEFAULT_HOST_ID) {
            JsonObj *devSubObj = JsonInit();
            PROF_CHK_EXPR_ACTION_NODO(devSubObj == NULL, break, "Failed to init devSubObj.");
            SetDeviceInfoSubObject(devSubObj);
            devArr->AddArrayItem(devArr, *devSubObj);
            JsonFree(devSubObj);
        }
        // CPU
        size_t infoCpusSize = g_infoJson->cpuCores;
        for (size_t i = 0; i < infoCpusSize; ++i) {
            JsonObj *cpuSubObj = JsonInit();
            PROF_CHK_EXPR_ACTION_NODO(cpuSubObj == NULL, break, "Failed to init cpuSubObj.");
            SetHostCpuSubObject(cpuSubObj, i);
            cpuArr->AddArrayItem(cpuArr, *cpuSubObj);
            JsonFree(cpuSubObj);
        }
        // main json object
        DataFilling(obj, cpuArr);
        if (deviceId != DEFAULT_HOST_ID) {
            obj->SetValueByKey(obj, "DeviceInfo", *devArr);
        }
        // transfer json to string
        *content = JsonToString(obj);
        PROF_CHK_EXPR_ACTION_NODO(*content == NULL, break, "Failed to transfer info json to string.");
        ret = PROFILING_SUCCESS;
    } while (0);
    // free object
    JsonFree(devArr);
    JsonFree(cpuArr);
    JsonFree(obj);
    return ret;
}

/**
 * @brief Upload info json chunk data to uploader queue
 * @param [in] deviceId : device id
 * @param [in] content  : info json string
 * @return PROFILING_SUCCESS
           PROFILING_FAILED
 */
static int32_t UploadInfoJson(uint32_t deviceId, char* content, size_t contentLen)
{
    if (*content == '\0') {
        MSPROF_LOGE("Failed to upload info json because of empty string.");
        OSAL_MEM_FREE(content);
        return PROFILING_FAILED;
    }
    PROF_CHK_EXPR_ACTION_TWICE(deviceId > DEFAULT_HOST_ID, OSAL_MEM_FREE(content), return PROFILING_FAILED,
        "UploadInfoJson failed with device id %u.", deviceId);
    ProfFileChunk *chunk = (ProfFileChunk *)OsalMalloc(sizeof(ProfFileChunk));
    if (chunk == NULL) {
        MSPROF_LOGE("Failed to malloc chunk for UploadInfoJson.");
        OSAL_MEM_FREE(content);
        return PROFILING_FAILED;
    }
    chunk->chunk = (uint8_t*)content;
    chunk->deviceId = (uint8_t)deviceId;
    chunk->chunkSize = contentLen;
    chunk->chunkType = PROF_CTRL_DATA;
    chunk->isLastChunk = false;
    chunk->offset = -1;
    // for speed and function, do not need to check ret value
    (void)strcpy_s(chunk->fileName, sizeof(chunk->fileName), "info.json");
    int32_t ret = UploaderUploadData(chunk);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to upload info json.");
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

/**
 * @brief Generate info json string and upload its chunk data to uploader queue
 * @param [in] deviceId : device id
 * @return PROFILING_SUCCESS
           PROFILING_FAILED
 */
int32_t CreateInfoJson(uint32_t deviceId)
{
    MSPROF_LOGI("Start to generate info.json, device: %u.", deviceId);
    int32_t ret = InitInfoJson();
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to init info json.");
        return PROFILING_FAILED;
    }
    ret = AddDeviceInfo(deviceId);
    if (ret != PROFILING_SUCCESS) {
        OSAL_MEM_FREE(g_infoJson);
        MSPROF_LOGE("Failed to add device info.");
        return PROFILING_FAILED;
    }
    ret = AddOtherInfo();
    if (ret != PROFILING_SUCCESS) {
        OSAL_MEM_FREE(g_infoJson);
        MSPROF_LOGE("Failed to add other info.");
        return PROFILING_FAILED;
    }
    ret = AddHostInfo();
    if (ret != PROFILING_SUCCESS) {
        OSAL_MEM_FREE(g_infoJson);
        MSPROF_LOGE("Failed to add host info.");
        return PROFILING_FAILED;
    }
    do {
        char *content = NULL;
        ret = EncodeInfoToJson(&content, deviceId);
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("Failed to encode info to json.");
            break;
        }
        ret = UploadInfoJson(deviceId, content, strlen(content));
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("Failed to upload info.json, device: %u.", deviceId);
            break;
        }
    } while (0);
    OSAL_MEM_FREE(g_infoJson->infoCpus);
    OSAL_MEM_FREE(g_infoJson);
    return ret;
}

int32_t UploadCollectionTimeInfo(uint32_t deviceId, CHAR* content, size_t contentLen, const CHAR* fileName)
{
    PROF_CHK_EXPR_ACTION(content == NULL, return PROFILING_FAILED,
        "UploadCollectionTimeInfo failed with null content.");
    PROF_CHK_EXPR_ACTION_TWICE(deviceId > DEFAULT_HOST_ID, OSAL_MEM_FREE(content), return PROFILING_FAILED,
        "Device id %u is invalid.", deviceId);
    ProfFileChunk *chunk = (ProfFileChunk*)OsalMalloc(sizeof(ProfFileChunk));
    if (chunk == NULL) {
        OSAL_MEM_FREE(content);
        MSPROF_LOGE("Failed to malloc chunk for UploadCollectionTimeInfo.");
        return PROFILING_FAILED;
    }
    chunk->chunk = (uint8_t*)content;
    chunk->deviceId = (uint8_t)deviceId;
    chunk->chunkSize = contentLen;
    chunk->chunkType = PROF_CTRL_DATA;
    chunk->isLastChunk = false;
    chunk->offset = -1;
    errno_t result = strcpy_s(chunk->fileName, sizeof(chunk->fileName), fileName);
    if (result != EOK) {
        OSAL_MEM_FREE(chunk);
        OSAL_MEM_FREE(content);
        MSPROF_LOGE("strcpy_s CollectionTimeInfo to chunk failed.");
        return PROFILING_FAILED;
    }
    int32_t ret = UploaderUploadData(chunk);
    PROF_CHK_EXPR_ACTION(ret != PROFILING_SUCCESS,
        return PROFILING_FAILED, "Failed to upload CollectionTimeInfo data.");
    return PROFILING_SUCCESS;
}

int32_t CreateCollectionTimeInfo(uint32_t deviceId, bool isStartTime)
{
    const char *fileName = isStartTime ? PROF_START_INFO: PROF_END_INFO;
    MSPROF_LOGI("Start to generate %s, device: %u.", fileName, deviceId);
    uint64_t hostTime = 0;
    OsalTimeval tv;
    const uint32_t timeUs = 1000000;
    (void)memset_s(&tv, sizeof(tv), 0, sizeof(tv));
    int32_t ret = OsalGetTimeOfDay(&tv, NULL);
    if (ret != OSAL_EN_OK) {
        MSPROF_LOGE("gettimeofday failed");
    } else {
        hostTime = (uint64_t)tv.tv_sec * timeUs + (uint64_t)tv.tv_usec;
    }
    char *hostTimeStr = TransferUint64ToString(hostTime);
    PROF_CHK_EXPR_ACTION(hostTimeStr == NULL, return PROFILING_FAILED, "Failed to transfer hostTimeStr.");
    int64_t monoTime = GetClockMonotonicTime();
    PROF_CHK_EXPR_ACTION(monoTime < 0, monoTime = 0, "The obtained timestamp is a negative number.");
    char *timeStr = TransferUint64ToString((uint64_t)monoTime);
    PROF_CHK_EXPR_ACTION(timeStr == NULL,
        {OSAL_MEM_FREE(hostTimeStr); return PROFILING_FAILED;}, "Failed to transfer timeStr.");
    char *hostTimeDateStr = TimestampToTime(hostTime, timeUs);
    PROF_CHK_EXPR_ACTION(hostTimeDateStr == NULL,
        {OSAL_MEM_FREE(hostTimeStr); OSAL_MEM_FREE(timeStr); return PROFILING_FAILED;},
        "Failed to transfer hostTimeDateStr.");
    JsonObj *obj = JsonInit();
    PROF_CHK_EXPR_ACTION(obj == NULL,
        {OSAL_MEM_FREE(hostTimeStr); OSAL_MEM_FREE(timeStr); OSAL_MEM_FREE(hostTimeDateStr); return PROFILING_FAILED;},
        "Failed to init json obj.");
    if (isStartTime) {
        obj->SetValueByKey(obj, "collectionTimeEnd", (JsonObj){{.stringValue = ""}, .type = CJSON_STRING})
            ->SetValueByKey(obj, "collectionDateEnd", (JsonObj){{.stringValue = ""}, .type = CJSON_STRING})
            ->SetValueByKey(obj, "collectionTimeBegin", (JsonObj){{.stringValue = hostTimeStr}, .type = CJSON_STRING})
            ->SetValueByKey(obj, "collectionDateBegin",
            (JsonObj){{.stringValue = hostTimeDateStr}, .type = CJSON_STRING});
    } else {
        obj->SetValueByKey(obj, "collectionTimeEnd", (JsonObj){{.stringValue = hostTimeStr}, .type = CJSON_STRING})
            ->SetValueByKey(obj, "collectionDateEnd", (JsonObj){{.stringValue = hostTimeDateStr}, .type = CJSON_STRING})
            ->SetValueByKey(obj, "collectionTimeBegin", (JsonObj){{.stringValue = ""}, .type = CJSON_STRING})
            ->SetValueByKey(obj, "collectionDateBegin", (JsonObj){{.stringValue = ""}, .type = CJSON_STRING});
    }
    obj->SetValueByKey(obj, "clockMonotonicRaw", (JsonObj){{.stringValue = timeStr}, .type = CJSON_STRING});
    OSAL_MEM_FREE(hostTimeStr);
    OSAL_MEM_FREE(timeStr);
    OSAL_MEM_FREE(hostTimeDateStr);

    char *collectionTimeInfoStr = JsonToString(obj);
    JsonFree(obj);
    PROF_CHK_EXPR_ACTION(collectionTimeInfoStr == NULL, return PROFILING_FAILED, "Failed to generate json string.");
    ret = UploadCollectionTimeInfo(deviceId, collectionTimeInfoStr, strlen(collectionTimeInfoStr), fileName);
    PROF_CHK_EXPR_ACTION(ret != PROFILING_SUCCESS, return PROFILING_FAILED,
        "Failed to upload %s, device: %u.", fileName, deviceId);
    return PROFILING_SUCCESS;
}