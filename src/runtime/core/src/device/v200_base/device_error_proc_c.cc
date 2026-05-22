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
#include "ringbuffer_maintain_task.h"
#include "profiler_c.hpp"
#include "acc_error_info.h"
#include "error_code.h"

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
    MTE_INSTR_ILLEGAL_CFG = RINGBUFFER_MTE_ERROR_OFFSET + 14U,
    MTE_ATM_ADD_ADDR_MISALIGN,
    MTE_INSTR_ADDR_MISALIGN,
    MTE_GDMA_READ_OVERFLOW,
    MTE_GDMA_WRITE_OVERFLOW,
    MTE_STB_ECC = RINGBUFFER_MTE_ERROR_OFFSET + 26U,
    MTE_TAGMGR_BUF_ECC = RINGBUFFER_MTE_ERROR_OFFSET + 28U,
    MTE_UB_ECC,
    MTE_ROB_ECC,
    MTE_BIU_RDWR_RESP,

    L1_L0A_RDWR_CFLT = RINGBUFFER_L1_ERROR_OFFSET,
    L1_L0B_RDWR_CFLT,
    L1_READ_2D_OVERFLOW,
    L1_WRITE_2D_OVERFLOW,
    L1_ILLEGAL_CHN_SIZE = RINGBUFFER_L1_ERROR_OFFSET + 14U,
    L1_ILLEGAL_K_M_EXT_STEP,
    L1_ILLEGAL_K_M_START_POS,
    L1_ILLEGAL_FM_SIZE = RINGBUFFER_L1_ERROR_OFFSET + 19U,
    L1_ILLEGAL_STRIDE = RINGBUFFER_L1_ERROR_OFFSET + 21U,
    L1_PADDING_CFG,
    L1_READ_3D_OVERFLOW,
    L1_WRITE_3D_OVERFLOW,
    L1_F1WPOS_LARGER_FSIZE = RINGBUFFER_L1_ERROR_OFFSET + 27U,
    L1_FMAP_LESS_KERNEL,
    L1_FMAPWH_LARGER_L1SIZE,
    L1_FPOS_LARGER_FSIZE,

    FIXP_BIU_RDWR_RESP = RINGBUFFER_L1_ERROR_1_OFFSET + 1U,
    FIXP_STB_ECC_ERR, 
    FIXP_FBUF_WR_OVERFLOW ,
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
    L1_UB_WR_OVFLW,   //reserve，not in chip doc
    L1_WAITSET_ERR,   //reserve，not in chip doc
    L1_L1_ECC,  //reserve，not in chip doc
    L1_GDMA_READ_OVERFLOW,  //reserve，not in chip doc
    L1_GDMA_WRITE_OVERFLOW,  //reserve，not in chip doc
    L1_INSTR_ILLEGAL_CFG,  //reserve，not in chip doc
    L1_INSTR_ADDR_MISALIGN,   //reserve，not in chip doc

    SC_BUS_RESP_TIMEOUT_ERR = RINGBUFFER_SC_ERROR_OFFSET + 3U,

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
    SU_HIT_TRAP_ERR_T0 = RINGBUFFER_SU_ERROR_OFFSET + 30U,
    WARN_AS_EXCEPTION_T0,

    VEC_ERR_UB_ARB_DATA_EXCP_MTE_T0 = RINGBUFFER_VEC_ERROR_OFFSET,
    VEC_ERR_UB_ARB_DATA_EXCP_SU_T0,
    VEC_ERR_UB_ARB_DATA_EXCP_VEC_T0,
    VEC_ERR_INSTR_TIMEOUT_T0 = RINGBUFFER_VEC_ERROR_OFFSET + 6U,
    VEC_ERR_SU_PLD_UNDEF_T0,   //need to be updated after chip doc update
    VEC_ERR_SU_PLD_ILL_CFG_T0,  //need to be updated after chip doc update
    VEC_ERR_PC_OVERFLOW_T0,  //need to be updated after chip doc update
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
    {CUBE_INVLD_INPUT, "the data read back from L0a and L0b  is INF or NAN."},
    {CUBE_L0A_WRAP_AROUND, "The address for CUBE to operate L0A is out of bounds."},
    {CUBE_L0B_WRAP_AROUND, "The address for CUBE to operate L0B is out of bounds."},
    {CUBE_L0C_WRAP_AROUND, "The address for CUBE to operate L0C is out of bounds."},
    {CUBE_L0A_ECC, 
        "A multi-bit ECC error occurs when CUBE reads L0A. See the RAS alarm handling."},
    {CUBE_L0B_ECC, 
        "A multi-bit ECC error occurs when CUBE reads L0B. See the RAS alarm handling."},
    {CUBE_L0C_ECC, 
        "A multi-bit ECC error occurs when CUBE reads L0C. See the RAS alarm handling."},
    {CUBE_ILLEGAL_INSTR, "The CUBE instruction is abnormal. "
        "Possible cause: The parameter violates the instruction constraints, the binary version does not match, or the instruction is overwritten"},
    {CUBE_ERR_HSET_CNT_OVF, "A overflow error occurs in the CUBE HSET counter."},
    {CUBE_ERR_HSET_CNT_UNF, "A underflow error occurs in the CUBE HSET counter."},
    {CUBE_ERR_PBUF_WRAP_AROUND, "The address for CUBE to operate FIXP buffer is out of bounds."},
    {CUBE_ERR_PARITY_ERR, "Parity error for the Cube parity ERR register."},
    {CUBE_ERR_SF_ECC_MB_ERR, 
        "A multi-bit ECC error occurs when CUBE reads MX buffer. See the RAS alarm handling."},

    // RINGBUFFER_MTE_ERROR_OFFSET
    {MTE_NDDMA_CACHE_ECC, 
        "A multi-bit ECC error occurs when MTE reads NDDMA cache. See the RAS alarm handling."},
    {MTE_NDDMA_REG_BUF_ECC, 
        "A multi-bit ECC error occurs when MTE reads NDDMA request buffer. See the RAS alarm handling."},
    {MTE_L1_ECC, 
        "A multi-bit ECC error occurs when MTE2 and MTE3 reads L1. See the RAS alarm handling."},
    {MTE_CFG_REG_PARITY, 
        "A parity error occurs when AICore reads the CFG register. See the RAS alarm handling"},
    {MTE_READ_OVERFLOW,
        "The address of the MTE 2D instruction to read L1 is out of bounds."},
    {MTE_WRITE_OVERFLOW,
        "The address of the MTE 2D instruction to write L1/L0A/L0B is out of bounds."},
    {MTE_INSTR_ILLEGAL_CFG, "The MTE instruction is abnormal. "
        "Possible cause: The parameter violates the instruction constraints, the binary version does not match, or the instruction is overwritten"},
    {MTE_ATM_ADD_ADDR_MISALIGN, "The MTE atomic instruction address is not aligned."},
    {MTE_INSTR_ADDR_MISALIGN, "The MTE non-atomic instruction address is not aligned."},
    {MTE_GDMA_READ_OVERFLOW, 
        "The address for MTE2 to read UB and MTE3 to read L1/UB is out of bounds."},
    {MTE_GDMA_WRITE_OVERFLOW, "The address for MTE2 to write UB and MTE3 to write L1/UB is out of bounds."},
    {MTE_STB_ECC, 
        "A multi-bit ECC error occurs when MTE reads STB buffer. See the RAS alarm handling."},
    {MTE_TAGMGR_BUF_ECC, 
        "A multi-bit ECC error occurs when MTE reads tagmgr buffer. See the RAS alarm handling."},
    {MTE_UB_ECC, "A multi-bit ECC error occurs when MTE reads UB. See the RAS alarm handling."},
    {MTE_ROB_ECC, 
        "A multi-bit ECC error occurs when MTE reads ROB buffer. See the RAS alarm handling."},
    {MTE_BIU_RDWR_RESP, "The DDR address of the MTE instruction is out of range."},

    // RINGBUFFER_L1_ERROR_OFFSET
    {L1_L0A_RDWR_CFLT, "The address for MTE to write L0A conflicts with that for CUBE to read L0A."},
    {L1_L0B_RDWR_CFLT, "The address for MTE to write L0B conflicts with that for CUBE to read L0B."},
    {L1_READ_2D_OVERFLOW, "The address of the LOAD2D instruction to read L1 is out of bounds."},
    {L1_WRITE_2D_OVERFLOW, "The address of the LOAD2D instruction to write L0A/L0B is out of bounds."},
    {L1_ILLEGAL_CHN_SIZE, "The value of L1H*L1W*channel size of the LOAD3DV2 instruction is greater "
        "than the size of L1, or the channel size is not aligned."},
    {L1_ILLEGAL_K_M_EXT_STEP, "The k start pos + k step or m start pos + m step of the LOAD3D instruction "
        "exceeds the range of the km matrix (the tail is considered as 16 if it is less than 16), "
        "or the fractal number calculated by step exceeds the range of L0A/L0B."},
    {L1_ILLEGAL_K_M_START_POS, "The km start pos of the LOAD3D instruction is out of the range of the KM matrix, "
        "the k start pos is not an integral multiple of the number of 32-byte data elements corresponding to the data type, "
        "or the m start pos is not an integral multiple of 16."},
    {L1_ILLEGAL_FM_SIZE, "The width or height of the feature map of the LOAD3D instruction is greater than 0X8000, "
        "or the area of the feature map is greater than the size of the L1 memory."},
    {L1_ILLEGAL_STRIDE, "The stride_w or stride_h of the LOAD3D instruction is 0."},
    {L1_PADDING_CFG, "The padding configuration of the LOAD3D instruction is invalid."},
    {L1_READ_3D_OVERFLOW, "The address for the LOAD3D instruction to read L1 is out of bounds."},
    {L1_WRITE_3D_OVERFLOW, "The address for the LOAD3D instruction to write L0A/L0B is out of bounds."},
    {L1_F1WPOS_LARGER_FSIZE,
        "The position of the first window of LOAD3D exceeds the left or upper padding boundary, "
        "or exceeds the right or lower padding boundary of the feature map(without padding)."},
    {L1_FMAP_LESS_KERNEL, "The width of the LOAD3D filter is greater than the width of the "
        "feature map plus padding. or the height of the filter after dilation is greater "
        "than the height of the feature map plus padding."},
    {L1_FMAPWH_LARGER_L1SIZE,
        "The LOAD3D parameter is invalid. L1H*L1W*(C1+1) is greater than L1 buffer size/32."},
    {L1_FPOS_LARGER_FSIZE,
        "The LOAD3D K postion is out of the filter range."},

    // RINGBUFFER_L1_ERROR_1_OFFSET
    {FIXP_BIU_RDWR_RESP, "The address for fixpipe to write GM is invalid"},
    {FIXP_STB_ECC_ERR, "A multi-bit ECC error occurs when fixpipe reads STB buffer. See the RAS alarm handling"},
    {FIXP_FBUF_WR_OVERFLOW, "The address for fixpipe to write FBUF is out of bounds."},
    {FIXP_FBUF_RD_OVERFLOW, "The address for fixpipe to read FBUF is out of bounds."},
    {FIXP_OUT_WR_OVERFLOW, "A overflow error occurs when the FIXP write."},
    {FIXP_L1_WR_OVERFLOW, "The address for fixpipe to write L1 is out of bounds."},
    {FIXP_L1_RD_OVERFLOW, "The address for fixpipe to read L1 is out of bounds."},
    {FIXP_L0C_RD_OVERFLOW, "The address for fixpipe to read L0C is out of bounds."},
    {FIXP_ILLEGAL_CFG, "The fixpipe instruction parameter is invalid."},
    {FIXP_ADDR_MISAL, "The address for fixpipe to read L0C, read/write L1, and read/write FBUF is not aligned."},
    {FIXP_L0C_ECC_ERR, "A multi-bit ECC error occurs when fixpipe reads L0C. See the RAS alarm handling."},
    {FIXP_L0C_RDWR_CFLT, "The address for fixpipe to read L0C confilicts with that for CUBE to write L0C."},
    {FIXP_WRITE_UB_OVFLW, "The address for fixpipe to write UB is out of bounds."},
    {L1_UB_WR_OVFLW, "The address for MTE to move from L1 to UB is out of bounds."},
    {L1_WAITSET_ERR, "The configuration of HWATI/HSET is invalid."},
    {L1_L1_ECC, "A multi-bit ECC error occurs when MTE/fixpipe reads L1. See the RAS alarm handling."},
    {L1_GDMA_READ_OVERFLOW, "The address for the MTE instruction to read L1 is out of bounds."},
    {L1_GDMA_WRITE_OVERFLOW, "The address for the MTE instruction to write the L0A/L0B bias table is out of bounds."},
    {L1_INSTR_ILLEGAL_CFG, "The MTE instruction is abnormal. Possible cause: "
        "The parameter violates the instruction constraints, the binary version does not match, or the instructinon is overwirtten."},
    {L1_INSTR_ADDR_MISALIGN, "The MTE instruction address is not aligned."},

    // RINGBUFFER_SU_ERROR_OFFSET
    {SU_IFU_BUS_ERR_T0, "The address of instruction is illegal when the AIcore reads instructions from GM."
        "Possible cause: The application unloads the operator binary in advance or stack corruption occurs."},
    {SU_CCU_CALL_DEPTH_OVRFLW_T0, "The number of nesting times of call the function is greater than CTRL[5:2]."},
    {SU_CCU_DIV0_T0, "divide by zero."},
    {SU_CCU_ILLEGAL_INSTR_T0, "The scalar instruction is abnormal. Possible cause: "
        "The parameter violates the instruction constraints, the binary version does not match, or the instructinon is overwirtten."},
    {SU_CCU_NEG_SQRT_T0, "The number of roots is negative. "},
    {SU_CCU_UB_ECC_T0, "A multi-bit ECC error occurs when scalar accesses UB. See the RAS alarm handling."},
    {SU_CCU_INF_NAN_T0, "The input of the floating-point instruction run by the CCU is nan/inf."},
    {SU_CCU_ADDR_ERR_T0, "The address for scalar to use is unaligned or out of bounds "
        "The GM address exceeds 48 bits, or the on-chip buffer address exceeds the size of the buffer."},
    {SU_CCU_BUS_ERR_T0, "The address for scalar to access GM is invalid"},
    {SU_CCU_DC_DATA_ECC_T0, "A multi-bit ECC error occurs when scalar accesses dcache data. See the RAS alarm handling."},
    {SU_CCU_DC_TAG_ECC_T0, "A multi-bit ECC error occurs when scalar accesses dcache tag. See the RAS alarm handling."},
    {SU_CCU_DIV0_FP_T0, "A error occurs in the FP32 DIV0."},
    {SU_CCU_NEG_SQRT_FP_T0, "The input of the FP SQRT calculation unit is a negative number."},
    {SU_CCU_ERR_PARITY_ERR_T0, "A parity error occurs when SU reads FIFO. See the RAS alarm handling."},
    {SU_CCU_SEQ_ERR_T0, "The SEQ command sequence is incorrect."},
    {SU_CCU_MPU_ERR_T0, "The address for scalar to access the internal buffer is out of bounds."},
    {SU_CCU_LSU_ERR_T0, "When the buffer is enabled, the stack access instruction cache is miss."},
    {SU_CCU_PB_ECC_ERR_T0, "A multi-bit ECC error occurs when scalar reads parameter buffer. See the RAS alarm handling."},
    {SU_CCU_SAFETY_CRC_ERR_T0, "MTE CRC error."},
    {SU_CCU_LSU_ATOMIC_ERR_T0, "The scalar atomic instruction accesses the GM that is modified by scalar "
        "but is not written back."},
    {SU_CCU_CC_SET_OVFL_ERR_T0, "The accumulated value of the inter-core communication flag coutner "
        "exceeds the maximum value 15."},
    {SU_SAFETY_1BIT_ECC_OVFLW_ERR_T0, "Overflow error when the number of 1-bit ECC errors exceeds the preset value."},
    {SU_CCU_DC_SSBUF_ECC_T0, "A multi-bit ECC error occurs when scalar reads SS buffer. See the RAS alarm handling."},
    {SU_HIT_TRAP_ERR_T0, "The trap instruction reports an error."},
    {WARN_AS_EXCEPTION_T0,
        "A 1-bit ECC err occurs 15 times or a multi-hit event occurs in IFU during AICore execution. "
        "See the RAS alarm handling."},

    // sc error
    {SC_BUS_RESP_TIMEOUT_ERR, "The bus is busy, and the response times out."},

    // RINGBUFFER_VEC_ERROR_OFFSET
    {VEC_ERR_UB_ARB_DATA_EXCP_MTE_T0, "Data from the MTE is abnormal."},
    {VEC_ERR_UB_ARB_DATA_EXCP_SU_T0, "Data from the CCU is abnormal."},
    {VEC_ERR_UB_ARB_DATA_EXCP_VEC_T0, "Data from the VEC is abnormal."},
    {VEC_ERR_INSTR_TIMEOUT_T0, "VEC VF execution timeout. Check the configuration of Runtime"},
    {VEC_ERR_SU_PLD_UNDEF_T0, "The non-VF instruction is abnormal. Possible cause: "
        "The parameter violates the instruction constraints, the binary version does not match, or the instructinon is overwirtten."},
    {VEC_ERR_SU_PLD_ILL_CFG_T0, "The parameter of the non-VF instruction is invalid."},
    {VEC_ERR_PC_OVERFLOW_T0, "PC is greater than 48 bits. Possible cause: the compiler bug or the instructoin is overwirtten."},
    {VEC_ERR_INSTR_UNDEF_T0, "The instruction in VEC VF is abnormal. Possible cause: "
        "The parameter violates the instruction constraints, the binary version does not match, or the instructinon is overwirtten."},
    {VEC_INSTR_ILLEGAL_CFG_T0, "The parameter of the VEC VF instruction is invalid."},
    {VEC_ERR_HWLP_STACK_OVFL_T0, "The number of nested VLOOP exceeds the hardware limit, which may be a complier bug."},
    {VEC_ERR_HWLP_INSTR_NUM_MISMATCH_T0, "For the nested VLOOP, the number of instructions in the inner loop "
        "is greater than that in the outer loop, which may be a complier bug."},
    {VEC_ERR_BIU_RESP_ERR_T0, "SMIT accesses an invalid GM address or the cross-device memory access times out."},
    {VEC_ERR_PB_ECC_MBERR_T0, "A multi-bit ECC error occurs when VEC accesses parameter buffer. See the RAS alarm handling."},
    {VEC_ERR_IDATA_INF_NAN_T0, "The input data of the instruction operation is INF/NAN."},
    {VEC_ERR_DIV_BY_ZERO_T0, "Divide-by-zero error occurs for the VEC instruction."},
    {VEC_ERR_VALU_NEG_LN_T0, "The input data of the VALU lN operation is a negative number."},
    {VEC_ERR_VALU_NEG_SQRT_T0, "The input data of the VALU squart operation is a negative number."},
    {VEC_ERR_UB_ADDR_OVERFLOW_T0, "The address for VEC to access UB is not aligned."},
    {VEC_UB_WRAP_AROUND, "The address for VEC to access UB is out of bounds."},
    {VEC_ERR_UB_ECC_MBERR_T0, "A multi-bit ECC error occurs when VEC accesses UB. See the RAS alarm handling."},
    {VEC_ERR_VMS_UNSORT_T0, "The input data of the sorting instruction is not correctly sorted."},
    {VEC_ERR_CSW_DATA_T0, "Exception when accessing the internal SRAM during context switch (multi-bit ECC)."},
    // RINGBUFFER_VEC_ERROR_1_OFFSET
    {VEC_ERR_UNEXP_JOIN_T0,
        "When the VEC executes a SIMT task, some warps end with \"join\" and some warps end with \"end\"."},
    {VEC_ERR_UB_SIZE_CFG_ERR_T0, "The dyn ubuf size is greater than 224 KB."},
    {VEC_ERR_DC_STACK_ADDR_OVFL_T0, "The VEC SIMT stack overflows. Possible cause: "
        "The local variable is too large or there are too many local variables."},
    {VEC_ERR_GM_ADDR_OVFL_T0, "The address for VEC to read GM is out of bounds(exceeding 48 bits)."},
    {VEC_ERR_DVG_STACK_OVFL_T0, "VEC SIMT DVG stack overflows, which may be caused by too many conditional branches "
        "or too manay nested loops."},
    {VEC_ERR_DVG_STACK_UNDFL_T0, "VEC SIMT push and pop operations do not mathc, which may be a compiler bug."},
    {VEC_ERR_BHU_ECC_MBERR_T0, "A multi-bit ECC error occurs when VEC SIMT accesses BHU. See the RAS alarm handling."},
    {VEC_ERR_MROB_ECC_MBERR_T0, "A multi-bit ECC error occurs when VEC SIMT accesses MROB. See the RAS alarm handling."},
    {VEC_ERR_DCACHE_TAG_MBERR_T0, "A multi-bit ECC error occurs when VEC SIMT accesses dcache tag. See the RAS alarm handling."},
    {VEC_ERR_DIRTY_ECC_MBERR_T0, "A multi-bit ECC error occurs when VEC SIMT accesses the dirty mem. See the RAS alarm handling."},
    {VEC_ERR_VTH_ID_ECC_MBERR_T0, "A multi-bit ECC error occurs when VEC SIMT accesses thread ID register. See the RAS alarm handling."},
    {VEC_ERR_MRF_ECC_MBERR_T0, "A multi-bit ECC error occurs when VEC SIMT accesses reagister table. See the RAS alarm handling."},
    {VEC_ERR_DVG_ECC_MBERR_T0, "A multi-bit ECC error occurs when VEC SIMT accesses DVG stack. See the RAS alarm handling."},
};

static const std::unordered_map<uint32_t, std::string> ubRasEventIdAndDesc = {
    {UB_POISON_ERROR_EVENT_ID, "node type=UB, sensor type=RAS State, event state=bus error, probably caused by software"},
};

static bool PrintRasEvents(const Device * const dev, const rtDmsFaultEvent * const faultEventInfo, const uint32_t eventCount)
{
    UNUSED(dev);
    for (uint32_t faultIndex = 0; faultIndex < eventCount; faultIndex++) {
        const rtDmsFaultEvent &event = faultEventInfo[faultIndex];
        uint32_t eventId = event.eventId;
        auto it = ubRasEventIdAndDesc.find(eventId);
        if (it != ubRasEventIdAndDesc.end()) {
            RT_LOG(RT_LOG_ERROR, "RAS event detected: event_id=0x%x, %s", eventId, it->second.c_str());
            return true;
        }
    }
    return false;
}

void CheckAndPrintRasInfo(const Device * const dev)
{
    if (dev == nullptr) {
        return;
    }
    
    constexpr uint32_t maxFaultNum = 128U;
    rtDmsFaultEvent *faultEventInfo = new (std::nothrow)rtDmsFaultEvent[maxFaultNum];
    COND_RETURN_VOID((faultEventInfo == nullptr), "new rtDmsFaultEvent failed.");
    const size_t totalSize = maxFaultNum * sizeof(rtDmsFaultEvent);
    const std::function<void()> releaseFunc = [&faultEventInfo]() { DELETE_A(faultEventInfo); };
    ScopeGuard faultEventInfoRelease(releaseFunc);
    
    const uint32_t maxQueryCount = 20U;
    const uint32_t queryIntervalMs = 10U;

    for (uint32_t queryCount = 0U; queryCount < maxQueryCount; ++queryCount) {
        (void)memset_s(faultEventInfo, totalSize, 0, totalSize);
        uint32_t eventCount = 0U;
        rtError_t error = GetDeviceFaultEvents(dev->Id_(), faultEventInfo, eventCount, maxFaultNum);
        if ((error == RT_ERROR_NONE) && PrintRasEvents(dev, faultEventInfo, eventCount)) {
            return;
        }
        (void)mmSleep(queryIntervalMs);
    }
}

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
    ProcessDavidStarsCoreErrorOneMapInfo(&cnt, info->mteError[0], errorString, errorCode,
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
                DeviceFaultInfo faultInfo = {};
                faultInfo.eventId = faultEventInfo[faultIndex].eventId;
                faultInfo.nodeType = faultEventInfo[faultIndex].nodeType;
                (RtPtrToUnConstPtr<Device *>(dev))->SetDeviceFaultInfo(faultInfo);
                return;
            }
        }
    }
    AiCoreUnknownErrProc(dev, info);
}

static void GetMteDeviceFaultEvent(const Device * const dev, uint32_t &faultEventId, bool &isHitBlklist)
{
    constexpr uint32_t maxFaultNum = 128U;
    rtDmsFaultEvent *faultEventInfo = new (std::nothrow)rtDmsFaultEvent[maxFaultNum];
    COND_RETURN_VOID((faultEventInfo == nullptr), "new rtDmsFaultEvent failed.");
    const size_t totalSize = maxFaultNum * sizeof(rtDmsFaultEvent);
    (void)memset_s(faultEventInfo, totalSize, 0, totalSize);

    const std::function<void()> releaseFunc = [&faultEventInfo]() { DELETE_A(faultEventInfo); };
    ScopeGuard faultEventInfoRelease(releaseFunc);
    uint32_t eventCount = 0U;
    rtError_t error = GetDeviceFaultEvents(dev->Id_(), faultEventInfo, eventCount, maxFaultNum);
    if (error != RT_ERROR_NONE) {
        return;
    }

    if (IsFaultEventOccur(L2_BUFFER_ECC_EVENT_ID, faultEventInfo, eventCount)) {
        isHitBlklist = IsHitBlacklist(faultEventInfo, eventCount, g_l2MulBitEccEventIdBlkList);
        if (!isHitBlklist) {
            faultEventId = L2_BUFFER_ECC_EVENT_ID;
            return;
        }
    }

    isHitBlklist = IsHitBlacklist(faultEventInfo, eventCount, g_mulBitEccEventIdBlkList);
    if (IsFaultEventOccur(HBM_ECC_EVENT_ID, faultEventInfo, eventCount) && !isHitBlklist) {
        faultEventId = HBM_ECC_EVENT_ID;
    }
}

static void SetTaskMteErrByType(const rtErrorType errType, const Device * const dev, TaskInfo *errTaskPtr)
{
    if (errTaskPtr == nullptr) {
        return;
    }

    /*
     * L2_BUFFER_ECC    HBM_ECC_NOTIFY    HBM_ECC    hit_black_list   mte_error       fault_type
     * YES              \                 \          NO               local_error     L2_BUFFER_ERROR
     * NO               NOT_SUPPORT       YES        NO               local_error     HBM_UCE_ERROR
     * NO               YES               \          NO               local_error     HBM_UCE_ERROR
     * NO               NO                \          NO               remote_error    LINK_ERROR
     * OTHERS                                                         0               AICORE_UNKNOWN_ERROR
     */
    if (errType == AICORE_ERROR) {
        (RtPtrToUnConstPtr<Device *>(dev))->SetDeviceFaultType(DeviceFaultType::AICORE_UNKNOWN_ERROR);
    }

    const bool suppHbmRas = (Runtime::Instance()->GetHbmRasProcFlag() != HBM_RAS_NOT_SUPPORT);
    bool hasMteHbmErr = suppHbmRas ? HasMteErr(dev) : false;

    uint32_t faultEventId = 0U;
    bool isHitBlklist = false;
    GetMteDeviceFaultEvent(dev, faultEventId, isHitBlklist);
    bool hasL2BuffEcc = (faultEventId == L2_BUFFER_ECC_EVENT_ID);
    bool hasHbmEcc = (faultEventId == HBM_ECC_EVENT_ID);
    bool isHitHbmBlkList = !hasL2BuffEcc && isHitBlklist;
    RT_LOG(RT_LOG_ERROR, "support_hbm_ras_report=%d, has_l2_buffer_ecc_event=%d, has_hbm_ecc_notify_event=%d, "
        "has_hbm_ecc_event=%d, hit_black_list=%d.", suppHbmRas, hasL2BuffEcc, hasMteHbmErr, hasHbmEcc, isHitBlklist);

    const uint16_t local_error = (errType == AICORE_ERROR) ? TS_ERROR_AICORE_MTE_ERROR : TS_ERROR_SDMA_POISON_ERROR;
    const uint16_t remote_error = TS_ERROR_SDMA_LINK_ERROR;
    if (hasL2BuffEcc) {
        errTaskPtr->mte_error = local_error;
        (RtPtrToUnConstPtr<Device *>(dev))->SetDeviceFaultType(DeviceFaultType::L2_BUFFER_ERROR);
        return;
    }
    if ((!suppHbmRas && hasHbmEcc) || (hasMteHbmErr && !isHitHbmBlkList)) {
        errTaskPtr->mte_error = local_error;
        (RtPtrToUnConstPtr<Device *>(dev))->SetDeviceFaultType(DeviceFaultType::HBM_UCE_ERROR);
        return;
    }
    if (suppHbmRas && !hasMteHbmErr && !isHitHbmBlkList) {
        errTaskPtr->mte_error = remote_error;
        (RtPtrToUnConstPtr<Device *>(dev))->SetDeviceFaultType(DeviceFaultType::LINK_ERROR);
        return;
    }
    errTaskPtr->mte_error = TS_SUCCESS;
}

static void SetDeviceFaultTypeByAixErrClass(const Device * const dev, const StarsDeviceErrorInfo * const info, TaskInfo *errTaskPtr)
{
    switch (static_cast<AixErrClass>(info->u.coreErrorInfo.comm.flag)) {
        case AixErrClass::AIX_MTE_POISON_ERROR:
            SetTaskMteErrByType(AICORE_ERROR, dev, errTaskPtr);
            RT_LOG(RT_LOG_ERROR, "mte error, stream_id=%hu, task_id=%hu, errorCode=%#hx.",
                info->u.coreErrorInfo.comm.streamId, info->u.coreErrorInfo.comm.taskId,
                (errTaskPtr == nullptr) ? static_cast<uint16_t>(TS_ERROR_RESERVED) : errTaskPtr->mte_error);
            CheckAndPrintRasInfo(dev);
            break;
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
            CheckAndPrintRasInfo(dev);
            break;
        default:
            break;
    }
}

static void ProcessCoreErrorClass(const Device * const dev, const StarsDeviceErrorInfo * const info)
{
    TaskInfo *errTaskPtr = GetTaskInfo(dev, static_cast<uint32_t>(info->u.davidCoreErrorInfo.comm.streamId),
        static_cast<uint32_t>(info->u.davidCoreErrorInfo.comm.taskId), true);
    if (errTaskPtr != nullptr) {
        errTaskPtr->isRingbufferGet = true;
        if ((errTaskPtr->type != TS_TASK_TYPE_KERNEL_AICORE) && (errTaskPtr->type != TS_TASK_TYPE_KERNEL_AIVEC)) {
            return;
        }
    }
    RT_LOG(RT_LOG_ERROR, "comm_flag=%hhu", info->u.coreErrorInfo.comm.flag);

    SetDeviceFaultTypeByAixErrClass(dev, info, errTaskPtr);
}

static void GetRegInfoErrReg(const DavidOneCoreErrorInfo& info, rtExceptionErrRegInfo_t &regInfo)
{
    const uint8_t REG_OFFSET = 32;
    regInfo.errReg[RT_V200_SU_ERR_INFO_T0_0] = static_cast<uint32_t>(info.suErrInfo[0]);
    regInfo.errReg[RT_V200_SU_ERR_INFO_T0_1] = static_cast<uint32_t>(info.suErrInfo[0] >> REG_OFFSET);
    regInfo.errReg[RT_V200_SU_ERR_INFO_T0_2] = static_cast<uint32_t>(info.suErrInfo[1]);
    regInfo.errReg[RT_V200_SU_ERR_INFO_T0_3] = static_cast<uint32_t>(info.suErrInfo[1] >> REG_OFFSET);
    regInfo.errReg[RT_V200_MTE_ERR_INFO_T0_0] = static_cast<uint32_t>(info.mteErrInfo[0]);
    regInfo.errReg[RT_V200_MTE_ERR_INFO_T0_1] = static_cast<uint32_t>(info.mteErrInfo[0] >> REG_OFFSET);
    regInfo.errReg[RT_V200_MTE_ERR_INFO_T0_2] = static_cast<uint32_t>(info.mteErrInfo[1]);
    regInfo.errReg[RT_V200_MTE_ERR_INFO_T1_0] = static_cast<uint32_t>(info.mteErrInfo[1] >> REG_OFFSET);
    regInfo.errReg[RT_V200_MTE_ERR_INFO_T1_1] = static_cast<uint32_t>(info.mteErrInfo[2]);
    regInfo.errReg[RT_V200_MTE_ERR_INFO_T1_2] = static_cast<uint32_t>(info.mteErrInfo[2] >> REG_OFFSET);
    regInfo.errReg[RT_V200_VEC_ERR_INFO_T0_0] = static_cast<uint32_t>(info.vecErrInfo[0]);
    regInfo.errReg[RT_V200_VEC_ERR_INFO_T0_1] = static_cast<uint32_t>(info.vecErrInfo[0] >> REG_OFFSET);
    regInfo.errReg[RT_V200_VEC_ERR_INFO_T0_2] = static_cast<uint32_t>(info.vecErrInfo[1]);
    regInfo.errReg[RT_V200_VEC_ERR_INFO_T0_3] = static_cast<uint32_t>(info.vecErrInfo[1] >> REG_OFFSET);
    regInfo.errReg[RT_V200_VEC_ERR_INFO_T0_4] = static_cast<uint32_t>(info.vecErrInfo[2]);
    regInfo.errReg[RT_V200_VEC_ERR_INFO_T0_5] = static_cast<uint32_t>(info.vecErrInfo[2] >> REG_OFFSET);
    regInfo.errReg[RT_V200_CUBE_ERR_INFO_T0_0] = static_cast<uint32_t>(info.cubeErrInfo);
    regInfo.errReg[RT_V200_CUBE_ERR_INFO_T0_1] = static_cast<uint32_t>(info.cubeErrInfo >> REG_OFFSET);
    regInfo.errReg[RT_V200_L1_ERR_INFO_T0_0] = static_cast<uint32_t>(info.l1ErrInfo);
    regInfo.errReg[RT_V200_L1_ERR_INFO_T0_1] = static_cast<uint32_t>(info.l1ErrInfo >> REG_OFFSET);
    regInfo.errReg[RT_V200_SC_ERROR_T0_0] = static_cast<uint32_t>(info.scError);
    regInfo.errReg[RT_V200_SU_ERROR_T0_0] = static_cast<uint32_t>(info.suError);
    regInfo.errReg[RT_V200_MTE_ERROR_T0_0] = static_cast<uint32_t>(info.mteError[0]);
    regInfo.errReg[RT_V200_MTE_ERROR_T1_0] = static_cast<uint32_t>(info.mteError[1]);
    regInfo.errReg[RT_V200_VEC_ERROR_T0_0] = static_cast<uint32_t>(info.vecError);
    regInfo.errReg[RT_V200_VEC_ERROR_T0_2] = static_cast<uint32_t>(info.vecError >> REG_OFFSET);
    regInfo.errReg[RT_V200_CUBE_ERROR_T0_0] = static_cast<uint32_t>(info.cubeError);
    regInfo.errReg[RT_V200_CUBE_ERROR_T0_1] = static_cast<uint32_t>(info.cubeError >> REG_OFFSET);
    regInfo.errReg[RT_V200_L1_ERROR_T0_0] = static_cast<uint32_t>(info.l1Error);
    regInfo.errReg[RT_V200_L1_ERROR_T0_1] = static_cast<uint32_t>(info.l1Error >> REG_OFFSET);
    regInfo.errReg[RT_V200_SC_ERR_INFO_T0_0] = static_cast<uint32_t>(info.scErrInfo);
    regInfo.errReg[RT_V200_SC_ERR_INFO_T0_1] = static_cast<uint32_t>(info.scErrInfo >> REG_OFFSET);
}

static void AddExceptionRegInfo(const StarsDeviceErrorInfo * const starsInfo, const uint32_t coreIdx,
    const uint16_t type, const TaskInfo *errTaskPtr)
{
    COND_RETURN_NORMAL(type != AICORE_ERROR && type != AIVECTOR_ERROR, "the type[%hu] not match", type);
    COND_RETURN_VOID(errTaskPtr == nullptr || errTaskPtr->stream == nullptr ||
        errTaskPtr->stream->Device_() == nullptr, "cannot get the device by errTaskPtr");

    const DavidOneCoreErrorInfo& info = starsInfo->u.davidCoreErrorInfo.info[coreIdx];
    rtExceptionErrRegInfo_t regInfo = {};
    regInfo.coreId = static_cast<uint32_t>(info.coreId);
    regInfo.coreType = static_cast<rtCoreType_t>(type);
    regInfo.startPC = info.pcStart;
    regInfo.currentPC = info.currentPC;
    GetRegInfoErrReg(info, regInfo);

    Device *dev = errTaskPtr->stream->Device_();
    uint32_t taskSn = errTaskPtr->taskSn;
    uint32_t streamId = starsInfo->u.davidCoreErrorInfo.comm.streamId;
    RT_LOG(RT_LOG_ERROR, "add error register: core_id=%u, stream_id=%u, task_sn=%u", regInfo.coreId, streamId, taskSn);
    std::pair<uint32_t, uint32_t> key = {streamId, taskSn};
    auto& exceptionRegMap = dev->GetExceptionRegMap();
    std::lock_guard<std::mutex> lock(dev->GetExceptionRegMutex());
    exceptionRegMap[key].push_back(regInfo);
}

rtError_t ProcessDavidStarsCoreErrorInfo(const StarsDeviceErrorInfo * const info,
    const uint64_t errorNumber, const Device * const dev, const DeviceErrorProc * const insPtr)
{
    UNUSED(insPtr);
    ProcessCoreErrorClass(dev, info);
    const uint16_t type = info->u.davidCoreErrorInfo.comm.type;

    TaskInfo *errTaskPtr = GetTaskInfo(dev, static_cast<uint32_t>(info->u.davidCoreErrorInfo.comm.streamId),
        static_cast<uint32_t>(info->u.davidCoreErrorInfo.comm.taskId), true);

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
        AddExceptionRegInfo(info, coreIdx, type, errTaskPtr);
        /* logs for aic tools, do not modify the item befor making a new agreement with tools */
        RT_LOG_CALL_MSG(ERR_MODULE_TBE,
            "The error from device(chipId:%u, dieId:%u), serial number is %" PRIu64 ", "
            "there is an %s exception, core id is %" PRIu64 ", "
            "error code = %s, dump info: "
            "pc start: %#" PRIx64 ", current: %#" PRIx64 ", "
            "sc error info: %#" PRIx64 ", su error info: %#" PRIx64 ",%#" PRIx64 ", "
            "mte error info: %#" PRIx64 ", vec error info: %#" PRIx64 ", "
            "cube error info: %#" PRIx64 ", l1 error info: %#" PRIx64 ", "
            "aic error mask: %#" PRIx64 ", para base: %#" PRIx64 ", mte error: %#" PRIx64 ".",
            info->u.davidCoreErrorInfo.comm.chipId, info->u.davidCoreErrorInfo.comm.dieId, errorNumber,
            GetStarsRingBufferHeadMsg(info->u.davidCoreErrorInfo.comm.type).c_str(),
            info->u.davidCoreErrorInfo.info[coreIdx].coreId, errorCode.c_str(),
            info->u.davidCoreErrorInfo.info[coreIdx].pcStart, info->u.davidCoreErrorInfo.info[coreIdx].currentPC,
            info->u.davidCoreErrorInfo.info[coreIdx].scErrInfo, info->u.davidCoreErrorInfo.info[coreIdx].suErrInfo[0],
            info->u.davidCoreErrorInfo.info[coreIdx].suErrInfo[1],
            info->u.davidCoreErrorInfo.info[coreIdx].mteErrInfo[0], info->u.davidCoreErrorInfo.info[coreIdx].vecErrInfo[0],
            info->u.davidCoreErrorInfo.info[coreIdx].cubeErrInfo, info->u.davidCoreErrorInfo.info[coreIdx].l1ErrInfo,
            info->u.davidCoreErrorInfo.info[coreIdx].aicErrorMask, info->u.davidCoreErrorInfo.info[coreIdx].paraBase,
            info->u.davidCoreErrorInfo.info[coreIdx].mteError[0]);
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
            SetTaskMteErrByType(SDMA_ERROR, dev, errTaskPtr);
            RT_LOG(RT_LOG_ERROR, "Get sdma mte error, stream_id=%hu, task_id=%hu, errorCode=%#hx.",
                info->u.coreErrorInfo.comm.streamId, info->u.coreErrorInfo.comm.taskId,
                (errTaskPtr == nullptr) ? static_cast<uint16_t>(TS_ERROR_RESERVED) : errTaskPtr->mte_error);
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
        static_cast<uint32_t>(info->u.sdmaErrorInfo.comm.taskId), true);
    if (errTaskPtr != nullptr) {
        errTaskPtr->isRingbufferGet = true;
    }
    const uint32_t coreNum = static_cast<uint32_t>(info->u.sdmaErrorInfo.comm.coreNum);
    RecordSdmaErrorInfo(dev, coreNum, errTaskPtr, info, errorNumber);
    return RT_ERROR_NONE;
}

static void CheckAixErrorClassInFusionKernel(const StarsDeviceErrorInfo *errInfo, const StarsDeviceErrorInfo * const info,
    const Device * const dev, TaskInfo *errTaskPtr)
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

void GetExceptionArgsForFusionKernelTask(const TaskInfo * const taskInfo, rtExceptionArgsInfo_t * const argsInfo)
{
    (void)memset_s(argsInfo, sizeof(rtExceptionArgsInfo_t), 0U, sizeof(rtExceptionArgsInfo_t));
    const FusionTaskInfo * const fusionKernelTask = &(taskInfo->u.fusionKernelTask);

    Kernel *kernel = fusionKernelTask->aicPart.kernel;
    GetKernelExceptionDfxInfo(kernel, &(fusionKernelTask->aicPart.inputArgsSize), fusionKernelTask->args,
        fusionKernelTask->argsSize, argsInfo);
    return;
}

static void LogFusionKernelErrorInfo(const StarsDeviceErrorInfo * const info, uint64_t errorNumber)
{
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
}

rtError_t ProcessDavidStarsFusionKernelErrorInfo(const StarsDeviceErrorInfo * const info,
    const uint64_t errorNumber, const Device * const dev, const DeviceErrorProc * const insPtr)
{
    if (info == nullptr) {
        return RT_ERROR_NONE;
    }

    TaskInfo *errTaskPtr = GetTaskInfo(dev, static_cast<uint32_t>(info->u.fusionKernelErrorInfo.comm.streamId),
        static_cast<uint32_t>(info->u.fusionKernelErrorInfo.comm.taskId), true);
    if (errTaskPtr != nullptr) {
        errTaskPtr->isRingbufferGet = true;
    }

    LogFusionKernelErrorInfo(info, errorNumber);

    rtExceptionArgsInfo_t kernelInfo = {};
    rtBinHandle binHandle = nullptr;
    
    if (errTaskPtr != nullptr && errTaskPtr->type == TS_TASK_TYPE_FUSION_KERNEL) { 
        GetExceptionArgsForFusionKernelTask(errTaskPtr, &kernelInfo);
        binHandle = kernelInfo.exceptionKernelInfo.bin;
    }

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
        TriggerMemoryCorruptionCheck(nullptr, dev, dev->Id_(), binHandle, &kernelInfo);
        CheckAixErrorClassInFusionKernel(errInfo, info, RtPtrToUnConstPtr<Device *>(dev), errTaskPtr);
        (void)ProcessDavidStarsCoreErrorInfo(errInfo, errorNumber, dev, insPtr);
    }
    if (info->u.fusionKernelErrorInfo.aivError == 1U) {
        errInfo = RtPtrToPtr<const StarsDeviceErrorInfo *>(&(info->u.fusionKernelErrorInfo.aivInfo));
        TriggerMemoryCorruptionCheck(nullptr, dev, dev->Id_(), binHandle, &kernelInfo);
        CheckAixErrorClassInFusionKernel(errInfo, info, RtPtrToUnConstPtr<Device *>(dev), errTaskPtr);
        (void)ProcessDavidStarsCoreErrorInfo(errInfo, errorNumber, dev, insPtr);
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

    TaskInfo *errTaskPtr = GetTaskInfo(dev, info->u.timeoutErrorInfo.streamId, info->u.timeoutErrorInfo.taskId, true);
    if (errTaskPtr != nullptr) {
        errTaskPtr->isRingbufferGet = true;
    }

    const uint8_t type = info->u.timeoutErrorInfo.waitType;
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

rtError_t ProcessStarsV2CoreTimeoutDfxInfo(const StarsDeviceErrorInfo *const info,
    const uint64_t errorNumber, const Device *const dev, const DeviceErrorProc *const insPtr)
{
    UNUSED(insPtr);
    if ((info == nullptr) || (dev == nullptr)) {
        RT_LOG(RT_LOG_ERROR, "input param info or dev is null.");
        return RT_ERROR_NONE;
    }
    StarsErrorCommonInfo common = info->u.starsV2CoreTimeoutDfxInfo.comm;
    const uint32_t devId = dev->Id_();
    const uint16_t streamId = common.streamId;
    const uint16_t taskId = common.taskId;
    RT_LOG(RT_LOG_ERROR,
        "kernel task timeout due to no available cores, device_id=%u, stream_id=%hu, task_id=%hu, "
        "serial number is %" PRIu64 ", non-idle core_num=%hu.",
        devId, streamId, taskId, errorNumber, common.coreNum);

    TaskInfo *errTaskPtr = GetTaskInfo(dev, static_cast<uint32_t>(streamId), static_cast<uint32_t>(taskId), true);
    if (errTaskPtr != nullptr) {
        errTaskPtr->isRingbufferGet = true;
    }

    if (!(RtPtrToUnConstPtr<Device *>(dev))->CheckFeatureSupport(TS_FEATURE_AICORE_TIMEOUT_DFX)) {
        RT_LOG(RT_LOG_WARNING, "feature not support because tsch version too low.");
        return RT_ERROR_NONE;
    }
    if (common.coreNum > (RT_STARS_V2_AICORE_NUM + RT_STARS_V2_AIVECTOR_NUM)) {
        RT_LOG(RT_LOG_ERROR, "invalid coreNum: %u.", common.coreNum);
        return RT_ERROR_NONE;
    }
    // only print the core info where subError!=0(current_pc0==current_pc1)
    for (uint16_t coreIdx = 0U; coreIdx < common.coreNum; coreIdx++) {
        StarsV2OneCoreTimeoutDfxInfo coreInfo = info->u.starsV2CoreTimeoutDfxInfo.coreInfo[coreIdx];
        if (coreInfo.subError != 0U) {
            RT_LOG(RT_LOG_ERROR,
                "aicore task timeout dfx, show core info where subError!=0(core is currently stuck), "
                "device_id=%u, core_id=%hu, core_type=%hu(%s), stream_id=%hu, sq_head=%hu, task_sn=%u, "
                "sub_error=%hu, current_pc=%#" PRIx64 ".",
                devId, coreInfo.coreId, coreInfo.coreType, ((coreInfo.coreType == 0) ? "AIC" : "AIV"),
                coreInfo.streamId, coreInfo.sqHead, coreInfo.taskSn, coreInfo.subError, coreInfo.currentPc);
        }
    }
    return RT_ERROR_NONE;
}

rtError_t ProcRingBufferTaskDavid(const Device *const dev, const void * const devMem, const bool delFlag,
    const uint32_t len)
{
    TaskInfo *tsk = nullptr;
    Stream *stm = dev->GetCtrlSQStream(dev->PrimaryStream_());
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
    return stm->Synchronize();
}

}  // namespace runtime
}  // namespace cce
