using System;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Utility_BlogUpdate : System.Web.UI.Page
{
    public string PageResult = "";
    public string PageGroups = "";
    public string PageExt = "";

    public BlogInfo record = new BlogInfo();
    public UserInfo u;

    protected void Page_Load(object sender, EventArgs e)
    {
        #region 身份确认
        Member m = new Member();
        if (m.Default == null)
        {
            //PageResult = "没有操作权限！";
            return;
        }
        #endregion

        u = Users.Find(m.Default.id);

        // 读取数据(id)
        int recordIndex = 0;
        if (Request["id"] != null)
        {
            recordIndex = Int32.Parse(XString.PureNumber(Request["id"].ToString()));
        }
        else
        {
            PageResult = "数据错误(Request[id] is null)！";
            return;
        }

        Blog table = new Blog();

        record = table.Load(recordIndex, "", "");
        if (record == null)
        {
            PageResult = "数据错误(Index error)！";
            return;
        }

        if (record.idHref > 0)
        {
            if (record.idHref >= 300000000 && record.idHref < 400000000)
                PageExt = "<a href=\"javascript:\" onclick=\"PopupShow(640,380,'编辑赛事信息','/utility/include/RaceCompetetionUpdate.aspx?id=" + record.idHref + "')\">编辑赛事信息</a>";
            if (record.idHref >= 400000000 && record.idHref < 500000000)
                PageExt = "<a href=\"javascript:\" onclick=\"PopupShow(640,480,'编辑约跑信息','/utility/include/RaceActivityUpdate.aspx?id=" + record.idHref + "')\">编辑约跑信息</a>";
            if (record.idHref >= 500000000 && record.idHref < 600000000)
                PageExt = "<a href=\"javascript:\" onclick=\"PopupShow(640,280,'编辑装备信息','/utility/include/ProductsUpdate.aspx?id=" + record.idHref + "')\">编辑装备信息</a>";
        }

        #region 非信息所有者不可修改

        if (record.idUser != u.id)
        {
            Response.Redirect("/");
        }

        #endregion

        if (Request.Form.Count > 0)
        {
            // 来源判别
            if (!Me.HostRequired)
            {
                Response.Redirect("/Member/");
            }

            record.idUser = u.id;
            record.cLoginName = u.cLoginName;

            #region 有限字段的修改
            if (Request.Form["UpdatedFields"] != null)
            {
                string[] fa = Request.Form["UpdatedFields"].ToString().Split(';');
                StringBuilder cmd = new StringBuilder();
                foreach (string fv in fa)
                {
                    if (fv.Trim().Length < 1) continue;
                    if (Request.Form[fv] != null)
                    {
                        cmd.Append(XString.SqlSafe(fv) + "='" + XString.SqlSafe(Request.Form[fv].ToString()) + "',");
                    }
                }
                if (table.UpdateByCommand(recordIndex, cmd.ToString()))
                {
                    record = table.Load(recordIndex, "", "");
                    PageResult = "数据修改成功！";
                }
                else
                {
                    PageResult = "系统错误：" + table._err;
                }
            }
            #endregion

            TCache.Clear("CACHE_PAGE_MEMBER_" + record.idUser);
            TCache.Clear("CACHE_PAGE_MEMBER_ME_" + record.idUser);

            int idImage = 0;
            if (Request.Form["idImage"] != null)
            {
                /*
                idImage = Int32.Parse("0" + Request.Form["idImage"].ToString());
                if (idImage > 0)
                {
                    Images imgs = new Images();
                    imgs.UpdateByCommand(idImage, "idInfo=" + recordIndex);
                }
                */
                Images imgs = new Images();
                string[] midx = Request.Form["idImage"].ToString().Split(',');
                for (int i = 0; i < midx.Length; i++)
                {
                    if (midx[i].Length > 0)
                    {
                        imgs.UpdateByCommand(Int32.Parse("0" + midx[i]), "idInfo=" + recordIndex);
                    }
                }
            }

            Response.Redirect(UrlHelper.BlogUrl(recordIndex));

        }

        #region 博客分类显示为下拉选择列表
        BlogGroup bg = new BlogGroup();
        PageGroups = bg.UserSelect(m.Default.id, record.idPersonGroup);
        #endregion
    }
}
/* Powered by Beijing Legalsoft Ltd. */
/* This file formatted by WizForm 2.1 at 09-17 09:17 */

