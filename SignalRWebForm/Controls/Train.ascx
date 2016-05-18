<%@ Control Language="C#" AutoEventWireup="true" %>

		<div id="H2_R_t" onclick="window.location='/utility/train/smarts.aspx';" title="点击查看更多[训练计划]资讯">
			训练计划
		</div>
		<div id="H2_R_1_1">
			<style>
			#smart * { font-size:12px;color:#AAAAAA; }
			#smart a { font-size:14px;color:#5C6F9A; }
         #smart select { width:70px; }
			</style>
			<table id="smart">
			<tr>
				<td align="right" style="width:60px;">当前你跑：</td>
				<td>
               <% =GCommon.Controls("当前你跑","select", "cRunNow", "") %>
				</td>
			</tr>
			<tr>
				<td align="right">用时：</td>
				<td>
					<select id="" name="" style="width:40px;">
               <script langauge="javascript">
               function AddOptions(n)
               {
                  for(var i=0; i<n; i++) {
                     document.write("<option value=\"" + i + "\">" + i + "</option>");
                  }
               }
               AddOptions(5);
               </script>
					</select>时

					<select id="" name="" style="width:40px;">
               <script langauge="javascript">AddOptions(60);</script>
					</select>分

					<select id="" name="" style="width:40px;">
               <script langauge="javascript">AddOptions(60);</script>
					</select>秒

				</td>
			</tr>
			<tr>
				<td align="right"></td>
				<td style="color:#AAAAAA;">
					如果你不知道时间，可以找一个标准<br>
               400米跑道，以最快速度跑4圈，记下<br>
               这个时间，选择1.6管理选项即可。
				</td>
			</tr>
			<tr>
				<td align="right">训练目标：</td>
				<td>
               <% =GCommon.Controls("训练目标","select", "cRunDestination", "") %>
               强度：
               <% =GCommon.Controls("强度","select", "cTrainStyle", "") %>
				</td>
			</tr>
			<tr>
				<td align="right">每周跑量：</td>
				<td>
               <% =GCommon.Controls("每周跑量","select", "cRunWeek", "") %>
					长跑日：
					<select id="cRunAt" name="cRunAt">
					<option value="6">周六</option>
					<option value="7">周日</option>
					<option value="1">周一</option>
					<option value="2">周二</option>
					<option value="3">周三</option>
					<option value="4">周四</option>
					<option value="5">周五</option>
					</select>
				</td>
			</tr>
			<tr>
				<td align="right">比赛日期：</td>
				<td>
					<input type="text" id="cAnswer" name="cAnswer" size="20" maxlength="255"  readonly value="1966-8-8" onclick="GDate(this);" style="background-color:#E0E0E0;cursor:pointer;">
				</td>
			</tr>
			<tr>
				<td align="right"></td>
				<td>
					<img src="/images/search.gif">
				</td>
			</tr>
			</table>
		</div>

