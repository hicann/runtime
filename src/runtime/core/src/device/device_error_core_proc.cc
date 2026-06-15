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

#include <array>
#include <map>
#include <utility>
#include "error_message_manage.hpp"
#include "runtime.hpp"
#include "stream.hpp"
#include "task.hpp"
#include "base.h"
#include "error_message_manage.hpp"
#include "task_submit.hpp"
#include "context.hpp"
#include "task_fail_callback_manager.hpp"
#include "stream_sqcq_manage.hpp"
#include "ctrl_stream.hpp"
#include "stub_task.hpp"
#include "context_manage.hpp"
#include "davinci_kernel_task.h"
#include "npu_driver.hpp"
namespace cce {
namespace runtime {
namespace {
constexpr uint32_t TS_SDMA_STATUS_DDRC_ERROR = 0x8U;
constexpr uint32_t TS_SDMA_STATUS_LINK_ERROR = 0x9U;
constexpr uint32_t TS_SDMA_STATUS_POISON_ERROR = 0xAU;
} // namespace

const std::map<uint32_t, std::string> g_aicOrSdmaOrHcclLocalMulBitEccEventIdBlkList = {
    {0x80CD8008U, "L2BUFF multi bit Err."},
    {0x80F2180DU, "HBMA/MATA Os Err."},
    {0x80F38008U, "HBMA Multi Bit Ecc."},
    {0x81338002U, "TS Dispatch Input Err."},
    {0x81338004U, "TS Dispatch Config Err."},
    {0x813B8002U, "AIC Dispatch Input Error."},
    {0x813B8004U, "AIC Dispatch Config Error."},
    {0x81478002U, "DVPP Dispatch Input Error."},
    {0x81478004U, "DVPP Dispatch Config Error."},
    {0x815F8002U, "PERI Dispatch Input Error."},
    {0x815F8004U, "PERI Dispatch Config Error."},
    {0x81978002U, "PCIE Dispatch Input Error."},
    {0x81978004U, "PCIE Dispatch Config Error."},
    {0x81B58002U, "UB Dispatch Input Error."},
    {0x81B58004U, "UB Dispatch Config Error."},
    {0x81AF8008U, "UB multiple bit ecc error."},
    {0x81B18008U, "UB PORT multiple bit ecc error."}
};

const std::map<uint32_t, std::string> g_hcclRemoteMulBitEccEventIdBlkList = {
    {0x80CD8008U, "L2BUFF multi bit Err."},
    {0x80F2180DU, "HBMA/MATA Os Err."},
    {0x80F38008U, "HBMA Multi Bit Ecc."},
    {0x81338002U, "TS Dispatch Input Err."},
    {0x81338004U, "TS Dispatch Config Err."},
    {0x813B8002U, "AIC Dispatch Input Error."},
    {0x813B8004U, "AIC Dispatch Config Error."},
    {0x81478002U, "DVPP Dispatch Input Error."},
    {0x81478004U, "DVPP Dispatch Config Error."},
    {0x815F8002U, "PERI Dispatch Input Error."},
    {0x815F8004U, "PERI Dispatch Config Error."},
    {0x81978002U, "PCIE Dispatch Input Error."},
    {0x81978004U, "PCIE Dispatch Config Error."},
    {0x81B58002U, "UB Dispatch Input Error."},
    {0x81B58004U, "UB Dispatch Config Error."},
    {0x81AF8000U, "UB Module error."},
    {0x81AF8004U, "UB software configuration error."},
    {0x81AF8008U, "UB Multi Bit Ecc."},
    {0x81B18008U, "UB_PORT Multi Bit Ecc."},
    {0x81B1800DU, "UB_PORT link error."}
};

const std::vector<EventRasFilter> g_ubNonMemPoisonRasList = {
    {0x81AF8009U, 0x03, 0x02, 0x10000000U, "poison."},
    {0x81AF8009U, 0x03, 0x03, 0x40000000U, "cpu seq data poison."},
    {0x81AF8009U, 0x03, 0x03, 0x20000000U, "dwqe data poison."},
    {0x81AF8009U, 0x03, 0x03, 0x04000000U, "P2P opertion poison."},
    {0x81AF8009U, 0x03, 0x03, 0x02000000U, "UB IO traffic atomic operation poison."},
    {0x81AF8009U, 0x03, 0x03, 0x01000000U, "UB IO traffic store operation poison."},
    {0x81AF8009U, 0x03, 0x03, 0x00020000U, "UB: RX DMA 2-bit ECC error in IO read returns poison."},
    {0x81AF8009U, 0x03, 0x03, 0x00008000U, "Read/atomic request address hitting DWQE space returns poison."},
    {0x81AF8009U, 0x03, 0x03, 0x00002000U, "Atomic write data poisoning / Atomic lookup table exception / Atomic timeout exception / Atomic packet header assembly exception returns poison."},
    {0x81AF8009U, 0x03, 0x03, 0x00000800U, "Read timeout exception / Read lookup table exception / Read packet header assembly exception returns poison."},
    {0x81AF8009U, 0x03, 0x03, 0x00000200U, "CCUA read operation returns poison."}
};

const std::vector<EventRasFilter> g_ubMemPoisonRasList = {
    {0x81AF8009U, 0x03, 0x03, 0x80000000, "UB MEM Atomic data Poison."},
    {0x81AF8009U, 0x03, 0x03, 0x08000000, "UB MEM traffic poison."},
    {0x81AF8009U, 0x03, 0x03, 0x00800000, "UB MEM read operation returned poison due to abnormal traffic."}
};

const std::vector<EventRasFilter> g_ubMemPoisonRasOnlyPosisonList = {
    {0x81AF8009U, 0x03, 0x02, 0x10000000, "poison."}
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

const std::map<uint32_t, std::string> g_mulBitEccEventIdBlkList = {
    {0x80CD8008U, "L2BUFF multi bit Err."},
    {0x80F2180DU, "HBMA/MATA Os Err."},
    {0x80F38008U, "HBMA Multi Bit Ecc."},
    {0x81338002U, "TS Dispatch Input Err."},
    {0x81338004U, "TS Dispatch Config Err."},
    {0x813B8002U, "AIC Dispatch Input Error."},
    {0x813B8004U, "AIC Dispatch Config Error."},
    {0x815F8002U, "PERI Dispatch Input Error."},
    {0x815F8004U, "PERI Dispatch Config Error."},
    {0x81978002U, "PCIE Dispatch Input Error."},
    {0x81978004U, "PCIE Dispatch Config Error."},
    {0x81B58002U, "UB Dispatch Input Error."},
    {0x81B58004U, "UB Dispatch Config Error."},
    {0x81AF8008U, "UB Multi Bit Ecc."},
    {0x81B18008U, "UB_PORT Multi Bit Ecc."}
};

const std::map<uint32_t, std::string> g_l2MulBitEccEventIdBlkList = {
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
    {0x813D8005U, "AIC AA Ring Parity Error."},
    {0x81AF8009U, "UB Posion Error."}
};

const std::map<uint32_t, std::string> g_ccuTimeoutEventIdBlkList = {
    {0x81B58002U, "UB Dispatch Input Error."},
    {0x81B58004U, "UB Dispatch Config Error."},
    {0x81AF8000U, "UB Module Excerption."},
    {0x81AF8004U, "UB Software Config Error."},
    {0x81AF8008U, "UB Multi Bit Ecc."},
    {0x81AF8009U, "UB Posion Error."},
    {0x81B18008U, "UB_PORT Multi Bit Ecc."},
    {0x81B1800DU, "UB_PORT Link Error."}
};  // This blacklist is used for both TA ack timeout and UBMEM timeout.

const EventRasFilter g_ubMemTrafficTimeoutFilter = {
    .eventId = UB_POISON_ERROR_EVENT_ID,
    .subModuleId = 0x03,
    .errorRegisterIndex = 0x03,
    .bitMask = 0x100000,
    .description = "UB MEM traffic timeout exception"
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
    {CCU_CALL_DEPTH_OVRFLW, "The depth of nested function call is greater than CTRL[5:2]."},
    {CCU_DIV0, "Division by zero error."},
    {CCU_ILLEGAL_INSTR, "Illegal instruction, which is usually caused by unaligned UUB addresses."},
    {CCU_LOOP_CNT_ERR, "The loop count of the hardware loop instruction is 0."
     " Possible cause: The compiler optimization is incorrect or the instruction is overwritten."},
    {CCU_LOOP_ERR, "The loopend instruction is executed before executing loop instruction."
     " Possible cause: The compiler optimization is incorrect or the instruction is overwritten."},
    {CCU_NEG_SQRT, "The number of roots is negative. "},
    {CCU_UB_ECC, "A multi-bit ECC error occures when CCU reads/writes UB. See the RAS alarm handling."},
    {CUBE_INVLD_INPUT, "The data of L0a and L0b read back is the INF or NAN data."},
    {CUBE_L0A_ECC, "A multi-bit ECC error occures when CCU reads/writes L0A. See the RAS alarm handling."},
    {CUBE_L0A_RDWR_CFLT, "L0A read/write conflict."},
    {CUBE_L0A_WRAP_AROUND, "The operation address of L0A exceeds the maximum range of L0A."},
    {CUBE_L0B_ECC, "A multi-bit ECC error occures when CUBE reads/writes L0B. See the RAS alarm handling."},
    {CUBE_L0B_RDWR_CFLT, "L0B read/write conflict."},
    {CUBE_L0B_WRAP_AROUND, "The operation address of L0B exceeds the maximum range of L0B."},
    {CUBE_L0C_ECC, "A multi-bit ECC error occures when CUBE reads/writes L0C. See the RAS alarm handling"},
    {CUBE_L0C_RDWR_CFLT, "L0C read/write conflict(vec read operation or cube write operation)."},
    {CUBE_L0C_SELF_RDWR_CFLT, "The address for VEC to read L0C confilicts with that for CUBE to write L0C."},
    {CUBE_L0C_WRAP_AROUND, "The operation address of L0C exceeds the maximum range of L0C."},
    {IFU_BUS_ERR, "The address of instruction is illegal when the AIcore reads instructions from GM."
     "Possible cause: The application unloads the operator binary in advance or stack corruption occurs."},
    {MTE_AIPP_ILLEGAL_PARAM, "The configuration of AIPP is incorrect."},
    {MTE_BAS_RADDR_OBOUND, "The base address of the mte load3d instruction is out of bounds."},
    {MTE_BIU_RDWR_RESP, "MTE accesses an invalid GM address or the cross-device memory access times out."},
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
    {MTE_GDMA_READ_OVERFLOW, "The address for the MTE instruction to read on-chip buffer is out of bounds."},
    {MTE_GDMA_WRITE_OVERFLOW, "The address for the MTE instruction to write on-chip buffer is out of bounds."},
    {MTE_COMP, "A new index table is delivered before the current index is completed."},
    {MTE_ILLEGAL_FM_SIZE, "The feature map size of the mte load3d instruction is illegal(size = 0)."},
    {MTE_ILLEGAL_L1_3D_SIZE, "The set l1 3D size of the mte load3d instruction is illegal."},
    {MTE_ILLEGAL_STRIDE, "The stride size of the mte load3d instruction is illegal."},
    {MTE_L0A_RDWR_CFLT, "L0A read/write conflict in the MTE (same address)."},
    {MTE_L0B_RDWR_CFLT, "L0B read/write conflict in the MTE (same address)."},
    {MTE_L1_ECC, "A multi-bit ECC error occurs when MTE reads/writes L1. See the RAS alarm handling."},
    {MTE_PADDING_CFG, "The error in mte load3d padding configuration."},
    {MTE_READ_OVERFLOW, "The read address of the mte load2d instruction is greater than the maximum address of the source (L1)."},
    {MTE_ROB_ECC, "A multi-bit ECC error occurs when MTE reads/writes the internal buffer. See the RAS alarm handling."},
    {MTE_TLU_ECC, "An error occurred during the ECC check of the MTE TLU."},
    {MTE_UB_ECC, "A multi-bit ECC error occurs when MTE reads/writes UB. See the RAS alarm handling."},
    {MTE_UNZIP, "Decompression exception: length check or parity check or empty FIFO read or full FIFO write."},
    {MTE_WRITE_3D_OVERFLOW, "The write address of the mte load3d instruction is out of bounds."},
    {MTE_WRITE_OVERFLOW, "The write address of the mte load2d instruction is greater than the maximum destination address."},
    {VEC_DATA_EXCP_CCU, "Data from the CCU is abnormal."},
    {VEC_DATA_EXCP_MTE, "Data from the MTE is abnormal."},
    {VEC_DATA_EXCP_VEC, "Data from the VEC is abnormal."},
    {VEC_DIV0, "VEC instruction error: reciprocal division by 0 error."},
    {VEC_ILLEGAL_MASK, "VEC instruction error: the MASK instruction is all 0."},
    {VEC_INF_NAN, "VEC instruction error: the data is inf or nan."},
    {VEC_L0C_ECC, "A multi-bit ECC error occurs when VEC reads L0C. See the RAS alarm handling."},
    {VEC_L0C_RDWR_CFLT, "VEC reads/writes L0C and cube reads/writes L0C addresses are the same."},
    {VEC_NEG_LN, "VEC instruction error: the value of ln is a negative number."},
    {VEC_NEG_SQRT, "VEC instruction error: the reciprocal of the square root is a negative number."},
    {VEC_SAME_BLK_ADDR, "VEC instruction error: the destination blocks have the same address."},
    {VEC_UB_ECC, "A multi-bit ECC error occurs when VEC reads UB. See the RAS alarm handling."},
    {VEC_UB_SELF_RDWR_CFLT, "The address for VEC to read UB confilicts that for VEC to write UB."},
    {VEC_UB_WRAP_AROUND, "The address for the VEC instruction to read/write UB is out of bounds."},
    {BIU_DFX_ERR, "BIU error, which need to be further read from BIU_STATUS1 bit 15:11."},
    {CCU_SBUF_ECC, "ECC is reported in the CCU Scalar buffer."},
    {VEC_COL2IMG_RD_FM_ADDR_OVFLOW, "The value of col2img is invalid."},
    {VEC_COL2IMG_RD_DFM_ADDR_OVFFLOW, "The value of col2img is invalid."},
    {VEC_COL2IMG_ILLEGAL_FM_SIZE, "The value of col2img is invalid."},
    {VEC_COL2IMG_ILLEGAL_STRIDE, "The value of col2img is invalid."},
    {VEC_COL2IMG_ILLEGAL_1ST_WIN_POS, "The value of col2img is invalid."},
    {VEC_COL2IMG_ILLEGAL_FETCH_POS, "The value of col2img is invalid."},
    {VEC_COL2IMG_ILLEGAL_K_SIZE, "The value of col2img is invalid."},
    {CCU_INF_NAN, "The input of the floating-point instruction run by the CCU is nan/inf."},
    {MTE_ILLEGAL_SCHN_CFG,
     "The small_channal enable flag is valid but does not meet the conditions for small_channal."},
    {MTE_ATM_ADDR_MISALG, "The address of the MTE atomic instruction is not aligned with the data type bit width."},
    {VEC_INSTR_ADDR_MISALIGN, "The UB address accessed by the VEC instruction is not aligned."},
    {VEC_INSTR_ILLEGAL_CFG, "The VEC instruction parameter is invalid."},
    {VEC_INSTR_UNDEF, "The VEC instruction is abnormal. "
     "Possible cause: The parameter violates the instruction constraints, the binary version does not match, or the instruction is overwritten."},
    {CCU_ADDR_ERR, "The GM address accessed by scalar exceeds 48 bits."},
    {CCU_BUS_ERR,
     "The scalar instruction accesses an invalid GM address or the cross-device memory access times out."},
    {MTE_ERR_ADDR_MISALIGN, "The access address of the MTE instruction is not aligned with the data type bit width."},
    {MTE_ERR_DW_PAD_CONF_ERR, "DEPTHWIS PADDING is incorrectly configured."},
    {MTE_ERR_DW_FMAP_H_ILLEGAL, "The value of H configured on the DEPTHWISE FMAP is less than 3."},
    {MTE_ERR_WINO_L0B_WRITE_OVERFLOW, "L0B address overflow occurs when the WINOB writes to the L0B address."},
    {MTE_ERR_WINO_L0B_READ_OVERFLOW, "The L1 address read by WINOB overflows, and the loop occurs."},
    {MTE_ERR_ILLEGAL_V_COV_PAD_CTL, "The value of WINOA V padding is invalid."},
    {MTE_ERR_ILLEGAL_H_COV_PAD_CTL, "The value of WINOA H padding is invalid."},
    {MTE_ERR_ILLEGAL_W_SIZE, "The value of WINOA fmap W is invalid."},
    {MTE_ERR_ILLEGAL_H_SIZE, "The value of WINOA fmap H is invalid."},
    {MTE_ERR_ILLEGAL_CHN_SIZE, "The LOAD3DV2 channel size is invalid."},
    {MTE_ERR_ILLEGAL_K_M_EXT_STEP, "The LOAD3DV2 K_M_EXT_STEP is invalid."},
    {MTE_ERR_ILLEGAL_K_M_START_POS, "The LOAD3DV2 K_M_START_POS is invalid."},
    {MTE_ERR_ILLEGAL_SMALLK_CFG, "The small K configuration of the MTE load3d instruction is incorrect."},
    {MTE_ERR_READ_3D_OVERFLOW, "The address for the LOAD3D to read L1 is out of bounds."},
    {CCU_VECIQ_ECC, "A multi-bit ECC error occurs when VEC instructions issue. See the RAS alarm handling."},
    {CCU_DC_DATA_ECC, "A multi-bit ECC error occurs when scalar accesses the dcache data. See the RAS alarm handling."},
    {CCU_DC_TAG_ECC, "A multi-bit ECC error occurs when scalar accesses the dcache tag. See the RAS alarm handling."},
    {CCU_DIV0_FP, "A error occurs in the FP32 DIV0."},
    {CCU_NEG_SQRT_FP, "The input of the FP SQRT calculation unit is a negative number."},
    {CNT_SW_BUS_ERR,
     "During the slow context switch, the SC transfers data through the AXI bus, and the AXI returns an error."},
    {FIXP_ERR_INSTR_ADDR_MISAL, "The address for FIXP to read L0C/L1 and write FIXP buffer is not aligned."},
    {FIXP_ERR_ILLEGAL_CFG, "The parameter of the FIXP instruction is invalid."},
    {FIXP_ERR_READ_L0C_OVFLW, "The address for FIXP to read L0C is out of bounds."},
    {FIXP_ERR_READ_L1_OVFLW, "The address for FIXP to read L1 is out of bounds."},
    {FIXP_ERR_READ_UB_OVFLW, "The address for FIXP to read UB is out of bounds."},
    {FIXP_ERR_WRITE_L1_OVFLW, "The address for FIXP to write L1 is out of bounds."},
    {FIXP_ERR_WRITE_UB_OVFLW, "The address for FIXP to write UB is out of bounds."},
    {FIXP_ERR_FBUF_WRITE_OVFLW, "The address for FIXP to write FIXP buffer is out of bounds."},
    {FIXP_ERR_FBUF_READ_OVFLW, "The address for FIXP to read FIXP buffer is out of bounds."},
    {SC_REG_PARITY_ERR, "During safety check, parity errors occur in the registers in the nManager."},
    {MTE_ERR_FIFO_PARITY, "A parity error occurs when MTE reads FIFO. See the RAS alarm handling."},
    {MTE_ERR_WAITSET, "The configuration of HWATI/HSET is incorrect."},
    {CCU_ERR_PARITY_ERR, "A parity error occurs in the SU internal buffer during the safety feature."},
    {MTE_ERR_CACHE_ECC, "The MTE internal MVF cache fails."},
    {CUBE_ERR_HSET_CNT_UNF, "A underflow error occurs in the CUBE HSET counter."},
    {CUBE_ERR_HSET_CNT_OVF, "A overflow error occurs in the CUBE HSET counter."},
    {MTE_ERR_INSTR_ILLEGAL_CFG, "The MTE instruction parameter is invalid."},
    {MTE_ERR_HEBCD, "The instruction configuration of HEBCD is invalid."},
    {MTE_ERR_HEBCE, "The instruction configuration of HEBCE is invalid."},
    {MTE_ERR_WAIPP, "The instruction configuration of WAIPP is invalid."},
    {CCU_SEQ_ERR, "The SEQ command sequence is incorrect."},
    {CCU_MPU_ERR, "The address for the scalar to access the internal buffer of AICore is out of bounds."},
    {CCU_LSU_ERR, "When the buffer is enabled, the stack access instruction cache is missed."},
    {CCU_PB_ECC_ERR, "A multi-bit ECC error occurs when scalar read parameter buffer. See the RAS alarm handling."},
    {MTE_UB_WR_OVFLW, "The address for MTE to write UB is out of bounds."},
    {MTE_UB_RD_OVFLW, "The address for MTE to read UB is out of bounds."},
    {CUBE_ILLEGAL_INSTR, "The CUBE instruction parameter is invalid."},
    {CCU_SAFETY_CRC_ERR, "MTE CRC error."},
    {MTE_TIMEOUT, "An exception is reported when the MTE instruction or data times out."},
    {MTE_UB_RD_CFLT,
     "When the MTE reads the ub, the ub read/write conflict occurs and an exception is reported."},
    {MTE_UB_WR_CFLT, "When the MTE writes to the UB, the UB read/write conflict is reported."},
    {MTE_KTABLE_WR_ADDR_OVERFLOW,
     "An exception is reported when a write address conflict occurs when the MTE is full."},
    {MTE_KTABLE_RD_ADDR_OVERFLOW,
     "An exception is reported when a read address conflict occurs when the MTE is empty."},
    {CCU_UB_RD_CFLT, "When the CCU reads the UB, the UB read and write conflict is reported."},
    {CCU_UB_WR_CFLT, "When the CCU writes data to the UB, the UB read and write conflict occurs."},
    {CCU_UB_OVERFLOW_ERR, "The address for scalar to read/write UB is out of bounds."},
    {BIU_UNSPLIT_ERR, "An exception occurs on the BIU, for example, tag_id error or FIFO overflow."},
    {MTE_STB_ECC_ERR, "A multi-bit ECC error occurs when MTE read STB buffer. See the RAS alarm handling."},
    {MTE_AIPP_ECC_ERR, "A multi-bit ECC error occurs when MTE read the internal buffer of AIPP. See the RAS alarm handling."},
    {CCU_LSU_ATOMIC_ERR, "The scalar atomic instruction accesses the GM that is modified by scalar but is not written back."},
    {CCU_CROSS_CORE_SET_OVFL_ERR,
     "The value of the flag counter for inter-core communication exceeds the maximum value 15."},
    {FIXP_ERR_OUT_WRITE_OVERFLOW, "The GM address accessed by FIXP exceeds 48 bits."},
    {CUBE_ERR_PBUF_WRAP_AROUND, "The address for CUBE to read FIXP buffer is out of bounds."},
    {FIXP_L0C_ECC, "A multi-bit ECC error occurs when FIXP read L0C. See the RAS alarm handling."},
    {MTE_ERR_L0C_RDWR_CFLT, "The address for FIXP to read L0C confilicts with that for CUBE to write L0C."},
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

void DeviceErrorProc::PrintCoreErrorInfo(const DeviceErrorInfo *const coreInfo,
                                         const uint64_t errorNumber,
                                         const std::string &coreType,
                                         const uint64_t coreIdx,
                                         const Device *const dev,
                                         const std::string &errorStr)
{
    /* logs for aic tools, do not modify the item befor making a new agreement with tools */
    RT_LOG_CALL_MSG(ERR_MODULE_TBE,
           "The error from device(%hu), serial number is %" PRIu64 ", "
           "there is an error of %s, core id is %" PRIu64 ", "
           "error code = %#" PRIx64 ", dump info: "
           "pc start: %#" PRIx64 ", current: %#" PRIx64 ", "
           "vec error info: %#" PRIx64 ", mte error info: %#" PRIx64 ", "
           "ifu error info: %#" PRIx64 ", ccu error info: %#" PRIx64 ", "
           "cube error info: %#" PRIx64 ", biu error info: %#" PRIx64 ", "
           "aic error mask: %#" PRIx64 ", para base: %#" PRIx64 ", errorStr: %s",
           coreInfo->u.coreErrorInfo.deviceId, errorNumber,
           coreType.c_str(), coreInfo->u.coreErrorInfo.info[coreIdx].coreId,
           coreInfo->u.coreErrorInfo.info[coreIdx].aicError,
           coreInfo->u.coreErrorInfo.info[coreIdx].pcStart, coreInfo->u.coreErrorInfo.info[coreIdx].currentPC,
           coreInfo->u.coreErrorInfo.info[coreIdx].vecErrInfo, coreInfo->u.coreErrorInfo.info[coreIdx].mteErrInfo,
           coreInfo->u.coreErrorInfo.info[coreIdx].ifuErrInfo, coreInfo->u.coreErrorInfo.info[coreIdx].ccuErrInfo,
           coreInfo->u.coreErrorInfo.info[coreIdx].cubeErrInfo, coreInfo->u.coreErrorInfo.info[coreIdx].biuErrInfo,
           coreInfo->u.coreErrorInfo.info[coreIdx].aicErrorMask, coreInfo->u.coreErrorInfo.info[coreIdx].paraBase,
           errorStr.c_str());
    if ((dev != nullptr) && (coreInfo->u.coreErrorInfo.type == static_cast<uint16_t>(AICORE_ERROR)) &&
        (dev->GetTschVersion() >= static_cast<uint32_t>(TS_VERSION_AIC_ERR_REG_EXT))) {
        RT_LOG_CALL_MSG(ERR_MODULE_TBE,
            "The extend info from device(%hu), serial number is %" PRIu64 ", there is %s error, core id is %" PRIu64
            ", aicore int: %#" PRIx64 ", aicore error2: %#" PRIx64 ", axi clamp ctrl: %#" PRIx64
            ", axi clamp state: %#" PRIx64
            ", biu status0: %#" PRIx64 ", biu status1: %#" PRIx64
            ", clk gate mask: %#" PRIx64 ", dbg addr: %#" PRIx64
            ", ecc en: %#" PRIx64 ", mte ccu ecc 1bit error: %#" PRIx64
            ", vector cube ecc 1bit error: %#" PRIx64 ", run stall: %#" PRIx64
            ", dbg data0: %#" PRIx64 ", dbg data1: %#" PRIx64
            ", dbg data2: %#" PRIx64 ", dbg data3: %#" PRIx64 ", dfx data: %#" PRIx64,
            coreInfo->u.coreErrorInfo.deviceId, errorNumber,
            coreType.c_str(), coreInfo->u.coreErrorInfo.extend_info[coreIdx].coreId,
            coreInfo->u.coreErrorInfo.extend_info[coreIdx].aiCoreInt,
            coreInfo->u.coreErrorInfo.extend_info[coreIdx].aicError2,
            coreInfo->u.coreErrorInfo.extend_info[coreIdx].axiClampCtrl,
            coreInfo->u.coreErrorInfo.extend_info[coreIdx].axiClampState,
            coreInfo->u.coreErrorInfo.extend_info[coreIdx].biuStatus0,
            coreInfo->u.coreErrorInfo.extend_info[coreIdx].biuStatus1,
            coreInfo->u.coreErrorInfo.extend_info[coreIdx].clkGateMask,
            coreInfo->u.coreErrorInfo.extend_info[coreIdx].dbgAddr,
            coreInfo->u.coreErrorInfo.extend_info[coreIdx].eccEn,
            coreInfo->u.coreErrorInfo.extend_info[coreIdx].mteCcuEcc1bitErr,
            coreInfo->u.coreErrorInfo.extend_info[coreIdx].vecCubeEcc1bitErr,
            coreInfo->u.coreErrorInfo.extend_info[coreIdx].runStall,
            coreInfo->u.coreErrorInfo.extend_info[coreIdx].dbgData0,
            coreInfo->u.coreErrorInfo.extend_info[coreIdx].dbgData1,
            coreInfo->u.coreErrorInfo.extend_info[coreIdx].dbgData2,
            coreInfo->u.coreErrorInfo.extend_info[coreIdx].dbgData3,
            coreInfo->u.coreErrorInfo.extend_info[coreIdx].dfxData);
    }
}

void DeviceErrorProc::PrintCoreInfoErrMsg(const DeviceErrorInfo *const coreInfo)
{
    std::string errLevel(RT_TBE_INNER_ERROR);
    const auto it = errMsgCommMap_.find(coreInfo->u.coreErrorInfo.type);
    if (unlikely(it != errMsgCommMap_.end())) {
        errLevel = it->second;
    }
    std::array<char_t, MSG_LENGTH> buffer {};

    std::string errorCode;
    if (coreInfo->u.coreErrorInfo.coreNum == 0U) {
        errorCode = "none";
    } else {
        errorCode = std::string("0-") + std::to_string(coreInfo->u.coreErrorInfo.coreNum - 1U);
    }

    (void)snprintf_truncated_s(&(buffer[0]), static_cast<size_t>(MSG_LENGTH),
        "The device(%u), core list[%s], error code is:", static_cast<uint32_t>(coreInfo->u.coreErrorInfo.deviceId),
        errorCode.c_str());
    uint16_t coreIdx;
    int32_t countTotal = 0;
    int32_t cnt = 0;
    for (coreIdx = 0U; coreIdx < coreInfo->u.coreErrorInfo.coreNum; ++coreIdx) {
        if ((static_cast<int32_t>(coreIdx) % 4) == 0) {   // 4 表示每4个core一组
            REPORT_INNER_ERROR(errLevel.c_str(), "%s", &(buffer[0]));
            countTotal = sprintf_s(&(buffer[0]), static_cast<size_t>(MSG_LENGTH), "coreId(%2lu):",
                static_cast<uint64_t>(coreIdx));
            COND_RETURN_VOID_AND_MSG_INNER(countTotal < 0, "Failed to call sprintf_s, count=%d.", countTotal);
        }
        if ((countTotal >= MSG_LENGTH) || (coreIdx >= MAX_RECORD_CORE_NUM)) {
            break;
        }
        cnt = sprintf_s(&(buffer[countTotal]), static_cast<size_t>(MSG_LENGTH) - static_cast<size_t>(countTotal),
                        "%#16" PRIx64 "    ", coreInfo->u.coreErrorInfo.info[coreIdx].aicError);
        COND_RETURN_VOID_AND_MSG_INNER(cnt < 0, "Failed to call sprintf_s, count=%d.", cnt);
        countTotal += cnt;
    }
    if (static_cast<int32_t>(coreIdx) > 0) {   // 4 表示每4个core一组, 最后只要cordIdx > 0, 总是会有最后一组没打印
        REPORT_INNER_ERROR(errLevel.c_str(), "%s", &(buffer[0]));
    }
}

rtError_t DeviceErrorProc::ProcessCoreErrorInfo(const DeviceErrorInfo * const coreInfo,
                                                const uint64_t errorNumber,
                                                const Device *const dev)
{
    std::string coreType;
    uint32_t offset = 0U;
    if (coreInfo->u.coreErrorInfo.type == static_cast<uint16_t>(AICORE_ERROR)) {
        coreType = "aicore";
    } else if (coreInfo->u.coreErrorInfo.type == static_cast<uint16_t>(AIVECTOR_ERROR)) {
        coreType = "aivec";
        offset = MAX_AIC_ID;
    } else {
        return RT_ERROR_NONE;
    }

    uint16_t coreIdx;
    const uint16_t coreNum = coreInfo->u.coreErrorInfo.coreNum;
    const uint32_t deviceId = coreInfo->u.coreErrorInfo.deviceId;
    for (coreIdx = 0U; (coreIdx < coreNum) && (static_cast<uint32_t>(coreIdx) < MAX_RECORD_CORE_NUM); ++coreIdx) {
        uint32_t devCoreId = coreInfo->u.coreErrorInfo.info[coreIdx].coreId + offset;
        if ((devCoreId < MAX_AIC_ID + MAX_AIV_ID) && (deviceId < MAX_DEV_ID)) {
            error_pc[deviceId].last_error_pc[devCoreId] = coreInfo->u.coreErrorInfo.info[coreIdx].pcStart;
        }
        std::string errorString;
        uint64_t err = coreInfo->u.coreErrorInfo.info[coreIdx].aicError;
        if (err == 0ULL) {
            errorString = "timeout or trap error.";
            PrintCoreErrorInfo(coreInfo, errorNumber, coreType, static_cast<uint64_t>(coreIdx), dev, errorString);
            continue;
        }
        for (uint64_t i = BitScan(err); i < static_cast<uint64_t>(MAX_BIT_LEN); i = BitScan(err)) {
            BITMAP_CLR(err, i);
            const auto it = errorMapInfo_.find(i);
            if (it == errorMapInfo_.end()) {
                continue;
            }
            // if the string is too long, the log will truncate to 1024.
            // so the error string only show 400.
            if (unlikely((it->second.size() + errorString.size()) > 400UL)) {
                RT_LOG(RT_LOG_WARNING, "The error info is too long.");
                break;
            }
            errorString += it->second;
        }
        PrintCoreErrorInfo(coreInfo, errorNumber, coreType, static_cast<uint64_t>(coreIdx), dev, errorString);
    }

    if ((dev != nullptr) && (coreInfo->u.coreErrorInfo.type == static_cast<uint16_t>(AICORE_ERROR))
        && (dev->GetTschVersion() >= static_cast<uint32_t>(TS_VERSION_AIC_ERR_DHA_INFO))) {
        const uint16_t dhaNum = coreInfo->u.coreErrorInfo.dhaNum;
        RT_LOG(RT_LOG_DEBUG, "dha num:%hu", dhaNum);
        for (uint16_t dhaIndex = 0U; (dhaIndex < dhaNum) && (dhaIndex < MAX_RECORD_DHA_NUM); ++dhaIndex) {
            RT_LOG_CALL_MSG(ERR_MODULE_TBE,
                "The dha(mata) info comes from device(%hu), the dha id is %u, dha status 1 info: 0x%x.",
                coreInfo->u.coreErrorInfo.deviceId, coreInfo->u.coreErrorInfo.dhaInfo[dhaIndex].regId,
                coreInfo->u.coreErrorInfo.dhaInfo[dhaIndex].status1);
        }
    }
    PrintCoreInfoErrMsg(coreInfo);

    return RT_ERROR_NONE;
}

const std::string GetStarsRingBufferHeadMsg(const uint16_t errType)
{
    static const std::map<uint64_t, std::string> starsRingBufferHeadMsgMap = {
        {AICORE_ERROR, "aicore error"},
        {AIVECTOR_ERROR, "aivec error"},
        {FFTS_PLUS_AICORE_ERROR, "fftsplus aicore error"},
        {FFTS_PLUS_AIVECTOR_ERROR, "fftsplus aivector error"},
        {FFTS_PLUS_SDMA_ERROR, "fftsplus sdma error"},
        {FFTS_PLUS_AICPU_ERROR, "fftsplus aicpu error"},
        {FFTS_PLUS_DSA_ERROR, "fftsplus dsa error"},
        {HCCL_FFTSPLUS_TIMEOUT_ERROR, "hccl fftsplus timeout"},
    };
    const auto it = starsRingBufferHeadMsgMap.find(errType);
    if (it != starsRingBufferHeadMsgMap.end()) {
        return it->second;
    } else {
        return "undefine errType";
    }
}

bool HasMteErr(const Device * const dev)
{
    bool hasMteErr = dev->GetDeviceRas();
    uint32_t count = 0;
    while ((!hasMteErr) && (count < GetMteErrWaitCount()) && (!Runtime::Instance()->IsSupportOpTimeoutMs())) {
        std::this_thread::sleep_for(std::chrono::milliseconds(RAS_QUERY_INTERVAL));
        hasMteErr = dev->GetDeviceRas();
        count++;
    }
    return hasMteErr;
}

// 封装 SMMU 故障检查逻辑
static bool CheckSmmuFault(const uint32_t deviceId)
{
    bool isSmmuFault = false;
    const rtError_t error = NpuDriver::GetSmmuFaultValid(deviceId, isSmmuFault);
    if (error == RT_ERROR_FEATURE_NOT_SUPPORT) {
        RT_LOG(RT_LOG_EVENT, "Getting fault SMMU valid status is not supported");
        return false;
    } else if (error == RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Get isSmmuFault is %d.", isSmmuFault);
        return isSmmuFault;
    } else {
        RT_LOG(RT_LOG_EVENT, "Get NpuDriver::GetSmmuFaultValid ret %d.", error);
    }
    return false;
}

bool IsSmmuFault(const uint32_t deviceId)
{
    bool isSmmuFault = false;
    const rtError_t error = NpuDriver::GetSmmuFaultValid(deviceId, isSmmuFault);
    COND_RETURN_WARN(error == RT_ERROR_FEATURE_NOT_SUPPORT, false,
        "Getting fault SMMU valid status is not supported");
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Cannot get smmu of device_id=%u, error=%d", deviceId, error);
        return false;
    }
    return isSmmuFault;
}

bool IsHitBlacklist(const uint32_t deviceId, const std::map<uint32_t, std::string>& eventIdBlkList)
{
    constexpr uint32_t maxFaultNum = 128U;
    std::vector<rtDmsFaultEvent> faultEventInfo(maxFaultNum);

    constexpr size_t totalSize = maxFaultNum * sizeof(rtDmsFaultEvent);
    const auto eRet = memset_s(&faultEventInfo[0U], totalSize, 0, totalSize);
    COND_RETURN_WARN(eRet != EOK, false, "Mem set error, ret=%d", eRet);

    uint32_t eventCount = 0U;
    rtError_t error = GetDeviceFaultEvents(deviceId, &faultEventInfo[0U], eventCount, maxFaultNum);
    COND_PROC((error != RT_ERROR_NONE), return false);
    for (uint32_t faultIndex = 0U; faultIndex < eventCount; faultIndex++) {
        if (eventIdBlkList.find(faultEventInfo[faultIndex].eventId) != eventIdBlkList.end()) {
            std::ostringstream oss;
            std::string faultInfo;
            oss << std::hex << faultEventInfo[faultIndex].eventId;
            faultInfo = faultInfo + "[0x" + oss.str() + "]" + faultEventInfo[faultIndex].eventName;
            RT_LOG(RT_LOG_INFO, "Fault message is: [%s].", faultInfo.c_str());
            return true;
        }
    }
    return false;
}

bool HasBlacklistEventOnDevice(const uint32_t deviceId, const std::map<uint32_t, std::string>& eventIdBlkList)
{
    constexpr uint32_t maxFaultNum = 128U;
    rtDmsFaultEvent *faultEventInfo = new (std::nothrow)rtDmsFaultEvent[maxFaultNum];
    COND_RETURN_AND_MSG_OUTER(faultEventInfo == nullptr, false, ErrorCode::EE1013,
        maxFaultNum * sizeof(rtDmsFaultEvent));
    constexpr size_t totalSize = maxFaultNum * sizeof(rtDmsFaultEvent);
    (void)memset_s(faultEventInfo, totalSize, 0, totalSize);

    const std::function<void()> releaseFunc = [&faultEventInfo]() { DELETE_A(faultEventInfo); };
    ScopeGuard faultEventInfoRelease(releaseFunc);
    uint32_t eventCount = 0U;
    rtError_t error = GetDeviceFaultEvents(deviceId, faultEventInfo, eventCount, maxFaultNum);
    if (error != RT_ERROR_NONE) {
        return false;
    }
    return IsHitBlacklist(faultEventInfo, eventCount, eventIdBlkList);
}

/* 检查是否存在黑名单中的UCE错误 */
bool HasMemUceErr(const uint32_t deviceId, const std::map<uint32_t, std::string>& eventIdBlkList)
{
    Context *curCtx = Runtime::Instance()->CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, false);
    NULL_PTR_RETURN(curCtx->Device_(), false);
    if (curCtx->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_ALLOC_FROM_STREAM_POOL)) {
        return HasBlacklistEventOnDevice(deviceId, eventIdBlkList);
    }
    return HasBlacklistEventOnDevice(deviceId, eventIdBlkList) || CheckSmmuFault(deviceId);
}

bool IsHitBlacklist(const rtDmsFaultEvent *faultEventInfo, const uint32_t eventCount, const std::map<uint32_t, std::string>& eventIdBlkList)
{
    if (faultEventInfo == nullptr) {
        RT_LOG(RT_LOG_ERROR, "faultEventInfo is nullptr.");
        return false;
    }
    std::string faultInfo;
    for (uint32_t faultIndex = 0U; faultIndex < eventCount; faultIndex++) {
        if (eventIdBlkList.find(faultEventInfo[faultIndex].eventId) != eventIdBlkList.end()) {
            std::ostringstream oss;
            oss << std::hex << faultEventInfo[faultIndex].eventId;
            faultInfo = faultInfo + "[0x" + oss.str() + "]" + faultEventInfo[faultIndex].eventName;
            RT_LOG(RT_LOG_INFO, "Fault message is: [%s].", faultInfo.c_str());
            return true;
        }
    }
    return false;
}

bool IsFaultEventOccur(const uint32_t faultEventId, const rtDmsFaultEvent * const faultEventInfo, const uint32_t eventCount)
{
    if (faultEventInfo == nullptr) {
        RT_LOG(RT_LOG_ERROR, "faultEventInfo is nullptr.");
        return false;
    }
    for (uint32_t faultIndex = 0; faultIndex < eventCount; faultIndex++) {
        if (faultEventInfo[faultIndex].eventId == faultEventId) {
            return true;
        }
    }
    return false;
}

rtError_t GetDeviceFaultEvents(const uint32_t deviceId, rtDmsFaultEvent* const faultEventInfo,
    uint32_t &eventCount, const uint32_t maxFaultNum)
{
    rtError_t error = RT_ERROR_NONE;
    error = NpuDriver::GetAllFaultEvent(deviceId, faultEventInfo, maxFaultNum, &eventCount);
    COND_RETURN_WARN(error == RT_ERROR_FEATURE_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
        "Getting fault events is not supported.");
    COND_RETURN_ERROR((error != RT_ERROR_NONE) || (eventCount > maxFaultNum), (error == RT_ERROR_NONE) ? RT_ERROR_DRV_ERR : error,
        "Get fault event error, device_id=%u, eventCount=%u, maxFaultNum=%u, error=%#x.", deviceId,
            eventCount, maxFaultNum, static_cast<uint32_t>(error));
    return error;
}

void ProcessSdmaError(TaskInfo *taskInfo)
{
    Stream * const stream = taskInfo->stream;
    NULL_PTR_RETURN_DIRECTLY(stream);
    Device * const dev = stream->Device_();
    NULL_PTR_RETURN_DIRECTLY(dev);
    if (HasMteErr(stream->Device_())) {
        taskInfo->errorCode = TS_ERROR_SDMA_POISON_ERROR;
        (RtPtrToUnConstPtr<Device *>(dev))->SetDeviceFaultType(DeviceFaultType::HBM_UCE_ERROR);
    } else if (!HasMemUceErr(stream->Device_()->Id_())) {
        taskInfo->errorCode = TS_ERROR_SDMA_LINK_ERROR;
        (RtPtrToUnConstPtr<Device *>(dev))->SetDeviceFaultType(DeviceFaultType::LINK_ERROR);
    } else {
        taskInfo->errorCode = TS_ERROR_SDMA_ERROR;
    }
}

static void SetDeviceFaultTypeByErrorType(const Device * const dev, const rtErrorType errorType, bool &isMteError)
{
    UNUSED(errorType);
    if ((!IsHitBlacklist(dev->Id_(), g_mulBitEccEventId)) && (!IsSmmuFault(dev->Id_()))) {
        (RtPtrToUnConstPtr<Device *>(dev))->SetDeviceFaultType(DeviceFaultType::HBM_UCE_ERROR);
        isMteError = true;
    }
}

static void MteErrorProc(const TaskInfo * const errTaskPtr, const Device * const dev, const int32_t errorCode, bool &isMteError)
{
    if ((errTaskPtr->stream != nullptr) && (errTaskPtr->stream->Context_() != nullptr) &&
        (errTaskPtr->stream->Device_() != nullptr) && (errorCode == RT_ERROR_DEVICE_MEM_ERROR)) {
        (RtPtrToUnConstPtr<TaskInfo *>(errTaskPtr))->stream->SetAbortStatus(errorCode);
        (RtPtrToUnConstPtr<TaskInfo *>(errTaskPtr))->stream->Context_()->SetFailureError(errorCode);
        (RtPtrToUnConstPtr<TaskInfo *>(errTaskPtr))->stream->Device_()->SetDeviceStatus(errorCode);
    }
    SetDeviceFaultTypeByErrorType(dev, AICORE_ERROR, isMteError);
}

void SetTaskMteErr(TaskInfo *errTaskPtr, const Device * const dev,
    const std::map<uint32_t, std::string>& eventIdBlkList)
{
    // 若不支持ras上报接口，直接返回内存错误
    bool isMteError = false;
    if (Runtime::Instance()->GetHbmRasProcFlag() == HBM_RAS_NOT_SUPPORT) {
        SetDeviceFaultTypeByErrorType(dev, AICORE_ERROR, isMteError);
        RT_LOG(RT_LOG_WARNING, "Task Hbm Ras reporting is not supported.");
        errTaskPtr->mte_error = (isMteError ? TS_ERROR_AICORE_MTE_ERROR : TS_SUCCESS);
    } else {
        errTaskPtr->mte_error = HasMteErr(dev) ? TS_ERROR_AICORE_MTE_ERROR : TS_ERROR_SDMA_LINK_ERROR;
        if (errTaskPtr->mte_error == TS_ERROR_AICORE_MTE_ERROR) {
            MteErrorProc(errTaskPtr, dev, RT_ERROR_DEVICE_MEM_ERROR, isMteError);
            errTaskPtr->mte_error = (isMteError ? TS_ERROR_AICORE_MTE_ERROR : TS_SUCCESS);
        } else if (HasMemUceErr(dev->Id_(), eventIdBlkList)) {
            errTaskPtr->mte_error = 0U;
        } else {
            (RtPtrToUnConstPtr<Device *>(dev))->SetDeviceFaultType(DeviceFaultType::LINK_ERROR);
        }
    }
}

void GetMteErrFromCqeStatus(TaskInfo *errTaskPtr, const Device * const dev, const uint32_t cqeStatus,
    const std::map<uint32_t, std::string>& eventIdBlkList)
{
    if ((cqeStatus == TS_SDMA_STATUS_DDRC_ERROR) || (cqeStatus == TS_SDMA_STATUS_LINK_ERROR) ||
        (cqeStatus == TS_SDMA_STATUS_POISON_ERROR)) {
        // 若不支持ras上报接口，处理0x8、0x9和0xa直接返回内存错误
        bool isMteError = false;
        if (Runtime::Instance()->GetHbmRasProcFlag() == HBM_RAS_NOT_SUPPORT) {
            SetDeviceFaultTypeByErrorType(dev, SDMA_ERROR, isMteError);
            errTaskPtr->mte_error = (isMteError ? TS_ERROR_SDMA_POISON_ERROR : TS_SUCCESS);
        } else {
            errTaskPtr->mte_error = HasMteErr(dev) ? TS_ERROR_SDMA_POISON_ERROR : TS_ERROR_SDMA_LINK_ERROR;
            if (errTaskPtr->mte_error == TS_ERROR_SDMA_POISON_ERROR) {
                SetDeviceFaultTypeByErrorType(dev, SDMA_ERROR, isMteError);
                errTaskPtr->mte_error = (isMteError ? TS_ERROR_SDMA_POISON_ERROR : TS_SUCCESS);
            } else if (HasMemUceErr(dev->Id_(), eventIdBlkList)) {
                errTaskPtr->mte_error = 0U;
            } else {
                (RtPtrToUnConstPtr<Device *>(dev))->SetDeviceFaultType(DeviceFaultType::LINK_ERROR);
            }
        }
    }
}

bool IsEventRasMatch(const rtDmsFaultEvent &event, const EventRasFilter &filter)
{
    uint32_t rasCode = 0;
    rasCode |= static_cast<uint32_t>(event.rasCode[0]) << 24;
    rasCode |= static_cast<uint32_t>(event.rasCode[1]) << 16;
    rasCode |= static_cast<uint32_t>(event.rasCode[2]) << 8;
    rasCode |= static_cast<uint32_t>(event.rasCode[3]);
    return (event.eventId == filter.eventId) && (event.subModuleId == filter.subModuleId) &&
           (event.errorRegisterIndex == filter.errorRegisterIndex) && ((filter.bitMask & rasCode) != 0);
}

bool IsEventIdAndRasCodeMatch( const uint32_t deviceId, const std::vector<EventRasFilter>& ubNonMemPoisonRasList)
{
    constexpr uint32_t maxFaultNum = 128U;
    rtDmsFaultEvent *faultEventInfo = new (std::nothrow)rtDmsFaultEvent[maxFaultNum];
    COND_RETURN_AND_MSG_OUTER(faultEventInfo == nullptr, false, ErrorCode::EE1013,
        maxFaultNum * sizeof(rtDmsFaultEvent));
    constexpr size_t totalSize = maxFaultNum * sizeof(rtDmsFaultEvent);
    (void)memset_s(faultEventInfo, totalSize, 0, totalSize);

    const std::function<void()> releaseFunc = [&faultEventInfo]() { DELETE_A(faultEventInfo); };
    ScopeGuard faultEventInfoRelease(releaseFunc);
    uint32_t eventCount = 0U;
    rtError_t error = GetDeviceFaultEvents(deviceId, faultEventInfo, eventCount, maxFaultNum);
    if (error != RT_ERROR_NONE) {
        return false;
    }
    // UB Bus Access Exception eventId
    const uint32_t targetEventId = ubNonMemPoisonRasList.front().eventId;

    for (uint32_t faultIndex = 0U; faultIndex < eventCount; faultIndex++) {
        const auto& currentEvent = faultEventInfo[faultIndex];
        const uint32_t eventId = currentEvent.eventId;
        RT_LOG(RT_LOG_INFO, "eventId=%#" PRIx32, eventId);
        if (eventId != targetEventId) {
            continue;
        }
        for (const auto& filter : ubNonMemPoisonRasList) {
            if (IsEventRasMatch(currentEvent, filter)) {
                RT_LOG(RT_LOG_INFO,
                    "[UB Security Event] Device: %u, Event ID: %#" PRIx32 ", subModuleId: 0x%02X, errorRegisterIndex: 0x%02X, bitMask: %u",
                    deviceId,
                    currentEvent.eventId,
                    currentEvent.subModuleId,
                    currentEvent.errorRegisterIndex, 
                    filter.bitMask);

                return true;
            }
        }
    }
    return false;
}

static void AddExceptionRegInfo(const StarsDeviceErrorInfo * const starsInfo, const uint32_t coreIdx,
    const uint16_t type, const TaskInfo *errTaskPtr)
{
    COND_RETURN_NORMAL(type != AICORE_ERROR && type != AIVECTOR_ERROR && type != FFTS_PLUS_AICORE_ERROR &&
        type != FFTS_PLUS_AIVECTOR_ERROR, "the type[%hu] not match", type);
    COND_RETURN_VOID(errTaskPtr == nullptr || errTaskPtr->stream == nullptr ||
        errTaskPtr->stream->Device_() == nullptr, "Cannot get the device by errTaskPtr");

    const uint8_t errCoreType = (type == AICORE_ERROR || type == FFTS_PLUS_AICORE_ERROR) ?
        AICORE_ERROR : AIVECTOR_ERROR;
    const StarsOneCoreErrorInfo& info = starsInfo->u.coreErrorInfo.info[coreIdx];
    rtExceptionErrRegInfo_t regInfo = {};
    regInfo.coreId = static_cast<uint32_t>(info.coreId);
    regInfo.coreType = static_cast<rtCoreType_t>(errCoreType);
    regInfo.startPC = info.pcStart;
    regInfo.currentPC = info.currentPC;
    const uint8_t REG_OFFSET = 32;
    regInfo.errReg[RT_V100_AIC_ERR_0] = static_cast<uint32_t>(info.aicError[0]);
    regInfo.errReg[RT_V100_AIC_ERR_1] = static_cast<uint32_t>(info.aicError[0] >> REG_OFFSET);
    regInfo.errReg[RT_V100_AIC_ERR_2] = static_cast<uint32_t>(info.aicError[1]);
    regInfo.errReg[RT_V100_AIC_ERR_3] = static_cast<uint32_t>(info.aicError[1] >> REG_OFFSET);
    regInfo.errReg[RT_V100_AIC_ERR_4] = static_cast<uint32_t>(info.aicError[2]);
    regInfo.errReg[RT_V100_AIC_ERR_5] = static_cast<uint32_t>(info.aicError[2] >> REG_OFFSET);
    regInfo.errReg[RT_V100_BIU_ERR_0] = static_cast<uint32_t>(info.biuErrInfo);
    regInfo.errReg[RT_V100_BIU_ERR_1] = static_cast<uint32_t>(info.biuErrInfo >> REG_OFFSET);
    regInfo.errReg[RT_V100_CCU_ERR_0] = static_cast<uint32_t>(info.ccuErrInfo);
    regInfo.errReg[RT_V100_CCU_ERR_1] = static_cast<uint32_t>(info.ccuErrInfo >> REG_OFFSET);
    regInfo.errReg[RT_V100_CUBE_ERR_0] = static_cast<uint32_t>(info.cubeErrInfo);
    regInfo.errReg[RT_V100_CUBE_ERR_1] = static_cast<uint32_t>(info.cubeErrInfo >> REG_OFFSET);
    regInfo.errReg[RT_V100_IFU_ERR_0] = static_cast<uint32_t>(info.ifuErrInfo);
    regInfo.errReg[RT_V100_IFU_ERR_1] = static_cast<uint32_t>(info.ifuErrInfo >> REG_OFFSET);
    regInfo.errReg[RT_V100_MTE_ERR_0] = static_cast<uint32_t>(info.mteErrInfo);
    regInfo.errReg[RT_V100_MTE_ERR_1] = static_cast<uint32_t>(info.mteErrInfo >> REG_OFFSET);
    regInfo.errReg[RT_V100_VEC_ERR_0] = static_cast<uint32_t>(info.vecErrInfo);
    regInfo.errReg[RT_V100_VEC_ERR_1] = static_cast<uint32_t>(info.vecErrInfo >> REG_OFFSET);
    regInfo.errReg[RT_V100_FIXP_ERR_0] = info.fixPError0;
    regInfo.errReg[RT_V100_FIXP_ERR_1] = info.fixPError1;
    regInfo.errReg[RT_V100_AIC_COND_0] = static_cast<uint32_t>(info.aicCond);
    regInfo.errReg[RT_V100_AIC_COND_1] = static_cast<uint32_t>(info.aicCond >> REG_OFFSET);

    Device *dev = errTaskPtr->stream->Device_();
    uint32_t taskId = starsInfo->u.coreErrorInfo.comm.taskId;
    uint32_t streamId = starsInfo->u.coreErrorInfo.comm.streamId;
    RT_LOG(RT_LOG_ERROR, "add error register: core_id=%u, stream_id=%u, task_id=%u", regInfo.coreId, streamId, taskId);
    std::pair<uint32_t, uint32_t> key = {streamId, taskId};
    auto& exceptionRegMap = dev->GetExceptionRegMap();
    std::lock_guard<std::mutex> lock(dev->GetExceptionRegMutex());
    exceptionRegMap[key].push_back(regInfo);
}

static void PrintCoreInfo(const StarsDeviceErrorInfo * const info, const uint32_t coreIdx, const uint64_t errorNumber,
    std::string& errorString, std::string& headMsg)
{
    /* logs for aic tools, do not modify the item befor making a new agreement with tools */
    RT_LOG_CALL_MSG(ERR_MODULE_TBE,
        "The error from device(chipId:%u, dieId:%u), serial number is %" PRIu64 ", "
        "there is an exception of %s, core id is %" PRIu64 ", "
        "error code = %#" PRIx64 ", dump info: "
        "pc start: %#" PRIx64 ", current: %#" PRIx64 ", "
        "vec error info: %#" PRIx64 ", mte error info: %#" PRIx64 ", "
        "ifu error info: %#" PRIx64 ", ccu error info: %#" PRIx64 ", "
        "cube error info: %#" PRIx64 ", biu error info: %#" PRIx64 ", "
        "aic error mask: %#" PRIx64 ", para base: %#" PRIx64 ", "
        "aic cond: %#" PRIx64 ".\n"
        "The extend info: errcode:(%#" PRIx64 ", %#" PRIx64 ", %#" PRIx64 ") "
        "errorStr: %s "
        "fixp_error0 info: %#x, fixp_error1 info: %#x, "
        "fsmId:%u, tslot:%u, thread:%u, ctxid:%u, blk:%u, sublk:%u, subErrType:%u.\n"
        "For details, see the troubleshooting document on the Ascend official website. Search for the keyword \"AI Core Error\".",
        info->u.coreErrorInfo.comm.chipId, info->u.coreErrorInfo.comm.dieId, errorNumber, headMsg.c_str(),
        info->u.coreErrorInfo.info[coreIdx].coreId, info->u.coreErrorInfo.info[coreIdx].aicError[0],
        info->u.coreErrorInfo.info[coreIdx].pcStart, info->u.coreErrorInfo.info[coreIdx].currentPC,
        info->u.coreErrorInfo.info[coreIdx].vecErrInfo, info->u.coreErrorInfo.info[coreIdx].mteErrInfo,
        info->u.coreErrorInfo.info[coreIdx].ifuErrInfo, info->u.coreErrorInfo.info[coreIdx].ccuErrInfo,
        info->u.coreErrorInfo.info[coreIdx].cubeErrInfo, info->u.coreErrorInfo.info[coreIdx].biuErrInfo,
        info->u.coreErrorInfo.info[coreIdx].aicErrorMask, info->u.coreErrorInfo.info[coreIdx].paraBase,
        info->u.coreErrorInfo.info[coreIdx].aicCond,
        info->u.coreErrorInfo.info[coreIdx].aicError[0], info->u.coreErrorInfo.info[coreIdx].aicError[1],
        info->u.coreErrorInfo.info[coreIdx].aicError[2], errorString.c_str(),
        info->u.coreErrorInfo.info[coreIdx].fixPError0, info->u.coreErrorInfo.info[coreIdx].fixPError1,
        info->u.coreErrorInfo.info[coreIdx].fsmId, info->u.coreErrorInfo.info[coreIdx].fsmTslotId,
        info->u.coreErrorInfo.info[coreIdx].fsmThreadId, info->u.coreErrorInfo.info[coreIdx].fsmCxtId,
        info->u.coreErrorInfo.info[coreIdx].fsmBlkId, info->u.coreErrorInfo.info[coreIdx].fsmSublkId,
        info->u.coreErrorInfo.info[coreIdx].subErrType);
}

static void ProcessMteAndFfts(const StarsDeviceErrorInfo * const info, const uint32_t coreIdx, bool& isMteErr,
    const bool isCloudV2, const bool isFftsPlusTask, TaskInfo *errTaskPtr)
{
    // 取mteErrInfo[26:24]
    const uint64_t mteErrBit = (info->u.coreErrorInfo.info[coreIdx].mteErrInfo >> 24U) & 0x7U;
    const bool mteErr = (mteErrBit == 0b110U) || (mteErrBit == 0b111U) || (mteErrBit == 0b11U) || (mteErrBit == 0b10U);
    // 若返回的错误码不是0x800000, 或mte error不是0b110 or 0b111 (write bus error or write decode error)
    // or 0b11 or 0b10 (read bus error or read decode error)，则不认为是远端出错
    if ((info->u.coreErrorInfo.info[coreIdx].aicError[0] != 0x800000U) || (!mteErr) || (!isCloudV2)) {
        isMteErr = false;
    }

    rtFftsPlusTaskErrInfo_t fftsPlusErrInfo = rtFftsPlusTaskErrInfo_t();
    if (isFftsPlusTask) {
        fftsPlusErrInfo.contextId = info->u.coreErrorInfo.info[coreIdx].fsmCxtId;
        fftsPlusErrInfo.threadId = static_cast<uint16_t>(info->u.coreErrorInfo.info[coreIdx].fsmThreadId);
        fftsPlusErrInfo.errType = info->u.coreErrorInfo.comm.type;
        fftsPlusErrInfo.pcStart = info->u.coreErrorInfo.info[coreIdx].pcStart;
        PushBackErrInfo(errTaskPtr, static_cast<const void *>(&fftsPlusErrInfo),
                        static_cast<uint32_t>(sizeof(rtFftsPlusTaskErrInfo_t)));
    }
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
            ProcessStarsTimeoutDfxSlotInfo4FftsPlus(info, dev, slotIdx);
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
    const StarsDeviceErrorInfo *const info, const Device *dev, uint16_t slotIdx)
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
    uint8_t *const descAlignBuf = RtPtrToPtr<uint8_t *, void *>(fftsPlusTaskInfo->descAlignBuf);
    const rtError_t ret = devDrv->MemCopySync(&contextInfo,
        CONTEXT_LEN,
        static_cast<void *>(&descAlignBuf[offset]),
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
        (void)mapAddr.emplace_back(
            static_cast<uint64_t>(contextInfo.nonTailTaskStartPcH) << 32U | static_cast<uint64_t>(contextInfo.nonTailTaskStartPcL));
        (void)mapAddr.emplace_back(static_cast<uint64_t>(contextInfo.tailTaskStartPcH) << 32U | static_cast<uint64_t>(contextInfo.tailTaskStartPcL));
        schemMode = contextInfo.schem;
        blockdim = contextInfo.tailBlockdim;
    } else if ((contextInfo.contextType == RT_CTX_TYPE_MIX_AIC) || (contextInfo.contextType == RT_CTX_TYPE_MIX_AIV)) {
        rtFftsPlusMixAicAivCtx_t *mixCtx = nullptr;
        mixCtx = RtPtrToPtr<rtFftsPlusMixAicAivCtx_t *, rtFftsPlusAicAivCtx_t *>(&contextInfo);
        (void)mapAddr.emplace_back(
            static_cast<uint64_t>(mixCtx->nonTailAicTaskStartPcH) << 32U | static_cast<uint64_t>(mixCtx->nonTailAicTaskStartPcL));
        (void)mapAddr.emplace_back(static_cast<uint64_t>(mixCtx->tailAicTaskStartPcH) << 32U | static_cast<uint64_t>(mixCtx->tailAicTaskStartPcL));
        (void)mapAddr.emplace_back(
            static_cast<uint64_t>(mixCtx->nonTailAivTaskStartPcH) << 32U | static_cast<uint64_t>(mixCtx->nonTailAivTaskStartPcL));
        (void)mapAddr.emplace_back(static_cast<uint64_t>(mixCtx->tailAivTaskStartPcH) << 32U | static_cast<uint64_t>(mixCtx->tailAivTaskStartPcL));
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

rtError_t DeviceErrorProc::ProcessStarsCoreErrorInfo(const StarsDeviceErrorInfo * const info,
                                                     const uint64_t errorNumber,
                                                     const Device * const dev, const DeviceErrorProc * const insPtr)
{
    UNUSED(insPtr);
    bool isFftsPlusTask = false;
    const uint16_t type = info->u.coreErrorInfo.comm.type;

    TaskInfo *errTaskPtr = dev->GetTaskFactory()->GetTask(static_cast<int32_t>(info->u.coreErrorInfo.comm.streamId),
        info->u.coreErrorInfo.comm.taskId);
    if (errTaskPtr != nullptr) {
        errTaskPtr->isRingbufferGet = true;
        if ((errTaskPtr->type ==  TS_TASK_TYPE_FFTS_PLUS) &&
            ((type == FFTS_PLUS_AICORE_ERROR) || (type == FFTS_PLUS_AIVECTOR_ERROR))) {
            isFftsPlusTask = true;
        }

        if (info->u.coreErrorInfo.comm.flag == 1U) {
            SetTaskMteErr(errTaskPtr, dev);
        }
    }

    const bool isSupportFastRecover = dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DFX_FAST_RECOVER_MTE_ERROR);
    const uint32_t inputcoreNum = info->u.coreErrorInfo.comm.coreNum;
    // info->u.coreErrorInfo.comm.flag等于1的场景在上述流程已经判断过，不需要再重复判断
    bool isMteErr = (inputcoreNum > 0U) && (info->u.coreErrorInfo.comm.flag != 1U) && isSupportFastRecover; 
    for (uint32_t coreIdx = 0U; coreIdx < inputcoreNum; coreIdx++) {
        if (isFftsPlusTask == false && errTaskPtr != nullptr && errTaskPtr->u.aicTaskInfo.kernel == nullptr) {
            AicTaskInfo *aicTask = &errTaskPtr->u.aicTaskInfo;
            RT_LOG(RT_LOG_ERROR, "stream_id=%u, task_id=%u not with kernel info.", info->u.coreErrorInfo.comm.streamId,
                info->u.coreErrorInfo.comm.taskId);
            if (aicTask->progHandle != nullptr && coreIdx < MAX_CORE_BLOCK_NUM) {
                aicTask->kernel =aicTask->progHandle->SearchKernelByPcAddr(info->u.coreErrorInfo.info[coreIdx].pcStart);
            }
        }
        std::string errorString;
        DeviceErrorProc::ProcessStarsCoreErrorMapInfo(&(info->u.coreErrorInfo.info[coreIdx]), errorString);
        std::string headMsg = GetStarsRingBufferHeadMsg(info->u.coreErrorInfo.comm.type);
        AddExceptionRegInfo(info, coreIdx, type, errTaskPtr);
        PrintCoreInfo(info, coreIdx, errorNumber, errorString, headMsg);
        ProcessMteAndFfts(info, coreIdx, isMteErr, isSupportFastRecover, isFftsPlusTask, errTaskPtr);
    }
    // 本地没有其他告警，且报错写mte错误，认为疑似是远端出错
    const bool hasErrTask = (errTaskPtr != nullptr);
    bool isLinkError = false;
    if (isMteErr && hasErrTask) {
        if (!HasMteErr(dev)) {
            isLinkError = !HasMemUceErr(dev->Id_());
        }
    }
    if (isLinkError) {
        errTaskPtr->mte_error = TS_ERROR_SDMA_LINK_ERROR;
        (RtPtrToUnConstPtr<Device *>(dev))->SetDeviceFaultType(DeviceFaultType::LINK_ERROR);
    }
    if (errTaskPtr != nullptr) {
        RT_LOG(RT_LOG_ERROR, "devId=%u, streamId=%u, taskId=%u, MTE errorCode=%u.", dev->Id_(),
               info->u.coreErrorInfo.comm.streamId, info->u.coreErrorInfo.comm.taskId, errTaskPtr->mte_error);
    }
    return RT_ERROR_NONE;
}
}  // namespace runtime
}  // namespace cce
