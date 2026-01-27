#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

import os
import re
import sys
import yaml
import commands

THIS_FILE_NAME = __file__

PARAM_TYPE_FLAG = "type"
PARAM_TYPEDEF_FLAG = "typedef"
PARAM_ASSUME_FLAG = "assume"
PARAM_NO_SYMBOLIC_FLAG = "no_sym"
BC_WITHOUT_MAIN_FILE = "out/mini/llt/ut/obj/EXECUTABLES/kernel_utest_intermediates/kernel_utest"

KLEE_SAN_OPTIONS = "-fsanitize=signed-integer-overflow -fsanitize=unsigned-integer-overflow -fsanitize=undefined"

ENUM_DICT = {"ccTensorFormat_t" : "CC_TENSOR_RESERVED",
             "ccDataType_t" : "CC_DATA_RESERVED",
             "ccConvolutionScaleType_t" : "SCALE_TYPE_BUTT",
             "ccConvolutionScaleValueMode_t" : "SCALE_VALUE_MODE_BUTT",
             "ccNanPropagation_t" : "CC_NAN_PROPAGATE_RESERVED",
             "ccConvolutionFwdAlgo_t" : "CC_CONVOLUTION_FWD_ALGO_RESERVED",
             "ccConvolutionMode_t" : "CC_CONV_MODE_RESERVED",
             "ccPoolingMode_t" : "CC_POOLING_RESERVED",
             "ccPaddingMode_t" : "CC_PADDING_RESERVED",
             "ccActivationMode_t" : "CC_ACTIVATION_RESERVED",
             "ccBatchNormMode_t" : "CC_BATCHNORM_RESERVED",
             "ccSoftmaxAlgo_t" : "CC_SOFTMAX_RESERVED",
             "ccSoftmaxMode_t" : "CC_SOFTMAX_MODE_RESERVED",
             "ccConcatMode_t" : "CC_CONCAT_RESERVED",
             "ccEltwiseMode_t" : "CC_ELTWISE_RESERVED",
             "ccDepthwiseFilterType_t" : "CC_Depthwise_FILTER_RESERVED",
             "ccSamplerType_t" : "CC_SAMPLER_RESERVED",
             "ccNmsType_t" : "CC_NMS_RESERVED",
             "ccBoxCodeType_t" : "CC_BOX_RESERVED",
             "ccSplitMode_t" : "CC_SPLIT_MODE_RESERVED",
             "ccRoiPoolingMode_t" : "CC_ROIPOOLING_RESERVED",
             "ccReductionOp_t" : "CC_REDUCTION_OP_RESERVED",
             "ccReductionIndices_t" : "CC_REDUCTION_INDICES_RESERVED",
             "ccNormMode_t" : "CC_NORM_RESERVED",
             "ccLRNMode_t" : "CC_LRN_RESERVED"}
             
Descriptor_DICT = {"ccTensorDescriptor_t" : {"format": "ccTensorFormat_t", "dataType": "ccDataType_t"},
                   "ccFilterDescriptor_t" : {"format": "ccTensorFormat_t", "dataType": "ccDataType_t"},
                   "ccConvolutionDescriptor_t" : {"mode": "ccConvolutionMode_t", "padMode": "ccPaddingMode_t"},
                   "ccPoolingDescriptor_t" : {"mode": "ccPoolingMode_t", "padMode": "ccPaddingMode_t", "maxpoolingNanOpt": "ccNanPropagation_t"},
                   "ccActivationDescriptor_t" : {"mode": "ccActivationMode_t", "reluNanOpt": "ccNanPropagation_t"},
                   "ccSpatialTransformerDescriptor_t" : {"samplerType": "ccSamplerType_t", "dataType": "ccDataType_t"},
                   "ccShiftTransformerDescriptor_t" : {"samplerType": "ccSamplerType_t"},
                   "ccPReluDescriptor_t" : {"reluNanOpt": "ccNanPropagation_t"},
                   "ccSsdDetectionOutputDescriptor_t" : {"codeType": "ccBoxCodeType_t"},
                   "ccMscnnBoxOutputDescriptor_t" : {"nmsType": "ccNmsType_t"},
                   "ccSsdPriorBoxDescriptor_t" : {"codeType": "ccBoxCodeType_t"},
                   "ccRoiPoolingDescriptor_t" : {"roiPoolingMode": "ccRoiPoolingMode_t", "poolingMode": "ccPoolingMode_t"},
                   "ccReductionDescriptor_t" : {"reductionOp": "ccReductionOp_t", "reductionCompType": "ccDataType_t", "reductionIndices": "ccReductionIndices_t"},
                   "ccLRNDescriptor_t" : {"lrnMode": "ccLRNMode_t"},
                   "ccSSDNormalizeDescriptor_t" : {"normMode": "ccNormMode_t"}}
                   
DESC_SET_FUNC_DICT = {"ccTensorDescriptor_t" : "ccSetTensor4dDescriptor",
                      "ccFilterDescriptor_t" : "ccSetFilter4dDescriptor",
                      "ccConvolutionDescriptor_t" : "ccSetConvolution2dDescriptor",
                      "ccPoolingDescriptor_t" : "ccSetPooling2dDescriptor",
                      "ccActivationDescriptor_t" : "ccSetActivationDescriptor",
                      "ccCropDescriptor_t" : "ccSetCropDescriptor",
                      "ccSpatialTransformerDescriptor_t" : "ccSetSpatialTransformerNdDescriptor",
                      "ccShiftTransformerDescriptor_t" : "ccSetShiftTransformerDescriptor",
                      "ccPReluDescriptor_t" : "ccSetPReluDescriptor",
                      "ccInterpDescriptor_t" : "ccSetInterpDescriptor",
                      "ccFasterRcnnDetectionOutputDescriptor_t" : "ccSetFasterRcnnDetectionOutputDescriptor",
                      "ccSsdDetectionOutputDescriptor_t" : "ccSetSsdDetectionOutputDescriptor",
                      "ccYoloDetectionOutputDescriptor_t" : "ccSetYoloDetectionOutputDescriptor",
                      "ccYolo2DetectionOutputDescriptor_t" : "ccSetYolo2DetectionOutputDescriptor",
                      "ccNmsDescriptor_t" : "ccSetNmsDescriptor",
                      "ccMscnnBoxOutputDescriptor_t" : "ccSetMscnnBoxOutputDescriptor",
                      "ccSsdPriorBoxDescriptor_t" : "ccSetSsdPriorBoxDescriptor",
                      "ccYolo2RegionDescriptor_t" : "ccSetYolo2RegionDescriptor",
                      "ccPowerDescriptor_t" : "ccSetPowerDescriptor",
                      "ccRoiPoolingDescriptor_t" : "ccSetRoiPoolingDescriptor",
                      "ccReductionDescriptor_t" : "ccSetReductionDescriptor",
                      "ccFasterRcnnProposalDescriptor_t" : "ccSetFasterRcnnProposalDescriptor",
                      "ccLRNDescriptor_t" : "ccSetLRNDescriptor",
                      "ccSSDNormalizeDescriptor_t" : "ccSetSsdNormalizeDescriptor",
                      "ccDetectionFull3DOutputDescriptor_t" : "ccSetDetectionFull3DOutputDescriptor"}

def write_all(file_name, content):
    try:
        parent_dir = os.path.dirname(file_name)
        if not os.path.exists(parent_dir):
            os.makedirs(parent_dir)
        
        file_handle = open(file_name,'w')
        file_handle.write(content)
        file_handle.close()
    
        return True
    except:
        print "write_all, failed to write"
    
    return False
    
class test_func_conf(object):
    def __init__(self, config_file):
        if not os.path.exists(config_file):
            print "config file: %s is not exist" % (config_file)
            raise Exception("config file no exist!")

        try:
            stream = open(config_file, 'r')
            self.all_func_config = yaml.load(stream)
            stream.close()
        except Exception, e:
            print "exception happen:\n%s" % str(e)
            raise Exception("load config file failed!")

    def get_func_info(self):
        return self.all_func_config
        
    def get_return_type(self, func_name):
        return_type = self.all_func_config.get(func_name, {}).get("return_value", "")
        return return_type
        
    def get_params_list(self, func_name):
        params_list = self.all_func_config.get(func_name, {}).get("paras", [])
        return params_list
        
    def get_head_files(self, func_name):
        head_files_list = self.all_func_config.get(func_name, {}).get("head_files", [])
        return head_files_list
        
    def get_namespaces_files(self, func_name):
        namespaces_list = self.all_func_config.get(func_name, {}).get("namespace", [])
        return namespaces_list
    
    def is_extern_func(self, func_name):
        extern_flag = self.all_func_config.get(func_name, {}).get("extern", False)
        return extern_flag
    
    def is_need_disable(self, func_name):
        disable_flag = self.all_func_config.get(func_name, {}).get("disable", False)
        return disable_flag

def generate_test_file(func_obj, func_name):
    main_code = "#include <klee/klee.h>\n"
    if func_obj.is_need_disable(func_name):
        #print "found disable flag, ignore: %s" % func_name
        return
    head_file_list = func_obj.get_head_files(func_name)
    for head_file in head_file_list:
        main_code += "#include \"%s\"\n" % head_file
    namespaces_list = func_obj.get_namespaces_files(func_name)
    # add namespace
    for namespace in namespaces_list:
        main_code += "using namespace %s;\n" % namespace
    #add extern func
    params_list = func_obj.get_params_list(func_name)
    extern_flag = func_obj.is_extern_func(func_name)
    extern_func_param_list = []
    if extern_flag:
        return_type = func_obj.get_return_type(func_name)
        main_code += "\nextern %s %s(" % (return_type, func_name) 
        for params_dict in params_list:
            for para_name, param_info_dict in params_dict.items():
                para_type = param_info_dict.get(PARAM_TYPE_FLAG)
                extern_func_param_list.append(para_type + " " + para_name)
        main_code += "%s);\n" % (", ".join(extern_func_param_list))
    main_code += "\nint main() {\n"
    #main_code += "    cceSysInit();\n"
    # add params and symbolic
    para_name_list = []
    for params_dict in params_list:
        for para_name, param_info_dict in params_dict.items():
            para_type = param_info_dict.get(PARAM_TYPE_FLAG)
            typedef = param_info_dict.get(PARAM_TYPEDEF_FLAG)
            assume_list = param_info_dict.get(PARAM_ASSUME_FLAG, [])
            no_symbolic = param_info_dict.get(PARAM_NO_SYMBOLIC_FLAG, False)
            real_type = para_type
            if typedef:
                real_type = typedef
            # point type
            if "*" in real_type:
                if para_name == "alpha":
                    main_code += "    float %s[1] = {1.0f};\n" % para_name
                elif para_name == "beta":
                    main_code += "    float %s[1] = {0.0f};\n" % para_name
                elif "void **" in real_type:
                    #print "found void ** in func_name: %s" % func_name
                    real_type = "void *";
                    main_code += "    %s %s[1] = {NULL};\n" % (real_type, para_name)
                    #main_code += "    klee_make_symbolic(%s, sizeof(%s), \"%s\");\n" % (para_name, para_name, para_name)
                elif "void" in real_type:
                    real_type = "uint8_t";
                    main_code += "    %s %s[100000] = {0};\n" % (real_type, para_name)
                    #main_code += "    klee_make_symbolic(%s, sizeof(%s), \"%s\");\n" % (para_name, para_name, para_name)
                else:
                    main_code += "    %s %s;\n" % (para_type, para_name)
                    real_type = real_type.replace("*", "")
                    main_code += "    %s ori_%s;\n" % (real_type.replace("const ", ""), para_name)
                    main_code += "    %s = &ori_%s;\n" % (para_name, para_name)
                    set_func_name = DESC_SET_FUNC_DICT.get(para_type)
                    if not no_symbolic:
                        if set_func_name:
                            main_code += "#ifdef DESC_CONSTRUCTION_DIRECTLY\n"
                        main_code += "    klee_make_symbolic(&ori_%s, sizeof(%s), \"%s\");\n" % (para_name, real_type, para_name)
                        if para_type in Descriptor_DICT:
                            for descriptor_para, descriptor_type in Descriptor_DICT[para_type].items():
                                main_code += "    klee_assume(%s->%s >= 0);\n" % (para_name, descriptor_para)
                                main_code += "    klee_assume(%s->%s <= %s);\n" % (para_name, descriptor_para, ENUM_DICT[descriptor_type])
                        if set_func_name:
                            main_code += "#else\n"

                            set_params_list = func_obj.get_params_list(set_func_name)
                            set_para_name_list = []
                            for set_set_params_dict in set_params_list:
                                for set_para_name, set_param_info_dict in set_set_params_dict.items():
                                    set_para_type = set_param_info_dict.get(PARAM_TYPE_FLAG)
                                    set_typedef = set_param_info_dict.get(PARAM_TYPEDEF_FLAG)
                                    set_assume_list = set_param_info_dict.get(PARAM_ASSUME_FLAG, [])
                                    set_no_symbolic = set_param_info_dict.get(PARAM_NO_SYMBOLIC_FLAG, False)
                                    set_real_type = set_para_type
                                    set_para_name = para_name+"_"+set_para_name
                                    if set_typedef:
                                        set_real_type = set_typedef
                                    if set_para_type == para_type:
                                        set_para_name_list.append(para_name)
                                        continue
                                    # point type
                                    if "*" in set_real_type:
                                        if set_para_name == "alpha":
                                            main_code += "    float %s[1] = {1.0f};\n" % set_para_name
                                        elif set_para_name == "beta":
                                            main_code += "    float %s[1] = {0.0f};\n" % set_para_name
                                        elif "void **" in set_real_type:
                                            #print "found void ** in func_name: %s" % func_name
                                            set_real_type = "void *";
                                            main_code += "    %s %s[1] = {NULL};\n" % (set_real_type, set_para_name)
                                            #main_code += "    klee_make_symbolic(%s, sizeof(%s), \"%s\");\n" % (set_para_name, set_para_name, set_para_name)
                                        elif "void" in set_real_type:
                                            set_real_type = "uint8_t";
                                            main_code += "    %s %s[100000] = {0};\n" % (set_real_type, set_para_name)
                                            #main_code += "    klee_make_symbolic(%s, sizeof(%s), \"%s\");\n" % (set_para_name, set_para_name, set_para_name)
                                        else:
                                            main_code += "    %s %s;\n" % (set_para_type, set_para_name)
                                            set_real_type = set_real_type.replace("*", "")
                                            main_code += "    %s ori_%s;\n" % (set_real_type.replace("const ", ""), set_para_name)
                                            main_code += "    %s = &ori_%s;\n" % (set_para_name, set_para_name)
                                            if not set_no_symbolic:
                                                main_code += "    klee_make_symbolic(&ori_%s, sizeof(%s), \"%s\");\n" % (set_para_name, set_real_type, set_para_name)
                                                if set_para_type in Descriptor_DICT:
                                                    for descriptor_para, descriptor_type in Descriptor_DICT[set_para_type].items():
                                                        main_code += "    klee_assume(%s->%s >= 0);\n" % (set_para_name, descriptor_para)
                                                        main_code += "    klee_assume(%s->%s <= %s);\n" % (set_para_name, descriptor_para, ENUM_DICT[descriptor_type])
                                    # array type
                                    elif "[" in set_real_type:
                                        print "found [ in func_name: %s" % func_name
                                        main_code += "    %s %s[%s;\n" % (set_real_type.split("[")[0], set_para_name, set_real_type.split("[")[1])
                                        if not set_no_symbolic:
                                            main_code += "    klee_make_symbolic(%s, sizeof(%s), \"%s\");\n" % (set_para_name, set_para_name, set_para_name)
                                    # array type
                                    elif "[" in set_para_name:
                                        main_code += "    %s %s;\n" % (set_para_type, set_para_name)
                                        array_name = set_para_name.split("[")[0]
                                        array_cnt = set_para_name.split("[")[1].split("]")[0]
                                        if not set_no_symbolic:
                                            main_code += "    klee_make_symbolic(%s, sizeof(%s) * %s, \"%s\");\n" % (array_name, set_para_type, array_cnt, array_name)
                                        set_para_name = array_name
                                    # normal type
                                    else:
                                        main_code += "    %s %s;\n" % (set_para_type, set_para_name)
                                        if not set_no_symbolic:
                                            main_code += "    klee_make_symbolic(&%s, sizeof(%s), \"%s\");\n" % (set_para_name, set_para_type, set_para_name)
                                            if set_para_type in ENUM_DICT:
                                                main_code += "    klee_assume(%s >= 0);\n" % (set_para_name)
                                                main_code += "    klee_assume(%s <= %s);\n" % (set_para_name, ENUM_DICT[set_para_type])
                                    set_para_name_list.append(set_para_name)
                                    for assume in set_assume_list:
                                        set_assume = para_name+"_"+assume
                                        main_code += "    klee_assume(%s);\n" % set_assume
                            if "    ccStatus_t ccRet;\n" not in main_code:
                                main_code += "    ccStatus_t ccRet;\n"
                            main_code += "    ccRet = %s(%s);\n" % (set_func_name, ", ".join(set_para_name_list))
                            main_code += "    if (ccRet != CC_STATUS_SUCCESS)\n"
                            main_code += "    {\n"
                            main_code += "        return 0;\n"
                            main_code +="    }\n"
                            main_code +="#endif\n"



            # array type
            elif "[" in real_type:
                print "found [ in func_name: %s" % func_name
                main_code += "    %s %s[%s;\n" % (real_type.split("[")[0], para_name, real_type.split("[")[1])
                if not no_symbolic:
                    main_code += "    klee_make_symbolic(%s, sizeof(%s), \"%s\");\n" % (para_name, para_name, para_name)
            # array type
            elif "[" in para_name:
                main_code += "    %s %s;\n" % (para_type, para_name)
                array_name = para_name.split("[")[0]
                array_cnt = para_name.split("[")[1].split("]")[0]
                if not no_symbolic:
                    main_code += "    klee_make_symbolic(%s, sizeof(%s) * %s, \"%s\");\n" % (array_name, para_type, array_cnt, array_name)
                para_name = array_name
            # normal type
            else:
                main_code += "    %s %s;\n" % (para_type, para_name)
                if not no_symbolic:
                    main_code += "    klee_make_symbolic(&%s, sizeof(%s), \"%s\");\n" % (para_name, para_type, para_name)
                    if para_type in ENUM_DICT:
                        main_code += "    klee_assume(%s >= 0);\n" % (para_name)
                        main_code += "    klee_assume(%s <= %s);\n" % (para_name, ENUM_DICT[para_type])
            para_name_list.append(para_name)
            
            for assume in assume_list:
                main_code += "    klee_assume(%s);\n" % assume
                
    # add function to be test
    main_code += "    %s(%s);\n" % (func_name, ", ".join(para_name_list))
    main_code += "    return 0;\n}"
    
    test_file = "./klee_test_%s.cc"%func_name
    write_all(test_file, main_code)
    print "%s" % func_name

def add_test_file_mk(func_name):
    test_file = "klee_test_%s.cc"%func_name
    if not os.path.exists(test_file):
        print("[error] test file :%s not exists"% test_file)
        return False
    module_mk = "module.mk"
    if not os.path.exists(module_mk):
        print("[error] mk file :%s not exists"% module_mk)
        return False
    module_template = '''
include $(CLEAR_VARS)
LOCAL_MODULE := klee_%s
LOCAL_SRC_FILES := $(CCE_SRC_FILES) $(CCE_KT_FILES) %s
LOCAL_C_INCLUDES := $(CCE_INC_DIR) \\
LOCAL_CFLAGS += -D__CCE_KT_TEST__
LOCAL_STATIC_LIBRARIES := libc_sec
ifneq ($(strip $(BITCODE)),true)
LOCAL_STATIC_LIBRARIES += libmodel
endif
include $(BUILD_KLEE_TEST)
''' 
    mk_str = module_template % (func_name, test_file)
    print(mk_str)
    with open(module_mk, 'a+') as mf:
        #if "LOCAL_MODULE := klee_%s"%func_name in mf.read():
        for line in mf:
            if re.match("LOCAL_MODULE.*klee_%s"%func_name, line):
                print(func_name,' is already in ',module_mk)
                return True
        print(mk_str)
        mf.write(mk_str)

def main():
    if len(sys.argv) < 2:
        cmd_dict = {}
    else:
        cmd_list = sys.argv[1].split(";")
        cmd_dict = {}
        for cmd in cmd_list:
            key, value = cmd.split(":")
            cmd_dict[key] = value
    
    func_obj = test_func_conf("origin_head_files/runtime.yaml");
    #func_obj = test_func_conf("./test_func.yaml");
    #func_obj = test_func_conf("./klee/blas.h.yaml");
    #func_obj = test_func_conf("./klee/fp16_math.hpp.yaml");
    for func_name, func_info in func_obj.all_func_config.items():
        # add head file
        generate_test_file(func_obj, func_name)
        if cmd_dict.get("add_to_mk", "false") == "true":
            add_test_file_mk(func_name)

    exit(0)

if __name__ == '__main__':
    main()


