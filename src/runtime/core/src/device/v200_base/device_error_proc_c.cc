/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <array>
#include <unordered_map>
#include "device_error_proc_c.hpp"
#include "error_message_manage.hpp"
#include "task_david.hpp"
#include "task_recycle.hpp"
#include "runtime_task_manager.h"
#include "stream.hpp"
#include "task_fail_callback_manager.hpp"
#include "ringbuffer_maintain_task.h"
#include "profiler_c.hpp"
#include "acc_error_info.h"
#include "error_code.h"

namespace cce {
namespace runtime {

namespace {
constexpr uint32_t TS_SDMA_STATUS_DDRC_ERROR = 0x8U;
constexpr uint32_t TS_SDMA_STATUS_LINK_ERROR = 0x9U;
constexpr uint32_t TS_SDMA_STATUS_POISON_ERROR = 0xAU;
} // namespace

enum RtAixSubErrorType : std::uint8_t {
    AIC_TRAP_RD_OVERFLOW = 0, /* aicore trap read out of bounds */
    AIC_TRAP_WR_OVERFLOW,     /* aicore trap write out of bounds */
    AIV_TRAP_RD_OVERFLOW,     /* vector core trap read out of bounds */
    AIV_TRAP_WR_OVERFLOW,     /* vector core trap write out of bounds */
    SUB_ERROR_TYPE_RESERVE    /* NA */
};

static const std::unordered_map<uint64_t, std::string> g_davidErrorMapInfo = {
    // RINGBUFFER_CUBE_ERROR_0_OFFSET
    {CUBE_ERR_L0A_RDWR_CFLT, "Software's L0A Ping/Pong memory allocation scheme has problem."},
    {CUBE_ERR_L0B_RDWR_CFLT, "Software's L0B Ping/Pong memory allocation scheme has problem."},
    {CUBE_ERR_L0C_RDWR_CFLT, "Software's L0C Ping/Pong memory allocation scheme has problem."},
    {CUBE_INVLD_INPUT, "the data read back from L0a and L0b are INF or NAN."},
    {CUBE_L0A_WRAP_AROUND, "The address for CUBE to operate L0A is out of bounds."},
    {CUBE_L0B_WRAP_AROUND, "The address for CUBE to operate L0B is out of bounds."},
    {CUBE_L0C_WRAP_AROUND, "The address for CUBE to operate L0C is out of bounds."},
    {CUBE_L0A_ECC, "A multi-bit ECC error occurs when CUBE reads L0A. See the RAS alarm handling."},
    {CUBE_L0B_ECC, "A multi-bit ECC error occurs when CUBE reads L0B. See the RAS alarm handling."},
    {CUBE_L0C_ECC, "A multi-bit ECC error occurs when CUBE reads L0C. See the RAS alarm handling."},
    {CUBE_ILLEGAL_INSTR, "The CUBE instruction is abnormal. "
                         "Possible cause: The parameter violates the instruction constraints, the binary version does "
                         "not match, or the instruction is overwritten"},
    {CUBE_ERR_HSET_CNT_OVF, "An overflow error occurs in the CUBE HSET counter."},
    {CUBE_ERR_HSET_CNT_UNF, "An underflow error occurs in the CUBE HSET counter."},
    {CUBE_ERR_PBUF_WRAP_AROUND, "The address for CUBE to operate FIXP buffer is out of bounds."},
    {CUBE_ERR_PARITY_ERR, "Parity error for the Cube parity ERR register."},
    {CUBE_ERR_SF_ECC_MB_ERR, "A multi-bit ECC error occurs when CUBE reads MX buffer. See the RAS alarm handling."},
    {CUBE_ERR_L0ASF_WRAP_AROUND, "CUBE L0A memory read write conflict."},
    {CUBE_ERR_L0BSF_WRAP_AROUND, "CUBE L0B memory read write conflict."},
    // CUBE_ERROR_T0_1
    {CUBE_INSTR_UNDEF, "The operation code is illegal."},
    {CUBE_INSTR_ILL_CFG, "The instruction configuration of CUBE is illegal."},
    {CUBE_INSTR_ADDR_MISALIGN, "The CUBE instruction address misalign."},
    {CUBE_FM_ADDR_OVERFLOW, "Feature map(conv/wino) of left matrix(matmul) exceeds L1."},
    {CUBE_NONBRANCH_BIAS_OVERFLOW, "Non-brc bias addr exceeds L1."},
    {CUBE_ELW_ADDR_OVERFLOW, "Elw addr exceeds L1."},
    {CUBE_KERNEL_ADDR_OVERFLOW, "Kernel(conv/wino) or right matrix(matmul) exceeds L1."},
    {CUBE_FB_ADDR_OVERFLOW, "Fixp parameter buffer addr exceeds 6k."},
    {CUBE_BT_ADDR_OVERFLOW, "Bias table addr exceeds L1."},
    {CUBE_RESULT_ADDR_OVERFLOW, "Cube result addr exceeds L1."},

    // RINGBUFFER_MTE_ERROR_OFFSET
    {MTE_NDDMA_CACHE_ECC, "A multi-bit ECC error occurs when MTE reads NDDMA cache. See the RAS alarm handling."},
    {MTE_NDDMA_REG_BUF_ECC,
     "A multi-bit ECC error occurs when MTE reads NDDMA request buffer. See the RAS alarm handling."},
    {MTE_L1_ECC, "A multi-bit ECC error occurs when MTE2 and MTE3 read L1. See the RAS alarm handling."},
    {MTE_CFG_REG_PARITY, "A parity error occurs when AICore reads the CFG register. See the RAS alarm handling"},
    {MTE_L0A_RDWR_CFLT, "CUBE L0A memory read write conflict."},
    {MTE_L0B_RDWR_CFLT, "CUBE L0B memory read write conflict."},
    {MTE_OFFSET_MISALIGN, "MTE gather/scatter dma instruction offset misalign."},
    {MTE_XGAMMA_LINE_SEQ_WRON,
     "In the xgamma operation, the first line is not loaded before computation begins;"
     "moreover, there is no end-of-line marker to signal the completion of the current image before proceeding to"
     " the next image."},
    {MTE_READ_OVERFLOW, "The address of the MTE 2D instruction to read L1 is out of bounds."},
    {MTE_WRITE_OVERFLOW, "The address of the MTE 2D instruction to write L1/L0A/L0B is out of bounds."},
    {MTE_BIF_CFG_REG_PARITY, "BIF configuration parity error."},
    {MTE_INSTR_ILLEGAL_CFG, "The MTE instruction is abnormal. "
                            "Possible cause: The parameter violates the instruction constraints, the binary version "
                            "does not match, or the instruction is overwritten"},
    {MTE_ATM_ADD_ADDR_MISALIGN, "The MTE atomic instruction address is not aligned."},
    {MTE_INSTR_ADDR_MISALIGN, "The MTE non-atomic instruction address is not aligned."},
    {MTE_GDMA_READ_OVERFLOW, "The address for MTE2 to read UB and MTE3 to read L1/UB is out of bounds."},
    {MTE_GDMA_WRITE_OVERFLOW, "The address for MTE2 to write UB and MTE3 to write L1/UB is out of bounds."},
    {MTE_GDMA_ILLEGAL_BURST_NUM, "The burst number value of the MOV instruction is abnormal."},
    {MTE_GDMA_ILLEGAL_BURST_LEN, "The burst length value of the MOV instruction is abnormal."},
    {MTE_AIPP_ILLEGAL_PARAM, "AIPP decompression instruction configuration error."},
    {MTE_ERR_UNZIP, "UNZIP decompression instruction configuration error."},
    {MTE_XGAMMA_LB0_ECC, "MTE XGAMMA LB0 multi-bit ECC error."},
    {MTE_XGAMMA_LB1_ECC, "MTE XGAMMA LB1 multi-bit ECC error."},
    {MTE_ERR_WAIPP, "WAIPP instruction configuration error."},
    {MTE_STB_ECC, "A multi-bit ECC error occurs when MTE reads STB buffer. See the RAS alarm handling."},
    {MTE_AIPP_ECC, "MTE AIPP multi-bit ECC error."},
    {MTE_TAGMGR_BUF_ECC, "A multi-bit ECC error occurs when MTE reads tagmgr buffer. See the RAS alarm handling."},
    {MTE_UB_ECC, "A multi-bit ECC error occurs when MTE reads UB. See the RAS alarm handling."},
    {MTE_ROB_ECC, "A multi-bit ECC error occurs when MTE reads ROB buffer. See the RAS alarm handling."},
    {MTE_BIU_RDWR_RESP,
     "The MTE instruction accesses an invalid GM address or the cross-device memory access timeout."},

    // RINGBUFFER_L1_ERROR_OFFSET
    {L1_L0A_RDWR_CFLT, "The address for MTE to write L0A conflicts with that for CUBE to read L0A."},
    {L1_L0B_RDWR_CFLT, "The address for MTE to write L0B conflicts with that for CUBE to read L0B."},
    {L1_READ_2D_OVERFLOW, "The address of the LOAD2D instruction to read L1 is out of bounds."},
    {L1_WRITE_2D_OVERFLOW, "The address of the LOAD2D instruction to write L0A/L0B is out of bounds."},
    {L1_DWS_PAD_CONF_ERR, "DEPTHWISE PADDING illegal configuration."},
    {L1_DWS_FMAP_H_ILLEGAL, "DEPTHWISE FMAP illegal configuration."},
    {L1_WINO_L0B_WRITE_OVERFLOW, "WINOB write overflow."},
    {L1_WINO_L0B_READ_OVERFLOW, "WINOB read overflow."},
    {L1_WINO_L0A_WRITE_OVERFLOW, "WINOA write overflow."},
    {L1_WINO_L0A_READ_OVERFLOW, "WINOA read overflow."},
    {L1_WINO_ILLEGAL_V_COV_PAD_CTL, "WINO V padding value is invalid."},
    {L1_WINO_ILLEGAL_H_COV_PAD_CTL, "WINO H padding value is invalid."},
    {L1_ILLEGAL_W_SIZE, "WINOA FMAP width + PADDING value is less than 4."},
    {L1_ILLEGAL_H_SIZE, "WINOA FMAP height + PADDING value is less than 4."},
    {L1_ILLEGAL_CHN_SIZE, "The value of L1H*L1W*channel size of the LOAD3DV2 instruction is greater "
                          "than the size of L1, or the channel size is not aligned."},
    {L1_ILLEGAL_K_M_EXT_STEP,
     "The k start pos + k step or m start pos + m step of the LOAD3D instruction "
     "exceeds the range of the km matrix (the tail is considered as 16 if it is less than 16), "
     "or the fractal number calculated by step exceeds the range of L0A/L0B."},
    {L1_ILLEGAL_K_M_START_POS, "The km start pos of the LOAD3D instruction is out of the range of the KM matrix, "
                               "the k start pos is not an integral multiple of the number of 32-byte data elements "
                               "corresponding to the data type, "
                               "or the m start pos is not an integral multiple of 16."},
    {L1_ILLEGAL_SCHN_CFG, "Small channel mode configuration error."},
    {L1_ILLEGAL_SMALLK_CFG, "LOAD3D small k configuration error."},
    {L1_ILLEGAL_FM_SIZE, "The width or height of the feature map of the LOAD3D instruction is greater than 0X8000, "
                         "or the area of the feature map is greater than the size of the L1 memory."},
    {L1_ILLEGAL_L1_3D_SIZE, "LOAD3DV2 L1 3D size is invalid."},
    {L1_ILLEGAL_STRIDE, "The stride_w or stride_h of the LOAD3D instruction is 0."},
    {L1_PADDING_CFG, "The padding configuration of the LOAD3D instruction is invalid."},
    {L1_READ_3D_OVERFLOW, "The address for the LOAD3D instruction to read L1 is out of bounds."},
    {L1_WRITE_3D_OVERFLOW, "The address for the LOAD3D instruction to write L0A/L0B is out of bounds."},
    {L1_BAS_RADDR_OBOUND, "The initial address specified for the LOAD3D instruction is out of the L1 3D size range."},
    {L1_F1WPOS_LARGER_FSIZE, "The position of the first window of LOAD3D exceeds the left or upper padding boundary, "
                             "or exceeds the right or lower padding boundary of the feature map(without padding)."},
    {L1_FMAP_LESS_KERNEL, "The width of the LOAD3D filter is greater than the width of the "
                          "feature map plus padding. or the height of the filter after dilation is greater "
                          "than the height of the feature map plus padding."},
    {L1_FMAPWH_LARGER_L1SIZE, "The LOAD3D parameter is invalid. L1H*L1W*(C1+1) is greater than L1 buffer size/32."},
    {L1_FPOS_LARGER_FSIZE, "The LOAD3D K position is out of the filter range."},

    // RINGBUFFER_L1_ERROR_1_OFFSET
    {L1_ERR_FIFO_PARITY, "L1/FIXP fifo parity."},
    {FIXP_BIU_RDWR_RESP, "The address for fixpipe to write GM is invalid"},
    {FIXP_STB_ECC_ERR, "A multi-bit ECC error occurs when fixpipe reads STB buffer. See the RAS alarm handling"},
    {FIXP_FBUF_WR_OVERFLOW, "The address for fixpipe to write FBUF is out of bounds."},
    {FIXP_FBUF_RD_OVERFLOW, "The address for fixpipe to read FBUF is out of bounds."},
    {FIXP_OUT_WR_OVERFLOW, "An overflow error occurs when the FIXP write."},
    {FIXP_L1_WR_OVERFLOW, "The address for fixpipe to write L1 is out of bounds."},
    {FIXP_L1_RD_OVERFLOW, "The address for fixpipe to read L1 is out of bounds."},
    {FIXP_L0C_RD_OVERFLOW, "The address for fixpipe to read L0C is out of bounds."},
    {FIXP_ILLEGAL_CFG, "The fixpipe instruction parameter is invalid."},
    {FIXP_ADDR_MISAL, "The address for fixpipe to read L0C, read/write L1, and read/write FBUF is not aligned."},
    {FIXP_L0C_ECC_ERR, "A multi-bit ECC error occurs when fixpipe reads L0C. See the RAS alarm handling."},
    {FIXP_L0C_RDWR_CFLT, "The address for fixpipe to read L0C conflicts with that for CUBE to write L0C."},
    {FIXP_WRITE_UB_OVFLW, "The address for fixpipe to write UB is out of bounds."},
    {L1_UB_WR_OVFLW, "The address for MTE to move from L1 to UB is out of bounds."},
    {L1_WAITSET_ERR, "The configuration of HWATI/HSET is invalid."},
    {L1_L1_ECC, "A multi-bit ECC error occurs when MTE/fixpipe reads L1. See the RAS alarm handling."},
    {L1_GDMA_READ_OVERFLOW, "The address for the MTE instruction to read L1 is out of bounds."},
    {L1_GDMA_WRITE_OVERFLOW, "The address for the MTE instruction to write the L0A/L0B bias table is out of bounds."},
    {L1_INSTR_ILLEGAL_CFG, "The MTE instruction is abnormal. Possible cause: "
                           "The parameter violates the instruction constraints, the binary version does not match, or "
                           "the instruction is overwritten."},
    {L1_INSTR_ADDR_MISALIGN, "The MTE instruction address is not aligned."},
    {L1_SC_CFG_PARITY, "L1 SC configuration registers parity error."},
    {L1_FIXP_BT_NAN_INF, "MTE1 biasbuf path conversion NaN/Inf error."},

    // RINGBUFFER_SU_ERROR_OFFSET
    {SU_IFU_BUS_ERR_T0,
     "The address of instruction is illegal when the AIcore reads instructions from GM."
     "Possible cause: The application unloads the operator binary in advance or stack corruption occurs."},
    {SU_CCU_CALL_DEPTH_OVRFLW_T0, "The number of nesting times of call the function is greater than CTRL[5:2]."},
    {SU_CCU_DIV0_T0, "divide by 0."},
    {SU_CCU_ILLEGAL_INSTR_T0, "The scalar instruction is abnormal. Possible cause: "
                              "The parameter violates the instruction constraints, the binary version does not match, "
                              "or the instruction is overwritten."},
    {SU_CCU_NEG_SQRT_T0, "The number of roots is negative. "},
    {SU_CCU_UB_ECC_T0, "A multi-bit ECC error occurs when scalar accesses UB. See the RAS alarm handling."},
    {SU_CCU_INF_NAN_T0, "The input of the floating-point instruction run by the CCU is nan/inf."},
    {SU_CCU_ADDR_ERR_T0,
     "The address for scalar to use is unaligned or out of bounds "
     "The GM address exceeds 48 bits, or the on-chip buffer address exceeds the size of the buffer."},
    {SU_CCU_BUS_ERR_T0, "The address for scalar to access GM is invalid"},
    {SU_CCU_DC_DATA_ECC_T0,
     "A multi-bit ECC error occurs when scalar accesses dcache data. See the RAS alarm handling."},
    {SU_CCU_DC_TAG_ECC_T0, "A multi-bit ECC error occurs when scalar accesses dcache tag. See the RAS alarm handling."},
    {SU_CCU_DIV0_FP_T0, "An error occurs in the FP32 DIV0."},
    {SU_CCU_NEG_SQRT_FP_T0, "The input of the FP SQRT calculation unit is a negative number."},
    {SU_CCU_ERR_PARITY_ERR_T0, "A parity error occurs when SU reads FIFO. See the RAS alarm handling."},
    {SU_CCU_SEQ_ERR_T0, "The SEQ command sequence is incorrect."},
    {SU_CCU_MPU_ERR_T0, "The address for scalar to access the internal buffer is out of bounds."},
    {SU_CCU_LSU_ERR_T0, "When the buffer is enabled, the stack access instruction cache is miss."},
    {SU_CCU_PB_ECC_ERR_T0,
     "A multi-bit ECC error occurs when scalar reads parameter buffer. See the RAS alarm handling."},
    {SU_CCU_SAFETY_CRC_ERR_T0, "MTE CRC error."},
    {SU_CCU_LSU_ATOMIC_ERR_T0, "The scalar atomic instruction accesses the GM that is modified by scalar "
                               "but is not written back."},
    {SU_CCU_CC_SET_OVFL_ERR_T0, "The accumulated value of the inter-core communication flag counter "
                                "exceeds the maximum value 15."},
    {SU_SAFETY_1BIT_ECC_OVFLW_ERR_T0, "Overflow error when the number of 1-bit ECC errors exceeds the preset value."},
    {SU_CCU_DC_SSBUF_ECC_T0, "A multi-bit ECC error occurs when scalar reads SS buffer. See the RAS alarm handling."},
    {SU_IFU_BUS_PTY_ERR, "The parity code attached to the read data returned from BIF to IFU is inconsistent with the"
                         " parity code calculated by IFU, triggering a parity check error."},
    {SU_BMU_ERR, "An exception occurred in the buf_allocate or buf_free instructions related to BMU."},
    {SU_HSCB_BUS_ERR, "SU initiates access to the HSCB path, and the HSCB bus returns an error response."},
    {SU_GET_NEXT_TASK_ERR, "In a task program, there is an extra get_ntxt_task_hscb instruction."},
    {SU_HIT_TRAP_ERR_T0, "The trap instruction reports an error."},
    {WARN_AS_EXCEPTION_T0,
     "A 1-bit ECC err occurs 15 times or a multi-hit event occurs in IFU during AICore execution. "
     "See the RAS alarm handling."},

    // SC_ERROR_T0_0
    {SC_CNT_SW_BUS_ERR, "During a slow context switch, SC encounters a bus error while transferring data."},
    {SC_REG_PARITY_ERR, "A parity error occurred in the CFG register inside SC."},
    {SC_SLOW_CSW_ROB_ECC_ERR, "During a slow CSW in SC, the ROB RAM from the SU's IFU is reused for reading,"
                              "resulting in 2 2-bit ECC error."},
    {SC_BUS_RESP_TIMEOUT_ERR, "The bus is busy, and the response times out."},

    // SU_ERROR_T0_1
    {SU_IC_ECC_REPEAT_ERR, "ECC errors frequently occur at the same address within the same bank of the IC,"
                           " and the count reaches 0xFF, triggering an exception."},
    {SU_IC_ECC_OTHER_ERR, "Subsequent ECC errors occur at a different bank and address compared to the first ECC error,"
                          " and the count reaches 0xFF, triggering an exception."},
    {SU_DC_ECC_REPEAT_ERR, "For the DC, frequent ECC errors occur at the same bank and address,"
                           " and the count reaches 0xFF, triggering an exception."},
    {SU_DC_ECC_OTHER_ERR, "For the DC, subsequent ECC errors occur at a bank and address different from the first ECC"
                          " error, and the count reaches 0xFF, triggering an exception."},

    // RINGBUFFER_VEC_ERROR_OFFSET
    {VEC_ERR_UB_ARB_DATA_EXCP_MTE_T0, "Data from the MTE is abnormal."},
    {VEC_ERR_UB_ARB_DATA_EXCP_SU_T0, "Data from the CCU is abnormal."},
    {VEC_ERR_UB_ARB_DATA_EXCP_VEC_T0, "Data from the VEC is abnormal."},
    {VEC_ERR_INSTR_TIMEOUT_T0, "VEC VF execution timeout. Check the configuration of Runtime"},
    {VEC_ERR_SU_PLD_UNDEF_T0, "The non-VF instruction is abnormal. Possible cause: "
                              "The parameter violates the instruction constraints, the binary version does not match, "
                              "or the instruction is overwritten."},
    {VEC_ERR_SU_PLD_ILL_CFG_T0, "The parameter of the non-VF instruction is invalid."},
    {VEC_ERR_PC_OVERFLOW_T0,
     "PC is greater than 48 bits. Possible cause: the compiler bug or the instruction is overwritten."},
    {VEC_ERR_INSTR_UNDEF_T0, "The instruction in VEC VF is abnormal. Possible cause: "
                             "The parameter violates the instruction constraints, the binary version does not match, "
                             "or the instruction is overwritten."},
    {VEC_INSTR_ILLEGAL_CFG_T0, "The parameter of the VEC VF instruction is invalid."},
    {VEC_ERR_HWLP_STACK_OVFL_T0, "The number of nested VLOOP exceeds the hardware limit, which may be a compiler bug."},
    {VEC_ERR_HWLP_INSTR_NUM_MISMATCH_T0, "For the nested VLOOP, the number of instructions in the inner loop "
                                         "is greater than that in the outer loop, which may be a compiler bug."},
    {VEC_ERR_BIU_RESP_ERR_T0, "SIMT accesses an invalid GM address or the cross-device memory access times out."},
    {VEC_ERR_PB_ECC_MBERR_T0,
     "A multi-bit ECC error occurs when VEC accesses parameter buffer. See the RAS alarm handling."},
    {VEC_ERR_IDATA_INF_NAN_T0, "The input data of the instruction operation is INF/NAN."},
    {VEC_ERR_DIV_BY_ZERO_T0, "Divide-by-zero error occurs for the VEC instruction."},
    {VEC_ERR_VALU_NEG_LN_T0, "The input data of the VALU ln operation is a negative number."},
    {VEC_ERR_VALU_NEG_SQRT_T0, "The input data of the VALU sqrt operation is a negative number."},
    {VEC_ERR_UB_ADDR_OVERFLOW_T0, "The address for VEC to access UB is not aligned."},
    {VEC_UB_WRAP_AROUND, "The address for VEC to access UB is out of bounds."},
    {VEC_ERR_UB_ECC_MBERR_T0, "A multi-bit ECC error occurs when VEC accesses UB. See the RAS alarm handling."},
    {VEC_ERR_VMS_UNSORT_T0, "The input data of the sorting instruction is not correctly sorted."},
    {VEC_ERR_CSW_DATA_T0, "Exception when accessing the internal SRAM during context switch (multi-bit ECC)."},
    {VEC_ERR_SC_CFG_PARITY_T0, "SC Interface configuration register parity check error occurred."},
    {VEC_ERR_UB_SB_ECC_REPEAT_ERR_T0, "The number of single-bit ECC errors at the same address on UB has exceeded"
                                      " the hard failure threshold."},
    {VEC_ERR_UB_SB_ECC_OTHER_ERR_T0, "The number of single-bit ECC errors at different addresses on UB has"
                                     " exceeded the hard failure threshold."},
    {VEC_ERR_IC_ECC_REPEAT_ERR_T0, "The number of single-bit ECC errors at the same address on ICACHE has"
                                   " exceeded the hard failure threshold."},
    {VEC_ERR_IC_ECC_OTHER_ERR_T0, "The number of single-bit ECC errors at different addresses on ICACHE has"
                                  " exceeded the hard failure threshold."},
    // RINGBUFFER_VEC_ERROR_1_OFFSET
    {VEC_ERR_UNEXP_JOIN_T0,
     "When the VEC executes a SIMT task, some warps end with \"join\" and some warps end with \"end\"."},
    {VEC_ERR_UB_SIZE_CFG_ERR_T0, "The dyn ubuf size is greater than 224 KB."},
    {VEC_ERR_DC_STACK_ADDR_OVFL_T0, "The VEC SIMT stack overflows. Possible cause: "
                                    "The local variable is too large or there are too many local variables."},
    {VEC_ERR_GM_ADDR_OVFL_T0, "The address for VEC to read GM is out of bounds(exceeding 48 bits)."},
    {VEC_ERR_DVG_STACK_OVFL_T0, "VEC SIMT DVG stack overflows, which may be caused by too many conditional branches "
                                "or too many nested loops."},
    {VEC_ERR_DVG_STACK_UNDFL_T0, "VEC SIMT push and pop operations do not match, which may be a compiler bug."},
    {VEC_ERR_BHU_ECC_MBERR_T0, "A multi-bit ECC error occurs when VEC SIMT accesses BHU. See the RAS alarm handling."},
    {VEC_ERR_MROB_ECC_MBERR_T0,
     "A multi-bit ECC error occurs when VEC SIMT accesses MROB. See the RAS alarm handling."},
    {VEC_ERR_DCACHE_TAG_MBERR_T0,
     "A multi-bit ECC error occurs when VEC SIMT accesses dcache tag. See the RAS alarm handling."},
    {VEC_ERR_DIRTY_ECC_MBERR_T0,
     "A multi-bit ECC error occurs when VEC SIMT accesses the dirty mem. See the RAS alarm handling."},
    {VEC_ERR_VTH_ID_ECC_MBERR_T0,
     "A multi-bit ECC error occurs when VEC SIMT accesses thread ID register. See the RAS alarm handling."},
    {VEC_ERR_MRF_ECC_MBERR_T0,
     "A multi-bit ECC error occurs when VEC SIMT accesses register table. See the RAS alarm handling."},
    {VEC_ERR_DVG_ECC_MBERR_T0,
     "A multi-bit ECC error occurs when VEC SIMT accesses DVG stack. See the RAS alarm handling."},
};

const std::unordered_map<uint64_t, std::string>* GetDavidErrorMapInfo() { return &g_davidErrorMapInfo; }

uint32_t GetRingbufferElementNum() { return RINGBUFFER_LEN_DAVID; }

static const DavidErrorBitMask* g_davidErrorBitMaskByChip[CHIP_END] = {};

void RegDavidErrorBitMask(rtChipType_t chipType, const DavidErrorBitMask* mask)
{
    if (chipType < CHIP_BEGIN || chipType >= CHIP_END) {
        RT_LOG(RT_LOG_ERROR, "Invalid chipType = %d, valid range: [%d, %d).", chipType, CHIP_BEGIN, CHIP_END);
        return;
    }
    g_davidErrorBitMaskByChip[chipType] = mask;
}

const DavidErrorBitMask* GetDavidErrorBitMask(rtChipType_t chipType)
{
    if (chipType < CHIP_BEGIN || chipType >= CHIP_END) {
        RT_LOG(RT_LOG_ERROR, "Invalid chipType = %d, valid range: [%d, %d).", chipType, CHIP_BEGIN, CHIP_END);
        return nullptr;
    }
    return g_davidErrorBitMaskByChip[chipType];
}

static void ProcessDavidStarsCoreErrorOneMapInfo(
    const std::unordered_map<uint64_t, std::string>& errorMap, uint32_t* const cnt, uint64_t err,
    std::string& errorString, std::string& errorCode, uint32_t offset)
{
    if (err == 0ULL) {
        return;
    }

    RT_LOG(RT_LOG_DEBUG, "core errorCode:%" PRIx64, err);
    for (uint32_t i = static_cast<uint32_t>(BitScan(err)); i < MAX_BIT_LEN; i = static_cast<uint32_t>(BitScan(err))) {
        BITMAP_CLR(err, static_cast<uint64_t>(i));
        const auto it = errorMap.find((i + offset));
        if (it != errorMap.end()) {
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

void ProcessDavidStarsCoreErrorMapInfo(
    const DavidOneCoreErrorInfo* const info, std::string& errorString, std::string& errorCode, rtChipType_t chipType)
{
    const auto* errorMap = GetDavidErrorMapInfo();
    const auto* bitMask = GetDavidErrorBitMask(chipType);
    // bitMask == nullptr means no filtering (all bits valid)
    const uint64_t cubeMask = (bitMask != nullptr) ? bitMask->cubeMask : ~0ULL;
    const uint64_t mteMask = (bitMask != nullptr) ? bitMask->mteMask : ~0ULL;
    const uint64_t l1Mask = (bitMask != nullptr) ? bitMask->l1Mask : ~0ULL;
    const uint64_t scMask = (bitMask != nullptr) ? bitMask->scMask : ~0ULL;
    const uint64_t suMask = (bitMask != nullptr) ? bitMask->suMask : ~0ULL;
    const uint64_t vecMask = (bitMask != nullptr) ? bitMask->vecMask : ~0ULL;

    uint32_t cnt = 0U;
    ProcessDavidStarsCoreErrorOneMapInfo(
        *errorMap, &cnt, info->scError & scMask, errorString, errorCode, RINGBUFFER_SC_ERROR_OFFSET);
    ProcessDavidStarsCoreErrorOneMapInfo(
        *errorMap, &cnt, info->suError & suMask, errorString, errorCode,
        static_cast<uint32_t>(RINGBUFFER_SU_ERROR_OFFSET));
    ProcessDavidStarsCoreErrorOneMapInfo(
        *errorMap, &cnt, info->mteError[0] & mteMask, errorString, errorCode, RINGBUFFER_MTE_ERROR_OFFSET);
    ProcessDavidStarsCoreErrorOneMapInfo(
        *errorMap, &cnt, info->vecError & vecMask, errorString, errorCode,
        static_cast<uint32_t>(RINGBUFFER_VEC_ERROR_OFFSET));
    ProcessDavidStarsCoreErrorOneMapInfo(
        *errorMap, &cnt, info->cubeError & cubeMask, errorString, errorCode, RINGBUFFER_CUBE_ERROR_OFFSET);
    ProcessDavidStarsCoreErrorOneMapInfo(
        *errorMap, &cnt, info->l1Error & l1Mask, errorString, errorCode,
        static_cast<uint32_t>(RINGBUFFER_L1_ERROR_OFFSET));

    if (cnt != 0U) { // at least one error bit exists.
        return;
    }

    errorString = "timeout or trap error.";
    errorCode = "0";
    return;
}

static void AiCoreUnknownErrProc(const Device* const dev, const StarsDeviceErrorInfo* const info)
{
    (RtPtrToUnConstPtr<Device*>(dev))->SetDeviceFaultType(DeviceFaultType::AICORE_UNKNOWN_ERROR);
    RT_LOG(
        RT_LOG_ERROR, "unknown aicore error, stream_id=%hu, task_id=%hu.", info->u.coreErrorInfo.comm.streamId,
        info->u.coreErrorInfo.comm.taskId);
}

static void AixLinkErrProc(const Device* const dev, const StarsDeviceErrorInfo* const info, TaskInfo* errTaskPtr)
{
    std::this_thread::sleep_for(std::chrono::milliseconds(RAS_QUERY_INTERVAL * RAS_QUERY_MAX_COUNT));

    std::vector<rtDmsFaultEvent> faultEventInfo(RAS_GET_MAX_NUM, rtDmsFaultEvent{});
    uint32_t eventCount = 0U;
    const rtError_t error = GetDeviceFaultEvents(dev->Id_(), &faultEventInfo[0U], eventCount);
    if (error != RT_ERROR_NONE) {
        AiCoreUnknownErrProc(dev, info);
        return;
    }

    if (IsFaultEventOccur(UB_REMOTE_MEM_TIMEOUT_EVENT_ID, &faultEventInfo[0U], eventCount) &&
        !IsHitBlacklist(&faultEventInfo[0U], eventCount, g_ccuTimeoutEventIdBlkList)) {
        if (errTaskPtr != nullptr) {
            errTaskPtr->mte_error = TS_ERROR_LINK_ERROR;
        }
        RT_LOG(
            RT_LOG_ERROR, "network link error, stream_id=%hu, task_id=%hu, errorCode=%#hx.",
            info->u.coreErrorInfo.comm.streamId, info->u.coreErrorInfo.comm.taskId,
            (errTaskPtr == nullptr) ? static_cast<uint16_t>(TS_ERROR_RESERVED) : errTaskPtr->mte_error);
        (RtPtrToUnConstPtr<Device*>(dev))->SetDeviceFaultType(DeviceFaultType::LINK_ERROR);
        return;
    }
    AiCoreUnknownErrProc(dev, info);
}

static void GetMteDeviceFaultEvent(const Device* const dev, uint32_t& faultEventId)
{
    std::vector<rtDmsFaultEvent> faultEventInfo(RAS_GET_MAX_NUM, rtDmsFaultEvent{});
    uint32_t eventCount = 0U;
    const rtError_t error = GetDeviceFaultEvents(dev->Id_(), &faultEventInfo[0U], eventCount);
    if (error != RT_ERROR_NONE) {
        return;
    }

    static const EventBlkEntry eventId2BlkList[] = {
        {L2_BUFFER_ECC_EVENT_ID, g_l2MulBitEccEventIdBlkList},
        {HBM_ECC_NOTIFY_EVENT_ID, g_aicOrSdmaOrHcclLocalMulBitEccEventIdBlkList},
        {HBM_ECC_EVENT_ID, g_aicOrSdmaOrHcclLocalMulBitEccEventIdBlkList},
        {UB_REMOTE_MEM_DATA_EXCEPTION_EVENT_ID, g_hcclRemoteMulBitEccEventIdBlkList}};
    for (const auto& entry : eventId2BlkList) {
        if (IsFaultEventOccur(entry.eventId, &faultEventInfo[0U], eventCount) &&
            !IsHitBlacklist(&faultEventInfo[0U], eventCount, entry.blkList)) {
            faultEventId = entry.eventId;
            return;
        }
    }
}

static void SetTaskMteErrByType(const rtErrorType errType, const Device* const dev, TaskInfo* errTaskPtr)
{
    if (errTaskPtr == nullptr) {
        return;
    }

    if (errType == AICORE_ERROR) {
        (RtPtrToUnConstPtr<Device*>(dev))->SetDeviceFaultType(DeviceFaultType::AICORE_UNKNOWN_ERROR);
    }

    const bool hasHbmEccNotify = HasMteErr(dev);
    uint32_t faultEventId = 0U;
    GetMteDeviceFaultEvent(dev, faultEventId);
    const bool hasL2BuffEcc = (faultEventId == L2_BUFFER_ECC_EVENT_ID);
    const bool hasHbmEcc =
        hasHbmEccNotify && ((faultEventId == HBM_ECC_NOTIFY_EVENT_ID) || (faultEventId == HBM_ECC_EVENT_ID));
    const bool hasRemoteErr = (faultEventId == UB_REMOTE_MEM_DATA_EXCEPTION_EVENT_ID);
    RT_LOG(
        RT_LOG_ERROR, "has_hbm_ecc_notify_event=%d, event_id=%#x, device_id=%u", hasHbmEccNotify, faultEventId,
        dev->Id_());

    const uint16_t local_error = (errType == AICORE_ERROR) ? TS_ERROR_AICORE_MTE_ERROR : TS_ERROR_SDMA_POISON_ERROR;
    if (hasL2BuffEcc) {
        errTaskPtr->mte_error = local_error;
        (RtPtrToUnConstPtr<Device*>(dev))->SetDeviceFaultType(DeviceFaultType::L2_BUFFER_ERROR);
        return;
    }
    if (hasHbmEcc) {
        errTaskPtr->mte_error = local_error;
        (RtPtrToUnConstPtr<Device*>(dev))->SetDeviceFaultType(DeviceFaultType::HBM_UCE_ERROR);
        return;
    }
    if ((errType == AICORE_ERROR) && hasRemoteErr) {
        errTaskPtr->mte_error = TS_ERROR_REMOTE_MEM_ERROR;
        (RtPtrToUnConstPtr<Device*>(dev))->SetDeviceFaultType(DeviceFaultType::LINK_ERROR);
        return;
    }
    errTaskPtr->mte_error = TS_SUCCESS;
}

static void SetDeviceFaultTypeByAixErrClass(
    const Device* const dev, const StarsDeviceErrorInfo* const info, TaskInfo* errTaskPtr)
{
    switch (static_cast<AixErrClass>(info->u.coreErrorInfo.comm.flag)) {
        case AixErrClass::AIX_MTE_POISON_ERROR:
            SetTaskMteErrByType(AICORE_ERROR, dev, errTaskPtr);
            RT_LOG(
                RT_LOG_ERROR, "mte error, stream_id=%hu, task_id=%hu, errorCode=%#hx.",
                info->u.coreErrorInfo.comm.streamId, info->u.coreErrorInfo.comm.taskId,
                (errTaskPtr == nullptr) ? static_cast<uint16_t>(TS_ERROR_RESERVED) : errTaskPtr->mte_error);
            break;
        case AixErrClass::AIX_HW_L_ERROR:
            if (!HasBlacklistEventOnDevice(dev->Id_(), g_mulBitEccEventIdBlkList)) {
                (RtPtrToUnConstPtr<Device*>(dev))->SetDeviceFaultType(DeviceFaultType::AICORE_HW_L_ERROR);
                RT_LOG(
                    RT_LOG_ERROR, "hardware local error, stream_id=%hu, task_id=%hu, errorCode=%#x.",
                    info->u.coreErrorInfo.comm.streamId, info->u.coreErrorInfo.comm.taskId,
                    static_cast<uint32_t>(RT_ERROR_DEVICE_AICORE_ERROR_HW_L));
            } else {
                AiCoreUnknownErrProc(dev, info);
            }
            break;
        case AixErrClass::AIX_S_ERROR:
            if (!HasBlacklistEventOnDevice(dev->Id_(), g_mulBitEccEventIdBlkList)) {
                (RtPtrToUnConstPtr<Device*>(dev))->SetDeviceFaultType(DeviceFaultType::AICORE_SW_ERROR);
                RT_LOG(
                    RT_LOG_ERROR, "software error, stream_id=%hu, task_id=%hu.", info->u.coreErrorInfo.comm.streamId,
                    info->u.coreErrorInfo.comm.taskId);
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

void ProcessCoreErrorClass(const Device* const dev, const StarsDeviceErrorInfo* const info)
{
    TaskInfo* errTaskPtr = GetTaskInfo(
        dev, static_cast<uint32_t>(info->u.davidCoreErrorInfo.comm.streamId),
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

static void GetRegInfoErrReg(const DavidOneCoreErrorInfo& info, rtExceptionErrRegInfo_t& regInfo)
{
    constexpr uint8_t REG_OFFSET = 32;
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
    regInfo.errReg[RT_V200_SU_SPR_CONDITION_0] = static_cast<uint32_t>(info.aicCond);
    regInfo.errReg[RT_V200_SU_SPR_CONDITION_1] = static_cast<uint32_t>(info.aicCond >> REG_OFFSET);
}

void AddExceptionRegInfo(
    const StarsDeviceErrorInfo* const starsInfo, const uint32_t coreIdx, const uint16_t type,
    const TaskInfo* errTaskPtr)
{
    COND_RETURN_NORMAL(type != AICORE_ERROR && type != AIVECTOR_ERROR, "the type[%hu] not match", type);
    COND_RETURN_VOID(
        errTaskPtr == nullptr || errTaskPtr->stream == nullptr || errTaskPtr->stream->Device_() == nullptr,
        "Cannot get the device by errTaskPtr");

    const DavidOneCoreErrorInfo& info = starsInfo->u.davidCoreErrorInfo.info[coreIdx];
    rtExceptionErrRegInfo_t regInfo = {};
    regInfo.coreId = static_cast<uint32_t>(info.coreId);
    regInfo.coreType = static_cast<rtCoreType_t>(type);
    regInfo.startPC = info.pcStart;
    regInfo.currentPC = info.currentPC;
    GetRegInfoErrReg(info, regInfo);

    Device* dev = errTaskPtr->stream->Device_();
    uint32_t taskSn = errTaskPtr->taskSn;
    uint32_t streamId = starsInfo->u.davidCoreErrorInfo.comm.streamId;
    RT_LOG(RT_LOG_ERROR, "add error register: core_id=%u, stream_id=%u, task_sn=%u", regInfo.coreId, streamId, taskSn);
    std::pair<uint32_t, uint32_t> key = {streamId, taskSn};
    auto& exceptionRegMap = dev->GetExceptionRegMap();
    std::lock_guard<std::mutex> lock(dev->GetExceptionRegMutex());
    exceptionRegMap[key].push_back(regInfo);
}

// 查询 RAS 故障事件并格式化描述，用于 EZ2001 上报
static std::string QueryAndFormatRasFaultDavid(
    const Device* const dev, const int64_t deviceTime, const AixErrClass aixErrClass)
{
    const bool needReportUserErrcode =
        (aixErrClass == AixErrClass::AIX_MTE_POISON_ERROR || aixErrClass == AixErrClass::AIX_HW_L_ERROR ||
         aixErrClass == AixErrClass::AIX_LINK_ERROR);
    if (!needReportUserErrcode || (deviceTime <= 0)) {
        return "";
    }
    const uint64_t deviceTimeMs = static_cast<uint64_t>(deviceTime);
    const uint64_t rasWindowMs = static_cast<uint64_t>(GetMteErrWaitCount()) * RAS_QUERY_INTERVAL;
    RasEventMatch rasMatch;
    if (aixErrClass == AixErrClass::AIX_HW_L_ERROR) {
        // ProcessCoreErrorClass函数的AixErrClass::AIX_HW_L_ERROR分支中没有做任何轮询查询事件的动作，
        // QueryRasFaultEvents函数中需要轮询500ms，等待事件发生，QueryRasFaultEvents的windowAfterMs直接传rasWindowMs
        rasMatch = QueryRasFaultEvents(dev, deviceTimeMs, rasWindowMs);
    } else {
        // AixErrClass::AIX_MTE_POISON_ERROR 和 AixErrClass::AIX_LINK_ERROR分支已经等待过事件发生了，有两种场景
        // 1、等足了500ms，没有查到事件，此处不应该再去轮询查事件了，而是直接只查一次，以这次的查询结果为准
        // 2、没有等够500ms事件就发生了，函数提前返回，此处立即去查询告警，一定能查到
        // 无论那种情况，此处都不应该再去轮询查事件了，QueryRasFaultEvents的windowAfterMs直接传0
        rasMatch = QueryRasFaultEvents(dev, deviceTimeMs, 0U);
    }
    if (!rasMatch.found) {
        return "";
    }
    RT_LOG(
        RT_LOG_ERROR, "RAS event detail: device_id=%u, event_id=%#x, event_name=\"%s\", additional_info=\"%s\".",
        dev->Id_(), rasMatch.eventId, rasMatch.eventName.c_str(), rasMatch.additionalInfo.c_str());
    return FormatRasFaultDesc(rasMatch.eventId, rasMatch.eventName);
}

// 格式化 David 核心 error 信息到 aicoreBuffer，并根据 RAS 命中情况走 EZ2001 或 EZ9999 路径
static void PrintDavidCoreInfo(
    const StarsDeviceErrorInfo* const info, const uint32_t coreIdx, const uint64_t errorNumber,
    const std::string& errorString, const std::string& errorCode, const std::string& rasFaultDesc)
{
    constexpr size_t AICORE_BUF_LEN = 4096U;
    std::array<char, AICORE_BUF_LEN> aicoreBuffer{};
    /* logs for aic tools, do not modify the item befor making a new agreement with tools */
    (void)snprintf_truncated_s(
        aicoreBuffer.data(), AICORE_BUF_LEN,
        "An error occurs on the device(chipId:%u, dieId:%u), the serial number is %" PRIu64 ", "
        "the error is %s, core id is %" PRIu64 ", "
        "error code = %s, dump info: "
        "pc start: %#" PRIx64 ", current: %#" PRIx64 ", "
        "sc error info: %#" PRIx64 ", su error info: %#" PRIx64 ",%#" PRIx64 ", "
        "mte error info: %#" PRIx64 ", vec error info: %#" PRIx64 ", "
        "cube error info: %#" PRIx64 ", l1 error info: %#" PRIx64 ", "
        "aic error mask: %#" PRIx64 ", para base: %#" PRIx64 ", mte error: %#" PRIx64 ", "
        "aic cond: %#" PRIx64 ".\n"
        "The extend info: errcode:(%s) errorStr: %s subErrType: %#x.",
        info->u.davidCoreErrorInfo.comm.chipId, info->u.davidCoreErrorInfo.comm.dieId, errorNumber,
        GetStarsRingBufferHeadMsg(info->u.davidCoreErrorInfo.comm.type).c_str(),
        info->u.davidCoreErrorInfo.info[coreIdx].coreId, errorCode.c_str(),
        info->u.davidCoreErrorInfo.info[coreIdx].pcStart, info->u.davidCoreErrorInfo.info[coreIdx].currentPC,
        info->u.davidCoreErrorInfo.info[coreIdx].scErrInfo, info->u.davidCoreErrorInfo.info[coreIdx].suErrInfo[0],
        info->u.davidCoreErrorInfo.info[coreIdx].suErrInfo[1], info->u.davidCoreErrorInfo.info[coreIdx].mteErrInfo[0],
        info->u.davidCoreErrorInfo.info[coreIdx].vecErrInfo[0], info->u.davidCoreErrorInfo.info[coreIdx].cubeErrInfo,
        info->u.davidCoreErrorInfo.info[coreIdx].l1ErrInfo, info->u.davidCoreErrorInfo.info[coreIdx].aicErrorMask,
        info->u.davidCoreErrorInfo.info[coreIdx].paraBase, info->u.davidCoreErrorInfo.info[coreIdx].mteError[0],
        info->u.davidCoreErrorInfo.info[coreIdx].aicCond, errorCode.c_str(), errorString.c_str(),
        info->u.davidCoreErrorInfo.info[coreIdx].subErrType);
    if (!rasFaultDesc.empty()) {
        RT_LOG_OUTER_MSG_IMPL(ErrorCode::EZ2001, aicoreBuffer.data(), "RAS", rasFaultDesc);
    } else {
        RT_LOG_CALL_MSG(
            ERR_MODULE_TBE,
            "%s\nFor details, see the troubleshooting document on the Ascend official website. Search for the "
            "keyword \"AI Core Error\".",
            aicoreBuffer.data());
    }
}

rtError_t ProcessDavidStarsCoreErrorInfo(
    const StarsDeviceErrorInfo* const info, const uint64_t errorNumber, const Device* const dev,
    const DeviceErrorProc* const insPtr)
{
    UNUSED(insPtr);
    const int64_t deviceTime = dev->GetDeviceCurrentTime();
    ProcessCoreErrorClass(dev, info);
    const uint16_t type = info->u.davidCoreErrorInfo.comm.type;

    TaskInfo* errTaskPtr = GetTaskInfo(
        dev, static_cast<uint32_t>(info->u.davidCoreErrorInfo.comm.streamId),
        static_cast<uint32_t>(info->u.davidCoreErrorInfo.comm.taskId), true);

    const auto aixErrClass = static_cast<AixErrClass>(info->u.coreErrorInfo.comm.flag);
    std::string rasFaultDesc = QueryAndFormatRasFaultDavid(dev, deviceTime, aixErrClass);

    for (uint32_t coreIdx = 0U; coreIdx < static_cast<uint32_t>(info->u.davidCoreErrorInfo.comm.coreNum); coreIdx++) {
        if ((errTaskPtr != nullptr) && (errTaskPtr->u.aicTaskInfo.kernel == nullptr)) {
            AicTaskInfo* aicTask = &errTaskPtr->u.aicTaskInfo;
            RT_LOG(
                RT_LOG_ERROR, "stream_id=%u, task_id=%u not with kernel info, tilingKey=0x%llx.",
                info->u.davidCoreErrorInfo.comm.streamId, info->u.davidCoreErrorInfo.comm.taskId, aicTask->tilingKey);
            if (aicTask->progHandle != nullptr) {
                aicTask->kernel =
                    aicTask->progHandle->SearchKernelByPcAddr(info->u.davidCoreErrorInfo.info[coreIdx].pcStart);
            }
        }

        std::string errorString;
        std::string errorCode;
        ProcessDavidStarsCoreErrorMapInfo(
            &(info->u.davidCoreErrorInfo.info[coreIdx]), errorString, errorCode, dev->GetChipType());
        AddExceptionRegInfo(info, coreIdx, type, errTaskPtr);
        PrintDavidCoreInfo(info, coreIdx, errorNumber, errorString, errorCode, rasFaultDesc);
    }
    return RT_ERROR_NONE;
}

static void RecordSdmaErrorInfo(
    const Device* const dev, uint32_t coreNum, TaskInfo* errTaskPtr, const StarsDeviceErrorInfo* const info,
    const uint64_t errorNumber)
{
    for (uint32_t coreIdx = 0U; coreIdx < coreNum; coreIdx++) {
        RT_LOG_CALL_MSG(
            ERR_MODULE_GE,
            "The error from device(chipId:%u, dieId:%u), "
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
            RT_LOG(
                RT_LOG_ERROR, "Get sdma mte error, stream_id=%hu, task_id=%hu, errorCode=%#hx.",
                info->u.coreErrorInfo.comm.streamId, info->u.coreErrorInfo.comm.taskId,
                (errTaskPtr == nullptr) ? static_cast<uint16_t>(TS_ERROR_RESERVED) : errTaskPtr->mte_error);
        }
    }
}

rtError_t ProcessStarsSdmaErrorInfo(
    const StarsDeviceErrorInfo* const info, const uint64_t errorNumber, const Device* const dev,
    const DeviceErrorProc* const insPtr)
{
    UNUSED(insPtr);
    RUNTIME_NULL_NO_PROC_WITH_RET(info);
    RUNTIME_NULL_NO_PROC_WITH_RET(dev);
    TaskInfo* errTaskPtr = GetTaskInfo(
        dev, static_cast<uint32_t>(info->u.sdmaErrorInfo.comm.streamId),
        static_cast<uint32_t>(info->u.sdmaErrorInfo.comm.taskId), true);
    if (errTaskPtr != nullptr) {
        errTaskPtr->isRingbufferGet = true;
    }
    const uint32_t coreNum = static_cast<uint32_t>(info->u.sdmaErrorInfo.comm.coreNum);
    RecordSdmaErrorInfo(dev, coreNum, errTaskPtr, info, errorNumber);
    return RT_ERROR_NONE;
}

void CheckAixErrorClassInFusionKernel(
    const StarsDeviceErrorInfo* errInfo, const StarsDeviceErrorInfo* const info, const Device* const dev,
    TaskInfo* errTaskPtr)
{
    if ((info == nullptr) || (errInfo == nullptr)) {
        return;
    }

    RT_LOG(RT_LOG_ERROR, "comm_flag=%hhu", errInfo->u.coreErrorInfo.comm.flag);

    if ((info->u.fusionKernelErrorInfo.cqeStatus & FUSION_CQE_STATUS_ERROR_MASK) != FUSION_CQE_STATUS_ONLY_AIX_ERROR) {
        RT_LOG(
            RT_LOG_INFO, "Fusion task not only happens aicore exception, cqeStatus=0x%x.",
            info->u.fusionKernelErrorInfo.cqeStatus);
        return;
    }

    SetDeviceFaultTypeByAixErrClass(dev, errInfo, errTaskPtr);
}

void GetExceptionArgsForFusionKernelTask(const TaskInfo* const taskInfo, rtExceptionArgsInfo_t* const argsInfo)
{
    (void)memset_s(argsInfo, sizeof(rtExceptionArgsInfo_t), 0U, sizeof(rtExceptionArgsInfo_t));
    const FusionTaskInfo* const fusionKernelTask = &(taskInfo->u.fusionKernelTask);

    Kernel* kernel = fusionKernelTask->aicPart.kernel;
    GetKernelExceptionDfxInfo(
        kernel, &(fusionKernelTask->aicPart.inputArgsSize), fusionKernelTask->args, fusionKernelTask->argsSize,
        argsInfo);
    return;
}

void LogFusionKernelErrorInfo(const StarsDeviceErrorInfo* const info, uint64_t errorNumber)
{
    RT_LOG_CALL_MSG(
        ERR_MODULE_TBE,
        "The error from device(chipId=%u, dieId=%u), serial number is %" PRIu64 ", "
        "exception occurred during fusion kernel task execution, streamId=%u, taskId=%u, subtasks' subType=%hu, "
        "sqeLength=%hu, cqeStatus=%u.",
        info->u.fusionKernelErrorInfo.comm.chipId, info->u.fusionKernelErrorInfo.comm.dieId, errorNumber,
        info->u.fusionKernelErrorInfo.comm.streamId, info->u.fusionKernelErrorInfo.comm.taskId,
        info->u.fusionKernelErrorInfo.subType, info->u.fusionKernelErrorInfo.sqeLength,
        info->u.fusionKernelErrorInfo.cqeStatus);

    const uint32_t* const cmd =
        RtPtrToPtr<const uint32_t*, const rtDavidSqe_t*>(info->u.fusionKernelErrorInfo.davidSqe);
    const size_t size = sizeof(rtDavidSqe_t) * (info->u.fusionKernelErrorInfo.sqeLength + 1U);
    for (uint32_t i = 0U; i < (size / sizeof(uint32_t)); i += 8U) {
        RT_LOG(
            RT_LOG_ERROR, "printSqe: %08x %08x %08x %08x %08x %08x %08x %08x", cmd[i], cmd[i + 1U], cmd[i + 2U],
            cmd[i + 3U], cmd[i + 4U], cmd[i + 5U], cmd[i + 6U], cmd[i + 7U]);
    }

    RT_LOG(
        RT_LOG_ERROR,
        "structSize=%u, aicError=%u, aivError=%u, aicpuError=%u, ccuError=%u."
        "(just used to check if need process sub task's ringbuffer or not)",
        sizeof(StarsFusionKernelErrorInfo), info->u.fusionKernelErrorInfo.aicError,
        info->u.fusionKernelErrorInfo.aivError, info->u.fusionKernelErrorInfo.aicpuError,
        info->u.fusionKernelErrorInfo.ccuError);
}

rtError_t ProcessFusionKernelErrorCommon(
    const StarsDeviceErrorInfo* const info, const uint64_t errorNumber, const Device* const dev,
    const DeviceErrorProc* const insPtr, DeviceErrorProc::StarsErrorInfoProc coreErrorProc)
{
    if (info == nullptr) {
        return RT_ERROR_NONE;
    }

    TaskInfo* errTaskPtr = GetTaskInfo(
        dev, static_cast<uint32_t>(info->u.fusionKernelErrorInfo.comm.streamId),
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
    const StarsDeviceErrorInfo* errInfo = nullptr;
    if (info->u.fusionKernelErrorInfo.aicpuError == 1U) {
        errInfo = RtPtrToPtr<const StarsDeviceErrorInfo*>(&(info->u.fusionKernelErrorInfo.u.aicpuInfo));
        (void)ProcessStarsAicpuErrorInfo(errInfo, errorNumber, dev, insPtr);
    } else if (info->u.fusionKernelErrorInfo.ccuError == 1U) {
        errInfo = RtPtrToPtr<const StarsDeviceErrorInfo*>(&(info->u.fusionKernelErrorInfo.u.ccuInfo));
        (void)ProcessDavidStarsCcuErrorInfo(errInfo, errorNumber, dev, insPtr);
    } else {
        // 分别处理aicpuerror和ccuerror，其他情况不处理
    }

    if (info->u.fusionKernelErrorInfo.aicError == 1U) {
        errInfo = RtPtrToPtr<const StarsDeviceErrorInfo*>(&(info->u.fusionKernelErrorInfo.aicInfo));
        TriggerMemoryCorruptionCheck(nullptr, dev, dev->Id_(), binHandle, &kernelInfo);
        CheckAixErrorClassInFusionKernel(errInfo, info, RtPtrToUnConstPtr<Device*>(dev), errTaskPtr);
        (void)coreErrorProc(errInfo, errorNumber, dev, insPtr);
    }
    if (info->u.fusionKernelErrorInfo.aivError == 1U) {
        errInfo = RtPtrToPtr<const StarsDeviceErrorInfo*>(&(info->u.fusionKernelErrorInfo.aivInfo));
        TriggerMemoryCorruptionCheck(nullptr, dev, dev->Id_(), binHandle, &kernelInfo);
        CheckAixErrorClassInFusionKernel(errInfo, info, RtPtrToUnConstPtr<Device*>(dev), errTaskPtr);
        (void)coreErrorProc(errInfo, errorNumber, dev, insPtr);
    }
    return RT_ERROR_NONE;
}

rtError_t ProcessDavidStarsFusionKernelErrorInfo(
    const StarsDeviceErrorInfo* const info, const uint64_t errorNumber, const Device* const dev,
    const DeviceErrorProc* const insPtr)
{
    return ProcessFusionKernelErrorCommon(info, errorNumber, dev, insPtr, &ProcessDavidStarsCoreErrorInfo);
}

rtError_t ProcessDavidStarsWaitTimeoutErrorInfo(
    const StarsDeviceErrorInfo* const info, const uint64_t errorNumber, const Device* const dev,
    const DeviceErrorProc* const insPtr)
{
    UNUSED(insPtr);
    if (info == nullptr) {
        return RT_ERROR_NONE;
    }

    TaskInfo* errTaskPtr = GetTaskInfo(dev, info->u.timeoutErrorInfo.streamId, info->u.timeoutErrorInfo.taskId, true);
    if (errTaskPtr != nullptr) {
        errTaskPtr->isRingbufferGet = true;
    }

    const uint8_t type = info->u.timeoutErrorInfo.waitType;
    if (type == RT_DAVID_SQE_TYPE_NOTIFY_WAIT) {
        RT_LOG_CALL_MSG(
            ERR_MODULE_SYSTEM,
            "The error from device(chipId:%u, dieId:%u), serial number is %" PRIu64 ", "
            "wait timeout occurred during task execution, stream_id:%hu, sq_id:%hu, task_pos:%hu, "
            "id=%u, timeout=%us, cntFlag = %u, subType = %u(%s), cntValue = %u, clrFlag = %u, waitMode = %u, "
            "bitmap = %u.",
            info->u.timeoutErrorInfo.chipId, info->u.timeoutErrorInfo.dieId, errorNumber,
            info->u.timeoutErrorInfo.streamId, info->u.timeoutErrorInfo.sqId, info->u.timeoutErrorInfo.taskId,
            info->u.timeoutErrorInfo.wait.errorInfo.notifyId, info->u.timeoutErrorInfo.wait.errorInfo.timeout,
            info->u.timeoutErrorInfo.wait.errorInfo.cntFlag, info->u.timeoutErrorInfo.wait.errorInfo.subType,
            GetNotifySubType(static_cast<uint16_t>(info->u.timeoutErrorInfo.wait.errorInfo.subType)),
            info->u.timeoutErrorInfo.wait.errorInfo.cntValue, info->u.timeoutErrorInfo.wait.errorInfo.clrFlag,
            info->u.timeoutErrorInfo.wait.errorInfo.waitMode, info->u.timeoutErrorInfo.wait.errorInfo.bitmap);
    }
    return RT_ERROR_NONE;
}

rtError_t ProcessStarsV2CoreTimeoutDfxInfo(
    const StarsDeviceErrorInfo* const info, const uint64_t errorNumber, const Device* const dev,
    const DeviceErrorProc* const insPtr)
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
    RT_LOG(
        RT_LOG_ERROR,
        "kernel task timeout due to no available cores, device_id=%u, stream_id=%hu, task_id=%hu, "
        "serial number is %" PRIu64 ", non-idle core_num=%hu.",
        devId, streamId, taskId, errorNumber, common.coreNum);

    TaskInfo* errTaskPtr = GetTaskInfo(dev, static_cast<uint32_t>(streamId), static_cast<uint32_t>(taskId), true);
    if (errTaskPtr != nullptr) {
        errTaskPtr->isRingbufferGet = true;
    }

    if (!(RtPtrToUnConstPtr<Device*>(dev))->CheckFeatureSupport(TS_FEATURE_AICORE_TIMEOUT_DFX)) {
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
            RT_LOG(
                RT_LOG_ERROR,
                "aicore task timeout dfx, show core info where subError!=0(core is currently stuck), "
                "device_id=%u, core_id=%hu, core_type=%hu(%s), stream_id=%hu, sq_head=%hu, task_sn=%u, "
                "sub_error=%hu, current_pc=%#" PRIx64 ".",
                devId, coreInfo.coreId, coreInfo.coreType, ((coreInfo.coreType == 0) ? "AIC" : "AIV"),
                coreInfo.streamId, coreInfo.sqHead, coreInfo.taskSn, coreInfo.subError, coreInfo.currentPc);
        }
    }
    return RT_ERROR_NONE;
}

rtError_t ProcRingBufferTaskDavid(
    const Device* const dev, const void* const devMem, const bool delFlag, const uint32_t len)
{
    TaskInfo* tsk = nullptr;
    Stream* stm = dev->GetCtrlSQStream(dev->PrimaryStream_());
    NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);
    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(
        error, "Failed to check stream, stream_id=%d, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));
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
    ERROR_RETURN_MSG_INNER(
        error, "Failed to init create ringbuffer task, stream_id=%d, retCode=%#x.", stm->Id_(),
        static_cast<uint32_t>(error));
    error = DavidSendTask(tsk, stm);
    ERROR_RETURN_MSG_INNER(
        error, "Failed to submit task, stream_id=%d, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    stm->StreamUnLock();
    return stm->Synchronize();
}

// david bit mask: hardcoded from original g_davidErrorMapInfo bit positions.
// low32 = T0_0 register, high32 = T0_1 register (0 if no T0_1).
static const DavidErrorBitMask g_davidErrorBitMask = {
    0x000000000001FFF0ULL, // cube: T0_0 bits 4-16, no T0_1
    0x00000000F407C60FULL, // mte:  T0_0 bits 0-3,9-10,14-18,26,28-31, no T0_1
    0x001FFFFE79E9C00FULL, // l1:   T0_0 bits 0-3,14-16,19,21-24,27-30; T0_1 bits 1-20
    0x0000000000000008ULL, // sc:   T0_0 bit 3, no T0_1
    0x00000000C07FFFFFULL, // su:   T0_0 bits 0-22,30-31, no T0_1
    0x00001FFF01FFFFC7ULL, // vec:  T0_0 bits 0-2,6-24; T0_1 bits 0-12
};

static bool RegisterDavidErrorMap()
{
    const auto& chips = GetDavidChips();
    for (const auto chip : chips) {
        if (chip != CHIP_CLOUD_V5) {
            RegDavidErrorBitMask(chip, &g_davidErrorBitMask);
        }
    }
    return true;
}

static bool g_registerDavidErrorMap = RegisterDavidErrorMap();

} // namespace runtime
} // namespace cce
