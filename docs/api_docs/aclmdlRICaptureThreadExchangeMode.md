# aclmdlRICaptureThreadExchangeMode<a name="ZH-CN_TOPIC_0000002227559853"></a>

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于商用产品中。**

## AI处理器支持情况<a name="section42891738171919"></a>

<a name="table38301303189"></a>
<table><thead align="left"><tr id="row20831180131817"><th class="cellrowborder" valign="top" width="57.99999999999999%" id="mcps1.1.3.1.1"><p id="p1883113061818"><a name="p1883113061818"></a><a name="p1883113061818"></a>产品</p>
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

切换当前线程的捕获模式。

调用本接口会将调用线程的捕获模式设置为\*mode中包含的值，并通过\*mode返回该线程之前设置的模式。

## 函数原型<a name="section13230182415108"></a>

```
aclError aclmdlRICaptureThreadExchangeMode(aclmdlRICaptureMode *mode)
```

## 参数说明<a name="section75395119104"></a>

<a name="zh-cn_topic_0122830089_table438764393513"></a>
<table><thead align="left"><tr id="zh-cn_topic_0122830089_row53871743113510"><th class="cellrowborder" valign="top" width="15%" id="mcps1.1.4.1.1"><p id="zh-cn_topic_0122830089_p1438834363520"><a name="zh-cn_topic_0122830089_p1438834363520"></a><a name="zh-cn_topic_0122830089_p1438834363520"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="15%" id="mcps1.1.4.1.2"><p id="p1769255516412"><a name="p1769255516412"></a><a name="p1769255516412"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="70%" id="mcps1.1.4.1.3"><p id="zh-cn_topic_0122830089_p173881843143514"><a name="zh-cn_topic_0122830089_p173881843143514"></a><a name="zh-cn_topic_0122830089_p173881843143514"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="row8170205510541"><td class="cellrowborder" valign="top" width="15%" headers="mcps1.1.4.1.1 "><p id="p151701955165416"><a name="p151701955165416"></a><a name="p151701955165416"></a>mode</p>
</td>
<td class="cellrowborder" valign="top" width="15%" headers="mcps1.1.4.1.2 "><p id="p717015551544"><a name="p717015551544"></a><a name="p717015551544"></a>输入&amp;输出</p>
</td>
<td class="cellrowborder" valign="top" width="70%" headers="mcps1.1.4.1.3 "><p id="p18387152453615"><a name="p18387152453615"></a><a name="p18387152453615"></a>捕获模式，用于限制非安全函数（包括aclrtMemset、aclrtMemcpy、aclrtMemcpy2d）的作用范围。</p>
<div class="p" id="p966738555"><a name="p966738555"></a><a name="p966738555"></a>建议在<a href="aclmdlRICaptureBegin.md">aclmdlRICaptureBegin</a>和<a href="aclmdlRICaptureEnd.md">aclmdlRICaptureEnd</a>接口之间调用本接口切换当前线程的模式。各捕获模式的配置说明如下，说明中的其它线程指“没有调用aclmdlRICaptureBegin接口、不在捕获状态”的线程。<a name="ul14730125435917"></a><a name="ul14730125435917"></a><ul id="ul14730125435917"><li>若aclmdlRICaptureBegin接口将捕获模式设置为ACL_MODEL_RI_CAPTURE_MODE_RELAXED（下文简称RELAXED模式），表示所有线程都可以调用非安全函数，这时即使在其它线程（指不在捕获状态的线程）中调用本接口将捕获模式设置为其它值也不会生效，其它线程还是按照RELAXED模式。</li><li>若aclmdlRICaptureBegin接口将捕获模式设置为ACL_MODEL_RI_CAPTURE_MODE_THREAD_LOCAL（下文简称THREAD_LOCAL模式），表示当前线程禁止调用非安全函数，但其它线程可以调用非安全函数。如果本线程要调用非安全函数，需调用本接口将当前线程模式切换为RELAXED模式。</li><li>若aclmdlRICaptureBegin接口将捕获模式设置为ACL_MODEL_RI_CAPTURE_MODE_GLOBAL（下文简称GLOBAL模式），表示所有线程都不可以调用非安全函数。本线程若要调用非安全函数，需调用本接口切换为RELAXED模式，其它线程若要调用非安全函数，需调用本接口切换为RELAXED模式或THREAD_LOCAL模式。</li></ul>
</div>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section25791320141317"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

