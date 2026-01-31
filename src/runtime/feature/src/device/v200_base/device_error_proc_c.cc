/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "device_error_proc_c.hpp"
#include "error_message_manage.hpp"
#include "task_david.hpp"
#include "task_recycle.hpp"
#include "stream.hpp"
#include "task_fail_callback_manager.hpp"
#include "profiler_c.hpp"

namespace cce {
namespace runtime {

namespace {
enum RtDavidCoreErrorType : std::uint16_t {
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

    MTE_NDDMA_CACHE_ECC = RINGBUFFER_MTE_ERROR_OFFSET,
    MTE_NDDMA_REG_BUF_ECC,
    MTE_L1_ECC,
    MTE_CFG_REG_PARITY,
    MTE_READ_OVERFLOW = RINGBUFFER_MTE_ERROR_OFFSET + 9U,
    MTE_WRITE_OVERFLOW,
    MTE_ERR_INSTR_ILLEGAL_CFG = RINGBUFFER_MTE_ERROR_OFFSET + 14U,
    MTE_ERR_ADDR_MISALIGN,
    VEC_INSTR_ADDR_MISALIGN,
    MTE_GDMA_READ_OVERFLOW,
    MTE_GDMA_WRITE_OVERFLOW,
    MTE_STB_ECC_ERR = RINGBUFFER_MTE_ERROR_OFFSET + 26U,
    MTE_TAGMGR_BUF_ECC = RINGBUFFER_MTE_ERROR_OFFSET + 28U,
    MTE_UB_ECC,
    MTE_ROB_ECC,
    MTE_BIU_RDWR_RESP,

    L1_L0A_RDWR_CFLT = RINGBUFFER_L1_ERROR_OFFSET,
    L1_L0B_RDWR_CFLT,
    L1_READ_2D_OVERFLOW,
    L1_WRITE_2D_OVERFLOW,
    MTE_ERR_ILLEGAL_CHN_SIZE = RINGBUFFER_L1_ERROR_OFFSET + 14U,
    MTE_ERR_ILLEGAL_K_M_EXT_STEP,
    MTE_ERR_ILLEGAL_K_M_START_POS,
    MTE_ILLEGAL_FM_SIZE = RINGBUFFER_L1_ERROR_OFFSET + 20U,
    MTE_ILLEGAL_STRIDE,
    MTE_PADDING_CFG,
    MTE_ERR_READ_3D_OVERFLOW,
    MTE_WRITE_3D_OVERFLOW,
    MTE_F1WPOS_LARGER_FSIZE = RINGBUFFER_L1_ERROR_OFFSET + 27U,
    MTE_FMAP_LESS_KERNEL,
    MTE_FMAPWH_LARGER_L1SIZE,
    MTE_FPOS_LARGER_FSIZE,

    FIXP_ERR_FBUF_WRITE_OVFLW = RINGBUFFER_L1_ERROR_1_OFFSET + 3U,
    FIXP_ERR_FBUF_READ_OVFLW,
    FIXP_ERR_OUT_WRITE_OVERFLOW,
    FIXP_ERR_WRITE_L1_OVFLW,
    FIXP_ERR_READ_L1_OVFLW,
    FIXP_ERR_READ_L0C_OVFLW,
    FIXP_ERR_ILLEGAL_CFG,
    FIXP_ERR_INSTR_ADDR_MISAL,
    FIXP_L0C_ECC,
    FIXP_L0C_RDWR_CFLT,
    FIXP_ERR_WRITE_UB_OVFLW,
    L1_UB_WR_OVFLW,
    L1_WAITSET_ERR,
    L1_L1_ECC,
    L1_GDMA_READ_OVERFLOW,
    L1_GDMA_WRITE_OVERFLOW,
    L1_INSTR_ILLEGAL_CFG,
    L1_INSTR_ADDR_MISALIGN,

    IFU_BUS_ERR = RINGBUFFER_SU_ERROR_OFFSET,
    CCU_CALL_DEPTH_OVRFLW,
    CCU_DIV0,
    CCU_ILLEGAL_INSTR,
    CCU_NEG_SQRT,
    CCU_UB_ECC,
    CCU_INF_NAN,
    CCU_ADDR_ERR,
    CCU_BUS_ERR,
    CCU_DC_DATA_ECC,
    CCU_DC_TAG_ECC,
    CCU_DIV0_FP,
    CCU_NEG_SQRT_FP,
    CCU_ERR_PARITY_ERR,
    CCU_SEQ_ERR,
    CCU_MPU_ERR,
    CCU_LSU_ERR,
    CCU_PB_ECC_ERR,
    CCU_SAFETY_CRC_ERR,
    CCU_LSU_ATOMIC_ERR,
    CCU_CROSS_CORE_SET_OVFL_ERR,
    SU_SAFETY_1BIT_ECC_OVFLW_ERR_T0,
    CCU_SBUF_ECC,
    SU_HIT_TRAP_ERR = RINGBUFFER_SU_ERROR_OFFSET + 30U,
    WARN_AS_EXCEPTION_T0,

    SC_BUS_RESP_TIMEOUT_ERR = RINGBUFFER_SC_ERROR_OFFSET + 3U,

    VEC_DATA_EXCP_MTE = RINGBUFFER_VEC_ERROR_OFFSET,
    VEC_DATA_EXCP_CCU,
    VEC_DATA_EXCP_VEC,
    VEC_INSTR_TIMEOUT = RINGBUFFER_VEC_ERROR_OFFSET + 6U,
    VEC_ERR_SU_PLD_UNDEF,
    VEC_ERR_SU_PLD_ILL_CFG,
    VEC_ERR_PC_OVFL_T0,
    VEC_INSTR_UNDEF,
    VEC_INSTR_ILLEGAL_CFG,
    VEC_ERR_HWLP_STACK_OVFL_T0,
    VEC_ERR_HWLP_INSTR_NUM_MISMATCH_T0,
    VEC_BIU_RESP_ERR,
    VEC_PB_ECC_MBERR,
    VEC_IDATA_INF_NAN,
    VEC_DIV_BY_ZERO,
    VEC_VALU_NEG_LN,
    VEC_VALU_NEG_SQRT,
    VEC_INSTR_MISALIGN,
    VEC_ERR_UB_ADDR_OVERFLOW,
    VEC_UB_ECC_MBERR,
    VEC_ERR_VMS_UNSORT_T0,
    VEC_ERR_CSW_DATA_T0,

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
constexpr uint32_t TS_SDMA_STATUS_DDRC_ERROR = 0x8U;
constexpr uint32_t TS_SDMA_STATUS_LINK_ERROR = 0x9U;
constexpr uint32_t TS_SDMA_STATUS_POISON_ERROR = 0xAU;
}

enum RtAixSubErrorType : std::uint8_t {
    AIC_TRAP_RD_OVERFLOW = 0,   /* aicore trap read out of bounds */
    AIC_TRAP_WR_OVERFLOW,       /* aicore trap write out of bounds */
    AIV_TRAP_RD_OVERFLOW,       /* vector core trap read out of bounds */
    AIV_TRAP_WR_OVERFLOW,       /* vector core trap write out of bounds */
    SUB_ERROR_TYPE_RESERVE      /* NA */
};

static const std::map<uint64_t, std::string> g_davidErrorMapInfo = {
    // RINGBUFFER_CUBE_ERROR_0_OFFSET
    {CUBE_INVLD_INPUT, "the data of L0a and L0b read back is the INF or NAN data."},
    {CUBE_L0A_WRAP_AROUND, "The operation address of L0A exceeds the maximum range of L0A."},
    {CUBE_L0B_WRAP_AROUND, "The operation address of L0B exceeds the maximum range of L0B."},
    {CUBE_L0C_WRAP_AROUND, "The operation address of L0C exceeds the maximum range of L0C."},
    {CUBE_L0A_ECC, "ECC verification failed when L0A read/write."},
    {CUBE_L0B_ECC, "ECC verification failed when L0B read/write."},
    {CUBE_L0C_ECC, "ECC verification failed when L0C read/write."},
    {CUBE_ILLEGAL_INSTR, "The instruction configuration of CUBE is illegal."},
    {CUBE_ERR_HSET_CNT_OVF, "A overflow error occurs in the CUBE HSET counter."},
    {CUBE_ERR_HSET_CNT_UNF, "A underflow error occurs in the CUBE HSET counter."},
    {CUBE_ERR_PBUF_WRAP_AROUND, "A round error occurs in the CUBE FIXP_BUFFER."},
    {CUBE_ERR_PARITY_ERR, "Parity error for the Cube parity ERR register."},
    {CUBE_ERR_SF_ECC_MB_ERR, "Cube SF MEM failure."},

    // RINGBUFFER_MTE_ERROR_OFFSET
    {MTE_NDDMA_CACHE_ECC, "NDDMA Cache ECC ERROR."},
    {MTE_NDDMA_REG_BUF_ECC, "NDDMA REQ Buffer ECC ERROR."},
    {MTE_L1_ECC, "ECC verification failed when L1 read/write."},
    {MTE_CFG_REG_PARITY, "CFG REG PARIT ERROR."},
    {MTE_READ_OVERFLOW,
        "The read address of the mte load2d instruction is greater than the maximum address of the source (L1)."},
    {MTE_WRITE_OVERFLOW,
        "The write address of the mte load2d instruction is greater than the maximum destination address."},
    {MTE_ERR_INSTR_ILLEGAL_CFG, "The instruction configuration of MTE is illegal."},
    {MTE_ERR_ADDR_MISALIGN, "instruction address misalign(ADDR_MISALIGN)."},
    {VEC_INSTR_ADDR_MISALIGN, "The UB address accessed by the VEC instruction is not aligned."},
    {MTE_GDMA_READ_OVERFLOW, "The read address of the MTE instruction is out of range."},
    {MTE_GDMA_WRITE_OVERFLOW, "The write address of the MTE instruction is out of range."},
    {MTE_STB_ECC_ERR, "Multi-bit ECC error occurs in the MTE STB."},
    {MTE_TAGMGR_BUF_ECC, "Multi-bit ECC error occurs in the MTE tagmgr buffer."},
    {MTE_UB_ECC, "The ECC verification of the UB in the VEC failed."},
    {MTE_ROB_ECC, "An error occurs in the mte ROB ECC check."},
    {MTE_BIU_RDWR_RESP, "The DDR address of the MTE instruction is out of range."},

    // RINGBUFFER_L1_ERROR_OFFSET
    {L1_L0A_RDWR_CFLT, "L0A MEM read/write conflict(L0A_RDWR_CFLT)."},
    {L1_L0B_RDWR_CFLT, "L0B MEM read/write conflict(L0B_RDWR_CFLT)."},
    {L1_READ_2D_OVERFLOW, "LOAD2D instruction address overflow (READ_OVERFLOW)."},
    {L1_WRITE_2D_OVERFLOW, "LOAD2D instruction address overflow(WRITE_OVERFLOW)."},
    {MTE_ERR_ILLEGAL_CHN_SIZE, "The value of CHN_SIZE is illegal."},
    {MTE_ERR_ILLEGAL_K_M_EXT_STEP, "The value of K_M_EXT_STEP is illegal."},
    {MTE_ERR_ILLEGAL_K_M_START_POS, "The value of K_M_START_POS is illegal."},
    {MTE_ILLEGAL_FM_SIZE, "The feature map size of the mte load3d instruction is illegal(size = 0)."},
    {MTE_ILLEGAL_STRIDE, "The stride size of the mte load3d instruction is illegal."},
    {MTE_PADDING_CFG, "The error in mte load3d padding configuration."},
    {MTE_ERR_READ_3D_OVERFLOW, "The read address of the MTE load3d instruction is out of range."},
    {MTE_WRITE_3D_OVERFLOW, "The write address of the mte load3d instruction is out of range."},
    {MTE_F1WPOS_LARGER_FSIZE,
        "The 1st filter window position of the mte load3d instruction is greater than "
        "(Feature map size – Filter size)."},
    {MTE_FMAP_LESS_KERNEL, "The feature map size of the mte load3d instruction is less than the kernel size."},
    {MTE_FMAPWH_LARGER_L1SIZE,
        "FeatureMapW * FeatureMapH * (CIndex + 1) of the mte load3d instruction is greater than L1 buffer size/32."},
    {MTE_FPOS_LARGER_FSIZE,
        "The fetch position in filter of the mte load3d instruction is greater than the filter size."},

    // RINGBUFFER_L1_ERROR_1_OFFSET
    {FIXP_ERR_FBUF_WRITE_OVFLW, "The write address of the FBUF is out of range."},
    {FIXP_ERR_FBUF_READ_OVFLW, "The read address of the FBUF is out of range."},
    {FIXP_ERR_OUT_WRITE_OVERFLOW, "A overflow error occurs when the FIXP write."},
    {FIXP_ERR_WRITE_L1_OVFLW, "The write address of the L1 is out of range."},
    {FIXP_ERR_READ_L1_OVFLW, "The read address of the L1 is out of range."},
    {FIXP_ERR_READ_L0C_OVFLW, "The read address of the L0C is out of range."},
    {FIXP_ERR_ILLEGAL_CFG, "The configuration of FIXP is illegal."},
    {FIXP_ERR_INSTR_ADDR_MISAL, "Read L0C, read L1, and write FIXP buffer addresses are not aligned."},
    {FIXP_L0C_ECC, "FIXP instruction error: ECC verification failed when the l0c is read."},
    {FIXP_L0C_RDWR_CFLT, "L0C read/write conflict."},
    {FIXP_ERR_WRITE_UB_OVFLW, "The write address of the UB is out of range."},
    {L1_UB_WR_OVFLW, "L1 to UB write overflow(UB_WR_OVERFLOW)."},
    {L1_WAITSET_ERR, "The configuration of HWATI/HSET is incorrect."},
    {L1_L1_ECC, "L1 MEM 2bits ECC error(L1_ECC)."},
    {L1_GDMA_READ_OVERFLOW, "The read address of the MTE instruction is out of range."},
    {L1_GDMA_WRITE_OVERFLOW, "The write address of the MTE instruction is out of range."},
    {L1_INSTR_ILLEGAL_CFG, "instruction illegal config(INSTR_ILLEGAL_CFG)"},
    {L1_INSTR_ADDR_MISALIGN, "Instruction address misalign."},

    // RINGBUFFER_SU_ERROR_OFFSET
    {IFU_BUS_ERR, "it is usually instruction errors. The probability is low."},
    {CCU_CALL_DEPTH_OVRFLW, "The number of nesting times of call the function is greater than CTRL[5:2]."},
    {CCU_DIV0, "divide by zero."},
    {CCU_ILLEGAL_INSTR, "Illegal instruction, which is usually caused by unaligned UUB addresses."},
    {CCU_NEG_SQRT, "The number of roots is negative. "},
    {CCU_UB_ECC, "ECC verification failed when UB read/write."},
    {CCU_INF_NAN, "The input of the floating-point instruction run by the CCU is nan/inf."},
    {CCU_ADDR_ERR, "CCU instruction address check error."},
    {CCU_BUS_ERR,
        "When the D-cache reads and writes data to the UB, the response value returned by the bus is a non-zero "
        "value."},
    {CCU_DC_DATA_ECC, "A 2-bit ECC error occurs in the data-cache data-ram."},
    {CCU_DC_TAG_ECC, "A 2-bit ECC error occurs in the data-cache tag-ram."},
    {CCU_DIV0_FP, "A error occurs in the FP32 DIV0."},
    {CCU_NEG_SQRT_FP, "The input of the FP SQRT calculation unit is a negative number."},
    {CCU_ERR_PARITY_ERR, "A parity check error occurs in the SU internal buffer during the safety feature."},
    {CCU_SEQ_ERR, "The SEQ command sequence is incorrect."},
    {CCU_MPU_ERR, "The MPU address access is invalid."},
    {CCU_LSU_ERR, "When the buffer is enabled, the stack access instruction cache is miss."},
    {CCU_PB_ECC_ERR, "A 2-bit ECC error occurs in the parameter buffer."},
    {CCU_SAFETY_CRC_ERR, "MTE CRC error."},
    {CCU_LSU_ATOMIC_ERR, "Failed to execute atomic on the Scalar LSU."},
    {CCU_CROSS_CORE_SET_OVFL_ERR,
        "The value of the flag counter for inter-core communication exceeds the maximum value 15."},
    {SU_SAFETY_1BIT_ECC_OVFLW_ERR_T0, "Overflow error when the number of 1-bit ECC errors exceeds the preset value."},
    {CCU_SBUF_ECC, "ECC is reported in the CCU Scalar buffer."},
    {SU_HIT_TRAP_ERR, "trap instr error."},
    {WARN_AS_EXCEPTION_T0,
        "An exception is reported when the task ends, because more than 15 1-bit ECC errors or IFU multi-hit events "
        "occur during task running."},

    // sc error
    {SC_BUS_RESP_TIMEOUT_ERR,
        "Timeout when the slave bus accesses the SC and no response is received for a long time."},

    // RINGBUFFER_VEC_ERROR_OFFSET
    {VEC_DATA_EXCP_MTE, "Data from the MTE is abnormal."},
    {VEC_DATA_EXCP_CCU, "Data from the CCU is abnormal."},
    {VEC_DATA_EXCP_VEC, "Data from the VEC is abnormal."},
    {VEC_INSTR_TIMEOUT, "The instruction running timeout."},
    {VEC_ERR_SU_PLD_UNDEF, "ccu payload undefine."},
    {VEC_ERR_SU_PLD_ILL_CFG, "ccu payload illegal congifuration."},
    {VEC_ERR_PC_OVFL_T0, "VF PC overflow."},
    {VEC_INSTR_UNDEF, "Commands not supported by the current VEC version."},
    {VEC_INSTR_ILLEGAL_CFG, "VEC supports illegal configurations in commands."},
    {VEC_ERR_HWLP_STACK_OVFL_T0, "The number of nested VLOOPs exceeds the hardware limit (4)."},
    {VEC_ERR_HWLP_INSTR_NUM_MISMATCH_T0,
        "The number of instructions in the nested VLOOPs is greater than that in the outer loop."},
    {VEC_BIU_RESP_ERR, "The data returned by the BIU to the VEC is incorrect."},
    {VEC_PB_ECC_MBERR, "The PB data returned by the SU to the VEC contains ECC errors."},
    {VEC_IDATA_INF_NAN, "The input data of the instruction operation is INF/NAN."},
    {VEC_DIV_BY_ZERO, "The instruction of VEC divide-by-zero error."},
    {VEC_VALU_NEG_LN, "The input data of the VALU lN operation is a negative number."},
    {VEC_VALU_NEG_SQRT, "The input data of the VALU squart operation is a negative number."},
    {VEC_INSTR_MISALIGN, "The instruction access UB address is not aligned."},
    {VEC_ERR_UB_ADDR_OVERFLOW, "UB access address overflow."},
    {VEC_UB_ECC_MBERR, "Multi-bit ECC error occurs when access UB."},
    {VEC_ERR_VMS_UNSORT_T0, "Incorrectly sorted data entered by the VMS."},
    {VEC_ERR_CSW_DATA_T0, "Exception when accessing the internal SRAM during context switch (multi-bit ECC)."},
    // RINGBUFFER_VEC_ERROR_1_OFFSET
    {VEC_ERR_UNEXP_JOIN_T0,
        "When the VEC executes a SIMT task, some warps end with \"join\" and some warps end with \"end\"."},
    {VEC_ERR_UB_SIZE_CFG_ERR_T0, "The configured UB size exceeds 224 KB, and the DCU AGU is aware of it."},
    {VEC_ERR_DC_STACK_ADDR_OVFL_T0, "The DCache access address exceeds the maximum range of the DCache stack MEM."},
    {VEC_ERR_GM_ADDR_OVFL_T0, "The DCache access address exceeds the maximum range of the GM MEM."},
    {VEC_ERR_DVG_STACK_OVFL_T0, "Overflow error in the DVG stack."},
    {VEC_ERR_DVG_STACK_UNDFL_T0, "Underflow error in the DVG stack."},
    {VEC_ERR_BHU_ECC_MBERR_T0, "Multi-bit ECC error when the VEC accesses the BHU."},
    {VEC_ERR_MROB_ECC_MBERR_T0, "Multi-bit ECC error when the VEC accesses the MROB."},
    {VEC_ERR_DCACHE_TAG_MBERR_T0, "Multi-bit ECC error when the VEC accesses the DCache"},
    {VEC_ERR_DIRTY_ECC_MBERR_T0, "Multi-bit ECC error when the VEC accesses the dirty MEM."},
    {VEC_ERR_VTH_ID_ECC_MBERR_T0, "Multi-bit ECC error when the VEC accesses the Vthread ID."},
    {VEC_ERR_MRF_ECC_MBERR_T0, "Multi-bit ECC error when the VEC accesses the MRF."},
    {VEC_ERR_DVG_ECC_MBERR_T0, "Multi-bit ECC error when the VEC accesses the DVG stack."},
};

uint32_t GetRingbufferElementNum()
{
    return RINGBUFFER_LEN_DAVID;
}

static void ProcessDavidStarsCoreErrorOneMapInfo(uint32_t * const cnt, uint64_t err, std::string &errorString,
    std::string &errorCode, uint32_t offset)
{
    if (err == 0ULL) {
        return;
    }

    RT_LOG(RT_LOG_DEBUG, "core errorCode:%" PRIx64, err);
    for (uint32_t i = static_cast<uint32_t>(BitScan(err)); i < MAX_BIT_LEN; i = static_cast<uint32_t>(BitScan(err))) {
        BITMAP_CLR(err, static_cast<uint64_t>(i));
        const auto it = g_davidErrorMapInfo.find((i + offset));
        if (it != g_davidErrorMapInfo.end()) {
            // if the string is too long, the log will truncate to 1024.
            // so the error string only show 400.
            if (unlikely((it->second.size() + errorString.size()) > RINGBUFFER_ERROR_MSG_MAX_LEN)) {
                RT_LOG(RT_LOG_WARNING, "The error info is too long.");
                break;
            }
            errorString += it->second;
            if (!errorCode.empty()) {
                errorCode += ", ";
            }
            errorCode += std::to_string(i + offset);
        }
    }
    (*cnt)++;

    return;
}

static void ProcessDavidStarsCoreErrorMapInfo(const DavidOneCoreErrorInfo * const info,
    std::string &errorString, std::string &errorCode)
{
    uint32_t cnt = 0U;
    ProcessDavidStarsCoreErrorOneMapInfo(&cnt, info->scError, errorString, errorCode,
        RINGBUFFER_SC_ERROR_OFFSET);
    ProcessDavidStarsCoreErrorOneMapInfo(&cnt, info->suError, errorString, errorCode,
        static_cast<uint32_t>(RINGBUFFER_SU_ERROR_OFFSET));
    ProcessDavidStarsCoreErrorOneMapInfo(&cnt, info->mteError, errorString, errorCode,
        RINGBUFFER_MTE_ERROR_OFFSET);
    ProcessDavidStarsCoreErrorOneMapInfo(&cnt, info->vecError, errorString, errorCode,
        static_cast<uint32_t>(RINGBUFFER_VEC_ERROR_OFFSET));
    ProcessDavidStarsCoreErrorOneMapInfo(&cnt, info->cubeError, errorString, errorCode,
        RINGBUFFER_CUBE_ERROR_OFFSET);
    ProcessDavidStarsCoreErrorOneMapInfo(&cnt, info->l1Error, errorString, errorCode,
        static_cast<uint32_t>(RINGBUFFER_L1_ERROR_OFFSET));

    if (cnt != 0U) {  // at least one error bit exists.
        return;
    }

    errorString = "timeout or trap error.";
    errorCode = "0";
    return;
}

static void AiCoreUnknownErrProc(const Device * const dev, const StarsDeviceErrorInfo * const info)
{
    (RtPtrToUnConstPtr<Device *>(dev))->SetDeviceFaultType(DeviceFaultType::AICORE_UNKNOWN_ERROR);
    RT_LOG(RT_LOG_ERROR, "unknown aicore error, stream_id=%hu, task_id=%hu.",
        info->u.coreErrorInfo.comm.streamId, info->u.coreErrorInfo.comm.taskId);
}

static void AixLinkErrProc(const Device * const dev, const StarsDeviceErrorInfo * const info, TaskInfo *errTaskPtr)
{
    constexpr uint32_t maxFaultNum = 128U;
    rtDmsFaultEvent *faultEventInfo = new (std::nothrow)rtDmsFaultEvent[maxFaultNum];
    COND_RETURN_VOID((faultEventInfo == nullptr), "new rtDmsFaultEvent failed.");

    const std::function<void()> releaseFunc = [&faultEventInfo]() { DELETE_A(faultEventInfo); };
    ScopeGuard faultEventInfoRelease(releaseFunc);
    uint32_t eventCount = 0U;
    rtError_t error = GetDeviceFaultEvents(dev->Id_(), faultEventInfo, eventCount, maxFaultNum);
    if (error != RT_ERROR_NONE) {
        AiCoreUnknownErrProc(dev, info);
        return;
    }

    if (!IsHitBlacklist(faultEventInfo, eventCount, g_ubMemTimeoutEventIdBlkList)) {
        for (uint32_t faultIndex = 0; faultIndex < eventCount; faultIndex++) {
            if (faultEventInfo[faultIndex].eventId == UB_POISON_ERROR_EVENT_ID &&
                IsEventRasMatch(faultEventInfo[faultIndex], g_ubMemTrafficTimeoutFilter)) {
                errTaskPtr->mte_error = TS_ERROR_LINK_ERROR;
                RT_LOG(RT_LOG_ERROR, "network link error, stream_id=%hu, task_id=%hu, errorCode=%#x.",
                    info->u.coreErrorInfo.comm.streamId, info->u.coreErrorInfo.comm.taskId,
                    static_cast<uint32_t>(RT_ERROR_DEVICE_LINK_ERROR));
                (RtPtrToUnConstPtr<Device *>(dev))->SetDeviceFaultType(DeviceFaultType::LINK_ERROR);
                return;
            }
        }
    }
    AiCoreUnknownErrProc(dev, info);
}

static void SetDeviceFaultTypeByAixErrClass(const Device * const dev, const StarsDeviceErrorInfo * const info, TaskInfo *errTaskPtr)
{
    switch (static_cast<AixErrClass>(info->u.coreErrorInfo.comm.flag)) {
        case AixErrClass::AIX_MTE_POISON_ERROR: {
            bool hasSpecialErrorCode = false;
            COND_PROC((errTaskPtr == nullptr) && (Runtime::Instance()->GetHbmRasProcFlag() == HBM_RAS_NOT_SUPPORT),
                SetDeviceFaultTypeByErrorType(dev, AICORE_ERROR, hasSpecialErrorCode));
            if (errTaskPtr != nullptr) {
                SetTaskMteErr(errTaskPtr, dev, g_mulBitEccEventIdBlkList);
                RT_LOG(RT_LOG_ERROR, "mte error, stream_id=%hu, task_id=%hu, errorCode=%u.",
                    info->u.coreErrorInfo.comm.streamId, info->u.coreErrorInfo.comm.taskId, errTaskPtr->mte_error);
            }
            break;
        }
        case AixErrClass::AIX_HW_L_ERROR:
            if (!HasBlacklistEventOnDevice(dev->Id_(), g_mulBitEccEventIdBlkList)) {
                (RtPtrToUnConstPtr<Device *>(dev))->SetDeviceFaultType(DeviceFaultType::AICORE_HW_L_ERROR);
                RT_LOG(RT_LOG_ERROR, "hardware local error, stream_id=%hu, task_id=%hu, errorCode=%#x.",
                    info->u.coreErrorInfo.comm.streamId, info->u.coreErrorInfo.comm.taskId,
                    static_cast<uint32_t>(RT_ERROR_DEVICE_AICORE_ERROR_HW_L));
            } else {
                AiCoreUnknownErrProc(dev, info);
            }
            break;
        case AixErrClass::AIX_S_ERROR:
            if (!HasBlacklistEventOnDevice(dev->Id_(), g_mulBitEccEventIdBlkList)) {
                (RtPtrToUnConstPtr<Device *>(dev))->SetDeviceFaultType(DeviceFaultType::AICORE_SW_ERROR);
                RT_LOG(RT_LOG_ERROR, "software error, stream_id=%hu, task_id=%hu.",
                    info->u.coreErrorInfo.comm.streamId, info->u.coreErrorInfo.comm.taskId);
            } else {
                AiCoreUnknownErrProc(dev, info);
            }
            break;
        case AixErrClass::AIX_LINK_ERROR:
            AixLinkErrProc(dev, info, errTaskPtr);
            break;
        default:
            break;
    }
}

static void ProcessCoreErrorClass(const Device * const dev, const StarsDeviceErrorInfo * const info)
{
    TaskInfo *errTaskPtr = GetTaskInfo(dev, static_cast<uint32_t>(info->u.davidCoreErrorInfo.comm.streamId),
        static_cast<uint32_t>(info->u.davidCoreErrorInfo.comm.taskId));
    if (errTaskPtr != nullptr) {
        errTaskPtr->isRingbufferGet = true;
        if ((errTaskPtr->type != TS_TASK_TYPE_KERNEL_AICORE) && (errTaskPtr->type != TS_TASK_TYPE_KERNEL_AIVEC)) {
            return;
        }
    }
    RT_LOG(RT_LOG_ERROR, "comm_flag=%hhu", info->u.coreErrorInfo.comm.flag);

    SetDeviceFaultTypeByAixErrClass(dev, info, errTaskPtr);
}

rtError_t ProcessDavidStarsCoreErrorInfo(const StarsDeviceErrorInfo * const info,
    const uint64_t errorNumber, const Device * const dev, const DeviceErrorProc * const insPtr)
{
    UNUSED(insPtr);
    ProcessCoreErrorClass(dev, info);

    TaskInfo *errTaskPtr = GetTaskInfo(dev, static_cast<uint32_t>(info->u.davidCoreErrorInfo.comm.streamId),
        static_cast<uint32_t>(info->u.davidCoreErrorInfo.comm.taskId));

    for (uint32_t coreIdx = 0U; coreIdx < static_cast<uint32_t>(info->u.davidCoreErrorInfo.comm.coreNum); coreIdx++) {
        if ((errTaskPtr != nullptr) && (errTaskPtr->u.aicTaskInfo.kernel == nullptr)) {
            AicTaskInfo *aicTask = &errTaskPtr->u.aicTaskInfo;
            RT_LOG(RT_LOG_ERROR, "stream_id=%u, task_id=%u not with kernel info, tilingKey=0x%llx.", info->u.davidCoreErrorInfo.comm.streamId,
                info->u.davidCoreErrorInfo.comm.taskId, aicTask->tilingKey);
            if (aicTask->progHandle != nullptr) {
                aicTask->kernel = aicTask->progHandle->SearchKernelByPcAddr(info->u.davidCoreErrorInfo.info[coreIdx].pcStart);
            }
        }

        std::string errorString;
        std::string errorCode;
        ProcessDavidStarsCoreErrorMapInfo(&(info->u.davidCoreErrorInfo.info[coreIdx]),
            errorString, errorCode);

        /* logs for aic tools, do not modify the item befor making a new agreement with tools */
        RT_LOG_CALL_MSG(ERR_MODULE_TBE,
            "The error from device(chipId:%u, dieId:%u), serial number is %" PRIu64 ", "
            "there is an %s exception, core id is %" PRIu64 ", "
            "error code = %s, dump info: "
            "pc start: %#" PRIx64 ", current: %#" PRIx64 ", "
            "sc error info: %#" PRIx64 ", su error info: %#" PRIx64 ",%#" PRIx64 ", "
            "mte error info: %#" PRIx64 ", vec error info: %#" PRIx64 ", "
            "cube error info: %#" PRIx64 ", l1 error info: %#" PRIx64 ", "
            "aic error mask: %#" PRIx64 ", para base: %#" PRIx64 ".",
            info->u.davidCoreErrorInfo.comm.chipId, info->u.davidCoreErrorInfo.comm.dieId, errorNumber,
            GetStarsRingBufferHeadMsg(info->u.davidCoreErrorInfo.comm.type).c_str(),
            info->u.davidCoreErrorInfo.info[coreIdx].coreId, errorCode.c_str(),
            info->u.davidCoreErrorInfo.info[coreIdx].pcStart, info->u.davidCoreErrorInfo.info[coreIdx].currentPC,
            info->u.davidCoreErrorInfo.info[coreIdx].scErrInfo, info->u.davidCoreErrorInfo.info[coreIdx].suErrInfo[0],
            info->u.davidCoreErrorInfo.info[coreIdx].suErrInfo[1],
            info->u.davidCoreErrorInfo.info[coreIdx].mteErrInfo, info->u.davidCoreErrorInfo.info[coreIdx].vecErrInfo,
            info->u.davidCoreErrorInfo.info[coreIdx].cubeErrInfo, info->u.davidCoreErrorInfo.info[coreIdx].l1ErrInfo,
            info->u.davidCoreErrorInfo.info[coreIdx].aicErrorMask, info->u.davidCoreErrorInfo.info[coreIdx].paraBase);
        RT_LOG_CALL_MSG(ERR_MODULE_TBE,
            "The extend info: errcode:(%s) errorStr: %s subErrType: %#x.",
            errorCode.c_str(), errorString.c_str(), info->u.davidCoreErrorInfo.info[coreIdx].subErrType);
    }
    return RT_ERROR_NONE;
}

static void RecordSdmaErrorInfo(const Device * const dev, uint32_t coreNum, TaskInfo *errTaskPtr,
    const StarsDeviceErrorInfo * const info, const uint64_t errorNumber)
{
    for (uint32_t coreIdx = 0U; coreIdx < coreNum; coreIdx++) {
        RT_LOG_CALL_MSG(ERR_MODULE_GE, "The error from device(chipId:%u, dieId:%u), "
            "serial number is %" PRIu64 ".there is a sdma error, sdma channel is %hhu, "
            "sdmaChFsmState=0x%x, sdmaChFree=0x%x, irqStatus=0x%x, cqeStatus=0x%x ",
            info->u.sdmaErrorInfo.comm.chipId, info->u.sdmaErrorInfo.comm.dieId, errorNumber,
            info->u.sdmaErrorInfo.sdma.starsInfoForDavid[coreIdx].sdmaChannelId,
            info->u.sdmaErrorInfo.sdma.starsInfoForDavid[coreIdx].sdmaChFsmState,
            info->u.sdmaErrorInfo.sdma.starsInfoForDavid[coreIdx].sdmaChFree,
            info->u.sdmaErrorInfo.sdma.starsInfoForDavid[coreIdx].irqStatus,
            info->u.sdmaErrorInfo.sdma.starsInfoForDavid[coreIdx].cqeStatus);
        const uint32_t cqeStatus = info->u.sdmaErrorInfo.sdma.starsInfoForDavid[coreIdx].cqeStatus;
        if ((cqeStatus == TS_SDMA_STATUS_DDRC_ERROR) || (cqeStatus == TS_SDMA_STATUS_LINK_ERROR) ||
            (cqeStatus == TS_SDMA_STATUS_POISON_ERROR)) {
            bool hasSpecialErrorCode = false;
            COND_PROC((errTaskPtr == nullptr) && (Runtime::Instance()->GetHbmRasProcFlag() == HBM_RAS_NOT_SUPPORT),
                SetDeviceFaultTypeByErrorType(dev, SDMA_ERROR, hasSpecialErrorCode));
            if (errTaskPtr != nullptr) {
                GetMteErrFromCqeStatus(errTaskPtr, dev, cqeStatus, g_mulBitEccEventIdBlkList);
                RT_LOG(RT_LOG_ERROR, "Get sdma mte error, stream_id=%hu, task_id=%hu, errorCode=%u.",
                    info->u.coreErrorInfo.comm.streamId, info->u.coreErrorInfo.comm.taskId, errTaskPtr->mte_error);
            }
        }
    }
}

rtError_t ProcessStarsSdmaErrorInfo(const StarsDeviceErrorInfo * const info,
    const uint64_t errorNumber, const Device * const dev, const DeviceErrorProc * const insPtr)
{
    UNUSED(insPtr);
    RUNTIME_NULL_NO_PROC_WITH_RET(info);
    RUNTIME_NULL_NO_PROC_WITH_RET(dev);
    TaskInfo *errTaskPtr = GetTaskInfo(dev, static_cast<uint32_t>(info->u.sdmaErrorInfo.comm.streamId),
        static_cast<uint32_t>(info->u.sdmaErrorInfo.comm.taskId));
    if (errTaskPtr != nullptr) {
        errTaskPtr->isRingbufferGet = true;
    }
    const uint32_t coreNum = static_cast<uint32_t>(info->u.sdmaErrorInfo.comm.coreNum);
    RecordSdmaErrorInfo(dev, coreNum, errTaskPtr, info, errorNumber);
    return RT_ERROR_NONE;
}

static void CheckAixErrorClassInFusionKernel(const StarsDeviceErrorInfo *errInfo, const StarsDeviceErrorInfo * const info,
    Device * const dev, TaskInfo *errTaskPtr)
{
    if ((info == nullptr) || (errInfo == nullptr)) {
        return;
    }

    RT_LOG(RT_LOG_ERROR, "comm_flag=%hhu", errInfo->u.coreErrorInfo.comm.flag);
 
    if ((info->u.fusionKernelErrorInfo.cqeStatus & FUSION_CQE_STATUS_ERROR_MASK) != FUSION_CQE_STATUS_ONLY_AIX_ERROR) {
        RT_LOG(RT_LOG_INFO, "Fusion task not only happens aicore exception, cqeStatus=0x%x.",
            info->u.fusionKernelErrorInfo.cqeStatus);
        return;
    }

    SetDeviceFaultTypeByAixErrClass(dev, errInfo, errTaskPtr);
}

rtError_t ProcessDavidStarsFusionKernelErrorInfo(const StarsDeviceErrorInfo * const info,
    const uint64_t errorNumber, const Device * const dev, const DeviceErrorProc * const insPtr)
{
    if (info == nullptr) {
        return RT_ERROR_NONE;
    }

    TaskInfo *errTaskPtr = GetTaskInfo(dev, static_cast<uint32_t>(info->u.fusionKernelErrorInfo.comm.streamId),
        static_cast<uint32_t>(info->u.fusionKernelErrorInfo.comm.taskId));
    if (errTaskPtr != nullptr) {
        errTaskPtr->isRingbufferGet = true;
    }

    RT_LOG_CALL_MSG(ERR_MODULE_TBE, "The error from device(chipId=%u, dieId=%u), serial number is %" PRIu64 ", "
        "exception occurred during fusion kernel task execution, streamId=%u, taskId=%u, subtasks' subType=%hu,"
        "sqeLength=%hu, cqeStatus=%u.", info->u.fusionKernelErrorInfo.comm.chipId, info->u.fusionKernelErrorInfo.comm.dieId,
        errorNumber, info->u.fusionKernelErrorInfo.comm.streamId, info->u.fusionKernelErrorInfo.comm.taskId,
        info->u.fusionKernelErrorInfo.subType, info->u.fusionKernelErrorInfo.sqeLength,
        info->u.fusionKernelErrorInfo.cqeStatus);

    const uint32_t * const cmd = RtPtrToPtr<const uint32_t *, const rtDavidSqe_t *>(info->u.fusionKernelErrorInfo.davidSqe);
    const size_t size = sizeof(rtDavidSqe_t) * (info->u.fusionKernelErrorInfo.sqeLength + 1U);
    for (uint32_t i = 0U; i < (size / sizeof(uint32_t)); i += 8U) {
        RT_LOG(RT_LOG_ERROR, "printSqe: %08x %08x %08x %08x %08x %08x %08x %08x",
            cmd[i], cmd[i + 1U], cmd[i + 2U], cmd[i + 3U], cmd[i + 4U], cmd[i + 5U], cmd[i + 6U],
            cmd[i + 7U]);
    }

    RT_LOG(RT_LOG_ERROR, "structSize=%u, aicError=%u, aivError=%u, aicpuError=%u, ccuError=%u."
        "(just used to check if need process sub task's ringbuffer or not)",
        sizeof(StarsFusionKernelErrorInfo),
        info->u.fusionKernelErrorInfo.aicError, info->u.fusionKernelErrorInfo.aivError,
        info->u.fusionKernelErrorInfo.aicpuError, info->u.fusionKernelErrorInfo.ccuError);

    /* 处理子任务 */
    const StarsDeviceErrorInfo *errInfo = nullptr;
    if (info->u.fusionKernelErrorInfo.aicpuError == 1U) {
        errInfo = RtPtrToPtr<const StarsDeviceErrorInfo *>(&(info->u.fusionKernelErrorInfo.u.aicpuInfo));
        (void)ProcessStarsAicpuErrorInfo(errInfo, errorNumber, dev, insPtr);
    } else if (info->u.fusionKernelErrorInfo.ccuError == 1U) {
        errInfo = RtPtrToPtr<const StarsDeviceErrorInfo *>(&(info->u.fusionKernelErrorInfo.u.ccuInfo));
        (void)ProcessDavidStarsCcuErrorInfo(errInfo, errorNumber, dev, insPtr);
    } else {
        // 分别处理aicpuerror和ccuerror，其他情况不处理
    }

    if (info->u.fusionKernelErrorInfo.aicError == 1U) {
        errInfo = RtPtrToPtr<const StarsDeviceErrorInfo *>(&(info->u.fusionKernelErrorInfo.aicInfo));
        CheckAixErrorClassInFusionKernel(errInfo, info, RtPtrToUnConstPtr<Device *>(dev), errTaskPtr);
        (void)ProcessDavidStarsCoreErrorInfo(errInfo, errorNumber, dev, insPtr);
    }
    if (info->u.fusionKernelErrorInfo.aivError == 1U) {
        errInfo = RtPtrToPtr<const StarsDeviceErrorInfo *>(&(info->u.fusionKernelErrorInfo.aivInfo));
        CheckAixErrorClassInFusionKernel(errInfo, info, RtPtrToUnConstPtr<Device *>(dev), errTaskPtr);
        (void)ProcessDavidStarsCoreErrorInfo(errInfo, errorNumber, dev, insPtr);
    }
    return RT_ERROR_NONE;
}

static void GetExceptionArgsForFusionKernelTask(const TaskInfo * const taskInfo, rtExceptionArgsInfo_t * const argsInfo)
{
    (void)memset_s(argsInfo, sizeof(rtExceptionArgsInfo_t), 0U, sizeof(rtExceptionArgsInfo_t));
    const FusionTaskInfo * const fusionKernelTask = &(taskInfo->u.fusionKernelTask);

    Kernel *kernel = fusionKernelTask->aicPart.kernel;
    GetKernelExceptionDfxInfo(kernel, &(fusionKernelTask->aicPart.inputArgsSize), fusionKernelTask->args,
        fusionKernelTask->argsSize, argsInfo);
    return;
}

static void SetCcuExceptionSqeInfo(rtCcuSqeDetailInfo_t * const sqeInfo, RtDavidStarsCcuSqe * const ccuSqe,
    uint32_t inputIdx, uint32_t outputIdx)
{
    uint64_t* args = sqeInfo[outputIdx].args;
    sqeInfo[outputIdx].dieId = ccuSqe[inputIdx].resv.ccuResvDesc1.dieId;
    sqeInfo[outputIdx].instrId = ccuSqe[inputIdx].instStartId;
    sqeInfo[outputIdx].missionId = ccuSqe[inputIdx].resv.ccuResvDesc1.missionId;
    /* word6-15 memcpy, 5*8=40B */
    constexpr size_t firstCpySize = sizeof(uint64_t) * 5U;
    (void)memcpy_s(args, firstCpySize,
        RtPtrToPtr<uint8_t *, RtDavidStarsCcuSqe *>(&ccuSqe[inputIdx]) + sizeof(rtDavidSqe_t) - firstCpySize, firstCpySize);

    /* second ccu sqe part: 64 Byte(1 sqe size) */
    (void)memcpy_s(RtPtrToPtr<uint8_t *, uint64_t *>(args) + firstCpySize, sizeof(rtDavidSqe_t), &ccuSqe[inputIdx + 1U],
        sizeof(rtDavidSqe_t));
    RT_LOG(RT_LOG_ERROR, "128B:index=%u, dieId=%u, missionId=%u, instrId=%u.", outputIdx, sqeInfo[outputIdx].dieId,
        sqeInfo[outputIdx].missionId, sqeInfo[outputIdx].instrId);
    return;
}

static void ParseAndGetCcuExceptionInfo(rtExceptionExpandInfo_t * const expandInfo, const TaskInfo * const taskInfo,
    const StarsDeviceErrorInfo * const info)
{
    rtDavidSqe_t *sqe = const_cast<rtDavidSqe_t *>(info->u.ccuErrorInfo.davidSqe);
    if (taskInfo->type == TS_TASK_TYPE_CCU_LAUNCH) {
        COND_RETURN_VOID(info->u.ccuErrorInfo.comm.coreNum > 1U,
            "ccu sub task num is invalid, coreNum=%hu.", info->u.ccuErrorInfo.comm.coreNum);
        expandInfo->u.ccuInfo.ccuTaskNum = 1U;
        expandInfo->u.ccuInfo.panicLogNum = info->u.ccuErrorInfo.comm.coreNum;
        RtDavidStarsCcuSqe *ccuSqe = RtPtrToPtr<RtDavidStarsCcuSqe *, rtDavidSqe_t *>(sqe);
        /* ccu launch only has 1 ccu task */
        SetCcuExceptionSqeInfo(expandInfo->u.ccuInfo.sqeInfo, ccuSqe, 0U, 0U);
        (void)memcpy_s(expandInfo->u.ccuInfo.panicLog[0U], MAX_CCU_EXCEPTION_INFO_SIZE,
            info->u.ccuErrorInfo.panicLog[0U], MAX_CCU_EXCEPTION_INFO_SIZE);
    } else if (taskInfo->type == TS_TASK_TYPE_FUSION_KERNEL) {
        rtFusionExDetailInfo_t* fusionDetail = &(expandInfo->u.fusionInfo);
        fusionDetail->u.aicoreCcuInfo.ccuDetailMsg.ccuTaskNum = taskInfo->u.fusionKernelTask.ccuSqeNum;
        fusionDetail->u.aicoreCcuInfo.ccuDetailMsg.panicLogNum = info->u.ccuErrorInfo.comm.coreNum;
        if (taskInfo->u.fusionKernelTask.ccuArgSize == RT_CCU_SQE32B_ARGS_SIZE) {
            COND_RETURN_VOID(info->u.ccuErrorInfo.comm.coreNum > FUSION_SUB_TASK_MAX_CCU_NUM,
                "32B ccu sub task num is invalid, coreNum=%hu.", info->u.ccuErrorInfo.comm.coreNum);
            RtDavidStarsCcuSqe32B *ccuSqe = RtPtrToPtr<RtDavidStarsCcuSqe32B *, rtDavidSqe_t *>(sqe);
            for (uint8_t idx = 0U; idx < taskInfo->u.fusionKernelTask.ccuSqeNum; idx++) {
                fusionDetail->u.aicoreCcuInfo.ccuDetailMsg.sqeInfo[idx].dieId = ccuSqe[idx].resv.ccuResvDesc1.dieId;
                fusionDetail->u.aicoreCcuInfo.ccuDetailMsg.sqeInfo[idx].instrId = ccuSqe[idx].instStartId;
                fusionDetail->u.aicoreCcuInfo.ccuDetailMsg.sqeInfo[idx].missionId = ccuSqe[idx].resv.ccuResvDesc1.missionId;
                (void)memcpy_s(fusionDetail->u.aicoreCcuInfo.ccuDetailMsg.sqeInfo[idx].args, sizeof(uint64_t),
                    ccuSqe[idx].usrData, sizeof(uint64_t));
                RT_LOG(RT_LOG_ERROR, "32B:coreNum=%u, dieId=%hhu, missionId=%hhu, instrId=%hu, args=%#x.",
                    info->u.ccuErrorInfo.comm.coreNum,
                    fusionDetail->u.aicoreCcuInfo.ccuDetailMsg.sqeInfo[idx].dieId,
                    fusionDetail->u.aicoreCcuInfo.ccuDetailMsg.sqeInfo[idx].missionId,
                    fusionDetail->u.aicoreCcuInfo.ccuDetailMsg.sqeInfo[idx].instrId,
                    fusionDetail->u.aicoreCcuInfo.ccuDetailMsg.sqeInfo[idx].args[0U]);
            }
        } else {
            COND_RETURN_VOID(info->u.ccuErrorInfo.comm.coreNum > 2U,
                "128B ccu sub task num is invalid, coreNum=%hu.", info->u.ccuErrorInfo.comm.coreNum);
            RtDavidStarsCcuSqe *ccuSqe = RtPtrToPtr<RtDavidStarsCcuSqe *, rtDavidSqe_t *>(sqe);
            uint8_t idx = 0U;
            for (uint8_t num = 0U; num < taskInfo->u.fusionKernelTask.ccuSqeNum; num++) {
                SetCcuExceptionSqeInfo(fusionDetail->u.aicoreCcuInfo.ccuDetailMsg.sqeInfo, ccuSqe, static_cast<uint32_t>(idx), 
                    static_cast<uint32_t>(num));
                idx += 2U;
            }
        }
        for (uint8_t idx = 0U; idx < info->u.ccuErrorInfo.comm.coreNum; idx++) {
            (void)memcpy_s(fusionDetail->u.aicoreCcuInfo.ccuDetailMsg.panicLog[idx], MAX_CCU_EXCEPTION_INFO_SIZE,
                info->u.ccuErrorInfo.panicLog[idx], MAX_CCU_EXCEPTION_INFO_SIZE);
        }
    }
}

/* TaskFailCallBack for ccu and fusion can only use in ringbuffer process. */
static void TaskFailCallBackForFusionKernelTask(const TaskInfo * const taskInfo, const uint32_t deviceId,
    const StarsDeviceErrorInfo * const info)
{
    COND_RETURN_VOID(taskInfo == nullptr, "taskInfo is nullptr.");
    const int32_t streamId = taskInfo->stream->Id_();
    const uint32_t threadId = taskInfo->tid;
    rtExceptionInfo_t exceptionInfo;
    (void)memset_s(&exceptionInfo, sizeof(rtExceptionInfo_t), 0U, sizeof(rtExceptionInfo_t));
    rtExceptionExpandInfo_t *expandInfo = &(exceptionInfo.expandInfo);
    rtFusionExDetailInfo_t *fusionDetail = &(expandInfo->u.fusionInfo);
    fusionDetail->type = RT_FUSION_AICORE_CCU;

    ParseAndGetCcuExceptionInfo(expandInfo, taskInfo, info);
    exceptionInfo.retcode = static_cast<uint32_t>(ACL_ERROR_RT_TS_ERROR);
    exceptionInfo.taskid = taskInfo->taskSn;
    exceptionInfo.streamid = static_cast<uint32_t>(streamId);
    exceptionInfo.tid = threadId;
    exceptionInfo.deviceid = deviceId;
    expandInfo->type = RT_EXCEPTION_FUSION;
    GetExceptionArgsForFusionKernelTask(taskInfo, &(expandInfo->u.fusionInfo.u.aicoreCcuInfo.exceptionArgs));
    RT_LOG(RT_LOG_WARNING, "fusion kernel task: stream_id=%d, exception_task_id=%u, expandType=%u, retCode=%#x.",
        streamId, exceptionInfo.taskid, expandInfo->type, exceptionInfo.retcode);

    TaskFailCallBackNotify(&exceptionInfo);
}

static void TaskFailCallBackForCcuTask(const TaskInfo * const taskInfo, const uint32_t deviceId,
    const StarsDeviceErrorInfo * const info)
{
    COND_RETURN_VOID(taskInfo == nullptr, "taskInfo is nullptr.");
    const int32_t streamId = taskInfo->stream->Id_();
    const uint32_t threadId = taskInfo->tid;
    rtExceptionInfo_t exceptionInfo;
    (void)memset_s(&exceptionInfo, sizeof(rtExceptionInfo_t), 0U, sizeof(rtExceptionInfo_t));
    rtExceptionExpandInfo_t *expandInfo = &(exceptionInfo.expandInfo);

    ParseAndGetCcuExceptionInfo(expandInfo, taskInfo, info);
    exceptionInfo.retcode = static_cast<uint32_t>(ACL_ERROR_RT_TS_ERROR);
    exceptionInfo.taskid = taskInfo->taskSn;
    exceptionInfo.streamid = static_cast<uint32_t>(streamId);
    exceptionInfo.tid = threadId;
    exceptionInfo.deviceid = deviceId;
    expandInfo->type = RT_EXCEPTION_CCU;
    RT_LOG(RT_LOG_WARNING, "fusion kernel task: stream_id=%d, exception_task_id=%u, expandType=%u, retCode=%#x.",
        streamId, exceptionInfo.taskid, expandInfo->type, exceptionInfo.retcode);

    TaskFailCallBackNotify(&exceptionInfo);
}

rtError_t ProcessDavidStarsCcuErrorInfo(const StarsDeviceErrorInfo * const info,
    const uint64_t errorNumber, const Device * const dev, const DeviceErrorProc * const insPtr)
{
    UNUSED(insPtr);
    if (info == nullptr) {
        return RT_ERROR_NONE;
    }

    TaskInfo *errTaskPtr = GetTaskInfo(dev, static_cast<uint32_t>(info->u.ccuErrorInfo.comm.streamId),
        static_cast<uint32_t>(info->u.ccuErrorInfo.comm.taskId));

    RT_LOG_CALL_MSG(ERR_MODULE_TBE, "The error from device(D-die, chipId=%u, dieId=%u), serial number is %" PRIu64 ", "
        "ccu task print, coreNum=%hu, streamId=%hu, taskId=%hu.", info->u.ccuErrorInfo.comm.chipId,
        info->u.ccuErrorInfo.comm.dieId, errorNumber, info->u.ccuErrorInfo.comm.coreNum,
        info->u.ccuErrorInfo.comm.streamId, info->u.ccuErrorInfo.comm.taskId);

    COND_RETURN_WARN(errTaskPtr == nullptr, RT_ERROR_NONE, "taskInfo is nullptr.");
    errTaskPtr->isRingbufferGet = true;

    /* maybe fusion or ccu can arrive at this step */
    if (errTaskPtr->type == TS_TASK_TYPE_CCU_LAUNCH) {
        TaskFailCallBackForCcuTask(errTaskPtr, dev->Id_(), info);
    } else if (errTaskPtr->type == TS_TASK_TYPE_FUSION_KERNEL) {
        TaskFailCallBackForFusionKernelTask(errTaskPtr, dev->Id_(), info);
    } else {
        /* do nothing */
    }

    return RT_ERROR_NONE;
}

rtError_t ProcessDavidStarsWaitTimeoutErrorInfo(const StarsDeviceErrorInfo * const info,
    const uint64_t errorNumber, const Device * const dev, const DeviceErrorProc * const insPtr)
{
    UNUSED(insPtr);
    if (info == nullptr) {
        return RT_ERROR_NONE;
    }

    TaskInfo *errTaskPtr = GetTaskInfo(dev, info->u.timeoutErrorInfo.streamId, info->u.timeoutErrorInfo.taskId);
    if (errTaskPtr != nullptr) {
        errTaskPtr->isRingbufferGet = true;
    }

    const uint8_t type = info->u.timeoutErrorInfo.waitType;
    if (type == RT_DAVID_SQE_TYPE_FUSION) {
        RT_LOG_CALL_MSG(ERR_MODULE_TBE, "The error from device(chipId:%u, dieId:%u), serial number is %" PRIu64 ", "
            "fusion wait timeout occurred during task execution, stream_id:%hu, sq_id:%hu, task_pos:%hu, "
            "sub_type=%u, timeout=%us.", info->u.timeoutErrorInfo.chipId, info->u.timeoutErrorInfo.dieId, errorNumber,
            info->u.timeoutErrorInfo.streamId, info->u.timeoutErrorInfo.sqId, info->u.timeoutErrorInfo.taskId,
            info->u.timeoutErrorInfo.wait.fusionInfo.subType, info->u.timeoutErrorInfo.wait.fusionInfo.timeout);
        TaskFailCallBackForFusionKernelTask(errTaskPtr, dev->Id_(), info);
    }
    if (type == RT_DAVID_SQE_TYPE_CCU) {
        RT_LOG_CALL_MSG(ERR_MODULE_TBE, "The error from device(chipId:%u, dieId:%u), serial number is %" PRIu64 ", "
            "ccu wait timeout occurred during task execution, stream_id=%hu, sq_id=%hu, task_pos=%hu, mission_id=%hu, "
            "dieid=%u, ccu_size=%u, timeout=%us.",
            info->u.timeoutErrorInfo.chipId, info->u.timeoutErrorInfo.dieId, errorNumber,
            info->u.timeoutErrorInfo.streamId, info->u.timeoutErrorInfo.sqId, info->u.timeoutErrorInfo.taskId,
            info->u.timeoutErrorInfo.wait.ccuInfo.missionId, info->u.timeoutErrorInfo.wait.ccuInfo.dieId,
            info->u.timeoutErrorInfo.wait.ccuInfo.ccuSize, info->u.timeoutErrorInfo.wait.ccuInfo.timeout);
        TaskFailCallBackForCcuTask(errTaskPtr, dev->Id_(), info);
    }
    if (type == RT_DAVID_SQE_TYPE_NOTIFY_WAIT) {
        RT_LOG_CALL_MSG(ERR_MODULE_SYSTEM, "The error from device(chipId:%u, dieId:%u), serial number is %" PRIu64 ", "
            "wait timeout occurred during task execution, stream_id:%hu, sq_id:%hu, task_pos:%hu, "
            "id=%u, timeout=%us, cntFlag = %u, subType = %u(%s), cntValue = %u, clrFlag = %u, waitMode = %u, "
            "bitmap = %u.", info->u.timeoutErrorInfo.chipId, info->u.timeoutErrorInfo.dieId, errorNumber,
            info->u.timeoutErrorInfo.streamId, info->u.timeoutErrorInfo.sqId, info->u.timeoutErrorInfo.taskId,
            info->u.timeoutErrorInfo.wait.errorInfo.notifyId, info->u.timeoutErrorInfo.wait.errorInfo.timeout,
            info->u.timeoutErrorInfo.wait.errorInfo.cntFlag, info->u.timeoutErrorInfo.wait.errorInfo.subType,
            GetNotifySubType(static_cast<uint16_t>(info->u.timeoutErrorInfo.wait.errorInfo.subType)),
            info->u.timeoutErrorInfo.wait.errorInfo.cntValue, info->u.timeoutErrorInfo.wait.errorInfo.clrFlag,
            info->u.timeoutErrorInfo.wait.errorInfo.waitMode, info->u.timeoutErrorInfo.wait.errorInfo.bitmap);
    }
    return RT_ERROR_NONE;
}

rtError_t ProcRingBufferTaskDavid(const Device *const dev, const void * const devMem, const bool delFlag,
    const uint32_t len)
{
    TaskInfo *tsk = nullptr;
    Stream *stm = dev->PrimaryStream_();
    NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);
    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "stream check failed, stream_id=%d, retCode=%#x.", stm->Id_(),
        static_cast<uint32_t>(error));
    uint32_t pos = 0xFFFFU;
    std::function<void()> const errRecycle = [&tsk, &stm, &pos]() {
        TaskUnInitProc(tsk);
        TaskRollBack(stm, pos);
        stm->StreamUnLock();
    };
    stm->StreamLock();
    error = AllocTaskInfo(&tsk, stm, pos);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();, "Failed to alloc task, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    SaveTaskCommonInfo(tsk, stm, pos);
    error = RingBufferMaintainTaskInit(tsk, devMem, delFlag, len);
    ScopeGuard tskErrRecycle(errRecycle);
    ERROR_RETURN_MSG_INNER(error, "Failed to init create ringbuffer task, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    error = DavidSendTask(tsk, stm);
    ERROR_RETURN_MSG_INNER(error, "Failed to submit task, stream_id=%d, retCode=%#x", stm->Id_(),
        static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    stm->StreamUnLock();
    return RT_ERROR_NONE;
}

}  // namespace runtime
}  // namespace cce