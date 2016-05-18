<%@ Page Language="C#" AutoEventWireup="true" validateRequest="false" CodeFile="WeiboCreate.aspx.cs" Inherits="_Admin_Weibo_Create" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>创建(Weibo)-数据维护-益跑网</title>
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<meta http-equiv="content-language" content="zh-cn" />
<link href="/Common/Frame.css" type="text/css" rel="stylesheet" />
<link href="/Common/Calendar.css" type="text/css" rel="stylesheet" />
    
</head>
<body>

<!-- 信息输入开始 -->
<form id="form1" name="form1" action="WeiboCreate.aspx" method="post">
<table id="tableCreate" width="100%" cellpadding="0" cellspacing="0" border="1" bordercolor="#CCCCCC" style="border-collapse:collapse;">
<tr>
	<td align="right" valign="top">图片：</td>
	<td>
		<div>
    <p><input type="button" value="修改头像" class="WhiteButton" id="PortraitAlter"/></p>
    <p>
        <ul>
            <li><b>当前头像</b></li>
            <li><img src="/images/noname.gif" id="portrait" alt=""/></li>
        </ul>
        
    </p>
    </div>
        <div id="operation-box">
        <div id="header">
         <table>
             <tr>
                 <td>
                     <div class="fileinput-button">
            <span><input type="button" value="上传图片" class="WhiteButton" id="UploadFile"/></span>
            <input id="fileupload" type="file" name="file"/>
            </div>

                 </td>
                 <td>
                     <input type="button" value="取消" class="WhiteButton" id="Cancel"/>
                 </td>
             </tr>

         </table>
        </div>
        <div id="content">
           <table>
               <tr>
                   <td id="result">
                       
                   </td>
                   <td valign="top">
                       <div style="width:150px;height:150px;overflow:hidden;margin-left:5px;">
	                        <img src="" id="preview" style="display:none;" />
                        </div>
                        <input type="hidden" id="x" />
<input type="hidden" id="y" />
<input type="hidden" id="w" />
<input type="hidden" id="h" />
                        <div id="oper" style="margin-top:10px;">
                            
                        </div>
                   </td>
               </tr>
           </table>
        </div>
    </div>
	</td>
</tr>
<tr>
	<td align="right" valign="top">比赛日期：</td>
	<td>
		<input type="text" id="cUsername" name="cUsername" size="0" maxlength="32" value="" > 
	</td>
</tr>
<tr>
	<td align="right" valign="top">赛事网址：</td>
	<td>
		<input type="text" id="cUserUrl" name="cUserUrl" size="60" maxlength="128" value="" > 
	</td>
</tr>
<tr>
	<td align="right" valign="top">赛事名称：</td>
	<td>
		<textarea id="cContent" name="cContent" cols="60" rows="5"></textarea> 
	</td>
</tr>
<tr>
	<td>
		<input type="hidden" id="UpdatedFields" name="UpdatedFields" value="">
	</td>
	<td>
		<div style="float:left;width:100px;height:32px;">
			<img src="/Images/submit.gif" onclick="Finish()">
		</div>
		<div id="total_echo" style="float:left;width:300px;height:22px;padding-top:10px;" class="check_echo">
		<% =PageResult %>
		</div>
	</td>
</tr>
</table>
</form>

<!-- 信息输入相关javascript代码，需jQuery支持 -->
<script language="javascript">

function Finish()
{
	var check_num = 4;
	var obj = $("#cFaceUrl")[0];
	if(NullCheck(obj)) if(StringCheck(obj)) { check_num--; }
	var obj = $("#cUsername")[0];
	if(NullCheck(obj)) if(StringCheck(obj)) { check_num--; }
	var obj = $("#cUserUrl")[0];
	if(NullCheck(obj)) if(StringCheck(obj)) { check_num--; }
	//var obj = $("#cWeiboUrl")[0];
	//if(NullCheck(obj)) if(StringCheck(obj)) { check_num--; }
	var obj = $("#cContent")[0];
	if(NullCheck(obj)) if(StringCheck(obj)) { check_num--; }
	if(check_num == 0)
	{
		document.form1.submit();
		return true;
	}
	else
	{
		$("#total_echo").html("不行啊！提交数据还有错误哦！");
	}
	return false;
}

</script>

</body>
</html>
<!--Powered by Beijing Legalsoft Ltd.-->
<!--This file formatted by WizForm 2.1 at 10-09 13:39-->

