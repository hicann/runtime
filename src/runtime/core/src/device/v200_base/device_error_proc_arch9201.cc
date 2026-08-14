/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <sstream>
#include "device_error_proc.hpp"
#include "device_error_proc_c.hpp"
#include "runtime.hpp"
#include "context.hpp"
#include "ccu_task.hpp"
#include "task_recycle.hpp"
#include "task_fail_callback_manager.hpp"

namespace cce {
namespace runtime {
static const std::map<uint64_t, std::string> g_arch9201ErrorMapInfo = {
    // RINGBUFFER_CUBE_ERROR_0_OFFSET
    {CUBE_ERR_L0A_RDWR_CFLT, "Software's L0A Ping/Pong memory allocation scheme has problem."},
    {CUBE_ERR_L0B_RDWR_CFLT, "Software's L0B Ping/Pong memory allocation scheme has problem."},
    {CUBE_ERR_L0C_RDWR_CFLT, "Software's L0C Ping/Pong memory allocation scheme has problem."},
    {CUBE_INVLD_INPUT, "the data read back from L0a and L0b is INF or NAN."},
    {CUBE_L0A_WRAP_AROUND, "The address for CUBE to operate L0A is out of bounds."},
    {CUBE_L0B_WRAP_AROUND, "The address for CUBE to operate L0B is out of bounds."},
    {CUBE_L0C_WRAP_AROUND, "The address for CUBE to operate L0C is out of bounds."},
    {CUBE_L0A_ECC, "A multi-bit ECC error occurs when CUBE reads L0A. See the RAS alarm handling."},
    {CUBE_L0B_ECC, "A multi-bit ECC error occurs when CUBE reads L0B. See the RAS alarm handling."},
    {CUBE_L0C_ECC, "A multi-bit ECC error occurs when CUBE reads L0C. See the RAS alarm handling."},
    {CUBE_ILLEGAL_INSTR, "The CUBE instruction is abnormal. "
                         "Possible cause: The parameter violates the instruction constraints, the binary version does "
                         "not match, or the instruction is overwritten"},
    {CUBE_ERR_HSET_CNT_OVF, "A overflow error occurs in the CUBE HSET counter."},
    {CUBE_ERR_HSET_CNT_UNF, "A underflow error occurs in the CUBE HSET counter."},
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
    {CUBE_FB_ADDR_OVERFLOW, "Fixp parameter buffer addr exceed 6k."},
    {CUBE_BT_ADDR_OVERFLOW, "Bias table addr exceeds L1."},
    {CUBE_RESULT_ADDR_OVERFLOW, "Cube result addr exceeds L1."},

    // RINGBUFFER_MTE_ERROR_OFFSET
    {MTE_NDDMA_CACHE_ECC, "A multi-bit ECC error occurs when MTE reads NDDMA cache. See the RAS alarm handling."},
    {MTE_NDDMA_REG_BUF_ECC,
     "A multi-bit ECC error occurs when MTE reads NDDMA request buffer. See the RAS alarm handling."},
    {MTE_L1_ECC, "A multi-bit ECC error occurs when MTE2 and MTE3 reads L1. See the RAS alarm handling."},
    {MTE_CFG_REG_PARITY, "A parity error occurs when AICore reads the CFG register. See the RAS alarm handling"},
    {MTE_L0A_RDWR_CFLT, "CUBE L0A memory read write conflict."},
    {MTE_L0B_RDWR_CFLT, "CUBE L0B memory read write conflict."},
    {MTE_OFFSET_MISALIGN, "MTE gather/scatter dma instruction offset misalign."},
    {MTE_XGAMMA_LINE_SEQ_WRON,
     "In the xgama operation, the first line is not loaded before computation begins;"
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
    {FIXP_OUT_WR_OVERFLOW, "A overflow error occurs when the FIXP write."},
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
    {SU_CCU_ILLEGAL_INSTR_T0, "The scalar instruction is abnormal. Possible cause: "
                              "The parameter violates the instruction constraints, the binary version does not match, "
                              "or the instruction is overwritten."},
    {SU_CCU_UB_ECC_T0, "A multi-bit ECC error occurs when scalar accesses UB. See the RAS alarm handling."},
    {SU_CCU_ADDR_ERR_T0,
     "The address for scalar to use is unaligned or out of bounds "
     "The GM address exceeds 48 bits, or the on-chip buffer address exceeds the size of the buffer."},
    {SU_CCU_BUS_ERR_T0, "The address for scalar to access GM is invalid"},
    {SU_CCU_DC_DATA_ECC_T0,
     "A multi-bit ECC error occurs when scalar accesses dcache data. See the RAS alarm handling."},
    {SU_CCU_DC_TAG_ECC_T0, "A multi-bit ECC error occurs when scalar accesses dcache tag. See the RAS alarm handling."},
    {SU_CCU_ERR_PARITY_ERR_T0, "A parity error occurs when SU reads FIFO. See the RAS alarm handling."},
    {SU_CCU_MPU_ERR_T0, "The address for scalar to access the internal buffer is out of bounds."},
    {SU_CCU_PB_ECC_ERR_T0,
     "A multi-bit ECC error occurs when scalar reads parameter buffer. See the RAS alarm handling."},
    {SU_CCU_SAFETY_CRC_ERR_T0, "MTE CRC error."},
    {SU_CCU_CC_SET_OVFL_ERR_T0, "The accumulated value of the inter-core communication flag counter "
                                "exceeds the maximum value 15."},
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
    {VEC_ERR_UB_ADDR_OVERFLOW_T0, "The address for VEC to access UB is not aligned."},
    {VEC_UB_WRAP_AROUND, "The address for VEC to access UB is out of bounds."},
    {VEC_ERR_UB_ECC_MBERR_T0, "A multi-bit ECC error occurs when VEC accesses UB. See the RAS alarm handling."},
    {VEC_ERR_VMS_UNSORT_T0, "The input data of the sorting instruction is not correctly sorted."},
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

static bool RegisterArch9201ErrorMap()
{
    RegDavidErrorMapInfo(CHIP_CLOUD_V5, &g_arch9201ErrorMapInfo);
    return true;
}

static bool g_registerArch9201ErrorMap = RegisterArch9201ErrorMap();

static void PrintArch9201CoreErrInfo(
    const StarsDeviceErrorInfo* const info, const uint64_t errorNumber, const uint32_t coreIdx,
    const std::string& errorCode)
{
    const DavidOneCoreErrorInfo& coreErrInfo = info->u.davidCoreErrorInfo.info[coreIdx];
    std::ostringstream oss;
    oss << std::showbase << std::dec << "The error from device(chipId:" << info->u.davidCoreErrorInfo.comm.chipId
        << ", dieId:" << info->u.davidCoreErrorInfo.comm.dieId << "), serial number is " << errorNumber
        << ". There is an" << GetStarsRingBufferHeadMsg(info->u.davidCoreErrorInfo.comm.type).c_str()
        << " exception , core id is " << coreErrInfo.coreId << ", error code = " << errorCode.c_str()
        << ", dump info: pc start: " << std::hex << coreErrInfo.pcStart << ", current:" << coreErrInfo.currentPC
        << ", sc error info: " << coreErrInfo.scErrInfo << ", su error info: " << coreErrInfo.suErrInfo[0] << ","
        << coreErrInfo.suErrInfo[1] << "," << coreErrInfo.suErrInfo[2] << "," << coreErrInfo.suErrInfo[3]
        << ", mte error info: " << coreErrInfo.mteErrInfo[0] << ", vec error info: " << coreErrInfo.vecErrInfo[0]
        << ", cube error info: " << coreErrInfo.cubeErrInfo << ", l1 error info: " << coreErrInfo.l1ErrInfo
        << ", aic error mask: " << coreErrInfo.aicErrorMask << ", para base: " << coreErrInfo.paraBase
        << ", first pc start: " << coreErrInfo.ostTaskOneCore[0].pcStart << std::dec
        << ", first taskid: " << coreErrInfo.ostTaskOneCore[0].taskId
        << ", first streamid: " << coreErrInfo.ostTaskOneCore[0].streamId;
    if (coreErrInfo.ostTaskOneCore[1].pcStart != 0) {
        oss << std::showbase << std::hex << ", second pc start: " << coreErrInfo.ostTaskOneCore[1].pcStart << std::dec
            << ", second taskid: " << coreErrInfo.ostTaskOneCore[1].taskId
            << ", second streamid: " << coreErrInfo.ostTaskOneCore[1].streamId
            << ", isconcurrentexe:" << coreErrInfo.isConcurrentExe << ".";
    } else {
        oss << ".";
    }
    RT_LOG_CALL_MSG(ERR_MODULE_TBE, "%s", oss.str().c_str());
}

static rtFusionExType_t GetFusionTaskDetailType(uint8_t fusionSubType)
{
    const uint8_t fusionCcuBit = 0x18; // subType中b'11000(0x18)中的3/4bit表示fusion中有ccu任务
    rtFusionExType_t fusionDetailType;

    if ((fusionSubType & fusionCcuBit) != 0) {
        fusionDetailType = RT_FUSION_AICORE_CCU;
    } else {
        fusionDetailType = RT_FUSION_AICORE_AICPU;
    }
    return fusionDetailType;
}

static void DavidUpdateAicTaskKernel(
    TaskInfo* errTaskPtr, const DavidOneCoreErrorInfo* const info, const uint16_t streamId, const uint16_t taskId)
{
    if (errTaskPtr->u.aicTaskInfo.kernel == nullptr) {
        AicTaskInfo* aicTask = &errTaskPtr->u.aicTaskInfo;
        RT_LOG(
            RT_LOG_ERROR, "stream_id=%u, task_id=%u not with kernel info, tilingKey=0x%llx.", streamId, taskId,
            aicTask->tilingKey);
        if (aicTask->progHandle != nullptr) {
            aicTask->kernel = aicTask->progHandle->SearchKernelByPcAddr(info->pcStart);
        }
    }
}

static void DavidOstTaskFailCallBack(
    const Device* const dev, const TaskInfo* errTaskPtr, const uint16_t streamId, const uint16_t taskId)
{
    if (errTaskPtr->type == TS_TASK_TYPE_KERNEL_AIVEC) {
        TaskFailCallBack(
            streamId, taskId, errTaskPtr->tid, TS_ERROR_VECTOR_CORE_EXCEPTION, errTaskPtr->stream->Device_());
    } else if (errTaskPtr->type == TS_TASK_TYPE_KERNEL_AICORE) {
        TaskFailCallBack(streamId, taskId, errTaskPtr->tid, TS_ERROR_AICORE_EXCEPTION, errTaskPtr->stream->Device_());
    } else if (errTaskPtr->type == TS_TASK_TYPE_FUSION_KERNEL) {
        rtFusionExType_t fusionDetailType = GetFusionTaskDetailType(errTaskPtr->u.fusionKernelTask.sqeSubType);
        TaskFailCallBackForFusionKernelTask(errTaskPtr, dev->Id_(), nullptr, fusionDetailType);
    }
}

static void DavidOstTaskErrorProc(
    const Device* const dev, const DavidOneCoreErrorInfo* const info, std::unordered_set<uint32_t>* allSTaskId)
{
    for (uint32_t taskIdx = 0; taskIdx < MAX_TASK_NUM_ONE_CORE; taskIdx++) {
        /* pc start 为0表示该组信息无效 */
        if (info->ostTaskOneCore[taskIdx].pcStart == 0ULL) {
            continue;
        }
        const uint16_t streamId = info->ostTaskOneCore[taskIdx].streamId;
        const uint16_t taskId = info->ostTaskOneCore[taskIdx].taskId;
        const uint32_t formatSTaskId = ((streamId << 16) | taskId); // streamId和taskId组合成一个32位的值用于去重
        if (allSTaskId->find(formatSTaskId) != allSTaskId->end()) {
            continue;
        }
        allSTaskId->insert(formatSTaskId);

        TaskInfo* errTaskPtr = GetTaskInfo(dev, streamId, taskId);
        if (errTaskPtr == nullptr) {
            RT_LOG(
                RT_LOG_WARNING, "GetTask error, device_id=%u, stream_id=%u, task_id=%u.", dev->Id_(), streamId, taskId);
            continue;
        }

        DavidUpdateAicTaskKernel(errTaskPtr, info, streamId, taskId);
        DavidOstTaskFailCallBack(dev, errTaskPtr, streamId, taskId);
    }
}

static rtError_t ProcessArch9201StarsCoreErrorInfo(
    const StarsDeviceErrorInfo* const info, const uint64_t errorNumber, const Device* const dev,
    const DeviceErrorProc* const insPtr)
{
    UNUSED(insPtr);
    ProcessCoreErrorClass(dev, info);
    const uint16_t type = info->u.davidCoreErrorInfo.comm.type;

    TaskInfo* errTaskPtr = GetTaskInfo(
        dev, static_cast<uint32_t>(info->u.davidCoreErrorInfo.comm.streamId),
        static_cast<uint32_t>(info->u.davidCoreErrorInfo.comm.taskId), true);

    std::unordered_set<uint32_t> allSTaskId;
    for (uint32_t coreIdx = 0U; coreIdx < static_cast<uint32_t>(info->u.davidCoreErrorInfo.comm.coreNum); coreIdx++) {
        std::string errorString;
        std::string errorCode;
        ProcessDavidStarsCoreErrorMapInfo(
            &(info->u.davidCoreErrorInfo.info[coreIdx]), errorString, errorCode, dev->GetChipType());
        AddExceptionRegInfo(info, coreIdx, type, errTaskPtr);
        PrintArch9201CoreErrInfo(info, errorNumber, coreIdx, errorCode);
        DavidOstTaskErrorProc(dev, &(info->u.davidCoreErrorInfo.info[coreIdx]), &allSTaskId);
    }
    return RT_ERROR_NONE;
}

static rtError_t ProcessArch9201FusionKernelErrorInfo(
    const StarsDeviceErrorInfo* const info, const uint64_t errorNumber, const Device* const dev,
    const DeviceErrorProc* const insPtr)
{
    return ProcessFusionKernelErrorCommon(info, errorNumber, dev, insPtr, &ProcessArch9201StarsCoreErrorInfo);
}

static bool RegisterDavidErrorProcFunc()
{
    RegErrorProcFunc(CHIP_CLOUD_V5, AICORE_ERROR, &ProcessArch9201StarsCoreErrorInfo);
    RegErrorProcFunc(CHIP_CLOUD_V5, AIVECTOR_ERROR, &ProcessArch9201StarsCoreErrorInfo);
    RegErrorProcFunc(CHIP_CLOUD_V5, WAIT_TIMEOUT_ERROR, &ProcessDavidStarsWaitTimeoutErrorInfo);
    RegErrorProcFunc(CHIP_CLOUD_V5, SDMA_ERROR, &ProcessStarsSdmaErrorInfo);
    RegErrorProcFunc(CHIP_CLOUD_V5, AICPU_ERROR, &ProcessStarsAicpuErrorInfo);
    RegErrorProcFunc(CHIP_CLOUD_V5, DVPP_ERROR, &DeviceErrorProc::ProcessStarsDvppErrorInfo);
    RegErrorProcFunc(CHIP_CLOUD_V5, SQE_ERROR, &DeviceErrorProc::ProcessStarsSqeErrorInfo);
    RegErrorProcFunc(CHIP_CLOUD_V5, FUSION_KERNEL_ERROR, &ProcessArch9201FusionKernelErrorInfo);
    RegErrorProcFunc(CHIP_CLOUD_V5, CCU_ERROR, &ProcessDavidStarsCcuErrorInfo);
    RegErrorProcFunc(CHIP_CLOUD_V5, AICORE_TIMEOUT_DFX, &ProcessStarsV2CoreTimeoutDfxInfo);
    return true;
}

static bool g_registerDavidErrorProc = RegisterDavidErrorProcFunc();
} // namespace runtime
} // namespace cce
