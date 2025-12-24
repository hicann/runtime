/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
 
#ifndef CCE_RUNTIME_DEVICE_ERROR_INFO_H
#define CCE_RUNTIME_DEVICE_ERROR_INFO_H
#include "base.hpp"

namespace cce {
namespace runtime {
	/*
	0-63	RINGBUFFER_CUBE_ERROR_OFFSET
	64-127	RINGBUFFER_MTE_ERROR_OFFSET
	128-191	RINGBUFFER_L1_ERROR_OFFSET
		RINGBUFFER_L1_ERROR_1_OFFSET
	192-255	RINGBUFFER_SC_ERROR_OFFSET
	256-319	RINGBUFFER_SU_ERROR_OFFSET
	320-383	RINGBUFFER_VEC_ERROR_OFFSET
		RINGBUFFER_VEC_ERROR_1_OFFSET
	*/
    constexpr uint32_t RINGBUFFER_CUBE_ERROR_OFFSET = 0U;
    constexpr uint32_t RINGBUFFER_MTE_ERROR_OFFSET = 64U;
    constexpr uint16_t RINGBUFFER_L1_ERROR_OFFSET = 128U;
    constexpr uint32_t RINGBUFFER_L1_ERROR_1_OFFSET = 160U;
    constexpr uint32_t RINGBUFFER_SC_ERROR_OFFSET = 192U;
    constexpr uint16_t RINGBUFFER_SU_ERROR_OFFSET= 256U;
    constexpr uint16_t RINGBUFFER_VEC_ERROR_OFFSET = 320U;
    constexpr uint16_t RINGBUFFER_VEC_ERROR_1_OFFSET = 352;
    constexpr uint32_t MAX_RECORD_CORE_NUM  = 32U;
    constexpr uint32_t MAX_RECORD_DHA_NUM = 8U;

enum rtErrorType : std::uint8_t {
    AICORE_ERROR = 0,
    AIVECTOR_ERROR,
    SDMA_ERROR,
    AICPU_ERROR,
    FFTS_PLUS_SDMA_ERROR,
    FFTS_PLUS_AICPU_ERROR,
    DVPP_ERROR,
    DSA_ERROR,
    FFTS_PLUS_DSA_ERROR,
    SQE_ERROR,
    WAIT_TIMEOUT_ERROR,
    FFTS_PLUS_AICORE_ERROR,
    FFTS_PLUS_AIVECTOR_ERROR,
    HCCL_FFTSPLUS_TIMEOUT_ERROR,
    AICORE_TIMEOUT_DFX,
    FUSION_KERNEL_ERROR,
    CCU_ERROR,
    ERROR_TYPE_BUTT
};

const std::map<uint32_t, std::string> g_mulBitEccEventId = {
    {0x80CD8008U, "L2BUFF multi bit Err."},
    {0x80F2180DU, "HBMA/MATA Os Err."},
    {0x80F38008U, "HBMA Multi Bit Ecc."},
    {0x81338002U, "TS Dispatch Input Err"},
    {0x81338004U, "TS Dispatch Config Err."},
    {0x81338008U, "TS Dispatch Multi Bit Ecc."},
    {0x813B8002U, "AIC Dispatch Input Error"},
    {0x813B8004U, "AIC Dispatch Config Error."},
    {0x813B8008U, "AIC Dispatch Multi Bit Ecc."},
    {0x81478002U, "DVPP Dispatch Input Error"},
    {0x81478004U, "DVPP Dispatch Config Error"},
    {0x81478008U, "DVPP Dispatch Multi Bit Ecc."},
    {0x815F8002U, "PERI Dispatch Input Error."},
    {0x815F8004U, "PERI Dispatch Config Error"},
    {0x815F8008U, "PERI Dispatch Multi Bit Ecc."},
    {0x81938002U, "DSA Dispatch Input Error."},
    {0x81938004U, "DSA Dispatch Config Error."},
    {0x81938008U, "DSA Dispatch Multi Bit Ecc."},
    {0x81958002U, "NIC Dispatch Input Error."},
    {0x81958004U, "NIC Dispatch Config Error."},
    {0x81958008U, "NIC Dispatch Multi Bit Ecc."},
    {0x81978002U, "PCIE Dispatch Input Error."},
    {0x81978004U, "PCIE Dispatch Config Error."},
    {0x81978008U, "PCIE Dispatch Multi Bit Ecc."}
};

const std::map<uint32_t, std::string> g_starsv2MulBitEccEventId = {
    {0x80CD8008U, "L2BUFF multi bit Err."},
    {0x80F2180DU, "HBMA/MATA Os Err."},
    {0x80F38008U, "HBMA Multi Bit Ecc."},
    {0x81338002U, "TS Dispatch Input Err"},
    {0x81338004U, "TS Dispatch Config Err."},
    {0x81338008U, "TS Dispatch Multi Bit Ecc."},
    {0x813B8002U, "AIC Dispatch Input Error"},
    {0x813B8004U, "AIC Dispatch Config Error."},
    {0x81478002U, "DVPP Dispatch Input Error"},
    {0x81478004U, "DVPP Dispatch Config Error"},
    {0x815F8002U, "PERI Dispatch Input Error."},
    {0x815F8004U, "PERI Dispatch Config Error"},
    {0x81978002U, "PCIE Dispatch Input Error."},
    {0x81978004U, "PCIE Dispatch Config Error."},
    {0x81B58002U, "UB Dispatch Input Error."},
    {0x81B58004U, "UB Dispatch Config Error."},
    {0x813D8009U, "AIC AA Ring parity Error."},
    {0x81AF8009U, "UB posion Error."}
};

const std::map<uint32_t, std::string> g_starsv2L2MulBitEccEventIdBlkList = {
    {0x80E01801U, "HBM Multi Bit Error."},
    {0x80F2180DU, "HBMA/MATA Os Error."},
    {0x80F38008U, "HBMA Multi Bit Ecc."},
    {0x81338002U, "TS Dispatch Input Error"},
    {0x81338004U, "TS Dispatch Config Error."},
    {0x81338008U, "TS Dispatch Multi Bit Ecc."},
    {0x813B8002U, "AIC Dispatch Input Error"},
    {0x813B8004U, "AIC Dispatch Config Error."},
    {0x81478002U, "DVPP Dispatch Input Error"},
    {0x81478004U, "DVPP Dispatch Config Error"},
    {0x815F8002U, "PERI Dispatch Input Error."},
    {0x815F8004U, "PERI Dispatch Config Error"},
    {0x81978002U, "PCIE Dispatch Input Error."},
    {0x81978004U, "PCIE Dispatch Config Error."},
    {0x81B58002U, "UB Dispatch Input Error."},
    {0x81B58004U, "UB Dispatch Config Error."},
    {0x813D8009U, "AIC AA Ring Parity Error."},
    {0x81AF8009U, "UB Posion Error."}
};

enum rtSdmaErrorType : std::uint32_t {
    // Submission Descriptor read response error
    // this is bit position
    SDMA_SQE_READ_RSP_ERR = 0,
    SDMA_SMMU_TERMINATE = 1,
    SDMA_DMAA_ERR1 = 2,
    SDMA_DMAA_ERR2 = 3,
    SDMA_DMAA_ERR3 = 4,
    SDMA_AXIM_BERR = 5,
    SDMA_SQ_TABLE_ALL_ZERO = 6,
    // if the sdma status is timeout , the channel_status don`t need care othe bits.
    SDMA_ERROR_TIMEOUT = 65536
};

enum rtAICPUErrorType : std::uint16_t {
    // KERNEL
    KERNEL_EXECUTE_PARAM_INVLID = 1,  // kernel execute param invalid
    KERNEL_EXECUTE_INNER_ERROR = 2,   // kernel execute inner error
    KERNEL_EXECUTE_TIMEOUT = 3,       // kernel execute timeout

    // aicpu processor
    AE_END_OF_SEQUENCE = 6,              // end of sequence
    AE_STATUS_SILENT_FAULT = 7,          // silent fault
    AE_STATUS_TASK_ABORT = 8,            // aicpu abort
    AE_STATUS_STRESS_DETECT_FAULT = 9,   // stress detect slient fault
    AE_STATUS_STRESS_DETECT_FAULT_NORAS = 10,   // stress detect slient fault
    AE_STATUS_STRESS_DETECT_FAULT_LOW = 11,   // stress detect slient fault
    AE_STATUS_STRESS_DETECT_FAULT_LOW_OFFLINE = 12,   // stress detect slient fault
    AE_TASK_WAIT = 101,                  // task wait for aicpu super task

    // [1000, 1099] is used by hccl
    AICPU_HCCL_OP_RETRY_FAILED = 1000,   // hccl op retry failed
    AICPU_HCCL_OP_SDMA_LINK_FAILED = 1001,   // hccl op sdma link failed

    AE_BAD_PARAM = 11001,                // bad param
    AE_OPEN_SO_FAILED = 11002,           // open so failed
    AE_GET_KERNEL_NAME_FAILED = 11003,   // get kernel failed
    AE_KERNEL_API_PARAM_INVALID = 11004, // execute kernel api param invalid
    AE_KERNEL_API_INNER = 11005,   // execute kernel api failed
    AE_INNER = 11006,              // inner error

    // aicpu sd
    AICPU_PARAMETER_NOT_VALID = 21001,     // param invalid
    AICPU_DUMP_FAILED = 21002,             // dump failed
    AICPU_FROM_DRV =  21003,               // drv error
    AICPU_TOOL_ERR = 21004,                // tool error
    AICPU_NOT_FOUND_LOGICAL_TASK = 21005,  // logical task not found
    AICPU_TASK_EXECUTE_FAILED = 21006,     // task execute failed
    AICPU_TASK_EXECUTE_TIMEOUT = 21007,    // task execute timeout
    AICPU_INNER = 21008,             // inner error
    // error code for model
    AICPU_IN_WORKING = 21100,              // current resource or model is working
    AICPU_MODEL_NOT_FOUND = 21101,         // model not found
    AICPU_STREAM_NOT_FOUND = 21102,        // stream not found
    AICPU_MODEL_STATUS_NOT_ALLOW_OPERATE = 21103,  // operate not allowed with current model status
    AICPU_MODEL_EXIT_ERR = 21104,          // model exit error

    AICPU_RESERVED = 21200,

    // cust aicpu sd
    AICPU_CUST_PARAMETER_NOT_VALID = 22001,     // param invalid
    AICPU_CUST_DRV_ERR =  22002,                // driver error
    AICPU_CUST_TOOL_ERR = 22003,                // tool error
    AICPU_CUST_TASK_EXECUTE_FAILED = 22004,     // custom task execute failed
    AICPU_CUST_TASK_EXECUTE_TIMEOUT = 22005,    // custom task execute timeout
    AICPU_CUST_TASK_EXECUTE_PARAM_INVALID = 22006, // custom task execute param invalid
    AICPU_CUST_INNER = 22007,             // inner error
    AICPU_CUST_RESERVED = 22200                // reserved: inner error
};

struct RingBufferElementInfo {
    uint64_t pid;
    uint32_t infoLen;
    uint32_t errorType;
    uint64_t errorNumber;
    uint16_t vfId;
    uint8_t reserved[6];
};

struct StreamTaskId {
    uint16_t streamId = 0xFFFFU;
    uint16_t taskId = 0xFFFFU;
};

struct OneAiCoreErrorDhaInfo {
    uint32_t regId;
    uint32_t errStatusL;
    uint32_t errMisc1H;
    uint32_t status1; // for dha_status1
};

struct OneCoreErrorExtendInfo {
    uint64_t coreId;
    // aicore status registers
    uint64_t runStall;
    uint64_t aiCoreInt;
    uint64_t eccEn;
    uint64_t axiClampCtrl;
    uint64_t axiClampState;
    uint64_t biuStatus0;
    uint64_t biuStatus1;
    // aicore error registers, some register has been read in ts_one_core_error_info
    uint64_t aicError2;
    uint64_t aicError3;
    uint64_t aicError5;
    uint64_t mteCcuEcc1bitErr;
    uint64_t vecCubeEcc1bitErr;
    // debug mode and dfx mode
    uint64_t clkGateMask;
    uint64_t dbgAddr;
    uint64_t dbgData0;
    uint64_t dbgData1;
    uint64_t dbgData2;
    uint64_t dbgData3;
    uint64_t dfxData;
};

// it is used to transfer aicore error info from tscpu to host.
struct OneCoreErrorInfo {
    uint64_t coreId;
    uint64_t aicError;
    uint64_t pcStart;
    uint64_t currentPC;
    uint64_t vecErrInfo;
    uint64_t mteErrInfo;
    uint64_t ifuErrInfo;
    uint64_t ccuErrInfo;
    uint64_t cubeErrInfo;
    uint64_t biuErrInfo;
    uint64_t aicErrorMask;
    uint64_t paraBase;
};

struct CoreErrorInfo {
    uint16_t type;  // AICORE or AIV
    uint16_t coreNum;
    uint16_t deviceId;
    uint8_t dhaNum;
    uint8_t res;
    OneCoreErrorInfo info[MAX_RECORD_CORE_NUM];
    OneCoreErrorExtendInfo extend_info[MAX_RECORD_CORE_NUM];
    OneAiCoreErrorDhaInfo dhaInfo[MAX_RECORD_DHA_NUM];
};

// it is used to transfer sdma error info from tscpu to host.
struct SdmaErrorInfo {
    uint64_t setting1;
    uint64_t setting2;
    uint64_t setting3;
    uint64_t sqBaseAddr;
    uint64_t channel;
    uint64_t channelStatus; // 0x0 :success 0x1~0xf :sdma error
    uint64_t cqeStatus;
    uint32_t deviceId;
    uint32_t res;
};

// it is used to transfer aicpu error info from tscpu to host.
struct AicpuErrorInfo {
    uint64_t errcode;
    uint32_t stream_id;
    uint32_t task_id;
};

// it is format data in one element from ringbuffer.
struct DeviceErrorInfo {
    union {
        CoreErrorInfo   coreErrorInfo;
        SdmaErrorInfo   sdmaErrorInfo;
        AicpuErrorInfo  aicpuErrorInfo;
    }u;
};
}
}
#endif