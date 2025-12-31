/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "device/device_error_proc.hpp"
#include <memory>
#include <string>
#include "runtime.hpp"
#include "stream.hpp"
#include "task.hpp"
#include "error_message_manage.hpp"
#include "task_submit.hpp"
#include "context.hpp"
#include "task_fail_callback_manager.hpp"
#include "stream_sqcq_manage.hpp"
#include "ctrl_stream.hpp"
#include "stub_task.hpp"
#include "context_manage.hpp"

namespace cce {
namespace runtime {
namespace {
constexpr uint32_t TS_SDMA_STATUS_DDRC_ERROR = 0x8U;
constexpr uint32_t TS_SDMA_STATUS_LINK_ERROR = 0x9U;
constexpr uint32_t TS_SDMA_STATUS_POISON_ERROR = 0xAU;
} // namespace

// alloc a huge page size

const std::map<uint64_t, DeviceErrorProc::ErrorInfoProc> DeviceErrorProc::funcMap_ = {
    {AICORE_ERROR, &DeviceErrorProc::ProcessCoreErrorInfo},
    {AIVECTOR_ERROR, &DeviceErrorProc::ProcessCoreErrorInfo},
    {SDMA_ERROR,   &DeviceErrorProc::ProcessSdmaErrorInfo},
    {AICPU_ERROR,  &DeviceErrorProc::ProcessAicpuErrorInfo}
};
AicErrorInfo DeviceErrorProc::error_pc[MAX_DEV_ID] = {{}};

const std::map<uint64_t, std::string> DeviceErrorProc::errMsgCommMap_ = {
    {AICORE_ERROR, RT_NPU_COMMON_INNER_ERROR},
    {AIVECTOR_ERROR, RT_NPU_COMMON_INNER_ERROR},
    {AICPU_ERROR, RT_AICPU_INNER_ERROR}};

const std::map<uint64_t, std::string> DeviceErrorProc::cqeErrorMapInfo_ = {
    {0,  "SUCCESS"},
    {1,  "One of the following errors may occur: 1)Submission Descriptor read response error, "
         "2)Invalid OPCODE in the SQE."},
    {2,  "When the SQE translates a page table, the SMMU returns a Terminate error."},
    {3,  "Reserved."},
    {4,  "An error reported by the SDMA: can't access the DDR space."},
    {5,  "An error is reported by the SDMA: the transfer address delivered by the SDMA is not mapped in the DAW."},
    {6,  "An error is reported by the SDMA: the operation type is incorrect."},
    {7,  "An error is reported by the SDMA: a DDRC error occurs during the SDMA transfer."},
    {8,  "An error is reported by the SDMA: an ECC error occurs during the SDMA transfer."},
    {9,  "An error is reported by the SDMA: a COMPERR error occurs during the SDMA transfer."},
    {10, "An error is reported by the SDMA: a COMPDATAERR error occurs during the SDMA transfer."},
    {11, "An error is reported by the SDMA: an overflow error occurs during the reduce operation."},
    {12, "An error is reported by the SDMA: an underflow error occurs during the reduce operation."},
    {13, "An error is reported by the SDMA: the format of the reduce source data does not meet requirements."},
    {14, "An error is reported by the SDMA: the format of the reduce destination data does not meet requirements."},
    {15, "An error is reported by the SDMA: "
         "the formats of the reduce source and destination data do not meet requirements."},
};

const std::map<uint64_t, std::string> DeviceErrorProc::channelErrorMapInfo_ = {
    {SDMA_SQE_READ_RSP_ERR, "Submission Descriptor read response error."},
    {SDMA_SMMU_TERMINATE, "The SMMU returns a Terminate error during page table translation."},
    {SDMA_DMAA_ERR1, "DMAA Error"},
    {SDMA_DMAA_ERR2, "Reserved"},
    {SDMA_DMAA_ERR3, "Reserved"},
    {SDMA_AXIM_BERR, "AXIM Berr."},
    {SDMA_SQ_TABLE_ALL_ZERO, ""},
    {SDMA_ERROR_TIMEOUT, "time out"}
};

namespace {
enum RtCoreErrorType : std::uint8_t {
    // this is bit position
    BIU_L2_READ_OOB = 0,
    BIU_L2_WRITE_OOB,
    CCU_CALL_DEPTH_OVRFLW,
    CCU_DIV0,
    CCU_ILLEGAL_INSTR,
    CCU_LOOP_CNT_ERR,
    CCU_LOOP_ERR,
    CCU_NEG_SQRT,
    CCU_UB_ECC,
    CUBE_INVLD_INPUT,
    CUBE_L0A_ECC,
    CUBE_L0A_RDWR_CFLT,
    CUBE_L0A_WRAP_AROUND,
    CUBE_L0B_ECC,
    CUBE_L0B_RDWR_CFLT,
    CUBE_L0B_WRAP_AROUND,
    CUBE_L0C_ECC,
    CUBE_L0C_RDWR_CFLT,
    CUBE_L0C_SELF_RDWR_CFLT,
    CUBE_L0C_WRAP_AROUND,
    IFU_BUS_ERR,
    MTE_AIPP_ILLEGAL_PARAM,
    MTE_BAS_RADDR_OBOUND,
    MTE_BIU_RDWR_RESP,
    MTE_CIDX_OVERFLOW,
    MTE_DECOMP,
    MTE_F1WPOS_LARGER_FSIZE,
    MTE_FMAP_LESS_KERNEL,
    MTE_FMAPWH_LARGER_L1SIZE,
    MTE_FPOS_LARGER_FSIZE,
    MTE_GDMA_ILLEGAL_BURST_LEN,
    MTE_GDMA_ILLEGAL_BURST_NUM,
    MTE_GDMA_READ_OVERFLOW,
    MTE_GDMA_WRITE_OVERFLOW,
    MTE_COMP,
    MTE_ILLEGAL_FM_SIZE,
    MTE_ILLEGAL_L1_3D_SIZE,
    MTE_ILLEGAL_STRIDE,
    MTE_L0A_RDWR_CFLT,
    MTE_L0B_RDWR_CFLT,
    MTE_L1_ECC,
    MTE_PADDING_CFG,
    MTE_READ_OVERFLOW,
    MTE_ROB_ECC,
    MTE_TLU_ECC,
    MTE_UB_ECC,
    MTE_UNZIP,
    MTE_WRITE_3D_OVERFLOW,
    MTE_WRITE_OVERFLOW,
    VEC_DATA_EXCP_CCU,
    VEC_DATA_EXCP_MTE,
    VEC_DATA_EXCP_VEC,
    VEC_DIV0,
    VEC_ILLEGAL_MASK,
    VEC_INF_NAN,
    VEC_L0C_ECC,
    VEC_L0C_RDWR_CFLT,
    VEC_NEG_LN,
    VEC_NEG_SQRT,
    VEC_SAME_BLK_ADDR,
    VEC_UB_ECC,
    VEC_UB_SELF_RDWR_CFLT,
    VEC_UB_WRAP_AROUND,
    BIU_DFX_ERR,
    /*********************** aicore error_2 for stars ***********************/
    CCU_SBUF_ECC,
    VEC_COL2IMG_RD_FM_ADDR_OVFLOW,
    VEC_COL2IMG_RD_DFM_ADDR_OVFFLOW,
    VEC_COL2IMG_ILLEGAL_FM_SIZE,
    VEC_COL2IMG_ILLEGAL_STRIDE,
    VEC_COL2IMG_ILLEGAL_1ST_WIN_POS,
    VEC_COL2IMG_ILLEGAL_FETCH_POS,
    VEC_COL2IMG_ILLEGAL_K_SIZE,
    CCU_INF_NAN,
    MTE_ILLEGAL_SCHN_CFG,
    MTE_ATM_ADDR_MISALG,
    VEC_INSTR_ADDR_MISALIGN,
    VEC_INSTR_ILLEGAL_CFG,
    VEC_INSTR_UNDEF,
    CCU_ADDR_ERR,
    CCU_BUS_ERR,
    MTE_ERR_ADDR_MISALIGN,
    MTE_ERR_DW_PAD_CONF_ERR,
    MTE_ERR_DW_FMAP_H_ILLEGAL,
    MTE_ERR_WINO_L0B_WRITE_OVERFLOW,
    MTE_ERR_WINO_L0B_READ_OVERFLOW,
    MTE_ERR_ILLEGAL_V_COV_PAD_CTL,
    MTE_ERR_ILLEGAL_H_COV_PAD_CTL,
    MTE_ERR_ILLEGAL_W_SIZE,
    MTE_ERR_ILLEGAL_H_SIZE,
    MTE_ERR_ILLEGAL_CHN_SIZE,
    MTE_ERR_ILLEGAL_K_M_EXT_STEP,
    MTE_ERR_ILLEGAL_K_M_START_POS,
    MTE_ERR_ILLEGAL_SMALLK_CFG,
    MTE_ERR_READ_3D_OVERFLOW,
    CCU_VECIQ_ECC,
    CCU_DC_DATA_ECC,
    /*********************** aicore error_3 for stars ***********************/
    CCU_DC_TAG_ECC,
    CCU_DIV0_FP,
    CCU_NEG_SQRT_FP,
    CNT_SW_BUS_ERR,
    FIXP_ERR_INSTR_ADDR_MISAL,
    FIXP_ERR_ILLEGAL_CFG,
    FIXP_ERR_READ_L0C_OVFLW,
    FIXP_ERR_READ_L1_OVFLW,
    FIXP_ERR_READ_UB_OVFLW,
    FIXP_ERR_WRITE_L1_OVFLW,
    FIXP_ERR_WRITE_UB_OVFLW,
    FIXP_ERR_FBUF_WRITE_OVFLW,
    FIXP_ERR_FBUF_READ_OVFLW,
    SC_REG_PARITY_ERR,
    MTE_ERR_FIFO_PARITY,
    MTE_ERR_WAITSET,
    CCU_ERR_PARITY_ERR,
    MTE_ERR_CACHE_ECC,
    CUBE_ERR_HSET_CNT_UNF,
    CUBE_ERR_HSET_CNT_OVF,
    MTE_ERR_INSTR_ILLEGAL_CFG,
    MTE_ERR_HEBCD,
    MTE_ERR_HEBCE,
    MTE_ERR_WAIPP,
    CCU_SEQ_ERR,
    CCU_MPU_ERR,
    CCU_LSU_ERR,
    CCU_PB_ECC_ERR,
    MTE_UB_WR_OVFLW,
    MTE_UB_RD_OVFLW,
    CUBE_ILLEGAL_INSTR,
    CCU_SAFETY_CRC_ERR,
    /*********************** aicore error_4 for stars ***********************/
    MTE_TIMEOUT,
    MTE_UB_RD_CFLT,
    MTE_UB_WR_CFLT,
    MTE_KTABLE_WR_ADDR_OVERFLOW,
    MTE_KTABLE_RD_ADDR_OVERFLOW,
    CCU_UB_RD_CFLT,
    CCU_UB_WR_CFLT,
    CCU_UB_OVERFLOW_ERR,
    BIU_UNSPLIT_ERR,
    MTE_STB_ECC_ERR,
    MTE_AIPP_ECC_ERR,
    CCU_LSU_ATOMIC_ERR,
    CCU_CROSS_CORE_SET_OVFL_ERR,
    FIXP_ERR_OUT_WRITE_OVERFLOW,
    CUBE_ERR_PBUF_WRAP_AROUND,
    FIXP_L0C_ECC,
    MTE_ERR_L0C_RDWR_CFLT,
    /*********************** aicore error_5 for stars ***********************/
    VEC_DATA_EXCPT_MTE,
    VEC_DATA_EXCPT_SU,
    VEC_DATA_EXCPT_VEC,
    VEC_INSTR_TIMEOUT,
    VEC_INSTRS_UNDEF,
    VEC_INSTR_ILL_CFG,
    VEC_INSTR_MISALIGN,
    VEC_INSTR_ILL_MASK,
    VEC_INSTR_ILL_SQZN,
    VEC_UB_ADDR_WRAP_AROUND,
    VEC_UB_ECC_MBERR,
    VEC_IDATA_INF_NAN,
    VEC_DIV_BY_ZERO,
    VEC_VALU_NEG_LN,
    VEC_VALU_NEG_SQRT,
    VEC_VCI_IDATA_OUT_RANGE,
    VEC_ILL_VLOOP_OP,
    VEC_ILL_VLOOP_SREG,
    VEC_LD_NUM_MISMATCH,
    VEC_ST_NUM_MISMATCH,
    VEC_EX_NUM_MISMATCH,
    VEC_LD_NUM_EXCEED_LIMIT,
    VEC_ST_NUM_EXCEED_LIMIT,
    VEC_ILL_INSTR_PADDING,
    VEC_ILL_VGA_VPD_ORDER,
    VEC_IC_ECC_ERR,
    VEC_BIU_RESP_ERR,
    VEC_PB_ECC_MBERR,
    VEC_PB_READ_NO_RESP,
    VEC_VALU_ILL_ISSUE,
    VEC_ERR_PARITY_ERR
};
} // namespace

const std::map<uint64_t, std::string> DeviceErrorProc::errorMapInfo_ = {
    {BIU_L2_READ_OOB, "Bus read access error. You are advised to check the L2 code."},
    {BIU_L2_WRITE_OOB, "Bus write access error. You are advised to check the L2 code."},
    {CCU_CALL_DEPTH_OVRFLW, "The number of nesting times of call the function is greater than CTRL[5:2]."},
    {CCU_DIV0, "divide by zero."},
    {CCU_ILLEGAL_INSTR, "Illegal instruction, which is usually caused by unaligned UUB addresses."},
    {CCU_LOOP_CNT_ERR, "The lpcont of the loop instruction is 0."},
    {CCU_LOOP_ERR, "It is found that the loopend instruction is executed before executing loop instruction."
     "The lcnt value is 0 when the loopend instruction is executed."},
    {CCU_NEG_SQRT, "The number of roots is negative. "},
    {CCU_UB_ECC, "ECC verification failed when UB read/write."},
    {CUBE_INVLD_INPUT, "the data of L0a and L0b read back is the INF or NAN data."},
    {CUBE_L0A_ECC, "ECC verification failed when L0A read/write."},
    {CUBE_L0A_RDWR_CFLT, "L0A read/write conflict."},
    {CUBE_L0A_WRAP_AROUND, "The operation address of L0A exceeds the maximum range of L0A."},
    {CUBE_L0B_ECC, "ECC verification failed when L0B read/write."},
    {CUBE_L0B_RDWR_CFLT, "L0B read/write conflict."},
    {CUBE_L0B_WRAP_AROUND, "The operation address of L0B exceeds the maximum range of L0B."},
    {CUBE_L0C_ECC, "ECC verification failed when L0C read/write."},
    {CUBE_L0C_RDWR_CFLT, "L0C read/write conflict(vec read operation or cube write operation)."},
    {CUBE_L0C_SELF_RDWR_CFLT, "L0C read/write conflict(cube read operation or cube write operation)."},
    {CUBE_L0C_WRAP_AROUND, "The operation address of L0C exceeds the maximum range of L0C."},
    {IFU_BUS_ERR, "it is usually instruction errors. The probability is low."},
    {MTE_AIPP_ILLEGAL_PARAM, "The configuration of AIPP is incorrect."},
    {MTE_BAS_RADDR_OBOUND, "The base address of the mte load3d instruction is out of boundary."},
    {MTE_BIU_RDWR_RESP, "The DDR address of the MTE instruction is out of range."},
    {MTE_CIDX_OVERFLOW, "The C0 index of the mte load3d instruction overflows."},
    {MTE_DECOMP, "The number of load index entries is different from the number of data blocks "
     "to be decompressed in the latest load decompressed data."},
    {MTE_F1WPOS_LARGER_FSIZE, "The 1st filter window position of the mte load3d instruction is greater than "
     "(Feature map size – Filter size)."},
    {MTE_FMAP_LESS_KERNEL, "The feature map size of the mte load3d instruction is less than the kernel size."},
    {MTE_FMAPWH_LARGER_L1SIZE,
     "FeatureMapW * FeatureMapH * (CIndex + 1) of the mte load3d instruction is greater than L1 buffer size/32."},
    {MTE_FPOS_LARGER_FSIZE, "The fetch position in filter of the mte load3d instruction is greater than the filter size."},
    {MTE_GDMA_ILLEGAL_BURST_LEN, "The burst length of the mte instruction is incorrect."},
    {MTE_GDMA_ILLEGAL_BURST_NUM, "The burst num of the mte command is incorrect."},
    {MTE_GDMA_READ_OVERFLOW, "The read address of the MTE instruction is out of range."},
    {MTE_GDMA_WRITE_OVERFLOW, "The write address of the MTE instruction is out of range."},
    {MTE_COMP, "A new index table is delivered before the current index is completed."},
    {MTE_ILLEGAL_FM_SIZE, "The feature map size of the mte load3d instruction is illegal(size = 0)."},
    {MTE_ILLEGAL_L1_3D_SIZE, "The set l1 3D size of the mte load3d instruction is illegal."},
    {MTE_ILLEGAL_STRIDE, "The stride size of the mte load3d instruction is illegal."},
    {MTE_L0A_RDWR_CFLT, "L0A read/write conflict in the MTE (same address)."},
    {MTE_L0B_RDWR_CFLT, "L0B read/write conflict in the MTE (same address)."},
    {MTE_L1_ECC, "ECC verification failed when L1 read/write."},
    {MTE_PADDING_CFG, "The error in mte load3d padding configuration."},
    {MTE_READ_OVERFLOW, "The read address of the mte load2d instruction is greater than the maximum address of the source (L1)."},
    {MTE_ROB_ECC, "An error occurs in the mte ROB ECC check."},
    {MTE_TLU_ECC, "An error occurred during the ECC check of the MTE TLU."},
    {MTE_UB_ECC, "The ECC verification of the UB in the VEC failed."},
    {MTE_UNZIP, "Decompression exception: length check or parity check or empty FIFO read or full FIFO write."},
    {MTE_WRITE_3D_OVERFLOW, "The write address of the mte load3d instruction is out of range."},
    {MTE_WRITE_OVERFLOW, "The write address of the mte load2d instruction is greater than the maximum destination address."},
    {VEC_DATA_EXCP_CCU, "Data from the CCU is abnormal."},
    {VEC_DATA_EXCP_MTE, "Data from the MTE is abnormal."},
    {VEC_DATA_EXCP_VEC, "Data from the VEC is abnormal."},
    {VEC_DIV0, "VEC instruction error: reciprocal division by 0 error."},
    {VEC_ILLEGAL_MASK, "VEC instruction error: the MASK instruction is all 0."},
    {VEC_INF_NAN, "VEC instruction error: the data is inf and nan."},
    {VEC_L0C_ECC, "VEC instruction error: ECC verification failed when the loc is read."},
    {VEC_L0C_RDWR_CFLT, "VEC read/write L0C and cube read/write L0C addresses are the same."},
    {VEC_NEG_LN, "VEC instruction error: the value of ln is a negative number."},
    {VEC_NEG_SQRT, "VEC instruction error: the reciprocal of the square root is a negative number."},
    {VEC_SAME_BLK_ADDR, "VEC instruction error: the destination blocks have the same address."},
    {VEC_UB_ECC, "VEC instruction error: ECC verification failed when the UB is read."},
    {VEC_UB_SELF_RDWR_CFLT, "The UB read address is same as the UB write address."},
    {VEC_UB_WRAP_AROUND, "VEC instruction error: the ub address out of bounds."},
    {BIU_DFX_ERR, "BIU error types, which need to be further read from BIU_STATUS1 bit 15:11."},
    {CCU_SBUF_ECC, "ECC is reported in the CCU Scalar buffer."},
    {VEC_COL2IMG_RD_FM_ADDR_OVFLOW, "The value of col2img is illegal."},
    {VEC_COL2IMG_RD_DFM_ADDR_OVFFLOW, "The value of col2img is illegal."},
    {VEC_COL2IMG_ILLEGAL_FM_SIZE, "The value of col2img is illegal."},
    {VEC_COL2IMG_ILLEGAL_STRIDE, "The value of col2img is illegal."},
    {VEC_COL2IMG_ILLEGAL_1ST_WIN_POS, "The value of col2img is illegal."},
    {VEC_COL2IMG_ILLEGAL_FETCH_POS, "The value of col2img is illegal."},
    {VEC_COL2IMG_ILLEGAL_K_SIZE, "The value of col2img is illegal."},
    {CCU_INF_NAN, "The input of the floating-point instruction run by the CCU is nan/inf."},
    {MTE_ILLEGAL_SCHN_CFG,
     "The small_channal enable flag is valid but does not meet the conditions for small_channal."},
    {MTE_ATM_ADDR_MISALG, "MTE atomic add addresses are not aligned (AIC, AIV1, and AIV2)."},
    {VEC_INSTR_ADDR_MISALIGN, "The UB address accessed by the VEC instruction is not aligned."},
    {VEC_INSTR_ILLEGAL_CFG, "VEC supports illegal configurations in commands."},
    {VEC_INSTR_UNDEF, "Commands not supported by the current VEC version."},
    {CCU_ADDR_ERR, "CCU instruction address check error."},
    {CCU_BUS_ERR,
     "When the D-cache reads and writes data to the UB, the response value returned by the bus is a non-zero value."},
    {MTE_ERR_ADDR_MISALIGN, "instruction address misalign(ADDR_MISALIGN)."},
    {MTE_ERR_DW_PAD_CONF_ERR, "DEPTHWIS PADDING is incorrectly configured."},
    {MTE_ERR_DW_FMAP_H_ILLEGAL, "The value of H configured on the DEPTHWISE FMAP is less than 3."},
    {MTE_ERR_WINO_L0B_WRITE_OVERFLOW, "L0B address overflow occurs when the WINOB writes to the L0B address."},
    {MTE_ERR_WINO_L0B_READ_OVERFLOW, "The L1 address read by the WINOB overflows, and the loop occurs."},
    {MTE_ERR_ILLEGAL_V_COV_PAD_CTL, "The value of WINOA V padding is illegal."},
    {MTE_ERR_ILLEGAL_H_COV_PAD_CTL, "The value of WINOA H padding is illegal."},
    {MTE_ERR_ILLEGAL_W_SIZE, "The value of WINOA fmap W is illegal."},
    {MTE_ERR_ILLEGAL_H_SIZE, "The value of WINOA fmap H is illegal."},
    {MTE_ERR_ILLEGAL_CHN_SIZE, "The value of CHN_SIZE is illegal."},
    {MTE_ERR_ILLEGAL_K_M_EXT_STEP, "The value of K_M_EXT_STEP is illegal."},
    {MTE_ERR_ILLEGAL_K_M_START_POS, "The value of K_M_START_POS is illegal."},
    {MTE_ERR_ILLEGAL_SMALLK_CFG, "The small K configuration of the MTE load3d instruction is incorrect."},
    {MTE_ERR_READ_3D_OVERFLOW, "The read address of the MTE load3d instruction is out of range."},
    {CCU_VECIQ_ECC, "A 2-bit ECC error occurs in the VEC issue queue."},
    {CCU_DC_DATA_ECC, "A 2-bit ECC error occurs in the data-cache data-ram."},
    {CCU_DC_TAG_ECC, "A 2-bit ECC error occurs in the data-cache tag-ram."},
    {CCU_DIV0_FP, "A error occurs in the FP32 DIV0."},
    {CCU_NEG_SQRT_FP, "The input of the FP SQRT calculation unit is a negative number."},
    {CNT_SW_BUS_ERR,
     "During the slow context switch, the SC transfers data through the AXI bus, and the AXI returns an error."},
    {FIXP_ERR_INSTR_ADDR_MISAL, "Read L0C, read L1, and write FIXP buffer addresses are not aligned."},
    {FIXP_ERR_ILLEGAL_CFG, "The configuration of FIXP is illegal."},
    {FIXP_ERR_READ_L0C_OVFLW, "The read address of the L0C is out of range."},
    {FIXP_ERR_READ_L1_OVFLW, "The read address of the L1 is out of range."},
    {FIXP_ERR_READ_UB_OVFLW, "The read address of the UB is out of range."},
    {FIXP_ERR_WRITE_L1_OVFLW, "The write address of the L1 is out of range."},
    {FIXP_ERR_WRITE_UB_OVFLW, "The write address of the UB is out of range."},
    {FIXP_ERR_FBUF_WRITE_OVFLW, "The write address of the FBUF is out of range."},
    {FIXP_ERR_FBUF_READ_OVFLW, "The read address of the FBUF is out of range."},
    {SC_REG_PARITY_ERR, "During safety check, parity errors occur in the registers in the nManager."},
    {MTE_ERR_FIFO_PARITY, "The data read from the MTE internal FIFO is incorrect."},
    {MTE_ERR_WAITSET, "The configuration of HWATI/HSET is incorrect."},
    {CCU_ERR_PARITY_ERR, "A parity check error occurs in the SU internal buffer during the safety feature."},
    {MTE_ERR_CACHE_ECC, "The MTE internal MVF cache fails."},
    {CUBE_ERR_HSET_CNT_UNF, "A underflow error occurs in the CUBE HSET counter."},
    {CUBE_ERR_HSET_CNT_OVF, "A overflow error occurs in the CUBE HSET counter."},
    {MTE_ERR_INSTR_ILLEGAL_CFG, "The instruction configuration of MTE is illegal."},
    {MTE_ERR_HEBCD, "The instruction configuration of HEBCD is illegal."},
    {MTE_ERR_HEBCE, "The instruction configuration of HEBCE is illegal."},
    {MTE_ERR_WAIPP, "The instruction configuration of WAIPP is illegal."},
    {CCU_SEQ_ERR, "The SEQ command sequence is incorrect."},
    {CCU_MPU_ERR, "The MPU address access is invalid."},
    {CCU_LSU_ERR, "When the buffer is enabled, the stack access instruction cache is miss."},
    {CCU_PB_ECC_ERR, "A 2-bit ECC error occurs in the parameter buffer."},
    {MTE_UB_WR_OVFLW, "The address overflow occurs when the MTE writes to the UB address."},
    {MTE_UB_RD_OVFLW, "The address overflow occurs when the MTE reads to the UB address."},
    {CUBE_ILLEGAL_INSTR, "The instruction configuration of CUBE is illegal."},
    {CCU_SAFETY_CRC_ERR, "MTE CRC error."},
    {MTE_TIMEOUT, "Lite Only Error, an exception is reported when the MTE instruction or data times out."},
    {MTE_UB_RD_CFLT,
     "Lite Only Error. When the MTE reads the ub, the ub read/write conflict occurs and an exception is reported."},
    {MTE_UB_WR_CFLT, "Lite Only Error. When the MTE writes to the UB, the UB read/write conflict is reported."},
    {MTE_KTABLE_WR_ADDR_OVERFLOW,
     "An exception is reported when a write address conflict occurs when the MTE is full."},
    {MTE_KTABLE_RD_ADDR_OVERFLOW,
     "An exception is reported when a read address conflict occurs when the MTE is empty."},
    {CCU_UB_RD_CFLT, "Lite Only Error. When the CCU reads the UB, the UB read and write conflict is reported."},
    {CCU_UB_WR_CFLT, "Lite Only Error. When the CCU writes data to the UB, the UB read and write conflict occurs."},
    {CCU_UB_OVERFLOW_ERR, "When AIC and AIV share the UB, LS/ST access overwriting occurs."},
    {BIU_UNSPLIT_ERR, "An exception occurs on the BIU, for example, tag_id error or FIFO overflow."},
    {MTE_STB_ECC_ERR, "Multi-bit ECC error occurs in the MTE STB."},
    {MTE_AIPP_ECC_ERR, "Multi-bit ECC error occurs in the MTE AIPP."},
    {CCU_LSU_ATOMIC_ERR, "Failed to execute atomic on the Scalar LSU."},
    {CCU_CROSS_CORE_SET_OVFL_ERR,
     "The value of the flag counter for inter-core communication exceeds the maximum value 15."},
    {FIXP_ERR_OUT_WRITE_OVERFLOW, "A overflow error occurs when the FIXP write."},
    {CUBE_ERR_PBUF_WRAP_AROUND, "A round error occurs in the CUBE FIXP_BUFFER."},
    {FIXP_L0C_ECC, "FIXP instruction error: ECC verification failed when the l0c is read."},
    {MTE_ERR_L0C_RDWR_CFLT, "When the FIXP reads l0c, the read and write operations occur at the same address."},
    {VEC_DATA_EXCPT_MTE, "An data_exception is reported when the MTE writes/reads."},
    {VEC_DATA_EXCPT_SU, "An data_exception is reported when the SU writes/reads."},
    {VEC_DATA_EXCPT_VEC, "An data_exception is reported when the VECTOR writes/reads."},
    {VEC_INSTR_TIMEOUT, "The instruction running timeout."},
    {VEC_INSTRS_UNDEF, "The instruction is not defined in ISA."},
    {VEC_INSTR_ILL_CFG, "The instruction configuration of VEC is illegal."},
    {VEC_INSTR_MISALIGN, "The instruction access UB address is not aligned."},
    {VEC_INSTR_ILL_MASK, "The mask value is invalid."},
    {VEC_INSTR_ILL_SQZN, "The sqzn value is invalid."},
    {VEC_UB_ADDR_WRAP_AROUND, "The access address of the UB is out of range."},
    {VEC_UB_ECC_MBERR, "Multi-bit ECC error occurs when access UB."},
    {VEC_IDATA_INF_NAN, "The input data of the instruction operation is INF/NAN."},
    {VEC_DIV_BY_ZERO, "The instruction of VEC divide-by-zero error."},
    {VEC_VALU_NEG_LN, "The input data of the VALU lN operation is a negative number."},
    {VEC_VALU_NEG_SQRT, "The input data of the VALU squart operation is a negative number."},
    {VEC_VCI_IDATA_OUT_RANGE, "The input data of the VCI instruction is out of range."},
    {VEC_ILL_VLOOP_OP, "A opcode error occurs in the VLOOP instruction."},
    {VEC_ILL_VLOOP_SREG, "The number of VLOOP loop times at layer 4 is all 0."},
    {VEC_LD_NUM_MISMATCH, "The code segment where the ld instruction resides contains a non-ld instruction."},
    {VEC_ST_NUM_MISMATCH, "The code segment where the st instruction resides contains a non-st instruction."},
    {VEC_EX_NUM_MISMATCH, "The code segment where the ex instruction resides contains a non-ex instruction."},
    {VEC_LD_NUM_EXCEED_LIMIT, "The number of ld instructions exceeds the maximum specified in the ISA."},
    {VEC_ST_NUM_EXCEED_LIMIT, "The number of st instructions exceeds the maximum specified in the ISA."},
    {VEC_ILL_INSTR_PADDING, "The PADDING instruction of the VGA and VPD is not a VNOP."},
    {VEC_ILL_VGA_VPD_ORDER, "The order of the VGA and VPD commands violates IAS constraints."},
    {VEC_IC_ECC_ERR, "An ECC error occurs in the instruction fetched from the VEC ICACHE."},
    {VEC_BIU_RESP_ERR, "The data returned by the BIU to the VEC is incorrect."},
    {VEC_PB_ECC_MBERR, "The PB data returned by the SU to the VEC contains ECC errors."},
    {VEC_PB_READ_NO_RESP, "The SU does not respond for a long time after receiving a PB read request from the VEC."},
    {VEC_VALU_ILL_ISSUE, "VALU instruction transmit order violates ISA constraints."},
    {VEC_ERR_PARITY_ERR, "A parity check error occurs in the VEC."},
};

static const std::map<uint64_t, std::string> g_aicpuErrorMapInfo = {
    {KERNEL_EXECUTE_PARAM_INVLID, "execute kernel param invalid"},
    {KERNEL_EXECUTE_INNER_ERROR, "execute kernel inner error"},
    {KERNEL_EXECUTE_TIMEOUT, "execute kernel timeout"},
    {AE_END_OF_SEQUENCE, "end of sequence"},
    {AE_STATUS_SILENT_FAULT, "convergence sensitivity feature abnormal"},
    {AE_STATUS_STRESS_DETECT_FAULT, "stress detect feature abnormal"},
    {AE_STATUS_STRESS_DETECT_FAULT_LOW, "The AICPU operator detects that the low-bit precision is abnormal"},
    {AE_STATUS_STRESS_DETECT_FAULT_LOW_OFFLINE,
        "The AICPU operator detects that the low-bit precision is abnormal for offline scenarios "},
    {AE_STATUS_STRESS_DETECT_FAULT_NORAS, "stress detect feature abnormal noras"},
    {AE_TASK_WAIT, "task wait for aicpu super task"},
    {AE_BAD_PARAM, "bad param"},
    {AE_OPEN_SO_FAILED, "open so failed"},
    {AE_GET_KERNEL_NAME_FAILED, "get kernel failed"},
    {AE_KERNEL_API_PARAM_INVALID, "execute kernel api param invalid"},
    {AE_KERNEL_API_INNER, "execute kernel api failed"},
    {AE_INNER, "inner error"},
    {AICPU_PARAMETER_NOT_VALID, "param invalid"},
    {AICPU_DUMP_FAILED, "dump failed"},
    {AICPU_FROM_DRV, "drv error"},
    {AICPU_TOOL_ERR, "tool error"},
    {AICPU_NOT_FOUND_LOGICAL_TASK, "logical task not found"},
    {AICPU_TASK_EXECUTE_FAILED, "task execute failed"},
    {AICPU_TASK_EXECUTE_TIMEOUT, "task execute timeout"},
    {AICPU_INNER, "inner error"},
    {AICPU_IN_WORKING, "current resource or model is working"},
    {AICPU_MODEL_NOT_FOUND, "model not found"},
    {AICPU_STREAM_NOT_FOUND, "stream not found"},
    {AICPU_MODEL_STATUS_NOT_ALLOW_OPERATE, "operate not allowed with current model status"},
    {AICPU_MODEL_EXIT_ERR, "model exit error"},
    {AICPU_RESERVED, "reserved: inner error"},
    {AICPU_CUST_PARAMETER_NOT_VALID, "param invalid"},
    {AICPU_CUST_DRV_ERR, "driver error"},
    {AICPU_CUST_TOOL_ERR, "tool error"},
    {AICPU_CUST_TASK_EXECUTE_FAILED, "custom task execute failed"},
    {AICPU_CUST_TASK_EXECUTE_TIMEOUT, "custom task execute timeout"},
    {AICPU_CUST_TASK_EXECUTE_PARAM_INVALID, "custom task execute param invalid"},
    {AICPU_CUST_INNER, "inner error"},
    {AICPU_CUST_RESERVED, "reserved: inner error"}
};

DeviceErrorProc::DeviceErrorProc(Device *dev, uint32_t ringBufferSize)
    : device_(dev), deviceRingBufferAddr_(nullptr), needProcNum_(0ULL), consumeNum_(0ULL),
      ringBufferSize_(ringBufferSize), realFaultTaskPtr_(nullptr)
{
}

DeviceErrorProc::DeviceErrorProc(Device *dev)
    : device_(dev), deviceRingBufferAddr_(nullptr), needProcNum_(0ULL), consumeNum_(0ULL),
      ringBufferSize_(DEVICE_RINGBUFFER_SIZE), realFaultTaskPtr_(nullptr)
{
}

DeviceErrorProc::~DeviceErrorProc() noexcept
{
    const std::lock_guard<std::mutex> mutexLock(mutex_);

    if ((deviceRingBufferAddr_ != nullptr)) {
        Driver * const devDrv = device_->Driver_();
        (void)devDrv->DevMemFree(deviceRingBufferAddr_, device_->Id_());
        deviceRingBufferAddr_ = nullptr;
    }
    if ((fastRingBufferAddr_ != nullptr)) {
        Driver * const devDrv = device_->Driver_();
        devDrv->FreeFastRingBuffer(fastRingBufferAddr_, fastRingBufferSize_, device_->Id_());
        fastRingBufferAddr_ = nullptr;
    }
}

rtError_t DeviceErrorProc::GetTschCapability(const void *devMem) const
{
    if (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_TSCH_PACAGE_COMPATABLE)) {
        return RT_ERROR_NONE;
    }
    constexpr uint32_t len = RTS_TIMEOUT_STREAM_SNAPSHOT_LEN + TSCH_CAPABILITY_LEN;
    COND_RETURN_ERROR(len >= ringBufferSize_, RT_ERROR_INVALID_VALUE,
        "ring buffer length invalid, ringBufferSize=%u(bytes), len=%u(bytes)",
        ringBufferSize_, len);
    const uint32_t tschOffset = ringBufferSize_ - len;
    TschCapability *devTschCapa = RtValueToPtr<TschCapability *>(RtPtrToValue<const void *>(devMem) + tschOffset);

    std::unique_ptr<char[]> hostAddr(new (std::nothrow) char[sizeof(TschCapability)]);
    NULL_PTR_RETURN(hostAddr, RT_ERROR_MEMORY_ALLOCATION);
    Driver * const devDrv = device_->Driver_();
    const rtError_t error = devDrv->MemCopySync(hostAddr.get(), sizeof(TschCapability), devTschCapa,
        sizeof(TschCapability), RT_MEMCPY_DEVICE_TO_HOST, false);
    ERROR_RETURN(error, "Failed to Memcpy from dev to host, len=%u(bytes)", ringBufferSize_);

    TschCapability *tschCapa = RtPtrToPtr<TschCapability *, char_t *>(hostAddr.get());
    if ((tschCapa->header.magic != RINGBUFFER_CAPABILITY_MAGIC) ||
        (tschCapa->header.depth != sizeof(tschCapa->capability)) ||
        (tschCapa->header.head == tschCapa->header.tail)) {
        RT_LOG(RT_LOG_EVENT, "Tsch not support capability feature, use old solution.");
        return RT_ERROR_NONE;
    }

    uint32_t capaLen;
    if (likely(tschCapa->header.tail > tschCapa->header.head)) {
        capaLen = tschCapa->header.tail;
    } else { // ring queue inversion
        capaLen = static_cast<uint32_t>(sizeof(tschCapa->capability));
    }
    uint8_t *capa = new (std::nothrow) uint8_t[capaLen];
    NULL_PTR_RETURN(capa, RT_ERROR_MEMORY_ALLOCATION);
    const int ret = memcpy_s(capa, capaLen, tschCapa->capability, capaLen);
    COND_PROC_RETURN_ERROR(ret != EOK, RT_ERROR_SEC_HANDLE, DELETE_A(capa),
        "memcpy_s faild, ret=%d, len=%u", ret, capaLen);
    device_->InitTschCapability(capa, capaLen, tschCapa->header.depth);
    device_->SetSupportFlipVersionSwitch();
    Runtime::Instance()->SetTilingkeyFlag(
        static_cast<uint8_t>(device_->CheckFeatureSupport(TS_FEATURE_TILING_KEY_SINK)));
    return RT_ERROR_NONE;
}

rtError_t DeviceErrorProc::WriteRuntimeCapability(const void *hostAddr) const
{
    if (!(device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_SET_RUNTIME_CAPABLITY))) {
        return RT_ERROR_NONE;
    }
    constexpr uint32_t len = RTS_TIMEOUT_STREAM_SNAPSHOT_LEN + RUNTME_TSCH_CAPABILITY_LEN;
    COND_RETURN_ERROR(len >= ringBufferSize_, RT_ERROR_INVALID_VALUE,
        "ring buffer length invalid, ringBufferSize=%u(bytes), len=%u(bytes)",
        ringBufferSize_, len);
    const uint32_t rtsOffset = ringBufferSize_ - len;
    RuntimeCapability *hostRtCapa = RtValueToPtr<RuntimeCapability *>(RtPtrToValue<const void *>(hostAddr) + rtsOffset);
    const uint32_t *capa = GetRtCapabilityTbl();
    const uint32_t capaLen = GetRtCapabilityTblLen();
    uint32_t posMax = 0;
    hostRtCapa->header.depth = sizeof(hostRtCapa->capability);
    for (uint32_t i = 0; i < capaLen; i++) {
        const uint32_t pos = (capa[i] / ONE_BYTE_BITS ) % hostRtCapa->header.depth;
        hostRtCapa->capability[pos] |= 1U << (capa[i] % ONE_BYTE_BITS);
        posMax = pos > posMax ? pos : posMax;
    }
    hostRtCapa->header.magic = RINGBUFFER_CAPABILITY_MAGIC;
    hostRtCapa->header.head = 0U;
    hostRtCapa->header.tail = (posMax + 1U) % hostRtCapa->header.depth;

    return RT_ERROR_NONE;
}

rtError_t DeviceErrorProc::SendTaskToStopUseRingBuffer()
{
    void *devMem = nullptr;
    {
        const std::lock_guard<std::mutex> mutexLock(mutex_);
        if ((fastRingBufferAddr_ != nullptr)) {
            device_->Driver_()->FreeFastRingBuffer(fastRingBufferAddr_, fastRingBufferSize_, device_->Id_());
            fastRingBufferAddr_ = nullptr;
        }
        if (deviceRingBufferAddr_ == nullptr) {
            return RT_ERROR_NONE;
        }
        devMem = deviceRingBufferAddr_;
    }
    rtError_t error = RT_ERROR_NONE;
    if (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_ALLOC_FROM_STREAM_POOL)) {
        error = ProcRingBufferTaskStarsV2(device_, devMem, true, RINGBUFFER_LEN_STARSV2);
    } else {
        error = ProcRingBufferTask(devMem, true, RINGBUFFER_LEN);
    }
    ERROR_RETURN(error, "Failed to pass the buffer addr to device.");

    RT_LOG(RT_LOG_DEBUG, "End to send destroy task for deleting device ringbuffer.");
    return RT_ERROR_NONE;
}

rtError_t DeviceErrorProc::RingBufferRestore()
{
    NULL_PTR_RETURN(device_, RT_ERROR_DEVICE_NULL);
    {
        const std::lock_guard<std::mutex> mutexLock(mutex_);
        NULL_PTR_RETURN(deviceRingBufferAddr_, RT_ERROR_INVALID_VALUE);
    }

    // 申请host内存并设置capability信息
    std::vector<uint8_t> hostdata(ringBufferSize_, 0);
    rtError_t error = WriteRuntimeCapability(hostdata.data());
    ERROR_RETURN(error, "Failed to write runtime capability, errorcode=%u.", error);

    // 将结果拷贝的device侧
    Driver * const devDrv = device_->Driver_();
    error = devDrv->MemCopySync(deviceRingBufferAddr_, static_cast<uint64_t>(ringBufferSize_), hostdata.data(),
        static_cast<uint64_t>(ringBufferSize_), RT_MEMCPY_HOST_TO_DEVICE, false);
    ERROR_RETURN(error, "Failed to memcpy from host to dev, len=%u(bytes), errorcode=%u.",
        ringBufferSize_, error);

    // create task to transfer the addr to device.
    error = ProcRingBufferTask(deviceRingBufferAddr_, false, RINGBUFFER_LEN);
    ERROR_RETURN(error, "Failed to create ring buffer, errorcode=%u.", error);
    return RT_ERROR_NONE;
}

rtError_t DeviceErrorProc::CreateDeviceRingBufferAndSendTask()
{
    NULL_PTR_RETURN(device_, RT_ERROR_DEVICE_NULL);
    {
        const std::lock_guard<std::mutex> mutexLock(mutex_);
        COND_RETURN_WITH_NOLOG(deviceRingBufferAddr_ != nullptr, RT_ERROR_NONE)
    }
    void *devMem = nullptr;
    Driver * const devDrv = device_->Driver_();
    Runtime * const rtInstance = Runtime::Instance();
    const rtMemType_t memType = rtInstance->GetTsMemType(MEM_REQUEST_FEATURE_DEFAULT, ringBufferSize_);
    rtError_t error = devDrv->DevMemAlloc(&devMem, static_cast<uint64_t>(ringBufferSize_), memType, device_->Id_());
    COND_RETURN_WARN(error != RT_ERROR_NONE, RT_ERROR_DRV_MEMORY,
                     "Failed to alloc huge page device memory for ring buffer in device, size=%u(bytes)."
                     " ring buffer feature can't work.", ringBufferSize_);
    NULL_PTR_RETURN(devMem, RT_ERROR_DRV_MEMORY);

    std::unique_ptr<char[]> hostAddr(new (std::nothrow) char[ringBufferSize_]);
    COND_GOTO_ERROR(hostAddr == nullptr, ERROR_FREE, error, RT_ERROR_MEMORY_ALLOCATION, "new memory failed.");
    (void)memset_s(hostAddr.get(), ringBufferSize_, 0U, ringBufferSize_);

    error = WriteRuntimeCapability(hostAddr.get());
    ERROR_GOTO(error, ERROR_FREE, "Failed to write runtime capability, errorcode=%u.", error);
    error = devDrv->MemCopySync(devMem, static_cast<uint64_t>(ringBufferSize_), hostAddr.get(),
        static_cast<uint64_t>(ringBufferSize_), RT_MEMCPY_HOST_TO_DEVICE, false);
    ERROR_GOTO(error, ERROR_FREE, "Failed to memcpy from host to dev, len=%u(bytes), errorcode=%u.",
        ringBufferSize_, error);

    // create task to transfer the addr to device.
    if (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_ALLOC_FROM_STREAM_POOL)) {
        error = ProcRingBufferTaskStarsV2(device_, devMem, false, RINGBUFFER_LEN_STARSV2);
    } else {
        error = ProcRingBufferTask(devMem, false, RINGBUFFER_LEN);
    }
    ERROR_GOTO(error, ERROR_FREE, "Failed to create ring buffer, errorcode=%u.", error);

    error = GetTschCapability(devMem);
    ERROR_GOTO(error, ERROR_FREE, "Failed to get tsch capability, errorcode=%u.", error);

    {
        const std::lock_guard<std::mutex> mutexLock(mutex_);
        deviceRingBufferAddr_ = devMem;
    }
    RT_LOG(RT_LOG_DEBUG, "End to Create device ringbuffer and send task, ringbuffer size=%u(bytes).", ringBufferSize_);
    return RT_ERROR_NONE;
ERROR_FREE:
    (void)devDrv->DevMemFree(devMem, device_->Id_());
    return error;
}

rtError_t DeviceErrorProc::DestroyDeviceRingBuffer()
{
    NULL_PTR_RETURN(device_, RT_ERROR_DEVICE_NULL);

    RT_LOG(RT_LOG_DEBUG, "begin to delete device ringbuffer.");
    {
        const std::unique_lock<std::mutex> mutexLock(mutex_);
        // if addr is nullptr ,it don`t need to relase, directly to return.
        NULL_PTR_RETURN(deviceRingBufferAddr_, RT_ERROR_NONE);
        Driver * const devDrv = device_->Driver_();
        const rtError_t error = devDrv->DevMemFree(deviceRingBufferAddr_, device_->Id_());
        ERROR_RETURN(error, "Failed to release device memory, device_id=%u.", device_->Id_());
        deviceRingBufferAddr_ = nullptr;
    }

    return RT_ERROR_NONE;
}

rtError_t DeviceErrorProc::ProcRingBufferTask(const void * const devMem, const bool delFlag, const uint32_t len)
{
    /* ctrl stream  */
    NULL_PTR_RETURN(device_, RT_ERROR_DEVICE_NULL);
    auto * const factory = device_->GetTaskFactory();

    TaskInfo taskSubmit = {};
    TaskInfo *tsk = &taskSubmit;
    Stream* stm = device_->GetCtrlStream(device_->PrimaryStream_());
    NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);
    tsk->stream = stm;
    rtError_t error = RT_ERROR_TASK_NEW;
    if (stm->taskResMang_ == nullptr) {
        tsk = factory->Alloc(stm, TS_TASK_TYPE_DEVICE_RINGBUFFER_CONTROL, error);
        NULL_PTR_RETURN(tsk, error);
    }

    error = RingBufferMaintainTaskInit(tsk, devMem, delFlag, len);
    ERROR_GOTO(error, ERROR_TASK, "Failed to init create ringbuffer task.");

    error = device_->SubmitTask(tsk);
    ERROR_GOTO(error, ERROR_TASK, "Failed to SubmitTask task.");

    if (stm->IsCtrlStream()) {
        error = (dynamic_cast<CtrlStream*>(stm))->Synchronize();
    } else {
        error = stm->Synchronize();
    }
    ERROR_GOTO(error, ERROR_TASK, "Failed to Synchronize.");

    return RT_ERROR_NONE;
ERROR_TASK:
    (void)factory->Recycle(tsk);
    return error;
}

rtError_t DeviceErrorProc::ProcessSdmaErrorInfo(const DeviceErrorInfo * const info,
                                                const uint64_t errorNumber,
                                                const Device *const dev)
{
    UNUSED(dev);
    std::string str = "the channel exist the following problems:";
    if ((info->u.sdmaErrorInfo.channelStatus & static_cast<uint64_t>(SDMA_ERROR_TIMEOUT)) ==
        static_cast<uint64_t>(SDMA_ERROR_TIMEOUT)) {
        str += "time out";
    } else {
        uint64_t err = info->u.sdmaErrorInfo.channelStatus;
        for (uint32_t i = static_cast<uint32_t>(BitScan(err)); i < MAX_BIT_LEN;
             i = static_cast<uint32_t>(BitScan(err))) {
            BITMAP_CLR(err, static_cast<uint64_t>(i));
            str += " ";
            const auto it = channelErrorMapInfo_.find(i);
            if (it == channelErrorMapInfo_.end()) {
                continue;
            }
            // if the string is too long, the log will truncate to 1024.
            // so the error string only show 400.
            if (unlikely((it->second.size() + str.size())) > 400UL) {
                RT_LOG(RT_LOG_WARNING, "The error info is too long.");
                break;
            }
            str += it->second;
        }

        str += ". the value of CQE status is " + std::to_string(info->u.sdmaErrorInfo.cqeStatus);
        str += ". the description of CQE status: ";
        const auto it = cqeErrorMapInfo_.find(info->u.sdmaErrorInfo.cqeStatus);
        if (it != cqeErrorMapInfo_.end()) {
            str += it->second;
        }
    }
    RT_LOG_CALL_MSG(ERR_MODULE_GE, "The error from device(%u), serial number is %" PRIu64 ". "
        "there is a sdma error, sdma channel is %#" PRIx64 ", "
        "%s"
        "it's config include: "
        "setting1=%#" PRIx64 ", setting2=%#" PRIx64 ", setting3=%#" PRIx64 ", sq base addr=%#" PRIx64,
        info->u.sdmaErrorInfo.deviceId, errorNumber,
        info->u.sdmaErrorInfo.channel, str.c_str(),
        info->u.sdmaErrorInfo.setting1, info->u.sdmaErrorInfo.setting2,
        info->u.sdmaErrorInfo.setting3, info->u.sdmaErrorInfo.sqBaseAddr);

    return RT_ERROR_NONE;
}

rtError_t DeviceErrorProc::ProcessAicpuErrorInfo(const DeviceErrorInfo * const info,
                                                 const uint64_t errorNumber,
                                                 const Device *const dev)
{
    UNUSED(dev);
    UNUSED(errorNumber);
    std::string msg = "aicpu execute failed";
    const uint64_t errcode = info->u.aicpuErrorInfo.errcode;
    const auto it = g_aicpuErrorMapInfo.find(errcode);
    if (it != g_aicpuErrorMapInfo.end()) {
        msg = (it->second).c_str();
    }
    RT_LOG_CALL_MSG(ERR_MODULE_AICPU,
        "An exception occurred during AICPU execution, stream_id:%u, task_id:%u, errcode:%" PRIu64 ", msg:%s",
        info->u.aicpuErrorInfo.stream_id,
        info->u.aicpuErrorInfo.task_id,
        errcode, msg.c_str());
    return RT_ERROR_NONE;
}

rtError_t DeviceErrorProc::ProcessOneElementInRingBuffer(const DevRingBufferCtlInfo * const ctlInfo,
    uint32_t head, const uint32_t tail) const
{
    const uint32_t tschVer = device_->GetTschVersion();
    size_t headSize = sizeof(DevRingBufferCtlInfo);
    size_t elementSize;
    if (tschVer < static_cast<uint32_t>(TS_VERSION_AIC_ERR_REG_EXT)) {
        headSize = sizeof(DevRingBufferCtlInfo) - sizeof(uint64_t); // old tsch version head is 8bytes small
        elementSize = RINGBUFFER_ONE_ELEMENT_LENGTH;  // default is 4K, extern size should use tsch's size
    } else {
        elementSize = ctlInfo->elementSize;
    }

    RT_LOG(RT_LOG_DEBUG, "it needs process %u errorMessages, tschVer=%u, headSize=%zu, elementSize=%zu.",
           ((tail - head) + ctlInfo->ringBufferLen) % ctlInfo->ringBufferLen, tschVer, headSize, elementSize);

    while (head != tail) {
        const uint8_t * const infoAddr = RtPtrToPtr<const uint8_t *, const DevRingBufferCtlInfo *>(ctlInfo) + headSize + (head * elementSize);
        const RingBufferElementInfo * const info = RtPtrToPtr<const RingBufferElementInfo *, const uint8_t *>(infoAddr);

        RT_LOG(RT_LOG_INFO, "head info %u, tail info %u.", head, tail);

        head = (head + 1U) % (ctlInfo->ringBufferLen);

        if (info->errorType > static_cast<uint32_t>(FFTS_PLUS_SDMA_ERROR)) {
            RT_LOG(RT_LOG_WARNING, "Failed to get error information from device, error type=%u.", info->errorType);
            continue;
        }

        const DeviceErrorInfo * const errorInfo = RtPtrToPtr<const DeviceErrorInfo *, const RingBufferElementInfo *>(info + 1);
        const auto it = funcMap_.find(info->errorType);
        if (it != funcMap_.end()) {
            ErrorInfoProc const func = it->second;
            const rtError_t error = func(errorInfo, info->errorNumber, device_);
            if (error != RT_ERROR_NONE) {
                RT_LOG(RT_LOG_WARNING, "Failed to get error information from device.");
            }
        } else {
            RT_LOG(RT_LOG_WARNING, "Failed to find function to process the error information.");
        }
    }
    return RT_ERROR_NONE;
}

rtError_t DeviceErrorProc::PrintRingbufferErrorInfo(const DevRingBufferCtlInfo *const ctrlInfo) const
{
    RT_LOG(RT_LOG_ERROR, "The error from device(%u), tsId(%u)."
        "the ringbuffer magic is %u, the ringBufferLen is %u, the head of ringbuffer is %u,"
        "the tail of ringbuffer is %u, the pid of ringbuffer is %u,"
        "the elementSize of ringbuffer is %u",
        device_->Id_(),
        device_->DevGetTsId(),
        ctrlInfo->magic,
        ctrlInfo->ringBufferLen,
        ctrlInfo->head,
        ctrlInfo->tail,
        ctrlInfo->pid,
        ctrlInfo->elementSize);
    return RT_ERROR_NONE;
}

rtError_t DeviceErrorProc::CheckValid(const DevRingBufferCtlInfo *const ctrlInfo)
{
    if (ctrlInfo->ringBufferLen == 0U) {
        RT_LOG(RT_LOG_ERROR, "The length of ringbuffer is invalid.");
        PrintRingbufferErrorInfo(ctrlInfo);
        return RT_ERROR_INVALID_VALUE;
    }

    if (ctrlInfo->magic != RINGBUFFER_MAGIC) {
        RT_LOG(RT_LOG_ERROR, "The magic(%u) of ringbuffer is invalid.", ctrlInfo->magic);
        PrintRingbufferErrorInfo(ctrlInfo);
        return RT_ERROR_INVALID_VALUE;
    }

    if ((ctrlInfo->head >= GetRingbufferElementNum()) || (ctrlInfo->tail >= GetRingbufferElementNum())) {
        RT_LOG(RT_LOG_ERROR, "The head(%u) or tail(%u) of ringbuffer is invalid.", ctrlInfo->head, ctrlInfo->tail);
        PrintRingbufferErrorInfo(ctrlInfo);
        return RT_ERROR_INVALID_VALUE;
    }
    return RT_ERROR_NONE;
}

rtError_t DeviceErrorProc::ProcErrorInfoWithoutLock(const TaskInfo * const taskPtr, const bool isPrintTaskInfo)
{
    RT_LOG(RT_LOG_INFO, "Begin to process device abnormal info.");
    std::unique_ptr<char[]> hostAddr(new (std::nothrow)  char[ringBufferSize_]);
    NULL_PTR_RETURN(hostAddr, RT_ERROR_MEMORY_ALLOCATION);
    NULL_PTR_RETURN(device_, RT_ERROR_DEVICE_NULL);

    // 1. memcpy ringbuffer to host
    const uint64_t destMax = ringBufferSize_;
    const uint64_t copySize = ringBufferSize_;
    NULL_PTR_RETURN(deviceRingBufferAddr_, RT_ERROR_DEVICE_NULL);
    void * const devMem = deviceRingBufferAddr_;
    rtError_t error;
    uint32_t cycleTimes;
    DevRingBufferCtlInfo *tmpCtrlInfo = RtPtrToPtr<DevRingBufferCtlInfo *, char_t *>(hostAddr.get());
    Driver *devDrv = nullptr;

    if (Runtime::Instance()->ChipIsHaveStars() == true) {
        cycleTimes = device_->IsAddrFlatDev() ? 25000U : 50000U;  // Number of cyclic waiting times for stars 6s
        if (taskPtr != nullptr && taskPtr->stream->isForceRecycle_) {
            cycleTimes = 1U;
        }
    } else {
        cycleTimes = device_->GetDevProperties().ringBufferMemCopyCycleTimes;
    }
    const uint64_t beginTime = static_cast<uint64_t>(GetWallUs());
    while (cycleTimes != 0U) {
        devDrv = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
        NULL_PTR_RETURN(devDrv, RT_ERROR_DEVICE_RINGBUFFER_NO_DATA);
        error = devDrv->MemCopySync(hostAddr.get(), destMax, devMem, copySize, RT_MEMCPY_DEVICE_TO_HOST, false);
        ERROR_RETURN(error, "Failed to Memcpy from dev to host, destMax=%" PRIu64
            ", copy size=%" PRIu64, destMax, copySize);
        if ((tmpCtrlInfo->tail != tmpCtrlInfo->head) || (GetWallUs() - beginTime > 12000000ULL) ||  // 尝试12s后退出
            (Runtime::Instance()->IsSupportOpTimeoutMs())) { // 算子ms超时时故障上报不等待
            break;
        }
        if ((taskPtr != nullptr) && (taskPtr->isRingbufferGet)) {
            return RT_ERROR_NONE;
        }
        cycleTimes--;
    }

    DevRingBufferCtlInfo * const ctrlInfo = tmpCtrlInfo;
    error = DeviceErrorProc::CheckValid(ctrlInfo);
    ERROR_RETURN(error, "Find error in ringbuffer!");

    devDrv = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
    NULL_PTR_RETURN(devDrv, RT_ERROR_DEVICE_RINGBUFFER_NO_DATA);

    const uint32_t tail = ctrlInfo->tail;
    const uint32_t head = ctrlInfo->head;
    if (head == tail) {
        RT_LOG(RT_LOG_INFO, "There isn't errInfo of device.");
        return RT_ERROR_DEVICE_RINGBUFFER_NO_DATA;
    }

    // Set error device status
    device_->SetHasTaskError(true);

    // 2. memset read pointer
    ctrlInfo->head = tail;
    error = devDrv->MemCopySync(devMem, static_cast<uint64_t>(ringBufferSize_), hostAddr.get(),
        sizeof(uint32_t) + sizeof(uint32_t), RT_MEMCPY_HOST_TO_DEVICE, false);
    ERROR_RETURN(error, "Failed to Memcpy from host to device, max len=%u,"
        " copy size=%zu.", ringBufferSize_, sizeof(uint32_t) + sizeof(uint32_t));

    const uint32_t procNum = ((tail - head) + ctrlInfo->ringBufferLen) % ctrlInfo->ringBufferLen;
    ConsumeProcNum(procNum);

    // 3. record device error info to log in host
    if (Runtime::Instance()->ChipIsHaveStars()) {
        error = ProcessStarsOneElementInRingBuffer(ctrlInfo, head, tail, isPrintTaskInfo, taskPtr); // isPrintTaskInfo is true
    } else {
        error = ProcessOneElementInRingBuffer(ctrlInfo, head, tail); // isPrintTaskInfo is false
    }

    RT_LOG(RT_LOG_INFO, "Finished to process device errInfo, retCode=%#x.", error);
    return error;
}

rtError_t DeviceErrorProc::ProcTaskErrorWithoutLock(const TaskInfo * const taskPtr, const bool isPrintTaskInfo)
{
    const uint64_t beginTime = GetWallUs();
    bool isTimeOut = false;
    rtError_t error = RT_ERROR_NONE;
    // stream 已经强制回收，就只读一次。
    const bool needCheck = (taskPtr == nullptr) ? (false) :
        ((taskPtr->type != TS_TASK_TYPE_KERNEL_AICPU) && !taskPtr->stream->isForceRecycle_);
    // 至少执行一次，返回失败、或尝试超时12s、或传入task为null，或为aicputask，或取到task的ringbuffer信息后，退出
    const bool isTimeoutMs = Runtime::Instance()->IsSupportOpTimeoutMs();
    do {
        error = ProcErrorInfoWithoutLock(taskPtr, isPrintTaskInfo);
        isTimeOut = (GetWallUs() - beginTime) > 12000000ULL; // 12s
    } while ((error == RT_ERROR_NONE) && !isTimeOut && needCheck && (taskPtr->isRingbufferGet == 0U) && (!isTimeoutMs));
    return error;
}

rtError_t DeviceErrorProc::ProcErrorInfo(const TaskInfo * const taskPtr)
{
    if (((taskPtr != nullptr) && (taskPtr->isNoRingbuffer == 1U))) {
        return RT_ERROR_NONE;
    }
    const std::lock_guard<std::mutex> mutexLock(mutex_);
    return ProcTaskErrorWithoutLock(taskPtr);
}

void GetStreamAndTaskIdFromErrorInfo(const uint32_t errorType, 
    const StarsDeviceErrorInfo* const errorInfo, StreamTaskId &streamTaskId)
{
    switch (errorType) {
        case AICORE_ERROR:
        case AIVECTOR_ERROR:
        case FFTS_PLUS_AICORE_ERROR:
        case FFTS_PLUS_AIVECTOR_ERROR:
            streamTaskId.streamId = errorInfo->u.coreErrorInfo.comm.streamId;
            streamTaskId.taskId = errorInfo->u.coreErrorInfo.comm.taskId;
            break;
        case SDMA_ERROR:
        case FFTS_PLUS_SDMA_ERROR:
            streamTaskId.streamId = errorInfo->u.sdmaErrorInfo.comm.streamId;
            streamTaskId.taskId = errorInfo->u.sdmaErrorInfo.comm.taskId;
            break;
        case AICPU_ERROR:
        case FFTS_PLUS_AICPU_ERROR:
            streamTaskId.streamId = errorInfo->u.aicpuErrorInfo.comm.streamId;
            streamTaskId.taskId = errorInfo->u.aicpuErrorInfo.comm.taskId;
            break;
        case DVPP_ERROR:
            streamTaskId.streamId = errorInfo->u.dvppErrorInfo.streamId;
            streamTaskId.taskId = errorInfo->u.dvppErrorInfo.taskId;
            break;
        case DSA_ERROR:
        case FFTS_PLUS_DSA_ERROR:
            streamTaskId.streamId = errorInfo->u.dsaErrorInfo.sqe.sqeHeader.rt_stream_id;
            streamTaskId.taskId = errorInfo->u.dsaErrorInfo.sqe.sqeHeader.task_id;
            break;
        case SQE_ERROR:
            streamTaskId.streamId = errorInfo->u.sqeErrorInfo.streamId;
            streamTaskId.taskId = errorInfo->u.sqeErrorInfo.taskId;
            break;
        case WAIT_TIMEOUT_ERROR:
            streamTaskId.streamId = errorInfo->u.timeoutErrorInfo.streamId;
            streamTaskId.taskId = errorInfo->u.timeoutErrorInfo.taskId;
            break;
        case HCCL_FFTSPLUS_TIMEOUT_ERROR:
            streamTaskId.streamId = errorInfo->u.hcclFftsplusTimeoutInfo.common.streamId;
            streamTaskId.taskId = errorInfo->u.hcclFftsplusTimeoutInfo.common.taskId;
            break;
        case FUSION_KERNEL_ERROR:
            streamTaskId.streamId = errorInfo->u.fusionKernelErrorInfo.comm.streamId;
            streamTaskId.taskId = errorInfo->u.fusionKernelErrorInfo.comm.taskId;
            break; 
        default:
            streamTaskId.streamId = 0xFFFFU;
            streamTaskId.taskId = 0xFFFFU;
            break;
    }
}

rtError_t DeviceErrorProc::ProcessReportRingBuffer(const DevRingBufferCtlInfo * const tmpCtrlInfo,
    Driver * const devDrv, uint16_t *errorStreamId)
{
    // copy element
    const size_t elementSize = (device_->IsStarsV2Platform()) ? \
        static_cast<size_t>(RINGBUFFER_EXT_ONE_ELEMENT_LENGTH_ON_STARSV2) : \
        static_cast<size_t>(RINGBUFFER_EXT_ONE_ELEMENT_LENGTH);
    constexpr size_t copySize  = sizeof(RingBufferElementInfo) + sizeof(StarsDeviceErrorInfo);
    std::unique_ptr<char[]> elementHostAddr(new (std::nothrow) char[copySize]);
    NULL_PTR_RETURN(elementHostAddr, RT_ERROR_MEMORY_ALLOCATION);

    uint32_t head = tmpCtrlInfo->head;
    const uint32_t tail = tmpCtrlInfo->tail;
    const uint32_t depth = tmpCtrlInfo->ringBufferLen;
    StreamTaskId sTaskId;
    std::shared_ptr<Stream> stm = nullptr;
    RingBufferElementInfo *info = nullptr;
    while (head != tail) {
        const uint64_t elementOffset = static_cast<uint64_t>(sizeof(DevRingBufferCtlInfo)) +
            static_cast<uint64_t>(head * elementSize);
        void * const copyBase = RtPtrToPtr<void *, uint8_t *>(RtPtrToPtr<uint8_t *, void *>(deviceRingBufferAddr_) +
            elementOffset);
        rtError_t error = devDrv->MemCopySync(elementHostAddr.get(), copySize, copyBase, copySize,
            RT_MEMCPY_DEVICE_TO_HOST, false);
        ERROR_RETURN(error, "failed to Memcpy from, copy size=%" PRIu64 "(bytes), ret=%#x.", copySize, error);

        stm = nullptr;
        info = RtPtrToPtr<RingBufferElementInfo *, char_t *>(elementHostAddr.get());
        const StarsDeviceErrorInfo * const errorInfo = RtPtrToPtr<const StarsDeviceErrorInfo *, RingBufferElementInfo *>(info + 1);
        NULL_PTR_RETURN(errorInfo, RT_ERROR_DEVICE_RINGBUFFER_NO_DATA);
        GetStreamAndTaskIdFromErrorInfo(info->errorType, errorInfo, sTaskId);
        error = device_->GetStreamSqCqManage()->GetStreamSharedPtrById(static_cast<uint32_t>(sTaskId.streamId), stm);
        COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), RT_ERROR_TASK_MONITOR);

        if ((stm->Flags() & RT_STREAM_CP_PROCESS_USE) == 0U) {
            break;
        }
        head = (head + 1U) % depth;
    }

    if (stm->Model_() != nullptr && stm->Model_()->GetExeStream() != nullptr) {
        sTaskId.streamId = stm->Model_()->GetExeStream()->Id_();
    }
    *errorStreamId = sTaskId.streamId;

    if (stm->Model_() != nullptr && stm->Model_()->GetModelExecutorType() == MODEL_EXECUTOR_AICPU) {
        (void)ProcTaskErrorWithoutLock(nullptr, true);
    }

    bool monitorFlag = false;
    if (stm->Device_() == nullptr) {
        monitorFlag = false;
    } else {
        monitorFlag = stm->Device_()->GetMonitorExitFlag();
    }

    RT_LOG(RT_LOG_INFO, "Monitor get stream_id=%hu, type=%u, device=%p, monitorflag=%u",
        sTaskId.streamId, info->errorType, stm->Device_(), monitorFlag);
    stm.reset();
    return RT_ERROR_TASK_MONITOR;
}

rtError_t DeviceErrorProc::ReportRingBuffer(uint16_t *errorStreamId)
{
    // read ringbuffer obtain the device status
    rtError_t error;
    constexpr uint64_t headSize = sizeof(DevRingBufferCtlInfo);
    std::unique_ptr<char[]> hostAddr(new (std::nothrow) char[headSize]);
    NULL_PTR_RETURN(hostAddr, RT_ERROR_MEMORY_ALLOCATION);
    NULL_PTR_RETURN(device_, RT_ERROR_DEVICE_NULL);
    Driver * const devDrv = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
    NULL_PTR_RETURN(devDrv, RT_ERROR_DRV_NULL);

    const std::lock_guard<std::mutex> mutexLock(mutex_);
    if (deviceRingBufferAddr_ == nullptr) {
        return RT_ERROR_NONE;
    }
    void * const devMem = deviceRingBufferAddr_;
    error = devDrv->MemCopySync(hostAddr.get(), headSize, devMem, headSize, RT_MEMCPY_DEVICE_TO_HOST, false);
    ERROR_RETURN(error, "failed to Memcpy, copy size=%" PRIu64 "(bytes), ret=%#x.", headSize, error);
    
    DevRingBufferCtlInfo *tmpCtrlInfo = RtPtrToPtr<DevRingBufferCtlInfo *, char_t *>(hostAddr.get());
    if (tmpCtrlInfo->magic != RINGBUFFER_MAGIC) {
        return RT_ERROR_NONE;
    }
    
    // 2. ringbuffer is not nullptr
    if (tmpCtrlInfo->tail == tmpCtrlInfo->head) {
        return RT_ERROR_NONE;
    }

    error = DeviceErrorProc::CheckValid(tmpCtrlInfo);
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);

    if (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DFX_TS_RING_BUFFER)) {
        return ProcessReportRingBuffer(tmpCtrlInfo, devDrv, errorStreamId);
    }
    return RT_ERROR_TASK_MONITOR;
}

// alloc contiguour host mem and dispatch to tsfw
rtError_t DeviceErrorProc::CreateFastRingbuffer()
{
    NULL_PTR_RETURN(device_, RT_ERROR_DEVICE_NULL);
    rtError_t error = Runtime::Instance()->InitOpExecTimeout(device_);
    ERROR_RETURN(error, "failed to get op execute timeout, ret=%#x.", error);
    COND_RETURN_WITH_NOLOG(!Runtime::Instance()->IsSupportOpTimeoutMs(), RT_ERROR_NONE);
    const std::lock_guard<std::mutex> mutexLock(mutex_);
    COND_RETURN_WITH_NOLOG(fastRingBufferAddr_ != nullptr, RT_ERROR_NONE);

    void *hostMem = nullptr;
    Driver * const devDrv = device_->Driver_();
    error = devDrv->AllocFastRingBufferAndDispatch(&hostMem, fastRingBufferSize_, device_->Id_());
    ERROR_RETURN(error, "Failed to alloc fast ringbuffer memory, size=%zu(bytes).", fastRingBufferSize_);
    (void)memset_s(hostMem, fastRingBufferSize_, 0, fastRingBufferSize_);
    fastRingBufferAddr_ = hostMem;
    RT_LOG(RT_LOG_INFO, "Create fast ringbuffer successfully, size=%zu(bytes).", fastRingBufferSize_);
    return RT_ERROR_NONE;
}

void ConvertErrorCodeForFastReport(StarsOpExceptionInfo *report)
{
    const uint32_t sqeType = report->sqeType;
    const uint32_t errorCode = report->errorCode;
    // 定义映射表 [任务类型][原错误码] -> 新错误码
    static const std::unordered_map<uint32_t, std::unordered_map<uint32_t, uint32_t>> errorMap = {
        {RT_STARS_SQE_TYPE_FFTS, {{TS_ERROR_TASK_EXCEPTION, TS_ERROR_AICORE_EXCEPTION},
                                  {TS_ERROR_TASK_TIMEOUT, TS_ERROR_AICORE_TIMEOUT},
                                  {TS_ERROR_TASK_TRAP, TS_ERROR_AICORE_TRAP_EXCEPTION}}},
        {RT_STARS_SQE_TYPE_AICPU, {{TS_ERROR_TASK_EXCEPTION, TS_ERROR_AICPU_EXCEPTION},
                                   {TS_ERROR_TASK_TIMEOUT, TS_ERROR_AICPU_TIMEOUT}}},
        {RT_STARS_SQE_TYPE_SDMA, {{TS_ERROR_TASK_EXCEPTION, TS_ERROR_SDMA_ERROR},
                                  {TS_ERROR_TASK_TIMEOUT, TS_ERROR_SDMA_TIMEOUT}}}
    };

    auto taskIt = errorMap.find(sqeType);
    if (taskIt != errorMap.end()) {
        auto errorIt = taskIt->second.find(errorCode);
        if (errorIt != taskIt->second.end()) {
            report->errorCode = errorIt->second;
        }
    }
}

// fast ringbuffer(4k): DevRingBufferCtlInfo + RingBufferElementInfo + StarsOpExceptionInfo
void DeviceErrorProc::ProcessReportFastRingBuffer()
{
    COND_RETURN_VOID(device_ == nullptr, "device_ can not be nullptr.");
    if (fastRingBufferAddr_ == nullptr) {
        return; // not support fast ringbuffer
    }

    DevRingBufferCtlInfo *ctrlInfo = RtPtrToPtr<DevRingBufferCtlInfo *>(fastRingBufferAddr_);
    COND_PROC((ctrlInfo->magic != RINGBUFFER_MAGIC), return); // no error return
    StarsOpExceptionInfo report;
    {
        const std::lock_guard<std::mutex> lk(fastRingbufferMutex_);
        COND_PROC((ctrlInfo->magic != RINGBUFFER_MAGIC), return); // no error return
        StarsOpExceptionInfo *starsReport = RtValueToPtr<StarsOpExceptionInfo *>(RtPtrToValue(fastRingBufferAddr_) +
        sizeof(DevRingBufferCtlInfo) + sizeof(RingBufferElementInfo));
        report = *starsReport;
        __sync_synchronize(); // 最后置标记位, 防止指令重排
        ctrlInfo->magic = 0U; // 释放fast ring buffer, 以下不要使用
    }
    ConvertErrorCodeForFastReport(&report);
    TaskInfo *tsk = device_->GetTaskFactory()->GetTask(static_cast<int32_t>(report.streamId), report.taskId);
    RT_LOG(RT_LOG_ERROR, "fast ring buffer report error, "
        "device_id=%u, stream_id=%u, task_id=%u, sqe_type=%u, error_code=%#x, kernel_name=%s.",
        device_->Id_(), report.streamId, report.taskId, report.sqeType, report.errorCode,
        GetTaskKernelName(tsk).c_str());
    COND_RETURN_VOID(tsk == nullptr, "stream_id=%u, task_id=%u, task has been recycled.",
        report.streamId, report.taskId);
    tsk->stream->SetErrCode(report.errorCode);
    tsk->stream->EnterFailureAbort();
    TaskFailCallBack(report.streamId, report.taskId, tsk->tid, report.errorCode, device_);
    return;
}

void DeviceErrorProc::ProcClearFastRingBuffer() const
{
    if (fastRingBufferAddr_ == nullptr) {
        return;
    }
    DevRingBufferCtlInfo *ctrlInfo = RtPtrToPtr<DevRingBufferCtlInfo *>(fastRingBufferAddr_);
    ctrlInfo->magic = 0U;
}

rtError_t DeviceErrorProc::ProcCleanRingbuffer()
{
    std::unique_ptr<char[]> hostAddr(new (std::nothrow)  char[ringBufferSize_]);
    NULL_PTR_RETURN(hostAddr, RT_ERROR_MEMORY_ALLOCATION);
    NULL_PTR_RETURN(device_, RT_ERROR_DEVICE_NULL);

    // 1. memcpy ringbuffer to host
    const uint64_t copySize = ringBufferSize_;
    const uint64_t destMax = ringBufferSize_;
    const std::lock_guard<std::mutex> mutexLock(mutex_);
    NULL_PTR_RETURN(deviceRingBufferAddr_, RT_ERROR_DEVICE_NULL);
    void * const devMem = deviceRingBufferAddr_;
    rtError_t error;
    DevRingBufferCtlInfo *tmpCtrlInfo = RtPtrToPtr<DevRingBufferCtlInfo *, char_t *>(hostAddr.get());
    Driver *devDrv = nullptr;

    devDrv = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
    NULL_PTR_RETURN(devDrv, RT_ERROR_DEVICE_RINGBUFFER_NO_DATA);
    error = devDrv->MemCopySync(hostAddr.get(), destMax, devMem, copySize, RT_MEMCPY_DEVICE_TO_HOST, false);
    ERROR_RETURN(error, "Failed to Memcpy from dev to host, destMax=%" PRIu64
        ", copy size=%" PRIu64, destMax, copySize);
    
    if (tmpCtrlInfo->ringBufferLen == 0U) {
        RT_LOG(RT_LOG_EVENT, "The D2H copied data may be inconsistent. Try again.");
        error = devDrv->MemCopySync(hostAddr.get(), destMax, devMem, copySize, RT_MEMCPY_DEVICE_TO_HOST, false);
        ERROR_RETURN(error, "Failed to Memcpy from dev to host, destMax=%" PRIu64
            ", copy size=%" PRIu64, destMax, copySize);
    }

    DevRingBufferCtlInfo * const ctrlInfo = tmpCtrlInfo;
    error = DeviceErrorProc::CheckValid(ctrlInfo);
    ERROR_RETURN(error, "Find error in ringbuffer!");

    // 2. memset read pointer
    ctrlInfo->head = ctrlInfo->tail;
    error = devDrv->MemCopySync(devMem, static_cast<uint64_t>(ringBufferSize_), hostAddr.get(),
        sizeof(uint32_t) + sizeof(uint32_t), RT_MEMCPY_HOST_TO_DEVICE, false);
    ERROR_RETURN(error, "Failed to Memcpy from host to device, max len=%u,"
        " copy size=%zu.", ringBufferSize_, sizeof(uint32_t) + sizeof(uint32_t));

    RT_LOG(RT_LOG_INFO, "finished to clean ringbuffer.");
    return error;
}

static bool JudgeChipTypeforSnapshot(DevProperties properties, uint32_t tschVersion)
{
    bool snapshotFlag = false;
    if (properties.supportSnapshot == SupportSnapshot::SUPPORT) {
        snapshotFlag = true;
    } else if (properties.supportSnapshot == SupportSnapshot::SUPPORT_ON_HIGH_TS_VERSION &&
        tschVersion >= TS_VERSION_STREAM_TIMEOUT_SNAPSHOT) {
        snapshotFlag = true;
    }
    // other snapshotFlag don't support snapshot
    return snapshotFlag;
}

bool DeviceErrorProc::IsPrintStreamTimeoutSnapshot()
{
    if (device_ == nullptr) {
        return false;
    }
    NULL_PTR_RETURN(deviceRingBufferAddr_, false);
    const std::unique_lock<std::mutex> lk(device_->GetErrProLock());
    if (!JudgeChipTypeforSnapshot(device_->GetDevProperties(), device_->GetTschVersion()) ||
        !device_->GetSnapshotFlag()) {
        RT_LOG(RT_LOG_INFO, "do not snapshot: chiptype=%d ts_version=%u snapshotflag=%d",
            Runtime::Instance()->GetChipType(), device_->GetTschVersion(), device_->GetSnapshotFlag());
        return false;
    }
    RT_LOG(RT_LOG_DEBUG, "check snapshot para ok: chiptype=%d ts_version=%u snapshotflag=%d",
        Runtime::Instance()->GetChipType(), device_->GetTschVersion(), device_->GetSnapshotFlag());
    return true;
}

static void PrintSnapshotInfo(TaskInfo * const tsk, char_t * const errStr, int32_t countNum)
{
    int32_t ret = 0;
    switch (tsk->type) {
        case TS_TASK_TYPE_EVENT_RECORD: {
            EventRecordTaskInfo * const recTask = &(tsk->u.eventRecordTaskInfo);
            ret = sprintf_s(errStr + countNum,
                (static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum)),
                ", EventId=%d", recTask->eventid);
            break;
        }
        case TS_TASK_TYPE_STREAM_WAIT_EVENT: {
            EventWaitTaskInfo * const eventWaitTask = &(tsk->u.eventWaitTaskInfo);
            ret = sprintf_s(errStr + countNum,
                (static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum)),
                ", EventId=%d", eventWaitTask->eventId);
            break;
        }
        case TS_TASK_TYPE_NOTIFY_RECORD: {
            NotifyRecordTaskInfo * const notifyRecordTask = &(tsk->u.notifyrecordTask);
            ret = sprintf_s(errStr + countNum,
                (static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum)),
                ", NotifyId=%d", notifyRecordTask->notifyId);
            break;
        }
        case TS_TASK_TYPE_NOTIFY_WAIT: {
            NotifyWaitTaskInfo * const notifyWaitTask = &(tsk->u.notifywaitTask);
            ret = sprintf_s(errStr + countNum,
                (static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum)),
                ", NotifyId=%u", notifyWaitTask->notifyId);
            break;
        }
        case TS_TASK_TYPE_KERNEL_AICORE: {
            std::string kernelNameStr;
            AicTaskInfo * const aicTask = &(tsk->u.aicTaskInfo);
            if ((aicTask != nullptr) && (aicTask->kernel != nullptr)) {
                kernelNameStr = aicTask->kernel->Name_();
            }
            ret = sprintf_s(errStr + countNum,
                (static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum)),
                ", kernel_name=%s", kernelNameStr.c_str());
            break;
        }
        case TS_TASK_TYPE_KERNEL_AICPU: {
            ret = sprintf_s(errStr + countNum,
                (static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum)),
                ", OpName=%s", tsk->stream->GetTaskTag(tsk->id).c_str());
            break;
        }
        default:
            break;
    }

    COND_RETURN_VOID(ret < 0, "sprintf_s failed, ret=%d.", ret);
}

rtError_t DeviceErrorProc::PrintStreamTimeoutSnapshotInfo()
{
    char_t errMsg[MSG_LENGTH + 1U] = {0U};
    char_t * const errStr = errMsg;
    int32_t countNum;
    rtError_t error;
    NULL_PTR_RETURN(device_, RT_ERROR_DEVICE_NULL);
    Driver * const devDrv = device_->Driver_();

    if (!IsPrintStreamTimeoutSnapshot()) {
        return RT_ERROR_NONE;
    }

    const std::unique_lock<std::mutex> lk(device_->GetErrProLock());
    std::unique_ptr<char[]> hostAddr(new (std::nothrow) char[sizeof(RtsTimeoutStreamSnapshot)]);
    NULL_PTR_RETURN(hostAddr, RT_ERROR_MEMORY_ALLOCATION);
    error = devDrv->MemCopySync(hostAddr.get(), static_cast<uint64_t>(snapshotLen_),
        device_->GetSnapshotAddr(), static_cast<uint64_t>(snapshotLen_), RT_MEMCPY_DEVICE_TO_HOST, false);
    ERROR_RETURN(error, "Failed to Memcpy snapshot from dev to host");
    RtsTimeoutStreamSnapshot *streamTaskInfo = RtPtrToPtr<RtsTimeoutStreamSnapshot *,  char_t *>(hostAddr.get());
    if ((streamTaskInfo->stream_num == 0U) || (streamTaskInfo->stream_num > MAX_STREAM_NUM_CLOUD)) {
        RT_LOG(RT_LOG_INFO, "get stream wait timeout snapshot stream_num:%hu", streamTaskInfo->stream_num);
        return RT_ERROR_NONE;
    }
    RT_LOG(RT_LOG_DEBUG, "get stream wait timeout snapshot stream_num:%hu ok", streamTaskInfo->stream_num);
    for (uint32_t i = 0U; i < streamTaskInfo->stream_num; i++) {
        (void)memset_s(errStr, sizeof(errMsg), 0U, sizeof(errMsg));
        const uint16_t streamId = streamTaskInfo->detailInfo[i].stream_id;
        const uint16_t taskId = streamTaskInfo->detailInfo[i].task_id;
        TaskInfo *tsk = GetTaskInfo(device_, static_cast<uint32_t>(streamId), static_cast<uint32_t>(taskId));
        if (tsk == nullptr) {
            RT_LOG(RT_LOG_ERROR, "stream_id=%hu task_id=%hu can not find", streamId, taskId);
            continue;
        }
        countNum = sprintf_s(errStr, static_cast<size_t>(MSG_LENGTH),
            "stream_id=%hu, task_id=%hu, taskType=%d (%s)",
            streamId, taskId, tsk->type, tsk->typeName);
        if ((countNum < 0) || (countNum > MSG_LENGTH)) {
            RT_LOG(RT_LOG_ERROR, "cpy countNum=%d error", countNum);
            continue;
        }
        PrintSnapshotInfo(tsk, errStr, countNum);
        RT_LOG(RT_LOG_ERROR, "%s.", errStr);
    }

    device_->SetSnapshotFlag(false);
    RT_LOG(RT_LOG_INFO, "get stream wait timeout snapshot suc, snapshotFlag=%d", device_->GetSnapshotFlag());
    return RT_ERROR_NONE;
}

void DeviceErrorProc::ProduceProcNum()
{
    (void)needProcNum_++;
}

void DeviceErrorProc::ConsumeProcNum(const uint32_t procNum)
{
    const uint64_t num = procNum;
    (void)consumeNum_.fetch_add(num);
}

void DeviceErrorProc::ProcessStarsCoreErrorOneMapInfo(uint32_t * const cnt, uint64_t err, std::string &errorString,
    uint32_t offset)
{
    if (err == 0ULL) {
        return;
    }

    RT_LOG(RT_LOG_DEBUG, "core errorCode:%" PRIx64, err);
    for (uint32_t i = static_cast<uint32_t>(BitScan(err)); i < MAX_BIT_LEN; i = static_cast<uint32_t>(BitScan(err))) {
        BITMAP_CLR(err, static_cast<uint64_t>(i));
        const auto it = errorMapInfo_.find((i + offset));
        if (it != errorMapInfo_.end()) {
            // if the string is too long, the log will truncate to 1024.
            // so the error string only show 400.
            if (unlikely((it->second.size() + errorString.size()) > RINGBUFFER_ERROR_MSG_MAX_LEN)) {
                RT_LOG(RT_LOG_WARNING, "The error info is too long.");
                break;
            }
            errorString += it->second;
        }
    }
    (*cnt)++;

    return;
}

void DeviceErrorProc::ProcessStarsCoreErrorMapInfo(const StarsOneCoreErrorInfo * const info, std::string &errorString)
{
    uint32_t cnt = 0U;

    // aicError1 aicError 0
    DeviceErrorProc::ProcessStarsCoreErrorOneMapInfo(&cnt, info->aicError[0], errorString, RINGBUFFER_ERRCODE0_OFFSET);
    // aicError3 aicError 2
    DeviceErrorProc::ProcessStarsCoreErrorOneMapInfo(&cnt, info->aicError[1], errorString, RINGBUFFER_ERRCODE2_OFFSET);
    // aicError4 17 bits
    // aicError5 aicError 4
    const uint64_t err = (static_cast<uint64_t>((info->aicError[2] >> 32ULL) << 17ULL) | (info->aicError[2] & 0x1FFFFULL));
    DeviceErrorProc::ProcessStarsCoreErrorOneMapInfo(&cnt, err, errorString, RINGBUFFER_ERRCODE4_OFFSET);
    if (cnt != 0U) {  // at least one error bit exists.
        return;
    }

    errorString = "timeout or trap error.";
    return;
}

rtError_t DeviceErrorProc::ProcessStarsWaitTimeoutErrorInfo(const StarsDeviceErrorInfo * const info,
                                                            const uint64_t errorNumber,
                                                            const Device * const dev,
                                                            const DeviceErrorProc * const insPtr)
{
    UNUSED(insPtr);
    if (info == nullptr) {
        return RT_ERROR_NONE;
    }

    TaskInfo *errTaskPtr = dev->GetTaskFactory()->GetTask(static_cast<int32_t>(info->u.timeoutErrorInfo.streamId),
        info->u.timeoutErrorInfo.taskId);
    if (errTaskPtr != nullptr) {
        errTaskPtr->isRingbufferGet = true;
    }

    uint8_t type = info->u.timeoutErrorInfo.waitType;

    if (type == RT_STARS_SQE_TYPE_NOTIFY_WAIT) {
        RT_LOG_CALL_MSG(ERR_MODULE_SYSTEM, "The error from device(chipId:%u, dieId:%u), serial number is %" PRIu64 ", "
            "notify wait timeout occurred during task execution, stream_id:%hu, sq_id:%hu, task_id:%hu, "
            "notify_id=%u, timeout=%us.", info->u.timeoutErrorInfo.chipId, info->u.timeoutErrorInfo.dieId, errorNumber,
            info->u.timeoutErrorInfo.streamId, info->u.timeoutErrorInfo.sqId, info->u.timeoutErrorInfo.taskId,
            info->u.timeoutErrorInfo.wait.notifyInfo.notifyId, info->u.timeoutErrorInfo.wait.notifyInfo.timeout);
    } else if (type == RT_STARS_SQE_TYPE_EVENT_WAIT) {
        RT_LOG_CALL_MSG(ERR_MODULE_SYSTEM, "The error from device(chipId:%u, dieId:%u), serial number is %" PRIu64 ", "
            "event wait timeout occurred during task execution, stream_id:%hu, sq_id:%hu, task_id:%hu, "
            "event_id=%u, timeout=%us.", info->u.timeoutErrorInfo.chipId, info->u.timeoutErrorInfo.dieId, errorNumber,
            info->u.timeoutErrorInfo.streamId, info->u.timeoutErrorInfo.sqId, info->u.timeoutErrorInfo.taskId,
            info->u.timeoutErrorInfo.wait.eventInfo.eventId, info->u.timeoutErrorInfo.wait.eventInfo.timeout);
    } else {
        RT_LOG_CALL_MSG(ERR_MODULE_SYSTEM,
            "type = %hhu,The error from device(chipId:%u, dieId:%u), serial number is %" PRIu64 ", "
            "event wait timeout occurred during task execution, stream_id:%hu, sq_id:%hu, task_id:%hu.",
            type, info->u.timeoutErrorInfo.chipId, info->u.timeoutErrorInfo.dieId, errorNumber,
            info->u.timeoutErrorInfo.streamId, info->u.timeoutErrorInfo.sqId, info->u.timeoutErrorInfo.taskId);
    }
    if (errTaskPtr == nullptr) {
        RT_LOG_CALL_MSG(ERR_MODULE_GE, "Error task from the device stream.");
    }
    return RT_ERROR_NONE;
}


rtError_t ProcessStarsAicpuErrorInfo(const StarsDeviceErrorInfo * const info,
                                                      const uint64_t errorNumber,
                                                      const Device * const dev, const DeviceErrorProc * const insPtr)
{
    UNUSED(insPtr);
    if (info == nullptr) {
        return RT_ERROR_NONE;
    }

    if (info->u.aicpuErrorInfo.comm.coreNum == 0U) {
        return RT_ERROR_NONE;
    }
    const uint16_t type = info->u.coreErrorInfo.comm.type;
    bool isFftsPlusTask = false;
    rtFftsPlusTaskErrInfo_t fftsPlusErrInfo = rtFftsPlusTaskErrInfo_t();
    /* aicpu error by ffts+ */
    TaskInfo *errTaskPtr = GetTaskInfo(dev, static_cast<uint32_t>(info->u.aicpuErrorInfo.comm.streamId),
            static_cast<uint32_t>(info->u.aicpuErrorInfo.comm.taskId));
    if (errTaskPtr != nullptr) {
        errTaskPtr->isRingbufferGet = true;
        if ((errTaskPtr->type ==  TS_TASK_TYPE_FFTS_PLUS) && (type == FFTS_PLUS_AICPU_ERROR)) {
            isFftsPlusTask = true;
        }
    }
    /* aicpu error by topic scheduler */
    if (type == static_cast<uint16_t>(AICPU_ERROR)) {
        std::string msg = "aicpu execute failed";
        const uint64_t errcode = info->u.aicpuErrorInfo.aicpu.rspErrorInfo.errcode;
        const auto it = g_aicpuErrorMapInfo.find(errcode);
        if (it != g_aicpuErrorMapInfo.end()) {
            msg = it->second;
        }
        RT_LOG_CALL_MSG(ERR_MODULE_AICPU, "The error from device(chipId:%u, dieId:%u), serial number is %" PRIu64 ", "
            "an exception occurred during AICPU execution, stream_id:%u, %s:%u, errcode:%" PRIu64 ", msg:%s.",
            info->u.aicpuErrorInfo.comm.chipId, info->u.aicpuErrorInfo.comm.dieId, errorNumber,
            info->u.aicpuErrorInfo.aicpu.rspErrorInfo.streamId, TaskIdDesc(), info->u.aicpuErrorInfo.aicpu.rspErrorInfo.taskId,
            errcode, msg.c_str());
        return RT_ERROR_NONE;
    }

    for (uint32_t coreIdx = 0; coreIdx < static_cast<uint32_t>(info->u.aicpuErrorInfo.comm.coreNum); coreIdx++) {
        RT_LOG_CALL_MSG(ERR_MODULE_AICPU, "The error from device(chipId:%u, dieId:%u), serial number is %" PRIu64 ", "
            "an exception occurred during fftsplus AICPU execution, aicpuId:%hhu, "
            "aicpuState:%hhu, aicpuTslotid:%hhu, aicpuCxtid:%hu, aicpuThreadid:%hu.",
            info->u.aicpuErrorInfo.comm.chipId, info->u.aicpuErrorInfo.comm.dieId, errorNumber,
            info->u.aicpuErrorInfo.aicpu.info[coreIdx].aicpuId,
            info->u.aicpuErrorInfo.aicpu.info[coreIdx].aicpuState,
            info->u.aicpuErrorInfo.aicpu.info[coreIdx].aicpuTslotid,
            info->u.aicpuErrorInfo.aicpu.info[coreIdx].aicpuCxtid,
            info->u.aicpuErrorInfo.aicpu.info[coreIdx].aicpuThreadid);
        if (isFftsPlusTask) {
            fftsPlusErrInfo.contextId = info->u.aicpuErrorInfo.aicpu.info[coreIdx].aicpuCxtid;
            fftsPlusErrInfo.threadId = info->u.aicpuErrorInfo.aicpu.info[coreIdx].aicpuThreadid;
            fftsPlusErrInfo.errType = info->u.aicpuErrorInfo.comm.type;
            PushBackErrInfo(errTaskPtr, static_cast<const void *>(&fftsPlusErrInfo),
                            static_cast<uint32_t>(sizeof(rtFftsPlusTaskErrInfo_t)));
        }
    }
    return RT_ERROR_NONE;
}

static void RecordSdmaErrorInfo(Device * const dev, uint32_t coreNum, TaskInfo *errTaskPtr,
    const StarsDeviceErrorInfo * const info, const uint64_t errorNumber)
{
    for (uint32_t coreIdx = 0U; coreIdx < coreNum; coreIdx++) {
        RT_LOG_CALL_MSG(ERR_MODULE_GE, "The error from device(chipId:%u, dieId:%u), "
            "serial number is %" PRIu64 ".there is a sdma error, sdma channel is %hhu, "
            "sdmaChFsmState=0x%x, sdmaChFree=0x%x, irqStatus=0x%x, cqeStatus=0x%x ",
            info->u.sdmaErrorInfo.comm.chipId, info->u.sdmaErrorInfo.comm.dieId, errorNumber,
            info->u.sdmaErrorInfo.sdma.starsInfoForStarsV2[coreIdx].sdmaChannelId,
            info->u.sdmaErrorInfo.sdma.starsInfoForStarsV2[coreIdx].sdmaChFsmState,
            info->u.sdmaErrorInfo.sdma.starsInfoForStarsV2[coreIdx].sdmaChFree,
            info->u.sdmaErrorInfo.sdma.starsInfoForStarsV2[coreIdx].irqStatus,
            info->u.sdmaErrorInfo.sdma.starsInfoForStarsV2[coreIdx].cqeStatus);
        if (info->u.sdmaErrorInfo.sdma.starsInfoForStarsV2[coreIdx].cqeStatus == TS_SDMA_STATUS_POISON_ERROR) {
            dev->SetDeviceFaultType(DeviceFaultType::MTE_ERROR);
            if (errTaskPtr != nullptr) {
                errTaskPtr->mte_error = TS_ERROR_SDMA_POISON_ERROR;
            }
        }
    }
}

static void RecordSdmaErrorInfoForNonStarsV2(const Device * const dev, uint32_t coreNum, TaskInfo *errTaskPtr,
    const StarsDeviceErrorInfo * const info, const uint64_t errorNumber)
{
    for (uint32_t coreIdx = 0U; coreIdx < coreNum; coreIdx++) {
        RT_LOG_CALL_MSG(ERR_MODULE_GE, "The error from device(chipId:%u, dieId:%u), serial number is %" PRIu64 ". "
            "there is a sdma error, sdma channel is %hhu, "
            "sdmaBlkFsmState=0x%x, dfxSdmaBlkFsmOstCnt=0x%x, sdmaChFree=0x%x, "
            "irqStatus=0x%x, cqeStatus=0x%x ",
            info->u.sdmaErrorInfo.comm.chipId, info->u.sdmaErrorInfo.comm.dieId, errorNumber,
            info->u.sdmaErrorInfo.sdma.starsInfo[coreIdx].sdmaChannelId,
            info->u.sdmaErrorInfo.sdma.starsInfo[coreIdx].sdmaBlkFsmState,
            info->u.sdmaErrorInfo.sdma.starsInfo[coreIdx].dfxSdmaBlkFsmOstCnt,
            info->u.sdmaErrorInfo.sdma.starsInfo[coreIdx].sdmaChFree,
            info->u.sdmaErrorInfo.sdma.starsInfo[coreIdx].irqStatus,
            info->u.sdmaErrorInfo.sdma.starsInfo[coreIdx].cqeStatus);
        if (errTaskPtr != nullptr) {
            const uint32_t cqeStatus = info->u.sdmaErrorInfo.sdma.starsInfo[coreIdx].cqeStatus;
            GetMteErrFromCqeStatus(errTaskPtr, dev, cqeStatus);
            RT_LOG(RT_LOG_ERROR, "Get sdma mte error, stream_id=%hu, task_id=%hu, errorCode=%u",
                info->u.coreErrorInfo.comm.streamId, info->u.coreErrorInfo.comm.taskId, errTaskPtr->mte_error);
        }
    }
}

rtError_t DeviceErrorProc::ProcessStarsSdmaErrorInfo(const StarsDeviceErrorInfo * const info,
                                                     const uint64_t errorNumber,
                                                     const Device * const dev, const DeviceErrorProc *const insPtr)
{
    UNUSED(insPtr);
    RUNTIME_NULL_NO_PROC_WITH_RET(info);
    RUNTIME_NULL_NO_PROC_WITH_RET(dev);
    const uint16_t type = info->u.sdmaErrorInfo.comm.type;
    TaskInfo *errTaskPtr = GetTaskInfo(dev, static_cast<uint32_t>(info->u.sdmaErrorInfo.comm.streamId),
            static_cast<uint32_t>(info->u.sdmaErrorInfo.comm.taskId));
    if (errTaskPtr != nullptr) {
        errTaskPtr->isRingbufferGet = true;
    }
    const uint32_t coreNum = static_cast<uint32_t>(info->u.sdmaErrorInfo.comm.coreNum);
    if (type == static_cast<uint16_t>(SDMA_ERROR)) {
        if (dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_ALLOC_FROM_STREAM_POOL)) {
            RecordSdmaErrorInfo(RtPtrToUnConstPtr<Device *>(dev), coreNum, errTaskPtr, info, errorNumber);
        } else {
            RecordSdmaErrorInfoForNonStarsV2(dev, coreNum, errTaskPtr, info, errorNumber);
        }
        if (errTaskPtr == nullptr) {
            RT_LOG_CALL_MSG(ERR_MODULE_GE, "Error task from the device stream.");
        }
    } else {
        bool isFftsPlusTask = false;
         rtFftsPlusTaskErrInfo_t fftsPlusErrInfo = rtFftsPlusTaskErrInfo_t();
        if ((errTaskPtr != nullptr) && (errTaskPtr->type == TS_TASK_TYPE_FFTS_PLUS)) {
            isFftsPlusTask = true;
        }

        uint32_t fftsPluscqeStatus = 0;
        for (uint32_t coreIdx = 0U; coreIdx < static_cast<uint32_t>(info->u.sdmaErrorInfo.comm.coreNum); coreIdx++) {
            RT_LOG_CALL_MSG(ERR_MODULE_GE, "The error from device(chipId:%u, dieId:%u), serial number is %" PRIu64 ". "
                "there is a fftsplus sdma error, sdma channel is %hhu, "
                "sdmaState=0x%x, sdmaTslotid=0x%x, sdmaCxtid=0x%x, sdmaThreadid=0x%x, "
                "irqStatus=0x%x, cqeStatus=0x%x.",
                info->u.sdmaErrorInfo.comm.chipId, info->u.sdmaErrorInfo.comm.dieId, errorNumber,
                info->u.sdmaErrorInfo.sdma.fftsPlusInfo[coreIdx].sdmaChannelId,
                info->u.sdmaErrorInfo.sdma.fftsPlusInfo[coreIdx].sdmaState,
                info->u.sdmaErrorInfo.sdma.fftsPlusInfo[coreIdx].sdmaTslotid,
                info->u.sdmaErrorInfo.sdma.fftsPlusInfo[coreIdx].sdmaCxtid,
                info->u.sdmaErrorInfo.sdma.fftsPlusInfo[coreIdx].sdmaThreadid,
                info->u.sdmaErrorInfo.sdma.fftsPlusInfo[coreIdx].irqStatus,
                info->u.sdmaErrorInfo.sdma.fftsPlusInfo[coreIdx].cqeStatus);
                fftsPluscqeStatus = ((info->u.sdmaErrorInfo.sdma.fftsPlusInfo[coreIdx].cqeStatus) >> 17U) & 0x1FU;
                if (errTaskPtr != nullptr) {
                    GetMteErrFromCqeStatus(errTaskPtr, dev, fftsPluscqeStatus);
                    RT_LOG(RT_LOG_ERROR, "Get sdma mte error=0x%x, cqeStatus=0x%x.", errTaskPtr->mte_error,
                           fftsPluscqeStatus);
                }
            if (isFftsPlusTask) {
                fftsPlusErrInfo.contextId = info->u.sdmaErrorInfo.sdma.fftsPlusInfo[coreIdx].sdmaCxtid;
                fftsPlusErrInfo.threadId = info->u.sdmaErrorInfo.sdma.fftsPlusInfo[coreIdx].sdmaThreadid;
                fftsPlusErrInfo.errType = info->u.sdmaErrorInfo.comm.type;
                PushBackErrInfo(errTaskPtr, static_cast<const void *>(&fftsPlusErrInfo),
                                static_cast<uint32_t>(sizeof(rtFftsPlusTaskErrInfo_t)));
            }
        }
    }
    return RT_ERROR_NONE;
}

rtError_t DeviceErrorProc::ProcessStarsHcclFftsPlusTimeoutErrorInfo(const StarsDeviceErrorInfo * const info,
                                                                    const uint64_t errorNumber,
                                                                    const Device * const dev,
                                                                    const DeviceErrorProc * const insPtr)
{
    UNUSED(insPtr);
    if (info == nullptr) {
        return RT_ERROR_NONE;
    }

    rtFftsPlusTaskErrInfo_t fftsPlusErrInfo = rtFftsPlusTaskErrInfo_t();
    TaskInfo *errTask =
        dev->GetTaskFactory()->GetTask(static_cast<int32_t>(info->u.hcclFftsplusTimeoutInfo.common.streamId),
        info->u.hcclFftsplusTimeoutInfo.common.taskId);
    if (errTask != nullptr) {
        errTask->isRingbufferGet = true;
    }

    uint32_t ctxNum = info->u.hcclFftsplusTimeoutInfo.errConetxtNum < RINGBUFFER_HCCL_FFTSPLUS_MAX_CONTEXT_NUM ?
        info->u.hcclFftsplusTimeoutInfo.errConetxtNum : RINGBUFFER_HCCL_FFTSPLUS_MAX_CONTEXT_NUM;
    if (info->u.hcclFftsplusTimeoutInfo.common.timeout == RT_STARS_DEFAULT_HCCL_FFTSPLUS_TIMEOUT) {
        RT_LOG_CALL_MSG(ERR_MODULE_HCCL, "The error from device(chipId:%u, dieId:%u), serial number is %" PRIu64 ", "
            "hccl fftsplus task timeout occurred during task execution, stream_id:%hu, sq_id:%hu, "
            "task_id:%hu, stuck notify num:%u, timeout=30min(default).", info->u.hcclFftsplusTimeoutInfo.common.chipId,
            info->u.hcclFftsplusTimeoutInfo.common.dieId, errorNumber,
            info->u.hcclFftsplusTimeoutInfo.common.streamId, info->u.hcclFftsplusTimeoutInfo.common.sqId,
            info->u.hcclFftsplusTimeoutInfo.common.taskId, ctxNum);
    } else {
        RT_LOG_CALL_MSG(ERR_MODULE_HCCL, "The error from device(chipId:%u, dieId:%u), serial number is %" PRIu64 ", "
            "hccl fftsplus task timeout occurred during task execution, stream_id:%hu, sq_id:%hu, "
            "task_id:%hu, stuck notify num:%u, timeout=%us.", info->u.hcclFftsplusTimeoutInfo.common.chipId,
            info->u.hcclFftsplusTimeoutInfo.common.dieId, errorNumber,
            info->u.hcclFftsplusTimeoutInfo.common.streamId, info->u.hcclFftsplusTimeoutInfo.common.sqId,
            info->u.hcclFftsplusTimeoutInfo.common.taskId, ctxNum, info->u.hcclFftsplusTimeoutInfo.common.timeout);
    }
    for (uint32_t i = 0; i < ctxNum; i++) {
        fftsPlusErrInfo.errType = HCCL_FFTSPLUS_TIMEOUT_ERROR;
        fftsPlusErrInfo.contextId = info->u.hcclFftsplusTimeoutInfo.contextInfo.notifyInfo[i].contextId;
        RT_LOG_CALL_MSG(ERR_MODULE_HCCL, "The %u stuck notify wait context info:(context_id=%u, notify_id=%u).", i,
            info->u.hcclFftsplusTimeoutInfo.contextInfo.notifyInfo[i].contextId,
            info->u.hcclFftsplusTimeoutInfo.contextInfo.notifyInfo[i].notifyId);
        if (errTask != nullptr) {
            PushBackErrInfo(errTask, static_cast<const void *>(&fftsPlusErrInfo),
                static_cast<uint32_t>(sizeof(rtFftsPlusTaskErrInfo_t)));
        }
    }

    return RT_ERROR_NONE;
}

rtError_t DeviceErrorProc::ProcessStarsDvppErrorInfo(const StarsDeviceErrorInfo * const info,
                                                     const uint64_t errorNumber,
                                                     const Device * const dev, const DeviceErrorProc *const insPtr)
{
    UNUSED(insPtr);
    if (info == nullptr) {
        return RT_ERROR_NONE;
    }

    TaskInfo *errTaskPtr = GetTaskInfo(dev,
        static_cast<uint32_t>(info->u.dvppErrorInfo.streamId),
        static_cast<uint32_t>(info->u.dvppErrorInfo.taskId));
    if (errTaskPtr != nullptr) {
        errTaskPtr->isRingbufferGet = true;
    }

    RT_LOG_CALL_MSG(ERR_MODULE_SYSTEM, "The error from device(chipId:%u, dieId:%u), serial number is %" PRIu64 ", "
        "an exception occurred during DVPP task execution, stream_id:%u, %s:%u, errcode:%hu, sqe_type=%hu",
        info->u.dvppErrorInfo.chipId, info->u.dvppErrorInfo.dieId, errorNumber, info->u.dvppErrorInfo.streamId,
        TaskIdDesc(), info->u.dvppErrorInfo.taskId, info->u.dvppErrorInfo.exceptionType,
        info->u.dvppErrorInfo.sqeType);
    return RT_ERROR_NONE;
}

rtError_t DeviceErrorProc::ProcessStarsDsaErrorInfo(const StarsDeviceErrorInfo * const info,
                                                    const uint64_t errorNumber,
                                                    const Device * const dev, const DeviceErrorProc * const insPtr)
{
    UNUSED(insPtr);
    UNUSED(dev);

    if (info == nullptr) {
        return RT_ERROR_NONE;
    }
    if (info->u.dsaErrorInfo.type == static_cast<uint16_t>(DSA_ERROR)) {
        for (uint32_t coreIdx = 0U; coreIdx < static_cast<uint32_t>(info->u.dsaErrorInfo.coreNum); coreIdx++) {
            RT_LOG_CALL_MSG(ERR_MODULE_FE, "The error from device(chipId:%u, dieId:%u), serial number is %" PRIu64 ". "
                "there is a dsa error, dsa channel is %hhu, error intr status=0x%x.",
                info->u.dsaErrorInfo.chipId, info->u.dsaErrorInfo.dieId, errorNumber,
                info->u.dsaErrorInfo.info[coreIdx].chanId,
                info->u.dsaErrorInfo.info[coreIdx].chanErr);
        }
        TaskInfo *errTaskPtr = dev->GetTaskFactory()->GetTask(static_cast<int32_t>(info->u.dsaErrorInfo.sqe.sqeHeader.rt_stream_id),
        info->u.dsaErrorInfo.sqe.sqeHeader.task_id);
        if (errTaskPtr != nullptr) {
            errTaskPtr->isRingbufferGet = true;
        }
    } else {
        TaskInfo *realFaultTaskPtr = insPtr->GetRealFaultTaskPtr(); // maybe not match ringbuffer task.
        bool isNeedProFftsPlusErr = false;
        rtFftsPlusTaskErrInfo_t fftsPlusErr = {};
        if ((realFaultTaskPtr != nullptr) && (realFaultTaskPtr->type ==  TS_TASK_TYPE_FFTS_PLUS)) {
            isNeedProFftsPlusErr = true;
            realFaultTaskPtr->isRingbufferGet = true;
        }
        for (uint32_t coreIdx = 0U; coreIdx < static_cast<uint32_t>(info->u.dsaErrorInfo.coreNum); coreIdx++) {
            RT_LOG_CALL_MSG(ERR_MODULE_FE, "The error from device(chipId:%u, dieId:%u), serial number is %" PRIu64 ". "
                "there is a fftsplus dsa error, dsa channel is %hhu, error intr status=0x%x, "
                "dsaCtxid=0x%x, dsaThreadid=0x%x.",
                info->u.dsaErrorInfo.chipId, info->u.dsaErrorInfo.dieId, errorNumber,
                info->u.dsaErrorInfo.info[coreIdx].chanId,
                info->u.dsaErrorInfo.info[coreIdx].chanErr,
                info->u.dsaErrorInfo.info[coreIdx].ctxId,
                info->u.dsaErrorInfo.info[coreIdx].threadId);
            if (isNeedProFftsPlusErr) {
                fftsPlusErr.contextId = info->u.dsaErrorInfo.info[coreIdx].ctxId;
                fftsPlusErr.threadId = info->u.dsaErrorInfo.info[coreIdx].threadId;
                fftsPlusErr.errType = info->u.dsaErrorInfo.type;
                fftsPlusErr.dsaSqe = info->u.dsaErrorInfo.sqe;
                PushBackErrInfo(realFaultTaskPtr, static_cast<const void *>(&fftsPlusErr),
                                static_cast<uint32_t>(sizeof(rtFftsPlusTaskErrInfo_t)));
            }
        }
    }
    return RT_ERROR_NONE;
}

rtError_t DeviceErrorProc::ProcessStarsCoreTimeoutDfxInfo(const StarsDeviceErrorInfo *const info,
    const uint64_t errorNumber, const Device *const dev, const DeviceErrorProc *const insPtr)
{
    UNUSED(insPtr);
    if (info == nullptr) {
        RT_LOG(RT_LOG_ERROR, "info or device is null");
        return RT_ERROR_NONE;
    }
    StarsErrorCommonInfo common = info->u.coreTimeoutDfxInfo.comm;
    RT_LOG(RT_LOG_ERROR,
        "The error from device(chipId:%u, dieId:%u), serial number is %" PRIu64 ", "
        "aicore task timeout dfx, falut_stream_id=%u, falut_task_id=%u, falut_slot_id=%u, timeout and own_bitmap=0",
        common.chipId,
        common.dieId,
        errorNumber,
        common.streamId,
        common.taskId,
        common.exceptionSlotId);
    TaskInfo *errTaskPtr = dev->GetTaskFactory()->GetTask(static_cast<int32_t>(common.streamId), common.taskId);
    if (errTaskPtr != nullptr) {
        errTaskPtr->isRingbufferGet = true;
    }
    // process 8 slot,include ffts+
    for (uint16_t slotIdx = 0U; slotIdx < static_cast<uint16_t>(common.slotNum); slotIdx++) {
        StarsOneTimeoutSlotDfxInfo slotInfo = info->u.coreTimeoutDfxInfo.slotInfo[slotIdx];
        if (slotInfo.fftsType != RT_FFTS_PLUS_TYPE) {
            ProcessStarsTimeoutDfxSlotInfo(info, dev, slotIdx);
            continue;
        }
        TaskInfo *taskInfo = dev->GetTaskFactory()->GetTask(static_cast<int32_t>(slotInfo.streamId), slotInfo.taskId);
        if (taskInfo == nullptr) {
            RT_LOG(RT_LOG_ERROR, "task info is null, stream_id=%hu, task_id=%hu", slotInfo.streamId, slotInfo.taskId);
            continue;
        }

        AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);
        if (aicTaskInfo->kernel == nullptr) {
            RT_LOG(RT_LOG_ERROR, "task kernel is null, stream_id=%hu, task_id=%hu", slotInfo.streamId, slotInfo.taskId);
            continue;
        }
        const uint8_t mixType = aicTaskInfo->kernel->GetMixType();
        if ((mixType > NO_MIX) && (mixType <= static_cast<uint8_t>(MIX_AIC_AIV_MAIN_AIV))) {
            // mix
            ProcessStarsTimeoutDfxSlotInfo(info, dev, slotIdx);
        } else {
            // ffts+
            ProcessStarsTimeoutDfxSlotInfo4FftsPlus(info, const_cast<Device *>(dev), slotIdx);
        }
    }
    // core info, only print subError!=0
    for (uint16_t coreIdx = 0U; coreIdx < common.coreNum; coreIdx++) {
        StarsOneTimeoutCoreDfxInfo coreInfo = info->u.coreTimeoutDfxInfo.coreInfo[coreIdx];
        if (coreInfo.subError != 0) {
            RT_LOG(RT_LOG_ERROR,
                "aicore task timeout dfx, show core info, core_id=%u, core_type=%u, sub_error=%u, "
                "current_pc=%#" PRIx64 ", slot_id=%u.",
                coreInfo.coreId,
                coreInfo.coreType,
                coreInfo.subError,
                coreInfo.currentPc,
                coreInfo.slotId);
        }
    }
    return RT_ERROR_NONE;
}

void DeviceErrorProc::ProcessStarsTimeoutDfxSlotInfo(
    const StarsDeviceErrorInfo *const info, const Device *const dev, uint16_t slotIdx)
{
    if (info == nullptr || dev == nullptr) {
        RT_LOG(RT_LOG_WARNING, "info or device is null");
        return;
    }
    StarsOneTimeoutSlotDfxInfo slotInfo = info->u.coreTimeoutDfxInfo.slotInfo[slotIdx];
    const uint16_t streamId = slotInfo.streamId;
    const uint16_t taskId = slotInfo.taskId;

    TaskInfo *taskInfo = dev->GetTaskFactory()->GetTask(static_cast<int32_t>(streamId), taskId);
    if (taskInfo == nullptr) {
        RT_LOG(RT_LOG_ERROR, "task info is null, device_id=%u, stream_id=%u, task_id=%u, slot_id=%u", 
        dev->Id_(), streamId, taskId, slotInfo.slotId);
        return;
    }
    AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);
    std::string kernelNameStr;
    std::string kernelInfoExt;
    if (aicTaskInfo->kernel == nullptr) {
        kernelNameStr = "none";
        kernelInfoExt = "none";
    } else {
        kernelNameStr = aicTaskInfo->kernel->Name_().empty() ? "none" : aicTaskInfo->kernel->Name_();
        kernelInfoExt = aicTaskInfo->kernel->KernelInfoExtString().empty() ? "none" :
            aicTaskInfo->kernel->KernelInfoExtString();
    }
    RT_LOG(RT_LOG_ERROR,
        "aicore task timeout dfx, show slot info, slot_id=%u, device_id=%u, stream_id=%u, task_id=%u, "
        "sche_mode=%u, blockd_dim=%u, aic_own_bitmap=%#" PRIx64 ", aiv_own_bitmap0=%#" PRIx64
        " aiv_own_bitmap1=%#" PRIx64 ", "
        "kernel_name=%s, kernel_info_ext=%s, pc_start=%#" PRIx64 ".",
        slotInfo.slotId,
        dev->Id_(),
        streamId,
        taskId,
        aicTaskInfo->schemMode,
        aicTaskInfo->comm.dim,
        slotInfo.aicOwnBitmap,
        slotInfo.aivOwnBitmap0,
        slotInfo.aivOwnBitmap1,
        kernelNameStr.c_str(),
        kernelInfoExt.c_str(),
        slotInfo.pcStart);
}

void DeviceErrorProc::ProcessStarsTimeoutDfxSlotInfo4FftsPlus(
    const StarsDeviceErrorInfo *const info, Device *dev, uint16_t slotIdx)
{
    if (info == nullptr || dev == nullptr) {
        RT_LOG(RT_LOG_WARNING, "info or device is null");
        return;
    }
    StarsOneTimeoutSlotDfxInfo slotInfo = info->u.coreTimeoutDfxInfo.slotInfo[slotIdx];
    const uint16_t streamId = slotInfo.streamId;
    const uint16_t taskId = slotInfo.taskId;

    TaskInfo *taskInfo = dev->GetTaskFactory()->GetTask(static_cast<int32_t>(streamId), taskId);
    if (taskInfo == nullptr) {
        RT_LOG(RT_LOG_ERROR, "task info is null, stream_id=%u, task_id=%u", streamId, taskId);
        return;
    }

    rtFftsPlusAicAivCtx_t contextInfo;
    const uint64_t offset = static_cast<uint64_t>(slotInfo.cxtId) * CONTEXT_LEN;
    FftsPlusTaskInfo *fftsPlusTaskInfo = &(taskInfo->u.fftsPlusTask);
    if (((offset + CONTEXT_LEN) > fftsPlusTaskInfo->descBufLen) || (fftsPlusTaskInfo->descAlignBuf == nullptr)) {
        RT_LOG(RT_LOG_ERROR,
            "fftsplus task timeout dfx print failed, dev_id=%u, stream_id=%d, "
            "task_id=%u, context_id=%u, descBufLen=%u, descAlignBuf=%u, descAlignBuf is invalid.",
            dev->Id_(),
            streamId,
            taskId,
            slotInfo.cxtId,
            fftsPlusTaskInfo->descBufLen,
            fftsPlusTaskInfo->descAlignBuf);
        return;
    }
    Driver *const devDrv = dev->Driver_();
    const rtError_t ret = devDrv->MemCopySync(&contextInfo,
        CONTEXT_LEN,
        static_cast<void *>((RtPtrToPtr<uint8_t *, void *>(fftsPlusTaskInfo->descAlignBuf)) + offset),
        CONTEXT_LEN,
        RT_MEMCPY_DEVICE_TO_HOST);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "MemCopySync failed, retCode=%#x.", ret);
        return;
    }

    std::vector<uint64_t> mapAddr;
    uint16_t schemMode = 0U;
    uint16_t blockdim = 0U;
    if ((contextInfo.contextType == RT_CTX_TYPE_AICORE) || (contextInfo.contextType == RT_CTX_TYPE_AIV)) {
        mapAddr.emplace_back(
            static_cast<uint64_t>(contextInfo.nonTailTaskStartPcH) << 32U | static_cast<uint64_t>(contextInfo.nonTailTaskStartPcL));
        mapAddr.emplace_back(static_cast<uint64_t>(contextInfo.tailTaskStartPcH) << 32U | contextInfo.tailTaskStartPcL);
        schemMode = contextInfo.schem;
        blockdim = contextInfo.tailBlockdim;
    } else if ((contextInfo.contextType == RT_CTX_TYPE_MIX_AIC) || (contextInfo.contextType == RT_CTX_TYPE_MIX_AIV)) {
        rtFftsPlusMixAicAivCtx_t *mixCtx = nullptr;
        mixCtx = RtPtrToPtr<rtFftsPlusMixAicAivCtx_t *, rtFftsPlusAicAivCtx_t *>(&contextInfo);
        mapAddr.emplace_back(
            static_cast<uint64_t>(mixCtx->nonTailAicTaskStartPcH) << 32U | static_cast<uint64_t>(mixCtx->nonTailAicTaskStartPcL));
        mapAddr.emplace_back(static_cast<uint64_t>(mixCtx->tailAicTaskStartPcH) << 32U | static_cast<uint64_t>(mixCtx->tailAicTaskStartPcL));
        mapAddr.emplace_back(
            static_cast<uint64_t>(mixCtx->nonTailAivTaskStartPcH) << 32U | mixCtx->nonTailAivTaskStartPcL);
        mapAddr.emplace_back(static_cast<uint64_t>(mixCtx->tailAivTaskStartPcH) << 32U | static_cast<uint64_t>(mixCtx->tailAivTaskStartPcL));
        schemMode = mixCtx->schem;
        blockdim = mixCtx->tailBlockdim;
    } else {
        // do nothing
    }

    std::string kernelName;
    for (uint32_t i = 0U; i < mapAddr.size(); i++) {
        RT_LOG(RT_LOG_DEBUG, "contextype=%hu, map[%u]=%#" PRIx64 ".", contextInfo.contextType, i, mapAddr[i]);
        if (mapAddr[i] == slotInfo.pcStart) {
            kernelName = dev->LookupKernelNameByAddr(mapAddr[i]);
            break;
        }
    }
    kernelName = (kernelName.empty()) ? "none" : kernelName;

    RT_LOG(RT_LOG_ERROR,
        "fftsplus aicore task timeout dfx, show slot info, slot_id=%u, device_id=%u, stream_id=%u, task_id=%u, "
        "sche_mode=%u, block_dim=%u, aic_own_bitmap=%#" PRIx64 ", aiv_own_bitmap0=%#" PRIx64
        ", aiv_own_bitmap1=%#" PRIx64 ", "
        "kernel_name=%s, pc_start=%#" PRIx64 ".",
        slotInfo.slotId,
        dev->Id_(),
        streamId,
        taskId,
        schemMode,
        blockdim,
        slotInfo.aicOwnBitmap,
        slotInfo.aivOwnBitmap0,
        slotInfo.aivOwnBitmap1,
        kernelName.c_str(),
        slotInfo.pcStart);
}

rtError_t DeviceErrorProc::ProcessStarsSqeErrorInfo(const StarsDeviceErrorInfo * const info,
                                                    const uint64_t errorNumber,
                                                    const Device * const dev, const DeviceErrorProc * const insPtr)
{
    UNUSED(insPtr);
    if (info == nullptr) {
        return RT_ERROR_NONE;
    }

    TaskInfo *errTaskPtr = GetTaskInfo(
        dev, static_cast<uint32_t>(info->u.sqeErrorInfo.streamId), static_cast<uint32_t>(info->u.sqeErrorInfo.taskId));
    if (errTaskPtr != nullptr) {
        errTaskPtr->isRingbufferGet = true;
    }

    RT_LOG_CALL_MSG(ERR_MODULE_SYSTEM, "The error from device(chipId:%u, dieId:%u), serial number is %" PRIu64 ", "
        "sqe error occurred during task execution, stream_id:%hu, %s:%hu, sq_id:%hu, sq_head:%hu.",
        info->u.sqeErrorInfo.chipId, info->u.sqeErrorInfo.dieId, errorNumber, info->u.sqeErrorInfo.streamId,
        TaskIdDesc(), info->u.sqeErrorInfo.taskId, info->u.sqeErrorInfo.sqId, info->u.sqeErrorInfo.sqHead);

    const uint32_t * const sqe = reinterpret_cast<const uint32_t *>(&(info->u.sqeErrorInfo.sqe));
    for (size_t i = 0UL; i < (sizeof(rtStarsSqe_t) / sizeof(uint32_t)); i++) {
        RT_LOG(RT_LOG_ERROR, "sqe[%zu]=0x%08x.", i, *(sqe + i));
    }

    return RT_ERROR_NONE;
}

void DeviceErrorProc::PrintTaskErrorInfo(const uint32_t errorType,
    const StarsDeviceErrorInfo * const errorInfo) const
{
    StreamTaskId sTaskId;
    GetStreamAndTaskIdFromErrorInfo(errorType, errorInfo, sTaskId);
    TaskInfo *errTaskPtr = device_->GetTaskFactory()->GetTask(static_cast<int32_t>(sTaskId.streamId),
        static_cast<uint16_t>(sTaskId.taskId));
    if (errTaskPtr != nullptr) {
        PrintErrorInfo(errTaskPtr, device_->Id_());
    }
}

rtError_t DeviceErrorProc::ProcessStarsOneElementInRingBuffer(const DevRingBufferCtlInfo * const ctlInfo,
    uint32_t head, const uint32_t tail, const bool isPrintTaskInfo, const TaskInfo * const taskPtr) const
{
    constexpr size_t headSize = sizeof(DevRingBufferCtlInfo);
    const size_t elementSize = (device_->IsStarsV2Platform()) ? \
        RINGBUFFER_EXT_ONE_ELEMENT_LENGTH_ON_STARSV2 : RINGBUFFER_EXT_ONE_ELEMENT_LENGTH;

    RT_LOG(RT_LOG_INFO, "it need to process %u errMessages, headSize=%zu, elementSize=%zu.",
        (tail + ctlInfo->ringBufferLen - head) % ctlInfo->ringBufferLen, headSize, elementSize);

    while (head != tail) {
        const uint8_t * const infoAddr = RtPtrToPtr<const uint8_t *, const DevRingBufferCtlInfo *>(ctlInfo) + headSize + (head * elementSize);
        const RingBufferElementInfo * const info = RtPtrToPtr<const RingBufferElementInfo *, const uint8_t *>(infoAddr);

        RT_LOG(RT_LOG_INFO, "head info %u, tail info=%u, type=%u.", head, tail,
            (taskPtr == nullptr ? 0xFFU : static_cast<uint32_t>(taskPtr->type)));

        head = (head + 1U) % (ctlInfo->ringBufferLen);

        if (info->errorType > static_cast<uint32_t>(ERROR_TYPE_BUTT)) {
            RT_LOG(RT_LOG_WARNING, "Failed to get error information from device, error type=%u.", info->errorType);
            continue;
        }

        const StarsDeviceErrorInfo * const errorInfo = RtPtrToPtr<const StarsDeviceErrorInfo *, const RingBufferElementInfo *>(info + 1);
        std::map<uint64_t, DeviceErrorProc::StarsErrorInfoProc> funcMap;
        UpdateDeviceErrorProcFunc(funcMap);
        const auto it = funcMap.find(info->errorType);
        if (isPrintTaskInfo) {
            PrintTaskErrorInfo(info->errorType, errorInfo);
        }

        if (it != funcMap.end()) {
            auto func = it->second;
            const rtError_t error = func(errorInfo, info->errorNumber, device_, this);
            if (error != RT_ERROR_NONE) {
                RT_LOG(RT_LOG_WARNING, "Failed to get error information from device.");
            }
        } else {
            RT_LOG(RT_LOG_WARNING, "Failed to find function to process the error information.");
        }
    }
    return RT_ERROR_NONE;
}

}  // namespace runtime
}  // namespace cce
