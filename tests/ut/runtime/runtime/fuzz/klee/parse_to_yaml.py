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

import sys
import os
import yaml
import commands

THIS_FILE_NAME = __file__

TYPEDEF_DICT = {"ccHandle_t" : "struct tagCcContext *",
                "ccTensorDescriptor_t" : "struct tagCcTensor *",
                "ccFilterDescriptor_t" : "struct tagCcFilter *",
                "ccConvolutionDescriptor_t" : "struct tagCcConvolution *",
                "ccPoolingDescriptor_t" : "struct tagCcPooling *",
                "ccActivationDescriptor_t" : "struct tagCcActivation *",
                "ccCropDescriptor_t" : "struct tagCcCrop *",
                "ccSpatialTransformerDescriptor_t" : "struct tagCcSpatialTransformer *",
                "ccShiftTransformerDescriptor_t" : "struct tagCcShiftTransformer *",
                "ccPReluDescriptor_t" : "struct tagCcPRelu *",
                "ccInterpDescriptor_t" : "struct tagCcInterp *",
                "ccFasterRcnnDetectionOutputDescriptor_t" : "struct tagCcFasterRcnnDetectionOutput *",
                "ccSsdDetectionOutputDescriptor_t" : "struct tagCcSsdDetectionOutput *",
                "ccYoloDetectionOutputDescriptor_t" : "struct tagCcYoloDetectionOutput *",
                "ccYolo2DetectionOutputDescriptor_t" : "struct tagCcYolo2DetectionOutput *",
                "ccNmsDescriptor_t" : "struct tagCcNms *",
                "ccMscnnBoxOutputDescriptor_t" : "struct tagCcMscnnBoxOutput *",
                "ccSsdPriorBoxDescriptor_t" : "struct tagCcSsdPriorBox *",
                "ccYolo2RegionDescriptor_t" : "struct tagCcYolo2Region *",
                "ccSoftmaxTree_t" : "void*",
                "ccPowerDescriptor_t" : "struct tagCcPower *",
                "ccRoiPoolingDescriptor_t" : "struct tagCcRoiPooling *",
                "ccReductionDescriptor_t" : "struct tagCcReduction *",
                "ccFasterRcnnProposalDescriptor_t" : "struct tagCcFasterRcnnProposal *",
                "ccLRNDescriptor_t" : "struct tagCcLRN *",
                "ccSSDNormalizeDescriptor_t" : "struct tagCcSSDNormalize *",
                "ccDetectionFull3DOutputDescriptor_t" : "struct tagCcDetectionFull3DOutput *",
                "ccConvolutionQuantizeDescriptor_t" : "struct tagCcConvolutionQuantize *",}

def read_all(readfile):
    if not os.path.isfile(readfile):
        print "read_all, File %s does NOT exist"%readfile
        return ""
    
    file_handle = open(readfile,'r')
    content = file_handle.read()
    file_handle.close()

    return content
    
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
        
def get_func_paras(func_str):
    para_list = func_str.split("(")[-1].split(")")[0].split(",")
    para_info_list = []
    for para_info in para_list:
        para_name = para_info.split(" ")[-1].strip()
        para_type = para_info[:-len(para_name)].strip()
        if "*" in para_name:
            para_name = para_info.split("*")[-1].strip()
            para_type = para_info[:-len(para_name)].strip()
        para_info_list.append(para_type + "@" + para_name)
    return para_info_list
    
def main():
    #head_file = "./klee/blas.h"
    head_file = "origin_head_files/runtime.h"
    yaml_content = ""
    content = read_all(head_file)
    header_content, namespace_content, func_content = content.split("//@@@split for klee@@@")
    #gen header file str
    header_list = header_content.split("\n")
    header_str = "    head_files:\n"
    for header in header_list:
        if not header.strip():
            continue
        if "#include" in header:
            header_str += "        - %s\n" % header.split("\"")[1]
        else:
            header_str += "        - %s\n" % header
    #gen namespace str
    namespace_list = namespace_content.split("\n")
    namespace_str = "    namespace:\n"
    for namespace in namespace_list:
        if not namespace.strip():
            continue
        if namespace.startswith("using namespace"):
            namespace_str += "        - %s\n" % namespace.split("using namespace ")[1].replace(";", "")
        else:
            namespace_str += "        - %s\n" % namespace
    func_list = func_content.replace("\n", "").split(";")
    for func_info in func_list:
        if not func_info.strip():
            continue
        header = func_info.split("(")[0]
        func_name = header.split(" ")[-1].strip()
        if func_info.strip().startswith("//"):
            print func_name + " should be ignore!"
            continue
        yaml_content += func_name + ":\n    paras:\n"
        return_type = header[:-len(func_name)].strip()
        para_info_list = get_func_paras(func_info)
        for para_info in para_info_list:
            para_type, para_name = para_info.split("@")
            para_type = para_type.replace("const ", "").strip()
            yaml_content += "        - %s:\n" % para_name
            yaml_content += "            type: %s\n" % para_type
            #real_type = para_type.replace("const ", "").strip()
            if para_type in TYPEDEF_DICT:
                yaml_content += "            typedef: %s\n" % TYPEDEF_DICT[para_type]
            elif "void *" in para_type:
                yaml_content += "            no_sym: True\n"
        yaml_content += header_str
        yaml_content += namespace_str
    yaml_file = head_file + ".yaml"
    write_all(yaml_file, yaml_content);
    
    exit(0)

if __name__ == '__main__':
    main()

