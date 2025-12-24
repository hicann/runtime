# aclrtResetDeviceForce<a name="ZH-CN_TOPIC_0000002012779577"></a>

## AI处理器支持情况<a name="section68811473306"></a>

<a name="table94291331317"></a>
<table><thead align="left"><tr id="zh-cn_topic_0000002219420921_row779211127302"><th class="cellrowborder" valign="top" width="57.99999999999999%" id="mcps1.1.3.1.1"><p id="zh-cn_topic_0000002219420921_p1792161212300"><a name="zh-cn_topic_0000002219420921_p1792161212300"></a><a name="zh-cn_topic_0000002219420921_p1792161212300"></a><span id="zh-cn_topic_0000002219420921_ph117928121306"><a name="zh-cn_topic_0000002219420921_ph117928121306"></a><a name="zh-cn_topic_0000002219420921_ph117928121306"></a>AI处理器类型</span></p>
</th>
<th class="cellrowborder" align="center" valign="top" width="42%" id="mcps1.1.3.1.2"><p id="zh-cn_topic_0000002219420921_p1079218122304"><a name="zh-cn_topic_0000002219420921_p1079218122304"></a><a name="zh-cn_topic_0000002219420921_p1079218122304"></a>是否支持</p>
</th>
</tr>
</thead>
<tbody><tr id="zh-cn_topic_0000002219420921_row579201253010"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="zh-cn_topic_0000002219420921_p37922126304"><a name="zh-cn_topic_0000002219420921_p37922126304"></a><a name="zh-cn_topic_0000002219420921_p37922126304"></a><span id="zh-cn_topic_0000002219420921_ph379211121301"><a name="zh-cn_topic_0000002219420921_ph379211121301"></a><a name="zh-cn_topic_0000002219420921_ph379211121301"></a><term id="zh-cn_topic_0000002219420921_zh-cn_topic_0000001312391781_term1253731311225"><a name="zh-cn_topic_0000002219420921_zh-cn_topic_0000001312391781_term1253731311225"></a><a name="zh-cn_topic_0000002219420921_zh-cn_topic_0000001312391781_term1253731311225"></a>Ascend 910C</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="zh-cn_topic_0000002219420921_p12792161215309"><a name="zh-cn_topic_0000002219420921_p12792161215309"></a><a name="zh-cn_topic_0000002219420921_p12792161215309"></a>√</p>
</td>
</tr>
<tr id="zh-cn_topic_0000002219420921_row1879251215304"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="zh-cn_topic_0000002219420921_p379291210301"><a name="zh-cn_topic_0000002219420921_p379291210301"></a><a name="zh-cn_topic_0000002219420921_p379291210301"></a><span id="zh-cn_topic_0000002219420921_ph207921912173014"><a name="zh-cn_topic_0000002219420921_ph207921912173014"></a><a name="zh-cn_topic_0000002219420921_ph207921912173014"></a><term id="zh-cn_topic_0000002219420921_zh-cn_topic_0000001312391781_term11962195213215"><a name="zh-cn_topic_0000002219420921_zh-cn_topic_0000001312391781_term11962195213215"></a><a name="zh-cn_topic_0000002219420921_zh-cn_topic_0000001312391781_term11962195213215"></a>Ascend 910B</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="zh-cn_topic_0000002219420921_p5792191223019"><a name="zh-cn_topic_0000002219420921_p5792191223019"></a><a name="zh-cn_topic_0000002219420921_p5792191223019"></a>√</p>
</td>
</tr>
</tbody>
</table>

## 功能说明<a name="section36583473819"></a>

复位当前运算的Device，释放Device上的资源。释放的资源包括默认Context、默认Stream以及默认Context下创建的所有Stream。若默认Context或默认Stream下的任务还未完成，系统会等待任务完成后再释放。

aclrtResetDeviceForce接口可与aclrtSetDevice接口配对使用，也可不与aclrtSetDevice接口配对使用，若不配对使用，一个进程中，针对同一个Device，调用一次或多次aclrtSetDevice接口后，仅需调用一次aclrtResetDeviceForce接口可释放Device上的资源。

```
# 与aclrtSetDevice接口配对使用：
aclrtSetDevice(1) -> aclrtResetDeviceForce(1) -> aclrtSetDevice(1) -> aclrtResetDeviceForce(1)
 
# 与aclrtSetDevice接口不配对使用：
aclrtSetDevice(1) -> aclrtSetDevice(1) -> aclrtResetDeviceForce(1)
```

## 函数原型<a name="section13230182415108"></a>

```
aclError aclrtResetDeviceForce(int32_t deviceId)
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
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section25791320141317"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明<a name="section17997507213"></a>

-   多线程场景下，针对同一个Device，如果每个线程中都调用[aclrtSetDevice](aclrtSetDevice.md)接口、aclrtResetDeviceForce接口，如下所示，线程2中的aclrtResetDeviceForce接口会返回报错，因为线程1中aclrtResetDeviceForce接口已经释放了Device 1的资源：

    ```
    时间线 ----------------------------------------------------------------------------->
    线程1：aclrtSetDevice(1)           aclrtResetDeviceForce(1)
    线程2：aclrtSetDevice(1)                                   aclrtResetDeviceForce(1)
    ```

    多线程场景下，正确方式是应在线程执行的最后，调用一次aclrtResetDeviceForce释放Device资源，如下所示：

    ```
    时间线 ----------------------------------------------------------------------------->
    线程1：aclrtSetDevice(1)    
    线程2：aclrtSetDevice(1)                                   aclrtResetDeviceForce(1)
    ```

-   [aclrtResetDevice](aclrtResetDevice.md)接口与aclrtResetDeviceForce接口可以混用，但混用时，若两个Reset接口的调用次数、调用顺序不对，接口会返回报错。

    ```
    # 混用时的正确方式：
    # 两个Reset接口都分别与Set接口配对使用，且aclrtResetDeviceForce接口在aclrtResetDevice接口之后
    aclrtSetDevice(1) -> aclrtResetDevice(1) -> aclrtSetDevice(1) -> aclrtResetDeviceForce(1)
    aclrtSetDevice(1) -> aclrtSetDevice(1) -> aclrtResetDevice(1) -> aclrtResetDeviceForce(1)
    
    # 混用时的错误方式：
    # aclrtResetDevice接口内部涉及引用计数的实现，当aclrtResetDevice接口每被调用一次，则该引用计数减1，当引用计数减到0时，会真正释放Device上的资源，此时再调用aclrtResetDevice或aclrtResetDeviceForce接口都会报错
    aclrtSetDevice(1) -> aclrtSetDevice(1) -> aclrtResetDevice(1)-->aclrtResetDevice(1)-->aclrtResetDeviceForce(1)
    aclrtSetDevice(1) -> aclrtSetDevice(1) -> aclrtResetDevice(1)-->aclrtResetDeviceForce(1)-->aclrtResetDeviceForce(1)
    # aclrtResetDeviceForce接口在aclrtResetDevice接口之后，否则接口返回报错
    aclrtSetDevice(1) -> aclrtSetDevice(1) -> aclrtResetDeviceForce(1)-->aclrtResetDevice(1)
    ```

