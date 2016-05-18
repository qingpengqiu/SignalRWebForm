﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json.Linq;

public partial class Test : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //string encryptstr = Erun360.Common.DEncrypt.DESEncrypt.Encrypt("hi@hi.comERUNOFFICIAL&&&&&&", "erun_360");
        //string decryptstr = Erun360.Common.DEncrypt.DESEncrypt.Decrypt("88DBF37257139CB8B4C9CEE1E3AAD505B530F4DC9DEBFF3D", "erun_360");

        //Response.Write(encryptstr);//
        string jsonstr = "{\"id\":\"1046\",\"event_id\":\"45\",\"user_id\":\"1986\",\"type\":1,\"title\":\"2016\u6bd4\u8d5b\u7b7e\u5230\",\"distance\":\"6.18km\",\"time\":\"00:06:36\",\"speed\":\"54.55km/h\",\"calorie\":\"559.91kcal\",\"goal_speed\":\"\",\"created\":\"1456488651\",\"nickname\":\"houxin123\",\"event_name\":\"2016\u6bd4\u8d5b\u7b7e\u5230\",\"event_enroll\":\"http://www.erun360.com/Competetion/EventDetails.aspx?sid=300002153&nav=1&org=app\",\"items\":[{\"id\":\"20479\",\"record_id\":\"1046\",\"distance\":\"0.474\",\"speed\":\"00:00:52\",\"duration\":\"00:00:24\",\"time\":\"00:00:24\",\"timestamp\":\"0\",\"location\":{\"lon\":116.47524822287,\"lat\":39.93434971626}},{\"id\":\"20480\",\"record_id\":\"1046\",\"distance\":\"0.804\",\"speed\":\"00:00:45\",\"duration\":\"00:00:39\",\"time\":\"00:00:39\",\"timestamp\":\"0\",\"location\":{\"lon\":116.48195854245,\"lat\":39.941530343359}},{\"id\":\"20481\",\"record_id\":\"1046\",\"distance\":\"0.977\",\"speed\":\"00:00:57\",\"duration\":\"00:00:49\",\"time\":\"00:00:49\",\"timestamp\":\"0\",\"location\":{\"lon\":116.48807089609,\"lat\":39.946874731075}},{\"id\":\"20482\",\"record_id\":\"1046\",\"distance\":\"1\",\"speed\":\"00:01:33\",\"duration\":\"00:01:04\",\"time\":\"00:01:04\",\"timestamp\":\"0\",\"location\":{\"lon\":116.4924299051,\"lat\":39.953495922527}},{\"id\":\"20483\",\"record_id\":\"1046\",\"distance\":\"1.306\",\"speed\":\"00:01:29\",\"duration\":\"00:00:15\",\"time\":\"00:01:19\",\"timestamp\":\"0\",\"location\":{\"lon\":116.49920544337,\"lat\":39.962146000213}},{\"id\":\"20484\",\"record_id\":\"1046\",\"distance\":\"1.445\",\"speed\":\"00:01:11\",\"duration\":\"00:00:25\",\"time\":\"00:01:29\",\"timestamp\":\"0\",\"location\":{\"lon\":116.50098525569,\"lat\":39.963289872017}},{\"id\":\"20485\",\"record_id\":\"1046\",\"distance\":\"1.811\",\"speed\":\"00:01:08\",\"duration\":\"00:00:50\",\"time\":\"00:01:54\",\"timestamp\":\"0\",\"location\":{\"lon\":116.5152045301,\"lat\":39.981536424949}},{\"id\":\"20486\",\"record_id\":\"1046\",\"distance\":\"1.821\",\"speed\":\"00:16:40\",\"duration\":\"00:01:00\",\"time\":\"00:02:04\",\"timestamp\":\"0\",\"location\":{\"lon\":116.51993772115,\"lat\":39.981938121877}},{\"id\":\"20487\",\"record_id\":\"1046\",\"distance\":\"2\",\"speed\":\"00:00:47\",\"duration\":\"00:01:20\",\"time\":\"00:02:24\",\"timestamp\":\"0\",\"location\":{\"lon\":116.53152462206,\"lat\":39.993027166618}},{\"id\":\"20488\",\"record_id\":\"1046\",\"distance\":\"2.351\",\"speed\":\"00:00:47\",\"duration\":\"00:00:05\",\"time\":\"00:02:29\",\"timestamp\":\"0\",\"location\":{\"lon\":116.53220579612,\"lat\":39.993814047671}},{\"id\":\"20489\",\"record_id\":\"1046\",\"distance\":\"2.635\",\"speed\":\"00:01:10\",\"duration\":\"00:00:25\",\"time\":\"00:02:49\",\"timestamp\":\"0\",\"location\":{\"lon\":116.54050628957,\"lat\":40.002307192235}},{\"id\":\"20490\",\"record_id\":\"1046\",\"distance\":\"2.918\",\"speed\":\"00:00:53\",\"duration\":\"00:00:40\",\"time\":\"00:03:04\",\"timestamp\":\"0\",\"location\":{\"lon\":116.54759635343,\"lat\":40.008446255838}},{\"id\":\"20491\",\"record_id\":\"1046\",\"distance\":\"3\",\"speed\":\"00:01:24\",\"duration\":\"00:00:50\",\"time\":\"00:03:14\",\"timestamp\":\"0\",\"location\":{\"lon\":116.5492941366,\"lat\":40.013357631273}},{\"id\":\"20492\",\"record_id\":\"1046\",\"distance\":\"3.2\",\"speed\":\"00:01:00\",\"duration\":\"00:00:10\",\"time\":\"00:03:24\",\"timestamp\":\"0\",\"location\":{\"lon\":116.55118209664,\"lat\":40.018007542753}},{\"id\":\"20493\",\"record_id\":\"1046\",\"distance\":\"3.54\",\"speed\":\"00:00:58\",\"duration\":\"00:00:30\",\"time\":\"00:03:44\",\"timestamp\":\"0\",\"location\":{\"lon\":116.5585431669,\"lat\":40.032153280335}},{\"id\":\"20494\",\"record_id\":\"1046\",\"distance\":\"3.683\",\"speed\":\"00:01:10\",\"duration\":\"00:00:40\",\"time\":\"00:03:54\",\"timestamp\":\"0\",\"location\":{\"lon\":116.56521662154,\"lat\":40.035605868201}},{\"id\":\"20495\",\"record_id\":\"1046\",\"distance\":\"3.891\",\"speed\":\"00:01:36\",\"duration\":\"00:01:00\",\"time\":\"00:04:14\",\"timestamp\":\"0\",\"location\":{\"lon\":116.57773725719,\"lat\":40.045372479845}},{\"id\":\"20496\",\"record_id\":\"1046\",\"distance\":\"4\",\"speed\":\"00:01:56\",\"duration\":\"00:01:15\",\"time\":\"00:04:29\",\"timestamp\":\"0\",\"location\":{\"lon\":116.58848625366,\"lat\":40.05137239343}},{\"id\":\"20497\",\"record_id\":\"1046\",\"distance\":\"4.383\",\"speed\":\"00:00:55\",\"duration\":\"00:00:20\",\"time\":\"00:04:49\",\"timestamp\":\"0\",\"location\":{\"lon\":116.60014867673,\"lat\":40.065111499315}},{\"id\":\"20498\",\"record_id\":\"1046\",\"distance\":\"4.826\",\"speed\":\"00:00:56\",\"duration\":\"00:00:45\",\"time\":\"00:05:14\",\"timestamp\":\"0\",\"location\":{\"lon\":116.61515218542,\"lat\":40.081472883938}},{\"id\":\"20499\",\"record_id\":\"1046\",\"distance\":\"5\",\"speed\":\"00:01:03\",\"duration\":\"00:01:00\",\"time\":\"00:05:29\",\"timestamp\":\"0\",\"location\":{\"lon\":116.62217388749,\"lat\":40.090535367378}},{\"id\":\"20500\",\"record_id\":\"1046\",\"distance\":\"5.365\",\"speed\":\"00:00:49\",\"duration\":\"00:00:15\",\"time\":\"00:05:44\",\"timestamp\":\"0\",\"location\":{\"lon\":116.62763273205,\"lat\":40.097700837582}},{\"id\":\"20501\",\"record_id\":\"1046\",\"distance\":\"5.681\",\"speed\":\"00:01:03\",\"duration\":\"00:00:35\",\"time\":\"00:06:04\",\"timestamp\":\"0\",\"location\":{\"lon\":116.64201586693,\"lat\":40.106118858513}},{\"id\":\"20502\",\"record_id\":\"1046\",\"distance\":\"6\",\"speed\":\"00:00:46\",\"duration\":\"00:00:50\",\"time\":\"00:06:19\",\"timestamp\":\"0\",\"location\":{\"lon\":116.64701642693,\"lat\":40.11301853535}},{\"id\":\"20503\",\"record_id\":\"1046\",\"distance\":\"6.179\",\"speed\":\"00:00:57\",\"duration\":\"00:00:10\",\"time\":\"00:06:29\",\"timestamp\":\"0\",\"location\":{\"lon\":116.65153042187,\"lat\":40.116985843572}}]}";
        JObject jo = JObject.Parse(jsonstr);
        Response.Write(jo["items"].ToString());
    }
}