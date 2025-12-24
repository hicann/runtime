# aclrtSetDevice<a name="ZH-CN_TOPIC_0000001312400781"></a>

## AI处理器支持情况<a name="section8178181118225"></a>

<a name="table38301303189"></a>
<table><thead align="left"><tr id="row20831180131817"><th class="cellrowborder" valign="top" width="57.99999999999999%" id="mcps1.1.3.1.1"><p id="p1883113061818"><a name="p1883113061818"></a><a name="p1883113061818"></a><span id="ph20833205312295"><a name="ph20833205312295"></a><a name="ph20833205312295"></a>AI处理器类型</span></p>
</th>
<th class="cellrowborder" align="center" valign="top" width="42%" id="mcps1.1.3.1.2"><p id="p783113012187"><a name="p783113012187"></a><a name="p783113012187"></a>是否支持</p>
</th>
</tr>
</thead>
<tbody><tr id="row220181016240"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="p48327011813"><a name="p48327011813"></a><a name="p48327011813"></a><span id="ph583230201815"><a name="ph583230201815"></a><a name="ph583230201815"></a><term id="zh-cn_topic_0000001312391781_term1253731311225"><a name="zh-cn_topic_0000001312391781_term1253731311225"></a><a name="zh-cn_topic_0000001312391781_term1253731311225"></a>Ascend 910C</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p7948163910184"><a name="p7948163910184"></a><a name="p7948163910184"></a>√</p>
</td>
</tr>
<tr id="row173226882415"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="p14832120181815"><a name="p14832120181815"></a><a name="p14832120181815"></a><span id="ph1483216010188"><a name="ph1483216010188"></a><a name="ph1483216010188"></a><term id="zh-cn_topic_0000001312391781_term11962195213215"><a name="zh-cn_topic_0000001312391781_term11962195213215"></a><a name="zh-cn_topic_0000001312391781_term11962195213215"></a>Ascend 910B</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p19948143911820"><a name="p19948143911820"></a><a name="p19948143911820"></a>√</p>
</td>
</tr>
</tbody>
</table>

## 功能说明<a name="section36583473819"></a>

指定当前线程中用于运算的Device。

## 函数原型<a name="section13230182415108"></a>

```
aclError aclrtSetDevice(int32_t deviceId)
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
<tbody><tr id="zh-cn_topic_0122830089_row2038874343514"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="zh-cn_topic_0122830089_p1088611422254"><a name="zh-cn_topic_0122830089_p1088611422254"></a><a name="zh-cn_topic_0122830089_p1088611422254"></a>deviceId</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p8693185517417"><a name="p8693185517417"></a><a name="p8693185517417"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="zh-cn_topic_0122830089_p19388143103518"><a name="zh-cn_topic_0122830089_p19388143103518"></a><a name="zh-cn_topic_0122830089_p19388143103518"></a>Device ID。</p>
<p id="p5103103751315"><a name="p5103103751315"></a><a name="p5103103751315"></a>用户调用<a href="aclrtGetDeviceCount.md">aclrtGetDeviceCount</a>接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)]</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section25791320141317"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明<a name="section1797013523213"></a>

-   调用aclrtSetDevice接口指定运算的Device后，若不使用Device上的资源时，可调用[aclrtResetDevice](aclrtResetDevice.md)或[aclrtResetDeviceForce](aclrtResetDeviceForce.md)接口及时释放本进程使用的Device资源（若不调用这两个接口，功能上不会有问题，因为在进程退出时也会释放本进程使用的Device资源）：
    -   若调用[aclrtResetDevice](aclrtResetDevice.md)接口释放Device资源：

        aclrtResetDevice接口内部涉及引用计数的实现，建议aclrtResetDevice接口与[aclrtSetDevice](aclrtSetDevice.md)接口配对使用，aclrtSetDevice接口每被调用一次，则引用计数加一，aclrtResetDevice接口每被调用一次，则该引用计数减一，当引用计数减到0时，才会真正释放Device上的资源。

    -   若调用[aclrtResetDeviceForce](aclrtResetDeviceForce.md)接口释放Device资源：

        aclrtResetDeviceForce接口可与aclrtSetDevice接口配对使用，也可不与aclrtSetDevice接口配对使用，若不配对使用，一个进程中，针对同一个Device，调用一次或多次aclrtSetDevice接口后，仅需调用一次aclrtResetDeviceForce接口可释放Device上的资源。

-   在不同进程或线程中支持调用aclrtSetDevice接口指定同一个Device用于运算。在同一个进程中的多个线程中，如果调用aclrtSetDevice接口指定同一个Device用于运算，这时隐式创建的默认Context是同一个。
-   多Device场景下，可在进程中通过aclrtSetDevice接口切换到其它Device，也可以调用[aclrtSetCurrentContext](aclrtSetCurrentContext.md)接口通过切换Context来切换Device。
-   不同产品型号上，调用本接口隐式创建的Stream数量不同，如下表所示。

    <a name="table1042115287418"></a>
    <table><thead align="left"><tr id="row2042242816417"><th class="cellrowborder" valign="top" width="43.41%" id="mcps1.1.3.1.1"><p id="p4422112804119"><a name="p4422112804119"></a><a name="p4422112804119"></a>型号</p>
    </th>
    <th class="cellrowborder" valign="top" width="56.589999999999996%" id="mcps1.1.3.1.2"><p id="p1542282844112"><a name="p1542282844112"></a><a name="p1542282844112"></a>默认Context和默认Stream的说明</p>
    </th>
    </tr>
    </thead>
    <tbody><tr id="row96171042144115"><td class="cellrowborder" valign="top" width="43.41%" headers="mcps1.1.3.1.1 "><p id="p5563144114415"><a name="p5563144114415"></a><a name="p5563144114415"></a><span id="ph3640204918443"><a name="ph3640204918443"></a><a name="ph3640204918443"></a><term id="zh-cn_topic_0000001312391781_term1253731311225_1"><a name="zh-cn_topic_0000001312391781_term1253731311225_1"></a><a name="zh-cn_topic_0000001312391781_term1253731311225_1"></a>Ascend 910C</term></span></p>
    <p id="p1242751104414"><a name="p1242751104414"></a><a name="p1242751104414"></a><span id="ph107301423444"><a name="ph107301423444"></a><a name="ph107301423444"></a><term id="zh-cn_topic_0000001312391781_term11962195213215_1"><a name="zh-cn_topic_0000001312391781_term11962195213215_1"></a><a name="zh-cn_topic_0000001312391781_term11962195213215_1"></a>Ascend 910B</term></span></p>
    </td>
    <td class="cellrowborder" valign="top" width="56.589999999999996%" headers="mcps1.1.3.1.2 "><p id="p186172042174115"><a name="p186172042174115"></a><a name="p186172042174115"></a>调用本接口会隐式创建默认Context，该默认Context中包含1个默认Stream。</p>
    </td>
    </tr>
    </tbody>
    </table>

