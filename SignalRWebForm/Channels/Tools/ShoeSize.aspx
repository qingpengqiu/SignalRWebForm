<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ShoeSize.aspx.cs" Inherits="_Channels_Tools_ShoeSize" %>
<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>Ь����ձ�</title>
<meta name="description" content="�й���һ��רҵ�ܲ��Ż���վ��������������רҵ���ܲ����ݺͲ�Ʒ�������ܲ������ߡ����ֲ������̺�������֯�ߵ�ȫ��λרҵ���񣬴���ҵ��һ����ȫ�ܲ���̬��ƽ̨�����ܲ��������������Ľ�����������Ϊ��ᳱ����ʱ�С�" />

<meta name="keywords" content="2013���Ź���������,����,���Ӿ���,����ָ��,�ܲ�,ѵ��,����,�ܲ���վ,�ܲ���,ԽҰ,�ܲ���,�ܲ�ѵ��,�������,Ů���ܲ�,Ů���ܲ�,Ӫ��,����,����,����,�ܲ�����,��������,�ܲ�����,�ܲ�����,5KM,10KM,���������,ȫ��������,ԽҰ��,�ܲ�����,ר��ѵ��,��������,Ů��װ��,ѵ������,�ܲ�����,��Ь,�ܲ�Ь,��������,�ܲ���װ,�ܲ����,�����ܲ�,�˲��ָ�,�������,��ʳ,����,��������,��������,���ڸ���,��������,�ܲ�Ӣ��,�ܲ����,Ϊʲô��,��ο�ʼ,��һ�α���,�������� ,�ﾶ����,�ﾶ����,��·��,����,����,����,����,�̿�,����,�����,�п�,���,����,����,Ь��,ѹ��,�ָ�,���Ӳ�Ʒ,����,����,����,����,����,����,ñ��,ͷ��,��ˮϵͳ,����,����,��������,Ь��,�˶���,�ܲ��۾�,GPS,����,�ܲ��ֱ�,������,��Ƭ,��Ʒ,��Һ,������" />
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<meta http-equiv="content-language" content="zh-cn" />
<meta name="distribution" content="global" />
<link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
<link rel="stylesheet" type="text/css" href="/Html/css/rece.css" />
<link href="/Common/tools.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="/Common/jQuery.js?2012111"></script>
<script language="javascript" src="/Common/jCheck.js?2012111"></script>
<script language="javascript" src="/Common/jPopupfbk.js?2012111"></script>
<script language="javascript" src="/Common/jCalendar.js?2012111"></script>	
</head>
<body>
    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
<!--�ڶ���-->
<div id="H2_w">
	<div id="cal_main">
		<div id="guide">
			<ul>
				<li><a href="PaceCalculator.aspx">���ټ�������Pace Calculator��</a></li>
				<li><a href="PaceConverter.aspx">����ת������Pace Converter��</a></li>
				<li><a href="FinishTime.aspx">���ܼ�������Finish Time��</a></li>
				<li><a href="MarathonPace.aspx">����������ָ��<em>��Marathon Pace��</em></a></li>
				<li><a href="AgeGrade.aspx">����ȼ���������Age-graded��</a></li>
				<li><a href="BMI.aspx">BMI����ָ��������</a></li>
				<li><a href="Calorie.aspx">��·���������Calorie��</a></li>
				<li><a href="Training.aspx">ѵ��������</a></li>
				<li><a href="Grade.aspx">�����˶�Ա�ȼ�</a></li>
				<li><a href="BMR.aspx">������л������</a></li>
				<li class="dq"><a href="ShoeSize.aspx">Ь����ձ�</a></li>
				<li><a href="Converter.aspx">��Ӣ��ת��</a>	</li>
			</ul>			
			<script language="javascript" src="/common/jtools.js"></script>	
		</div>
		<div id="cont">
			<span>Ь����ձ�</span>
			<p>
			</p>	
			<div id="jieguo">											
			��Ь��<br>
			<table id="tab" width="100%" border="1" bordercolor="#CCCCCC" cellpadding="0" cellspacing="0">
			<tr><td>US Men's</td><td>6.0</td><td>6.5</td><td>7.0</td><td>7.5</td><td>8.0</td><td>8.5</td><td>9.0</td><td>9.5</td><td>10.0</td></tr>
			<tr><td>Ӣ��(UK)</td><td>5.5</td><td>6.0</td><td>6.5</td><td>7.0</td><td>7.5</td><td>8.0</td><td>8.5</td><td>9.0</td><td>9.5</td></tr>
			<tr><td>ŷ����(EU��FR)</td><td>38 2/3</td><td>39 1/3</td><td>40</td><td>40 2/3</td><td>41 1/3</td><td>42</td><td>42 2/3</td><td>43 1/3</td><td>44</td></tr>
			<tr><td>�ձ�Ь�루JP��</td><td>240</td><td>245</td><td>250</td><td>255</td><td>260</td><td>265</td><td>270</td><td>275</td><td>280</td></tr>
			<tr><td>�й���½��Ь��</td><td>38</td><td>39</td><td>40</td><td>41</td><td>42</td><td>43</td><td>44</td><td>45</td><td>46</td></tr>
			</table>
			ŮЬ��<br>
			<table id="tab" width="100%" border="1" bordercolor="#CCCCCC" cellpadding="0" cellspacing="0">
			<tr><td>US Women's</td><td>5.0</td><td>5.5</td><td>6.0</td><td>6.5</td><td>7.0</td><td>7.5</td><td>8.0</td><td>8.5</td><td>9.0</td></tr>
			<tr><td>Ӣ��(UK)</td><td>4.0</td><td>4.5</td><td>5.0</td><td>5.5</td><td>6.0</td><td>6.5</td><td>7.0</td><td>7.5</td><td>8.0</td></tr>
			<tr><td>ŷ����(EU��FR)</td><td>36</td><td>36 2/3</td><td>37 1/3</td><td>38</td><td>38 2/3</td><td>39 1/3</td><td>40</td><td>40 2/3</td><td>41 1/3</td></tr>
			<tr><td>�ձ�Ь�루JP��</td><td>220</td><td>225</td><td>230</td><td>235</td><td>240</td><td>245</td><td>250</td><td>255</td><td>260</td></tr>
			<tr><td>�й���½��Ь��</td><td>34</td><td>35</td><td>36</td><td>37</td><td>38</td><td>39</td><td>40</td><td>41</td><td>42</tr>
			</table>
			</div>			
		</div>
	</div>
</div>
<ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
</body>
</html>
