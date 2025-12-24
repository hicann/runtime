# aclrtDevAttr<a name="ZH-CN_TOPIC_0000002308747317"></a>

## 定义<a name="section152461834554"></a>

```
typedef enum { 
    ACL_DEV_ATTR_AICPU_CORE_NUM  = 1, 
    ACL_DEV_ATTR_AICORE_CORE_NUM = 101, 
    ACL_DEV_ATTR_CUBE_CORE_NUM = 102,
    ACL_DEV_ATTR_VECTOR_CORE_NUM = 201,      
    ACL_DEV_ATTR_WARP_SIZE = 202,
    ACL_DEV_ATTR_MAX_THREAD_PER_VECTOR_CORE,
    ACL_DEV_ATTR_LOCAL_MEM_PER_VECTOR_CORE,
    ACL_DEV_ATTR_TOTAL_GLOBAL_MEM_SIZE = 301,
    ACL_DEV_ATTR_L2_CACHE_SIZE,
    ACL_DEV_ATTR_SMP_ID = 401U,
    ACL_DEV_ATTR_PHY_CHIP_ID = 402U,
    ACL_DEV_ATTR_SUPER_POD_DEVIDE_ID = 403U,
    ACL_DEV_ATTR_SUPER_POD_SERVER_ID = 404U,
    ACL_DEV_ATTR_SUPER_POD_ID = 405U, 
    ACL_DEV_ATTR_CUST_OP_PRIVILEGE = 406U,
    ACL_DEV_ATTR_MAINBOARD_ID = 407U,
    ACL_DEV_ATTR_IS_VIRTUAL = 501U,
} aclrtDevAttr;
```

**表 1**  枚举项说明

<a name="table154428882117"></a>
<table><thead align="left"><tr id="row15442178172115"><th class="cellrowborder" valign="top" width="37.169999999999995%" id="mcps1.2.3.1.1"><p id="p10442188112114"><a name="p10442188112114"></a><a name="p10442188112114"></a>枚举项</p>
</th>
<th class="cellrowborder" valign="top" width="62.83%" id="mcps1.2.3.1.2"><p id="p84426814219"><a name="p84426814219"></a><a name="p84426814219"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="row134425813216"><td class="cellrowborder" valign="top" width="37.169999999999995%" headers="mcps1.2.3.1.1 "><p id="p151841348143711"><a name="p151841348143711"></a><a name="p151841348143711"></a>ACL_DEV_ATTR_AICPU_CORE_NUM</p>
</td>
<td class="cellrowborder" valign="top" width="62.83%" headers="mcps1.2.3.1.2 "><p id="p918334817379"><a name="p918334817379"></a><a name="p918334817379"></a>AI CPU数量。</p>
</td>
</tr>
<tr id="row444313892114"><td class="cellrowborder" valign="top" width="37.169999999999995%" headers="mcps1.2.3.1.1 "><p id="p101816482371"><a name="p101816482371"></a><a name="p101816482371"></a>ACL_DEV_ATTR_AICORE_CORE_NUM</p>
</td>
<td class="cellrowborder" valign="top" width="62.83%" headers="mcps1.2.3.1.2 "><p id="p12181148183714"><a name="p12181148183714"></a><a name="p12181148183714"></a>AI Core数量。</p>
</td>
</tr>
<tr id="row105107203385"><td class="cellrowborder" valign="top" width="37.169999999999995%" headers="mcps1.2.3.1.1 "><p id="p95101202388"><a name="p95101202388"></a><a name="p95101202388"></a>ACL_DEV_ATTR_CUBE_CORE_NUM</p>
</td>
<td class="cellrowborder" valign="top" width="62.83%" headers="mcps1.2.3.1.2 "><p id="p2510220113811"><a name="p2510220113811"></a><a name="p2510220113811"></a>Cube Core数量。</p>
</td>
</tr>
<tr id="row98151637133814"><td class="cellrowborder" valign="top" width="37.169999999999995%" headers="mcps1.2.3.1.1 "><p id="p381512378382"><a name="p381512378382"></a><a name="p381512378382"></a>ACL_DEV_ATTR_VECTOR_CORE_NUM</p>
</td>
<td class="cellrowborder" valign="top" width="62.83%" headers="mcps1.2.3.1.2 "><p id="p681523733817"><a name="p681523733817"></a><a name="p681523733817"></a>Vector Core数量。</p>
</td>
</tr>
<tr id="row1135450183819"><td class="cellrowborder" valign="top" width="37.169999999999995%" headers="mcps1.2.3.1.1 "><p id="p161351450133810"><a name="p161351450133810"></a><a name="p161351450133810"></a>ACL_DEV_ATTR_WARP_SIZE</p>
</td>
<td class="cellrowborder" valign="top" width="62.83%" headers="mcps1.2.3.1.2 "><p id="p1074371216397"><a name="p1074371216397"></a><a name="p1074371216397"></a>一个Warp里的线程数，在SIMT（单指令多线程，Single Instruction Multiple Thread）编程模型中，Warp是指执行相同指令的线程集合。</p>
<p id="p1113535023812"><a name="p1113535023812"></a><a name="p1113535023812"></a>当前不支持该类型。</p>
</td>
</tr>
<tr id="row1257113810398"><td class="cellrowborder" valign="top" width="37.169999999999995%" headers="mcps1.2.3.1.1 "><p id="p185717382397"><a name="p185717382397"></a><a name="p185717382397"></a>ACL_DEV_ATTR_MAX_THREAD_PER_VECTOR_CORE</p>
</td>
<td class="cellrowborder" valign="top" width="62.83%" headers="mcps1.2.3.1.2 "><p id="p167101194019"><a name="p167101194019"></a><a name="p167101194019"></a>每个VECTOR_CORE上可同时驻留的最大线程数。</p>
<p id="p157238163915"><a name="p157238163915"></a><a name="p157238163915"></a>当前不支持该类型。</p>
</td>
</tr>
<tr id="row186011220154013"><td class="cellrowborder" valign="top" width="37.169999999999995%" headers="mcps1.2.3.1.1 "><p id="p66011920114016"><a name="p66011920114016"></a><a name="p66011920114016"></a>ACL_DEV_ATTR_LOCAL_MEM_PER_VECTOR_CORE</p>
</td>
<td class="cellrowborder" valign="top" width="62.83%" headers="mcps1.2.3.1.2 "><p id="p12207104944010"><a name="p12207104944010"></a><a name="p12207104944010"></a>每个VECTOR_CORE上可以使用的最大本地内存，单位Byte。</p>
<p id="p86014205404"><a name="p86014205404"></a><a name="p86014205404"></a>当前不支持该类型。</p>
</td>
</tr>
<tr id="row14654155610404"><td class="cellrowborder" valign="top" width="37.169999999999995%" headers="mcps1.2.3.1.1 "><p id="p2654195619404"><a name="p2654195619404"></a><a name="p2654195619404"></a>ACL_DEV_ATTR_TOTAL_GLOBAL_MEM_SIZE</p>
</td>
<td class="cellrowborder" valign="top" width="62.83%" headers="mcps1.2.3.1.2 "><p id="p1565475615402"><a name="p1565475615402"></a><a name="p1565475615402"></a>Device上的可用总内存，单位Byte。</p>
</td>
</tr>
<tr id="row16851191219413"><td class="cellrowborder" valign="top" width="37.169999999999995%" headers="mcps1.2.3.1.1 "><p id="p385114129414"><a name="p385114129414"></a><a name="p385114129414"></a>ACL_DEV_ATTR_L2_CACHE_SIZE</p>
</td>
<td class="cellrowborder" valign="top" width="62.83%" headers="mcps1.2.3.1.2 "><p id="p485131274120"><a name="p485131274120"></a><a name="p485131274120"></a>L2 Cache（二级缓存）大小，单位Byte。</p>
</td>
</tr>
<tr id="row19101536105920"><td class="cellrowborder" valign="top" width="37.169999999999995%" headers="mcps1.2.3.1.1 "><p id="p11101436165912"><a name="p11101436165912"></a><a name="p11101436165912"></a>ACL_DEV_ATTR_SMP_ID</p>
</td>
<td class="cellrowborder" valign="top" width="62.83%" headers="mcps1.2.3.1.2 "><p id="p084272015583"><a name="p084272015583"></a><a name="p084272015583"></a>SMP（Symmetric Multiprocessing） ID，用于标识设备是否运行在同一操作系统上。</p>
</td>
</tr>
<tr id="row10817113825910"><td class="cellrowborder" valign="top" width="37.169999999999995%" headers="mcps1.2.3.1.1 "><p id="p188171438105917"><a name="p188171438105917"></a><a name="p188171438105917"></a>ACL_DEV_ATTR_PHY_CHIP_ID</p>
</td>
<td class="cellrowborder" valign="top" width="62.83%" headers="mcps1.2.3.1.2 "><p id="p19817163814598"><a name="p19817163814598"></a><a name="p19817163814598"></a><span>芯片物理</span>ID。</p>
</td>
</tr>
<tr id="row9863194013593"><td class="cellrowborder" valign="top" width="37.169999999999995%" headers="mcps1.2.3.1.1 "><p id="p48641340125915"><a name="p48641340125915"></a><a name="p48641340125915"></a>ACL_DEV_ATTR_SUPER_POD_DEVIDE_ID</p>
</td>
<td class="cellrowborder" valign="top" width="62.83%" headers="mcps1.2.3.1.2 "><p id="p11712658552"><a name="p11712658552"></a><a name="p11712658552"></a>SuperPOD Device ID表示超节点产品中的Device标识。</p>
</td>
</tr>
<tr id="row143222121409"><td class="cellrowborder" valign="top" width="37.169999999999995%" headers="mcps1.2.3.1.1 "><p id="p132219121604"><a name="p132219121604"></a><a name="p132219121604"></a>ACL_DEV_ATTR_SUPER_POD_SERVER_ID</p>
</td>
<td class="cellrowborder" valign="top" width="62.83%" headers="mcps1.2.3.1.2 "><p id="p15671215195"><a name="p15671215195"></a><a name="p15671215195"></a>SuperPOD Server ID表示超节点产品中的服务器标识。</p>
</td>
</tr>
<tr id="row7522133010011"><td class="cellrowborder" valign="top" width="37.169999999999995%" headers="mcps1.2.3.1.1 "><p id="p1452217304019"><a name="p1452217304019"></a><a name="p1452217304019"></a>ACL_DEV_ATTR_SUPER_POD_ID</p>
</td>
<td class="cellrowborder" valign="top" width="62.83%" headers="mcps1.2.3.1.2 "><p id="p1542217714295"><a name="p1542217714295"></a><a name="p1542217714295"></a>SuperPOD ID表示集群中的超节点ID。</p>
</td>
</tr>
<tr id="row1548064710012"><td class="cellrowborder" valign="top" width="37.169999999999995%" headers="mcps1.2.3.1.1 "><p id="p204812471001"><a name="p204812471001"></a><a name="p204812471001"></a>ACL_DEV_ATTR_CUST_OP_PRIVILEGE</p>
</td>
<td class="cellrowborder" valign="top" width="62.83%" headers="mcps1.2.3.1.2 "><p id="p139927132813"><a name="p139927132813"></a><a name="p139927132813"></a>表示查询自定义算是否可以执行更多的系统调用权限。</p>
<p id="p16651148132813"><a name="p16651148132813"></a><a name="p16651148132813"></a>取值如下：</p>
<a name="ul325882216296"></a><a name="ul325882216296"></a><ul id="ul325882216296"><li>0：自定义算子执行系统调用权限受控（例如不能执行Write操作）。</li><li>1：自定义算子可以执行更多的系统调用权限。</li></ul>
</td>
</tr>
<tr id="row15182057807"><td class="cellrowborder" valign="top" width="37.169999999999995%" headers="mcps1.2.3.1.1 "><p id="p131823571002"><a name="p131823571002"></a><a name="p131823571002"></a>ACL_DEV_ATTR_MAINBOARD_ID</p>
</td>
<td class="cellrowborder" valign="top" width="62.83%" headers="mcps1.2.3.1.2 "><p id="p918217571602"><a name="p918217571602"></a><a name="p918217571602"></a><span>主板ID。</span></p>
</td>
</tr>
<tr id="row14667104985913"><td class="cellrowborder" valign="top" width="37.169999999999995%" headers="mcps1.2.3.1.1 "><p id="p16668849155914"><a name="p16668849155914"></a><a name="p16668849155914"></a>ACL_DEV_ATTR_IS_VIRTUAL</p>
</td>
<td class="cellrowborder" valign="top" width="62.83%" headers="mcps1.2.3.1.2 "><p id="p196681049185917"><a name="p196681049185917"></a><a name="p196681049185917"></a>是否为<span id="ph118511218135612"><a name="ph118511218135612"></a><a name="ph118511218135612"></a>昇腾虚拟化实例</span>。</p>
<a name="ul10951140144"></a><a name="ul10951140144"></a><ul id="ul10951140144"><li>0：不是<span id="ph22351538517"><a name="ph22351538517"></a><a name="ph22351538517"></a>昇腾虚拟化实例</span>，是物理机。</li><li>1：是<span id="ph757016234518"><a name="ph757016234518"></a><a name="ph757016234518"></a>昇腾虚拟化实例</span>，可能是虚拟机或容器。</li></ul>
</td>
</tr>
</tbody>
</table>

## 了解AI Core、Cube Core、Vector Core的关系<a name="section02597528366"></a>

为便于理解AI Core、Cube Core、Vector Core的关系，此处先明确Core的定义，Core是指拥有独立Scalar计算单元的一个计算核，通常Scalar计算单元承担了一个计算核的SIMD（单指令多数据，Single Instruction Multiple Data）指令发射等功能，所以我们也通常也把这个Scalar计算单元称为核内的调度单元。不同产品上的AI数据处理核心单元不同，当前分为以下几类：

-   当AI数据处理核心单元是AI Core：
    -   在AI Core内，Cube和Vector共用一个Scalar调度单元。

        ![](figures/逻辑架构图.png)

    -   在AI Core内，Cube和Vector都有各自的Scalar调度单元，因此又被称为Cube Core、Vector Core。这时，一个Cube Core和一组Vector Core被定义为一个AI Core，AI Core数量通常是以多少个Cube Core为基准计算的，例如Ascend 910B。

        ![](figures/逻辑架构图-3.png)

-   当AI数据处理核心单元是AI Core以及单独的Vector Core：AI Core和Vector Core都拥有独立的Scalar调度单元。

    ![](figures/逻辑架构图-4.png)

