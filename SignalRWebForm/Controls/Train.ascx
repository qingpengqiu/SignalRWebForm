<%@ Control Language="C#" AutoEventWireup="true" %>

		<div id="H2_R_t" onclick="window.location='/utility/train/smarts.aspx';" title="����鿴����[ѵ���ƻ�]��Ѷ">
			ѵ���ƻ�
		</div>
		<div id="H2_R_1_1">
			<style>
			#smart * { font-size:12px;color:#AAAAAA; }
			#smart a { font-size:14px;color:#5C6F9A; }
         #smart select { width:70px; }
			</style>
			<table id="smart">
			<tr>
				<td align="right" style="width:60px;">��ǰ���ܣ�</td>
				<td>
               <% =GCommon.Controls("��ǰ����","select", "cRunNow", "") %>
				</td>
			</tr>
			<tr>
				<td align="right">��ʱ��</td>
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
					</select>ʱ

					<select id="" name="" style="width:40px;">
               <script langauge="javascript">AddOptions(60);</script>
					</select>��

					<select id="" name="" style="width:40px;">
               <script langauge="javascript">AddOptions(60);</script>
					</select>��

				</td>
			</tr>
			<tr>
				<td align="right"></td>
				<td style="color:#AAAAAA;">
					����㲻֪��ʱ�䣬������һ����׼<br>
               400���ܵ���������ٶ���4Ȧ������<br>
               ���ʱ�䣬ѡ��1.6����ѡ��ɡ�
				</td>
			</tr>
			<tr>
				<td align="right">ѵ��Ŀ�꣺</td>
				<td>
               <% =GCommon.Controls("ѵ��Ŀ��","select", "cRunDestination", "") %>
               ǿ�ȣ�
               <% =GCommon.Controls("ǿ��","select", "cTrainStyle", "") %>
				</td>
			</tr>
			<tr>
				<td align="right">ÿ��������</td>
				<td>
               <% =GCommon.Controls("ÿ������","select", "cRunWeek", "") %>
					�����գ�
					<select id="cRunAt" name="cRunAt">
					<option value="6">����</option>
					<option value="7">����</option>
					<option value="1">��һ</option>
					<option value="2">�ܶ�</option>
					<option value="3">����</option>
					<option value="4">����</option>
					<option value="5">����</option>
					</select>
				</td>
			</tr>
			<tr>
				<td align="right">�������ڣ�</td>
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

