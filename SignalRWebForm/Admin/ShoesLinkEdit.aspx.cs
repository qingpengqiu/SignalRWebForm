using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bll_DB5 = Erun360.BLL.DB5;
using Model_DB5 = Erun360.Model.DB5;
using Bll_DB2 = Erun360.BLL.DB2;
using Model_DB2 = Erun360.Model.DB2;
using Bll_DB1 = Erun360.BLL.DB1;
using Model_DB1 = Erun360.Model.DB1;
using Utils;
using System.Text;

public partial class Admin_ShoesLinkEdit : PageBase
{
    protected string showinfo = string.Empty;
    protected string linktype;
    protected string shoeid;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if ((CurrentUser.uId != 100001183 && CurrentUser.uId != 100055041) && CurrentUser.idMemberStyle != 99)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
        }
        if (!string.IsNullOrEmpty(Request["action"]))
        {
            if (Request["action"] == "add")
            {
                AddLink();
            }
            else if (Request["action"] == "del")
            {
                DelLink();
            }
        }
        if (!IsPostBack)
        {
            linktype = Context.Request["linktype"];
            shoeid = Context.Request["shoeid"];
            switch (linktype)
            {
                case "1":
                    showinfo = "博客文章";
                    break;
                case "2":
                    showinfo = "拼团产品";
                    break;
                default:
                    break;
            }
            this.lblshoeId.Text = shoeid;
            string strwhere = string.Format(" shoesId={0} and linktype={1} ", shoeid, linktype);
            List<Model_DB5.tblShoes_Linked> listofshoeslink = new Bll_DB5.tblShoes_Linked().GetModelList(strwhere);
            if (listofshoeslink.Count > 0)
            {
                StringBuilder shoelinkhtml = new StringBuilder();
                foreach (Model_DB5.tblShoes_Linked shoelink in listofshoeslink)
                {
                    if (shoelink.linktype == 1)
                    {
                        Model_DB2.tblBLOG blogmodel = new Bll_DB2.tblBLOG().GetModel(int.Parse(shoelink.linkedId));
                        if (blogmodel == null)
                        {
                            continue;
                        }
                        shoelinkhtml.AppendFormat("<div id=\"{0}\"><a href=\"/blog/{1}.aspx\" target=\"_blank\">{2}</a>&nbsp;&nbsp;<a href=\"javascript: void(0)\" onclick=\"DelLink({0})\">删除</a></div>", shoelink.Id, shoelink.linkedId, blogmodel.cTitle);
                    }
                    else if (shoelink.linktype == 2)
                    {
                        Model_DB1.tblGoods goodsmodel = new Bll_DB1.tblGoods().GetModel(int.Parse(shoelink.linkedId));
                        if (goodsmodel == null)
                        {
                            continue;
                        }
                        shoelinkhtml.AppendFormat("<div id=\"{0}\"><a href=\"/GroupBuy/Group.aspx?id={1}\" target=\"_blank\">{2}</a>&nbsp;&nbsp;<a href=\"javascript: void(0)\" onclick=\"DelLink({0})\">删除</a></div>", shoelink.Id, shoelink.linkedId, goodsmodel.cName);
                    }
                }
                this.litLinklist.Text = shoelinkhtml.ToString();
            }
        }
    }
    protected void AddLink()
    {
        if (string.IsNullOrEmpty(Request["shoeid"]))
        {
            ResponseEnd("{\"msg\":\"鞋编号不能为空！\",\"status\":\"0\"}");
        }
        if (string.IsNullOrEmpty(Request["linktype"]))
        {
            ResponseEnd("{\"msg\":\"关联类型不能为空！\",\"status\":\"0\"}");
        }
        if (string.IsNullOrEmpty(Request["linkid"]))
        {
            ResponseEnd("{\"msg\":\"关联Id不能为空！\",\"status\":\"0\"}");
        }
        Model_DB5.tblShoes_Linked shoelink = new Model_DB5.tblShoes_Linked();

        shoelink.linkedId = Request["linkid"].ToString().Trim();
        shoelink.shoesId = int.Parse(Request["shoeid"]);
        shoelink.linktype = int.Parse(Request["linktype"]);
        shoelink.adduId = CurrentUser.uId;
        shoelink.addtime = DateTime.Now;
        if (shoelink.linktype == 1)
        {
            Model_DB2.tblBLOG blogmodel = new Bll_DB2.tblBLOG().GetModel(int.Parse(shoelink.linkedId));
            if (blogmodel == null)
            {
                ResponseEnd("{\"msg\":\"此博客不存在！\",\"status\":\"0\"}");
            }
        }
        else if (shoelink.linktype == 2)
        {
            Model_DB1.tblGoods goodsmodel = new Bll_DB1.tblGoods().GetModel(int.Parse(shoelink.linkedId));
            if (goodsmodel == null)
            {
                ResponseEnd("{\"msg\":\"此拼团商品不存在！\",\"status\":\"0\"}");
            }
        }
        int id = new Bll_DB5.tblShoes_Linked().Add(shoelink);
        if (id > 0)
        {
            if (shoelink.linktype == 1)
            {
                ResponseEnd("{\"id\":\"" + id + "\",\"linkedId\":\"" + shoelink.linkedId + "\",\"title\":\"" + new Bll_DB2.tblBLOG().GetModel(int.Parse(shoelink.linkedId)).cTitle + "\",\"linktype\":\"" + shoelink.linktype + "\",\"status\":\"1\"}");
            }
            else if (shoelink.linktype == 2)
            {
                ResponseEnd("{\"id\":\"" + id + "\",\"linkedId\":\"" + shoelink.linkedId + "\",\"title\":\"" + new Bll_DB1.tblGoods().GetModel(int.Parse(shoelink.linkedId)).cName + "\",\"linktype\":\"" + shoelink.linktype + "\",\"status\":\"1\"}");
            }
        }
        else
        {
            ResponseEnd("{\"msg\":\"关联失败！\",\"status\":\"0\"}");
        }
    }

    protected void DelLink()
    {
        if (string.IsNullOrEmpty(Request["id"]))
        {
            ResponseEnd("{\"msg\":\"id不能为空！\",\"status\":\"0\"}");
        }
        if (new Bll_DB5.tblShoes_Linked().Delete(int.Parse(Request["id"])))
        {
            ResponseEnd("{\"msg\":\"删除成功！\",\"status\":\"1\"}");
        }
        else
        {
            ResponseEnd("{\"msg\":\"删除失败！\",\"status\":\"0\"}");
        }
    }
    protected void ResponseEnd(string result)
    {
        Response.Write(result);
        Response.End();
    }

    protected void imgbtn_Click(object sender, ImageClickEventArgs e)
    {
        if (string.IsNullOrEmpty(Request["linktype"]))
        {
            Response.Write("<script>alert('关联类型!');</script>");
            Response.End();
        }
        if (string.IsNullOrEmpty(Request["shoeid"]))
        {
            Response.Write("<script>alert('鞋编号!');</script>");
            Response.End();
        }
        string strwhere = string.Format(" shoesId={0} and linktype={1} ", Request["shoeid"], Request["linktype"]);
        Model_DB5.tblShoes_Linked shoelink = new Model_DB5.tblShoes_Linked();
        List<Model_DB5.tblShoes_Linked> listofshoeslink = new Bll_DB5.tblShoes_Linked().GetModelList(strwhere);
        if (listofshoeslink.Count > 0)
        {
            shoelink = listofshoeslink[0];
            if (!string.IsNullOrEmpty(this.LinkedId.Value))
            {
                shoelink.linkedId = this.LinkedId.Value.Trim();
            }
            shoelink.addtime = DateTime.Now;
            if (new Bll_DB5.tblShoes_Linked().Update(shoelink))
            {
                Response.Write("<script>alert('关联成功!');</script>");
            }
            else
            {
                Response.Write("<script>alert('关联失败!');</script>");
            }
        }
        else
        {
            if (!string.IsNullOrEmpty(this.LinkedId.Value))
            {
                shoelink.linkedId = this.LinkedId.Value.Trim();
            }
            shoelink.shoesId = int.Parse(Request["shoeid"]);
            shoelink.linktype = int.Parse(Request["linktype"]);
            shoelink.adduId = CurrentUser.uId;
            shoelink.addtime = DateTime.Now;
            if (new Bll_DB5.tblShoes_Linked().Add(shoelink) > 0)
            {
                Response.Write("<script>alert('关联成功!');</script>");
            }
            else
            {
                Response.Write("<script>alert('关联失败!');</script>");
            }
        }
    }
}