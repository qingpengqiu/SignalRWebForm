using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;

public partial class Admin_PayList : PageBase
{
    public StringBuilder item = new StringBuilder();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            AlertHelper.JQAlertGo("您没有权限", "/", false);
            return;
        }
        if (CurrentUser.idMemberStyle >= 12)
        {
            item.AppendLine(" <div id=\"item\" onclick=\"window.location='/admin/IntegralList.aspx';\">积分充值</div>");
            item.AppendLine(" <div id=\"item\" onclick=\"window.location='/Admin/GoodList.aspx';\">积分物品管理</div>");
            item.AppendLine(" <div id=\"item\" onclick=\"window.location='/admin/ReserveList.aspx';\">积分库存管理</div>");
            item.AppendLine(" <div id=\"item\" onclick=\"window.location='/Admin/CodeList.aspx';\">积分兑换</div>");
            item.AppendLine(" <div id=\"item\" onclick=\"window.location='/Admin/GoodShopList.aspx';\">拼团物品管理</div>");
            item.AppendLine("<div id=\"item\" onclick=\"window.location='/admin/TourList.aspx';\">拼团管理</div>");
            item.AppendLine(" <div id=\"item\" onclick=\"window.location='/admin/ReserveTourList.aspx';\">拼团库存管理</div>");
            item.AppendLine(" <div id=\"item\" onclick=\"window.location='/Admin/ShoppingList.aspx';\">商品购买记录</div>");

            item.AppendLine(" <div id=\"item\" onclick=\"window.location='/Admin/GoodShopList_zc.aspx';\">众筹物品管理</div>");
            item.AppendLine("<div id=\"item\" onclick=\"window.location='/admin/TourList_zc.aspx';\">众筹管理</div>");
            item.AppendLine(" <div id=\"item\" onclick=\"window.location='/admin/ReserveTourList_zc.aspx';\">众筹库存管理</div>");
            
        }
        else
        {
            AlertHelper.JQAlertGo("您没有权限", "/", false);
            return;
        }
    }
}