# aclrtCreateContext<a name="ZH-CN_TOPIC_0000001265241350"></a>

## AI处理器支持情况<a name="section16107182283615"></a>

<a name="zh-cn_topic_0000002219420921_table38301303189"></a>
<table><thead align="left"><tr id="zh-cn_topic_0000002219420921_row20831180131817"><th class="cellrowborder" valign="top" width="57.99999999999999%" id="mcps1.1.3.1.1"><p id="zh-cn_topic_0000002219420921_p1883113061818"><a name="zh-cn_topic_0000002219420921_p1883113061818"></a><a name="zh-cn_topic_0000002219420921_p1883113061818"></a><span id="zh-cn_topic_0000002219420921_ph20833205312295"><a name="zh-cn_topic_0000002219420921_ph20833205312295"></a><a name="zh-cn_topic_0000002219420921_ph20833205312295"></a>AI处理器类型</span></p>
</th>
<th class="cellrowborder" align="center" valign="top" width="42%" id="mcps1.1.3.1.2"><p id="zh-cn_topic_0000002219420921_p783113012187"><a name="zh-cn_topic_0000002219420921_p783113012187"></a><a name="zh-cn_topic_0000002219420921_p783113012187"></a>是否支持</p>
</th>
</tr>
</thead>
<tbody><tr id="zh-cn_topic_0000002219420921_row220181016240"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="zh-cn_topic_0000002219420921_p48327011813"><a name="zh-cn_topic_0000002219420921_p48327011813"></a><a name="zh-cn_topic_0000002219420921_p48327011813"></a><span id="zh-cn_topic_0000002219420921_ph583230201815"><a name="zh-cn_topic_0000002219420921_ph583230201815"></a><a name="zh-cn_topic_0000002219420921_ph583230201815"></a><term id="zh-cn_topic_0000002219420921_zh-cn_topic_0000001312391781_term1253731311225"><a name="zh-cn_topic_0000002219420921_zh-cn_topic_0000001312391781_term1253731311225"></a><a name="zh-cn_topic_0000002219420921_zh-cn_topic_0000001312391781_term1253731311225"></a>Ascend 910C</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="zh-cn_topic_0000002219420921_p7948163910184"><a name="zh-cn_topic_0000002219420921_p7948163910184"></a><a name="zh-cn_topic_0000002219420921_p7948163910184"></a>√</p>
</td>
</tr>
<tr id="zh-cn_topic_0000002219420921_row173226882415"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="zh-cn_topic_0000002219420921_p14832120181815"><a name="zh-cn_topic_0000002219420921_p14832120181815"></a><a name="zh-cn_topic_0000002219420921_p14832120181815"></a><span id="zh-cn_topic_0000002219420921_ph1483216010188"><a name="zh-cn_topic_0000002219420921_ph1483216010188"></a><a name="zh-cn_topic_0000002219420921_ph1483216010188"></a><term id="zh-cn_topic_0000002219420921_zh-cn_topic_0000001312391781_term11962195213215"><a name="zh-cn_topic_0000002219420921_zh-cn_topic_0000001312391781_term11962195213215"></a><a name="zh-cn_topic_0000002219420921_zh-cn_topic_0000001312391781_term11962195213215"></a>Ascend 910B</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="zh-cn_topic_0000002219420921_p19948143911820"><a name="zh-cn_topic_0000002219420921_p19948143911820"></a><a name="zh-cn_topic_0000002219420921_p19948143911820"></a>√</p>
</td>
</tr>
</tbody>
</table>

## 功能说明<a name="section36583473819"></a>

在当前进程或线程中显式创建Context。

## 函数原型<a name="section13230182415108"></a>

```
aclError aclrtCreateContext(aclrtContext *context, int32_t deviceId)
```

## 参数说明<a name="section75395119104"></a>

<a name="zh-cn_topic_0122830089_table438764393513"></a>
<table><thead align="left"><tr id="zh-cn_topic_0122830089_row53871743113510"><th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.1"><p id="zh-cn_topic_0122830089_p1438834363520"><a name="zh-cn_topic_0122830089_p1438834363520"></a><a name="zh-cn_topic_0122830089_p1438834363520"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.2"><p id="p1769255516412"><a name="p1769255516412"></a><a name="p1769255516412"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="72%" id="mcps1.1.4.1.3"><p id="zh-cn_topic_0122830089_p173881843143514"><a name="zh-cn_topic_0122830089_p173881843143514"></a><a name="zh-cn_topic_0122830089_p173881843143514"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="row16791142193514"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p19750152982019"><a name="p19750152982019"></a><a name="p19750152982019"></a>context</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p14751102992019"><a name="p14751102992019"></a><a name="p14751102992019"></a>输出</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p14751132952011"><a name="p14751132952011"></a><a name="p14751132952011"></a>Context的指针。</p>
</td>
</tr>
<tr id="zh-cn_topic_0122830089_row2038874343514"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p116115286175"><a name="p116115286175"></a><a name="p116115286175"></a>deviceId</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p1760828181716"><a name="p1760828181716"></a><a name="p1760828181716"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p11581028101716"><a name="p11581028101716"></a><a name="p11581028101716"></a>在指定的Device下创建Context。</p>
<p id="p5103103751315"><a name="p5103103751315"></a><a name="p5103103751315"></a>用户调用<a href="aclrtGetDeviceCount.md">aclrtGetDeviceCount</a>接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)]</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section25791320141317"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明<a name="section5299718173413"></a>

-   若不调用aclrtCreateContext接口显式创建Context，那系统会使用默认Context，该默认Context是在调用[aclrtSetDevice](aclrtSetDevice.md)接口时隐式创建的。
    -   隐式创建Context：适合简单、无复杂交互逻辑的应用，但缺点在于，在多线程编程中，执行结果取决于线程调度的顺序。
    -   显式创建Context：适合大型、复杂交互逻辑的应用，且便于提高程序的可读性、可维护性。

-   在某一进程中指定Device，该进程内的多个线程可共用在此Device上显式创建的Context（调用[aclrtCreateContext](aclrtCreateContext.md)接口显式创建Context）。
-   若在某一进程内创建多个Context（Context的数量与Stream相关，Stream数量有限制，请参见[aclrtCreateStream](aclrtCreateStream.md)），当前线程在同一时刻内只能使用其中一个Context，建议通过[aclrtSetCurrentContext](aclrtSetCurrentContext.md)接口明确指定当前线程的Context，增加程序的可维护性**。**
-   不同产品型号上，调用本接口隐式创建的Stream数量不同，如下表所示。

    <a name="table1042115287418"></a>
    <table><thead align="left"><tr id="row2042242816417"><th class="cellrowborder" valign="top" width="43.41%" id="mcps1.1.3.1.1"><p id="p4422112804119"><a name="p4422112804119"></a><a name="p4422112804119"></a>型号</p>
    </th>
    <th class="cellrowborder" valign="top" width="56.589999999999996%" id="mcps1.1.3.1.2"><p id="p1542282844112"><a name="p1542282844112"></a><a name="p1542282844112"></a>默认Stream的说明</p>
    </th>
    </tr>
    </thead>
    <tbody><tr id="row96171042144115"><td class="cellrowborder" valign="top" width="43.41%" headers="mcps1.1.3.1.1 "><p id="p5563144114415"><a name="p5563144114415"></a><a name="p5563144114415"></a><span id="ph3640204918443"><a name="ph3640204918443"></a><a name="ph3640204918443"></a><term id="zh-cn_topic_0000001312391781_term1253731311225"><a name="zh-cn_topic_0000001312391781_term1253731311225"></a><a name="zh-cn_topic_0000001312391781_term1253731311225"></a>Ascend 910C</term></span></p>
    <p id="p1242751104414"><a name="p1242751104414"></a><a name="p1242751104414"></a><span id="ph107301423444"><a name="ph107301423444"></a><a name="ph107301423444"></a><term id="zh-cn_topic_0000001312391781_term11962195213215"><a name="zh-cn_topic_0000001312391781_term11962195213215"></a><a name="zh-cn_topic_0000001312391781_term11962195213215"></a>Ascend 910B</term></span></p>
    </td>
    <td class="cellrowborder" valign="top" width="56.589999999999996%" headers="mcps1.1.3.1.2 "><p id="p5461741124111"><a name="p5461741124111"></a><a name="p5461741124111"></a>调用本接口创建的Context中包含1个默认Stream。</p>
    </td>
    </tr>
    </tbody>
    </table>

-   如果在应用程序中没有调用[aclrtSetDevice](aclrtSetDevice.md)接口，那么在首次调用aclrtCreateContext接口时，系统内部会根据该接口传入的Device ID，为该Device绑定一个默认Stream（一个Device仅绑定一个默认Stream），因此在首次调用aclrtCreateContext接口时，占用的Stream数量 = Device上绑定的默认Stream + Context中包含的Stream。

