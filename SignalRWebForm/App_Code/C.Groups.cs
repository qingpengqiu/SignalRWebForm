
using System;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Collections.Generic;

namespace ERUN360.Entity
{
    public partial class Groups : SQLHelper
    {
        private ArrayList cmds = new ArrayList();
        Random rnd = new Random();

        #region 测试数据(可删除)
		
        private void Append(int id, string title, int score)
        {
            GroupsInfo g = new GroupsInfo();
            g.id = id;
            g.cTitle = title;
            g.iScore = score;

            if (id > 100000000 && id < 200000000) g.cDescription = "积分编码";
            if (id > 200000000 && id < 300000000) g.cDescription = "装备分类编码";
            if (id > 300000000 && id < 400000000) g.cDescription = "栏目编码";
            if (id > 600000000 && id < 700000000) g.cDescription = "装备品牌编码";

            cmds.Add(InsertSql(g));
        }

        private void Initialize()
        {
            cmds.Clear();
            cmds.Add("DELETE FROM " + Database + ";");

            Append(300100100, "首页", 0);
            Append(300101100, "切换动画", 0);
            Append(300102100, "右侧专题", 0);
            Append(300102110, "右侧专题1", 0);
            Append(300102120, "右侧专题2", 0);
            Append(300102130, "右侧专题3", 0);
            Append(300102140, "右侧专题4", 0);
            Append(300111100, "训练", 0);
            Append(300112100, "鞋与装备", 0);
            Append(300113100, "红粉跑者", 0);
            Append(300114100, "营养·瘦身", 0);
            Append(300115100, "初级跑者", 0);
            Append(300116100, "跑步人生", 0);
            Append(300117100, "赛事·城市", 0);
            Append(300118100, "健康·恢复", 0);
            Append(300130100, "益跑视频", 0);
            Append(300140100, "益跑图片", 0);

            Append(301100100, "训练", 0);
            Append(301101100, "切换动画", 0);
            Append(301102100, "右侧专题", 0);
            Append(301102110, "右侧专题1", 0);
            Append(301102120, "右侧专题2", 0);
            Append(301102130, "右侧专题3", 0);
            Append(301111100, "5/10KM", 0);
            Append(301112100, "越野跑", 0);
            Append(301113100, "半程马拉松", 0);
            Append(301114100, "全程马拉松", 0);
            Append(301115100, "跑步技巧", 0);
            Append(301116100, "专项训练", 0);

            Append(302100100, "赛事·城市", 0);
            Append(302101100, "切换动画", 0);
            Append(302102100, "右侧专题", 0);
            Append(302102110, "右侧专题1", 0);
            Append(302102120, "右侧专题2", 0);
            Append(302102130, "右侧专题3", 0);
            Append(302111100, "国内赛事", 0);
            Append(302112100, "国际赛事", 0);
            Append(302113100, "越野赛事", 0);
            Append(302114100, "跑在各地", 0);

            Append(303100100, "鞋与装备", 0);
            Append(303101100, "切换动画", 0);
            Append(303102100, "右侧专题", 0);
            Append(303102110, "右侧专题1", 0);
            Append(303102120, "右侧专题2", 0);
            Append(303102130, "右侧专题3", 0);
            Append(303111100, "公路跑鞋", 0);
            Append(303112100, "越野跑鞋", 0);
            Append(303113100, "服装", 0);
            Append(303114100, "配件", 0);

            Append(304100100, "营养·瘦身", 0);
            Append(304101100, "切换动画", 0);
            Append(304102100, "右侧专题", 0);
            Append(304102110, "右侧专题1", 0);
            Append(304102120, "右侧专题2", 0);
            Append(304102130, "右侧专题3", 0);
            Append(304111100, "饮食", 0);
            Append(304112100, "减肥", 0);

            Append(305100100, "健康·恢复", 0);
            Append(305101100, "切换动画", 0);
            Append(305102100, "右侧专题", 0);
            Append(305102110, "右侧专题1", 0);
            Append(305102120, "右侧专题2", 0);
            Append(305102130, "右侧专题3", 0);
            Append(305111100, "健康跑步", 0);
            Append(305112100, "伤病恢复", 0);
            Append(305113100, "身体解密", 0);
            Append(305114100, "其它", 0);

            Append(311100100, "初级跑者", 0);
            Append(311101100, "切换动画", 0);
            Append(311102100, "右侧专题", 0);
            Append(311102110, "右侧专题1", 0);
            Append(311102120, "右侧专题2", 0);
            Append(311102130, "右侧专题3", 0);
            Append(311111100, "为什么跑", 0);
            Append(311112100, "如何开始", 0);
            Append(311113100, "第一次比赛", 0);
            Append(311114100, "新手问题", 0);

            Append(312100100, "红粉跑者", 0);
            Append(312101100, "切换动画", 0);
            Append(312102100, "右侧专题", 0);
            Append(312102110, "右侧专题1", 0);
            Append(312102120, "右侧专题2", 0);
            Append(312102130, "右侧专题3", 0);
            Append(312111100, "养颜塑身", 0);
            Append(312112100, "专属装备", 0);
            Append(312113100, "训练技巧", 0);
            Append(312114100, "常见问题", 0);

            Append(313100100, "跑步人生", 0);
            Append(313101100, "切换动画", 0);
            Append(313102100, "右侧专题", 0);
            Append(313102110, "右侧专题1", 0);
            Append(313102120, "右侧专题2", 0);
            Append(313102130, "右侧专题3", 0);
            Append(313111100, "我是跑者", 0);
            Append(313112100, "跑步英雄", 0);
            Append(313113100, "跑步随笔", 0);
            Append(313114100, "其它", 0);

            Append(321100100, "益跑专家", 0);
            Append(321111100, "益跑专家", 0);
            Append(321112100, "训练专家", 0);
            Append(321113100, "伤病专家", 0);
            Append(321114100, "营养专家", 0);
            Append(322100100, "工具", 0);

            //Append(200000000, "装备", 0);
            Append(201000000, "鞋", 0);
            Append(201100000, "田径短跑", 0);
            Append(201101000, "田径赛道", 0);
            Append(201102000, "公路跑", 0);
            Append(201103000, "越野跑", 0);
            Append(202000000, "服装", 0);
            Append(202100000, "无袖·背心", 0);
            Append(202101000, "短袖", 0);
            Append(202102000, "长袖", 0);
            Append(202103000, "短裤", 0);
            Append(202104000, "裤子·紧身裤", 0);
            Append(202105000, "夹克·马甲", 0);
            Append(202106000, "内衣", 0);
            Append(202107000, "袜子·鞋套", 0);
            Append(202108000, "压缩·恢复", 0);
            Append(203000000, "配件", 0);
            Append(203100000, "电子产品", 0);
            Append(203100100, "GPS", 0);
            Append(203100101, "心率", 0);
            Append(203100102, "手表", 0);
            Append(203101000, "补剂", 0);
            Append(203101100, "能量胶·嚼片", 0);
            Append(203101101, "饮品·补液", 0);
            Append(203101102, "能量棒", 0);
            Append(203102000, "袖套·腿套", 0);
            Append(203103000, "腰带·腰包", 0);
            Append(203104000, "书·DVD", 0);
            Append(203105000, "手套", 0);
            Append(203106000, "帽子·头饰", 0);
            Append(203107000, "饮水系统", 0);
            Append(203108000, "反光·照明", 0);
            Append(203109000, "保护治疗", 0);
            Append(203110000, "鞋垫", 0);
            Append(203111000, "运动包", 0);
            Append(203112000, "太阳镜", 0);

            Append(100800100, "注册", 20);                  //（单次）
            Append(100800101, "上传头像", 5);               //（单次）
            Append(100800102, "完善资料", 10);              //（单次）
            Append(100800103, "每日登录", 1);               //（每天）
            Append(100800104, "填写报名信息", 5);           //（单次）
            Append(100800105, "填写身材/脚型", 5);          //（单次）
            //Append(100800106, "填写脚型（单次）", 5);     //
            Append(100800107, "发表博文", 5);               //（每篇）
            Append(100800108, "博文被删除", -25);           //（每篇）
            Append(100800109, "发表评论/回复", 1);          //（每次）
            Append(100800110, "评论被删除", -5);            //（每次）
            Append(100800111, "文章到栏目", 20);            //（每次）
            Append(100800112, "文章到首页", 50);            //（每次）
            Append(100800113, "发布约跑", 5);               //（每次）
            Append(100800114, "约跑成功举办", 2);           //（每报名一人发布者奖励一次）
            Append(100800115, "报名（并参加）约跑", 3);     //（每次）
            Append(100800116, "上传训练数据", 1);           //（每次）
            Append(100800117, "报名国内赛事", 5);           //（每次）
            Append(100800118, "报名国外赛事）", 5);         //（每次
            Append(100800119, "上传自己的装备", 1);         //（每次）
            Append(100800120, "购买装备", 50);              //（每件）
            Append(100800121, "关注好友", 1);               //（每人）
            Append(100800122, "被好友关注", 1);             //（每人）
            Append(100800123, "关注文章、比赛等", 1);       //（每次）

            Append(600201000, "ASICS 亚瑟士", 0);
            Append(600202000, "ADIDAS 阿迪达斯", 0);
            Append(600203000, "BROOKS 布鲁克斯", 0);
            Append(600204000, "CAMELBAK 驼峰", 0);
            Append(600205000, "COLOMBIA 哥伦比亚", 0);
            Append(600206000, "CW-X", 0);
            Append(600207000, "ECCO 爱步", 0);
            Append(600208000, "GARMIN 高明", 0);
            Append(600209000, "INOV-8", 0);
            Append(600210000, "JACK WOLFSKIN 狼爪", 0);
            Append(600211000, "LA SPORTIVIA", 0);
            Append(600212000, "LAFUMA 乐飞叶", 0);
            Append(600213000, "MIZUNO 美津浓", 0);
            Append(600214000, "MONTRAIL", 0);
            Append(600215000, "MOUNTAINHARDWARE 山浩", 0);
            Append(600216000, "NATHAN", 0);
            Append(600217000, "NIKE 耐克", 0);
            Append(600218000, "NEW BALANCE 新百伦", 0);
            Append(600219000, "NEWTON", 0);
            Append(600220000, "OAKLEY 奥克利", 0);
            Append(600221000, "PEARL IZUMI", 0);
            Append(600222000, "REEBOK 锐步", 0);
            Append(600223000, "RUDY PROJECT 卤迪", 0);
            Append(600224000, "SALOMON 萨洛蒙", 0);
            Append(600225000, "SAUCONY 索康尼", 0);
            Append(600226000, "SKECHERS 斯凯奇", 0);
            Append(600227000, "SKINS 思金思", 0);
            Append(600228000, "SUUNTO 松拓", 0);
            Append(600229000, "TECNICA 泰尼卡", 0);
            Append(600230000, "TIMEX 天美时", 0);
            Append(600231000, "THE NORTH FACE 北面", 0);
            Append(600232000, "UNDER AMOR 安德玛", 0);
            Append(600233000, "VFF 巍跋然", 0);
            Append(600234000, "X-BIONIC", 0);
            Append(600235000, "ZOOT", 0);
            Append(600236000, "2XU", 0);

            SQLHelper.ExecuteSqlTran(cmds);
        }

        #endregion

        /// <summary>
        /// 按字段名显示为页面控件(SELECT,RADIO,CHECKBOX)
        /// </summary>
        /// <param name="Caption">保留</param>
        /// <param name="controlStyle">控件类型</param>
        /// <param name="controlName">控件ID</param>
        /// <param name="defaultValue">默认值</param>
        /// <returns></returns>
        public string Controls(string controlName, int start, int defaultValue)
        {
            if (Items == null) return _err;

            StringBuilder sb = new StringBuilder();

            sb.AppendLine("<select id=\"" + controlName + "\" name=\"" + controlName + "\" onchange=\"UpdateHistory(this)\">");
            int idx = 0;
            foreach (GroupsInfo gc in Items)
            {
                if (gc.id >= start && gc.id < (start + 100000000))
                {
                    string space = "";
                    if (start == 200000000)
                    {
                        if (gc.id.ToString().Substring(3, 3) != "000") space = "　　";
                    }
                    if (start == 300000000)
                    {
                        if (gc.id.ToString().Substring(3, 3) != "100") space = "　　";
                    }

                    string caption = "";
                    if (gc.id.ToString().Substring(3, 6) == "102100" || gc.id.ToString().Substring(3, 6) == "100100")
                    {
                        caption = "(不选)";
                    }

                    if (defaultValue == gc.id || (idx == 0 && defaultValue < 1))
                    {
                        sb.AppendLine("\t\t\t\t<option value=\"" + gc.id + "\" selected>" + space + gc.cTitle + caption + "</option>");
                    }
                    else
                    {
                        sb.AppendLine("\t\t\t\t<option value=\"" + gc.id + "\">" + space + gc.cTitle + caption + "</option>");
                    }
                    idx++;
                }
            }
            sb.AppendLine("\t\t\t</select>");
            return sb.ToString();
        }
    }
}
