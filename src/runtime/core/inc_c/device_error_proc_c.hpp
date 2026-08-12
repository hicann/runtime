/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_DEVICE_ERROR_PROC_C_HPP__
#define __CCE_RUNTIME_DEVICE_ERROR_PROC_C_HPP__

#include "device/device_error_proc.hpp"

namespace cce {
namespace runtime {
constexpr uint32_t FUSION_CQE_STATUS_ONLY_AIX_ERROR = 0x400U;
constexpr uint32_t FUSION_CQE_STATUS_ERROR_MASK = 0x44444U;

enum class AixErrClass : int32_t {
    AIX_ERROR_NA = 0,
    AIX_MTE_POISON_ERROR = 1,
    AIX_HW_L_ERROR = 2,
    AIX_S_ERROR = 4,
    AIX_LINK_ERROR = 8,
    AIX_ERROR_END
}; // 与TS侧ts_aix_err_class_t对应

enum RtDavidCoreErrorType : std::uint16_t {
    /* CUBE_ERROR_T0_0 bit parse */
    CUBE_ERR_L0A_RDWR_CFLT = RINGBUFFER_CUBE_ERROR_OFFSET,
    CUBE_ERR_L0B_RDWR_CFLT,
    CUBE_ERR_L0C_RDWR_CFLT,
    CUBE_INVLD_INPUT = RINGBUFFER_CUBE_ERROR_OFFSET + 4U,
    CUBE_L0A_WRAP_AROUND,
    CUBE_L0B_WRAP_AROUND,
    CUBE_L0C_WRAP_AROUND,
    CUBE_L0A_ECC,
    CUBE_L0B_ECC,
    CUBE_L0C_ECC,
    CUBE_ILLEGAL_INSTR,
    CUBE_ERR_HSET_CNT_OVF,
    CUBE_ERR_HSET_CNT_UNF,
    CUBE_ERR_PBUF_WRAP_AROUND,
    CUBE_ERR_PARITY_ERR,
    CUBE_ERR_SF_ECC_MB_ERR,
    CUBE_ERR_L0ASF_WRAP_AROUND,
    CUBE_ERR_L0BSF_WRAP_AROUND,

    /* CUBE_ERROR_T0_1 bit parse */
    CUBE_INSTR_UNDEF = RINGBUFFER_CUBE_ERROR_OFFSET + 32U,
    CUBE_INSTR_ILL_CFG,
    CUBE_INSTR_ADDR_MISALIGN,
    CUBE_FM_ADDR_OVERFLOW,
    CUBE_NONBRANCH_BIAS_OVERFLOW,
    CUBE_ELW_ADDR_OVERFLOW,
    CUBE_KERNEL_ADDR_OVERFLOW,
    CUBE_FB_ADDR_OVERFLOW,
    CUBE_BT_ADDR_OVERFLOW,
    CUBE_RESULT_ADDR_OVERFLOW,

    /* MTE_ERROR_T0_0 bit parse */
    MTE_NDDMA_CACHE_ECC = RINGBUFFER_MTE_ERROR_OFFSET,
    MTE_NDDMA_REG_BUF_ECC,
    MTE_L1_ECC,
    MTE_CFG_REG_PARITY,
    MTE_L0A_RDWR_CFLT,
    MTE_L0B_RDWR_CFLT,
    MTE_OFFSET_MISALIGN = RINGBUFFER_MTE_ERROR_OFFSET + 7U,
    MTE_XGAMMA_LINE_SEQ_WRON,
    MTE_READ_OVERFLOW,
    MTE_WRITE_OVERFLOW,
    MTE_BIF_CFG_REG_PARITY,
    MTE_INSTR_ILLEGAL_CFG = RINGBUFFER_MTE_ERROR_OFFSET + 14U,
    MTE_ATM_ADD_ADDR_MISALIGN,
    MTE_INSTR_ADDR_MISALIGN,
    MTE_GDMA_READ_OVERFLOW,
    MTE_GDMA_WRITE_OVERFLOW,
    MTE_GDMA_ILLEGAL_BURST_NUM,
    MTE_GDMA_ILLEGAL_BURST_LEN,
    MTE_AIPP_ILLEGAL_PARAM,
    MTE_ERR_UNZIP,
    MTE_XGAMMA_LB0_ECC,
    MTE_XGAMMA_LB1_ECC,
    MTE_ERR_WAIPP,
    MTE_STB_ECC = RINGBUFFER_MTE_ERROR_OFFSET + 26U,
    MTE_AIPP_ECC,
    MTE_TAGMGR_BUF_ECC = RINGBUFFER_MTE_ERROR_OFFSET + 28U,
    MTE_UB_ECC,
    MTE_ROB_ECC,
    MTE_BIU_RDWR_RESP,

    /* L1_ERROR_T0_0 bit parse */
    L1_L0A_RDWR_CFLT = RINGBUFFER_L1_ERROR_OFFSET,
    L1_L0B_RDWR_CFLT,
    L1_READ_2D_OVERFLOW,
    L1_WRITE_2D_OVERFLOW,
    L1_DWS_PAD_CONF_ERR,
    L1_DWS_FMAP_H_ILLEGAL,
    L1_WINO_L0B_WRITE_OVERFLOW,
    L1_WINO_L0B_READ_OVERFLOW,
    L1_WINO_L0A_WRITE_OVERFLOW,
    L1_WINO_L0A_READ_OVERFLOW,
    L1_WINO_ILLEGAL_V_COV_PAD_CTL,
    L1_WINO_ILLEGAL_H_COV_PAD_CTL,
    L1_ILLEGAL_W_SIZE,
    L1_ILLEGAL_H_SIZE,
    L1_ILLEGAL_CHN_SIZE = RINGBUFFER_L1_ERROR_OFFSET + 14U,
    L1_ILLEGAL_K_M_EXT_STEP,
    L1_ILLEGAL_K_M_START_POS,
    L1_ILLEGAL_SCHN_CFG,
    L1_ILLEGAL_SMALLK_CFG,
    L1_ILLEGAL_FM_SIZE = RINGBUFFER_L1_ERROR_OFFSET + 19U,
    L1_ILLEGAL_L1_3D_SIZE,
    L1_ILLEGAL_STRIDE = RINGBUFFER_L1_ERROR_OFFSET + 21U,
    L1_PADDING_CFG,
    L1_READ_3D_OVERFLOW,
    L1_WRITE_3D_OVERFLOW,
    L1_BAS_RADDR_OBOUND,
    L1_F1WPOS_LARGER_FSIZE = RINGBUFFER_L1_ERROR_OFFSET + 27U,
    L1_FMAP_LESS_KERNEL,
    L1_FMAPWH_LARGER_L1SIZE,
    L1_FPOS_LARGER_FSIZE,

    /* L1_ERROR_T0_1 bit parse */
    L1_ERR_FIFO_PARITY = RINGBUFFER_L1_ERROR_1_OFFSET,
    FIXP_BIU_RDWR_RESP,
    FIXP_STB_ECC_ERR,
    FIXP_FBUF_WR_OVERFLOW,
    FIXP_FBUF_RD_OVERFLOW,
    FIXP_OUT_WR_OVERFLOW,
    FIXP_L1_WR_OVERFLOW,
    FIXP_L1_RD_OVERFLOW,
    FIXP_L0C_RD_OVERFLOW,
    FIXP_ILLEGAL_CFG,
    FIXP_ADDR_MISAL,
    FIXP_L0C_ECC_ERR,
    FIXP_L0C_RDWR_CFLT,
    FIXP_WRITE_UB_OVFLW,
    L1_UB_WR_OVFLW,
    L1_WAITSET_ERR,
    L1_L1_ECC,
    L1_GDMA_READ_OVERFLOW,
    L1_GDMA_WRITE_OVERFLOW,
    L1_INSTR_ILLEGAL_CFG,
    L1_INSTR_ADDR_MISALIGN,
    L1_SC_CFG_PARITY,
    L1_FIXP_BT_NAN_INF,

    /* SC_ERROR_T0_0 bit parse */
    SC_CNT_SW_BUS_ERR = RINGBUFFER_SC_ERROR_OFFSET,
    SC_REG_PARITY_ERR,
    SC_SLOW_CSW_ROB_ECC_ERR,
    SC_BUS_RESP_TIMEOUT_ERR = RINGBUFFER_SC_ERROR_OFFSET + 3U,

    /* SU_ERROR_T0_0 bit parse */
    SU_IFU_BUS_ERR_T0 = RINGBUFFER_SU_ERROR_OFFSET,
    SU_CCU_CALL_DEPTH_OVRFLW_T0,
    SU_CCU_DIV0_T0,
    SU_CCU_ILLEGAL_INSTR_T0,
    SU_CCU_NEG_SQRT_T0,
    SU_CCU_UB_ECC_T0,
    SU_CCU_INF_NAN_T0,
    SU_CCU_ADDR_ERR_T0,
    SU_CCU_BUS_ERR_T0,
    SU_CCU_DC_DATA_ECC_T0,
    SU_CCU_DC_TAG_ECC_T0,
    SU_CCU_DIV0_FP_T0,
    SU_CCU_NEG_SQRT_FP_T0,
    SU_CCU_ERR_PARITY_ERR_T0,
    SU_CCU_SEQ_ERR_T0,
    SU_CCU_MPU_ERR_T0,
    SU_CCU_LSU_ERR_T0,
    SU_CCU_PB_ECC_ERR_T0,
    SU_CCU_SAFETY_CRC_ERR_T0,
    SU_CCU_LSU_ATOMIC_ERR_T0,
    SU_CCU_CC_SET_OVFL_ERR_T0,
    SU_SAFETY_1BIT_ECC_OVFLW_ERR_T0,
    SU_CCU_DC_SSBUF_ECC_T0,
    SU_IFU_BUS_PTY_ERR,
    SU_BMU_ERR,
    SU_HSCB_BUS_ERR = RINGBUFFER_SU_ERROR_OFFSET + 26U,
    SU_GET_NEXT_TASK_ERR,
    SU_HIT_TRAP_ERR_T0 = RINGBUFFER_SU_ERROR_OFFSET + 30U,
    WARN_AS_EXCEPTION_T0,

    /* SU_ERROR_T0_1 bit parse */
    SU_IC_ECC_REPEAT_ERR = RINGBUFFER_SU_ERROR_OFFSET + 32U,
    SU_IC_ECC_OTHER_ERR,
    SU_DC_ECC_REPEAT_ERR,
    SU_DC_ECC_OTHER_ERR,

    /* VEC_ERROR_T0_0 bit parse */
    VEC_ERR_UB_ARB_DATA_EXCP_MTE_T0 = RINGBUFFER_VEC_ERROR_OFFSET,
    VEC_ERR_UB_ARB_DATA_EXCP_SU_T0,
    VEC_ERR_UB_ARB_DATA_EXCP_VEC_T0,
    VEC_ERR_INSTR_TIMEOUT_T0 = RINGBUFFER_VEC_ERROR_OFFSET + 6U,
    VEC_ERR_SU_PLD_UNDEF_T0,   // need to be updated after chip doc update
    VEC_ERR_SU_PLD_ILL_CFG_T0, // need to be updated after chip doc update
    VEC_ERR_PC_OVERFLOW_T0,    // need to be updated after chip doc update
    VEC_ERR_INSTR_UNDEF_T0,
    VEC_INSTR_ILLEGAL_CFG_T0,
    VEC_ERR_HWLP_STACK_OVFL_T0,
    VEC_ERR_HWLP_INSTR_NUM_MISMATCH_T0,
    VEC_ERR_BIU_RESP_ERR_T0,
    VEC_ERR_PB_ECC_MBERR_T0,
    VEC_ERR_IDATA_INF_NAN_T0,
    VEC_ERR_DIV_BY_ZERO_T0,
    VEC_ERR_VALU_NEG_LN_T0,
    VEC_ERR_VALU_NEG_SQRT_T0,
    VEC_ERR_UB_ADDR_OVERFLOW_T0,
    VEC_UB_WRAP_AROUND,
    VEC_ERR_UB_ECC_MBERR_T0,
    VEC_ERR_VMS_UNSORT_T0,
    VEC_ERR_CSW_DATA_T0,
    VEC_ERR_SC_CFG_PARITY_T0,
    VEC_ERR_UB_SB_ECC_REPEAT_ERR_T0,
    VEC_ERR_UB_SB_ECC_OTHER_ERR_T0,
    VEC_ERR_IC_ECC_REPEAT_ERR_T0,
    VEC_ERR_IC_ECC_OTHER_ERR_T0,

    VEC_ERR_UNEXP_JOIN_T0 = RINGBUFFER_VEC_ERROR_1_OFFSET,
    VEC_ERR_UB_SIZE_CFG_ERR_T0,
    VEC_ERR_DC_STACK_ADDR_OVFL_T0,
    VEC_ERR_GM_ADDR_OVFL_T0,
    VEC_ERR_DVG_STACK_OVFL_T0,
    VEC_ERR_DVG_STACK_UNDFL_T0,
    VEC_ERR_BHU_ECC_MBERR_T0,
    VEC_ERR_MROB_ECC_MBERR_T0,
    VEC_ERR_DCACHE_TAG_MBERR_T0,
    VEC_ERR_DIRTY_ECC_MBERR_T0,
    VEC_ERR_VTH_ID_ECC_MBERR_T0,
    VEC_ERR_MRF_ECC_MBERR_T0,
    VEC_ERR_DVG_ECC_MBERR_T0,
};

rtError_t ProcRingBufferTaskDavid(
    const Device* const dev, const void* const devMem, const bool delFlag, const uint32_t len);
void GetExceptionArgsForFusionKernelTask(const TaskInfo* const taskInfo, rtExceptionArgsInfo_t* const argsInfo);
rtError_t ProcessDavidStarsFusionKernelErrorInfo(
    const StarsDeviceErrorInfo* const info, const uint64_t errorNumber, const Device* const dev,
    const DeviceErrorProc* const insPtr);
rtError_t ProcessDavidStarsWaitTimeoutErrorInfo(
    const StarsDeviceErrorInfo* const info, const uint64_t errorNumber, const Device* const dev,
    const DeviceErrorProc* const insPtr);
rtError_t ProcessDavidStarsCoreErrorInfo(
    const StarsDeviceErrorInfo* const info, const uint64_t errorNumber, const Device* const dev,
    const DeviceErrorProc* const insPtr);
void ProcessDavidStarsCoreErrorMapInfo(
    const DavidOneCoreErrorInfo* const info, std::string& errorString, std::string& errorCode, rtChipType_t chipType);
rtError_t ProcessDavidStarsCcuErrorInfo(
    const StarsDeviceErrorInfo* const info, const uint64_t errorNumber, const Device* const dev,
    const DeviceErrorProc* const insPtr);
rtError_t ProcessStarsSdmaErrorInfo(
    const StarsDeviceErrorInfo* const info, const uint64_t errorNumber, const Device* const dev,
    const DeviceErrorProc* const insPtr);
rtError_t ProcessStarsV2CoreTimeoutDfxInfo(
    const StarsDeviceErrorInfo* const info, const uint64_t errorNumber, const Device* const dev,
    const DeviceErrorProc* const insPtr);
void ProcessCoreErrorClass(const Device* const dev, const StarsDeviceErrorInfo* const info);
void AddExceptionRegInfo(
    const StarsDeviceErrorInfo* const starsInfo, const uint32_t coreIdx, const uint16_t type,
    const TaskInfo* errTaskPtr);
void CheckAixErrorClassInFusionKernel(
    const StarsDeviceErrorInfo* errInfo, const StarsDeviceErrorInfo* const info, const Device* const dev,
    TaskInfo* errTaskPtr);
void LogFusionKernelErrorInfo(const StarsDeviceErrorInfo* const info, uint64_t errorNumber);
rtError_t ProcessFusionKernelErrorCommon(
    const StarsDeviceErrorInfo* const info, const uint64_t errorNumber, const Device* const dev,
    const DeviceErrorProc* const insPtr, DeviceErrorProc::StarsErrorInfoProc coreErrorProc);
} // namespace runtime
} // namespace cce

#endif
