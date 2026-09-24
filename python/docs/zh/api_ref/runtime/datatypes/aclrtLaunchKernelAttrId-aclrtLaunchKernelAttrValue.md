# aclrtLaunchKernelAttrId/aclrtLaunchKernelAttrValue

- ACL\_RT\_LAUNCH\_KERNEL\_ATTR\_SCHEM\_MODE = 1

    调度模式。取值如下：

  - 0：普通调度模式，有空闲的核，就启动算子执行。例如，当blockDim为8时，表示算子核函数将会在8个核上执行，这时如果指定普通调度模式，则表示只要有1个核空闲了，就启动算子执行。
  - 1：batch调度模式，必须所有所需的核都空闲了，才启动算子执行。例如，当blockDim为8时，表示算子核函数将会在8个核上执行，这时如果指定batch调度模式，则表示必须等8个核都空闲了，才启动算子执行。

- ACL\_RT\_LAUNCH\_KERNEL\_ATTR\_DYN\_UBUF\_SIZE = 2

    用于指定SIMT（Single Instruction Multiple Thread）算子执行时需要的UB（Unified Buffer，统一缓冲区）动态内存大小，单位Byte。纯SIMD算子该参数仅支持设置为0。

    <!-- npu="950" id1 -->
    仅Ascend 950PR&950DT系列产品支持该参数。
    <!-- end id1 -->

- ACL\_RT\_LAUNCH\_KERNEL\_ATTR\_ENGINE\_TYPE = 3

    算子执行引擎。取值请参见[aclrtEngineType](aclrtEngineType.md)。

    <!-- npu="310p" id2 -->
    仅Atlas推理系列产品支持该参数。
    <!-- end id2 -->

- ACL\_RT\_LAUNCH\_KERNEL\_ATTR\_BLOCKDIM\_OFFSET

    numBlocks偏移量。

  - **如果numBlocks ≤ AI Core核数**，则无需使用Vector Core上计算，可将engineType配置为ACL\_RT\_ENGINE\_TYPE\_AIC（表示在AI Core上计算），则此处的blockDimOffset配置为0。
  - **如果numBlocks \> AI Core核数**，则需：

    - 在一个Stream上下发任务，将engineType配置为ACL\_RT\_ENGINE\_TYPE\_AIC（表示在AI Core上计算），此处的blockDimOffset配置为0。
    - 在另一个Stream上下发任务，将engineType配置为ACL\_RT\_ENGINE\_TYPE\_AIV（表示在Vector Core上计算），此处的blockDimOffset配置为aicorenumBlocks，aicorenumBlocks的计算公式如下：
      - numBlocks ≤ AI Core核数+Vector Core核数时，aicorenumBlocks = AI Core核数
      - 否则，aicorenumBlocks = 向上取整 \( numBlocks \* \( AI Core核数 \) / \( AI Core核数 + Vector Core核数 \)\)

        <!-- npu="310p" id3 -->
        仅Atlas推理系列产品支持该参数。
        <!-- end id3 -->

- ACL\_RT\_LAUNCH\_KERNEL\_ATTR\_BLOCK\_TASK\_PREFETCH

    任务下发时，是否阻止硬件预取本任务的信息。

    取值如下：

  - 0：不阻止
  - 1：阻止

- ACL\_RT\_LAUNCH\_KERNEL\_ATTR\_DATA\_DUMP

    是否开启Dump。

    取值如下：

  - 0：不开启
  - 1：开启

- ACL\_RT\_LAUNCH\_KERNEL\_ATTR\_TIMEOUT

    任务调度器等待任务执行的超时时间。仅适用于执行AI CPU或AI Core算子的场景。

    取值如下：

  - 0：表示永久等待；
  - \>0：配置具体的超时时间，单位是秒。
