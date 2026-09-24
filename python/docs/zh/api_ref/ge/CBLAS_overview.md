# 总体说明

调用本章节接口实现“矩阵-矩阵”或“矩阵-向量”相乘的运算，本章中的接口内部封装了系统内置的矩阵乘算子GEMM，接口调用流程参见[接口调用流程](https://www.hiascend.com/document/detail/zh/CANNCommunityEdition/latest/others/acldevg/aclpythondevg_0069.html)。

按照接口调用流程，在使用本章节的接口前，需要先使用ATC（Ascend Tensor Compiler）工具将内置的矩阵乘算子GEMM的算子描述信息（包括输入输出Tensor描述、算子属性等）编译成适配AI处理器的离线模型（\*.om文件），用于验证矩阵乘算子GEMM的运行结果。

本章的CBLAS接口都是异步接口，调用接口成功仅表示任务下发成功，不表示任务执行成功。调用该接口后，需调用同步等待接口（例如，`acl.rt.synchronize\_stream`）确保任务已执行完成。
