using System;
using System.IO;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Utility_ImportPrc : System.Web.UI.Page
{
    public string PageResult = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Form.Count > 0)
        {
            // 来源判别
            if (!Me.HostRequired)
            {
                Response.Redirect("/Member/");
            }

            int cnt = 0;

            string cContent = "";

            if (Request.Form["cContent"] != null)
            {
                cContent = Request.Form["cContent"].ToString();
            }

            Blog table = new Blog();
            BlogInfo record = new BlogInfo();

            string[] lines = cContent.Split('\n');
            StringBuilder sb = new StringBuilder();
            StringBuilder sk = new StringBuilder();
            int line_number = 1;
            foreach (string lbuf in lines)
            {
                string rbuf = lbuf.Replace("\r", "").Trim();
                if (line_number > 3 && rbuf.Length < 1) continue;

                if (rbuf.StartsWith("######"))
                {
                    string fbuf = sb.ToString();
                    if (fbuf.Length > 100)
                    {
                        record.cContent = fbuf;
                        if (record.idUser == 0)
                        {
                            sk.AppendLine("导入(" + cnt + "):" + record.cLoginName + " - " + record.cTitle + " 失败！没有改注册用户信息！<br>");
                        }
                        else
                        {
                            int recordIndex = 0;
                            table.Insert(record, out recordIndex);
                            sk.AppendLine("导入(" + cnt + "):" + record.cLoginName + " - " + record.cTitle + " 成功！<br>");
                            cnt++;
                        }
                    }
                    record.idUser = 0;
                    sb.Remove(0, sb.Length);
                    line_number = 1;
                }
                else
                {
                    if (line_number == 1)
                    {
                        record.cTitle = rbuf;
                        line_number++;
                        continue;
                    }
                    if (line_number == 3)
                    {
                        record.idUser = Users.FindByName(rbuf);
                        record.cLoginName = rbuf;
                        line_number++;
                        continue;
                    }
                    sb.AppendLine(rbuf);
                    line_number++;
                }
            }

            // 最后一篇
            string fbuf2 = sb.ToString();
            if (fbuf2.Length > 100)
            {
                record.cContent = fbuf2;
                int recordIndex = 0;
                table.Insert(record, out recordIndex);
                cnt++;
            }

            //sk.AppendLine("总共成功导入了 " + cnt.ToString() + " 篇博客！");
            //PageResult = sk.ToString();

            Response.Redirect("Import.aspx?cnt=" + cnt);
        }
    }
}
