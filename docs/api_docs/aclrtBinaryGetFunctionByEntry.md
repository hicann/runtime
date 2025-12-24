# aclrtBinaryGetFunctionByEntry<a name="ZH-CN_TOPIC_0000002235745169"></a>

**须知：本接口为预留接口，暂不支持。**

## 功能说明<a name="section73552454261"></a>

根据Function Entry获取核函数句柄。

## 函数原型<a name="section195491952142612"></a>

```
aclError aclrtBinaryGetFunctionByEntry(aclrtBinHandle binHandle, uint64_t funcEntry, aclrtFuncHandle *funcHandle)
```

## 参数说明<a name="section155499553266"></a>

<a name="zh-cn_topic_0122830089_table438764393513"></a>
<table><thead align="left"><tr id="zh-cn_topic_0122830089_row53871743113510"><th class="cellrowborder" valign="top" width="18%" id="mcps1.1.4.1.1"><p id="zh-cn_topic_0122830089_p1438834363520"><a name="zh-cn_topic_0122830089_p1438834363520"></a><a name="zh-cn_topic_0122830089_p1438834363520"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.2"><p id="p1769255516412"><a name="p1769255516412"></a><a name="p1769255516412"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="68%" id="mcps1.1.4.1.3"><p id="zh-cn_topic_0122830089_p173881843143514"><a name="zh-cn_topic_0122830089_p173881843143514"></a><a name="zh-cn_topic_0122830089_p173881843143514"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="row7909131293411"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p1912212521619"><a name="p1912212521619"></a><a name="p1912212521619"></a>binHandle</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p171219521613"><a name="p171219521613"></a><a name="p171219521613"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p14111122374218"><a name="p14111122374218"></a><a name="p14111122374218"></a>算子二进制句柄。</p>
<p id="p74571231121"><a name="p74571231121"></a><a name="p74571231121"></a>调用<a href="aclrtBinaryLoadFromFile.md">aclrtBinaryLoadFromFile</a>接口或<a href="aclrtBinaryLoadFromData.md">aclrtBinaryLoadFromData</a>接口获取算子二进制句柄，再将其作为入参传入本接口。</p>
</td>
</tr>
<tr id="row153124110712"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p5531134114711"><a name="p5531134114711"></a><a name="p5531134114711"></a>funcEntry</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p2053116411713"><a name="p2053116411713"></a><a name="p2053116411713"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p86771625092"><a name="p86771625092"></a><a name="p86771625092"></a>标识核函数的关键字。</p>
</td>
</tr>
<tr id="row107134414713"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p771134418717"><a name="p771134418717"></a><a name="p771134418717"></a>funcHandle</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p1719447716"><a name="p1719447716"></a><a name="p1719447716"></a>输出</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p117117448711"><a name="p117117448711"></a><a name="p117117448711"></a>核函数句柄。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section1435713587268"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

