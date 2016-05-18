var __emotion__cache = false;
jQuery.fn.emotions = function() {
var aEmotion = new Array();
    aEmotion[1] = new Array('[Î¢Ð¦]', '\\[Î¢Ð¦\\]');
    aEmotion[2] = new Array('[º©Ð¦]', '\\[º©Ð¦\\]');
    aEmotion[3] = new Array('[µ÷Æ¤]', '\\[µ÷Æ¤\\]');
    aEmotion[4] = new Array('[¾ªÑÈ]', '\\[¾ªÑÈ\\]');
    aEmotion[5] = new Array('[Ë£¿á]', '\\[Ë£¿á\\]');
    aEmotion[6] = new Array('[·¢»ð]', '\\[·¢»ð\\]');
    aEmotion[7] = new Array('[ºÇºÇ]', '\\[ºÇºÇ\\]');
    aEmotion[8] = new Array('[º¹Ë®]', '\\[º¹Ë®\\]');
    aEmotion[9] = new Array('[´ó¿Þ]', '\\[´ó¿Þ\\]');
    aEmotion[10] = new Array('[ÞÏÞÎ]', '\\[ÞÏÞÎ\\]');
    aEmotion[11] = new Array('[±ÉÊÓ]', '\\[±ÉÊÓ\\]');
    aEmotion[12] = new Array('[ÄÑ¹ý]', '\\[ÄÑ¹ý\\]');
    aEmotion[13] = new Array('[¿ä½±]', '\\[¿ä½±\\]');
    aEmotion[14] = new Array('[²ÆÃÔ]', '\\[²ÆÃÔ\\]');
    aEmotion[15] = new Array('[ÒÉÎÊ]', '\\[ÒÉÎÊ\\]');
    aEmotion[16] = new Array('[ºßºß]', '\\[ºßºß\\]');
    aEmotion[17] = new Array('[¿ñÍÂ]', '\\[¿ñÍÂ\\]');
    aEmotion[18] = new Array('[Ó´ºÇ]', '\\[Ó´ºÇ\\]');
    aEmotion[19] = new Array('[º¦Ðß]', '\\[º¦Ðß\\]');
    aEmotion[20] = new Array('[Ç×ÎÇ]', '\\[Ç×ÎÇ\\]');
    aEmotion[21] = new Array('[·¢³î]', '\\[·¢³î\\]');
    aEmotion[22] = new Array('[´óÐ¦]', '\\[´óÐ¦\\]');
    aEmotion[23] = new Array('[ÔÎµ¹]', '\\[ÔÎµ¹\\]');
    aEmotion[24] = new Array('[¿É°®]', '\\[¿É°®\\]');
    aEmotion[25] = new Array('[»µÐ¦]', '\\[»µÐ¦\\]');
    aEmotion[26] = new Array('[ßÚÑÀ]', '\\[ßÚÑÀ\\]');
    aEmotion[27] = new Array('[±©º¹]', '\\[±©º¹\\]');
    aEmotion[28] = new Array('[³þ³þ¿ÉÁ¯]', '\\[³þ³þ¿ÉÁ¯\\]');
    aEmotion[29] = new Array('[À§]', '\\[À§\\]');
    aEmotion[30] = new Array('[¿Þ]', '\\[¿Þ\\]');
    aEmotion[31] = new Array('[ÉúÆø]', '\\[ÉúÆø\\]');
    aEmotion[32] = new Array('[³Ô¾ª]', '\\[³Ô¾ª\\]');
    aEmotion[33] = new Array('[¿ÚË®]', '\\[¿ÚË®\\]');
    aEmotion[34] = new Array('[°®]', '\\[°®\\]');
    aEmotion[35] = new Array('[ÐÄËé]', '\\[ÐÄËé\\]');
    aEmotion[36] = new Array('[Ãµ¹å]', '\\[Ãµ¹å\\]');
    aEmotion[37] = new Array('[ÀñÎï]', '\\[ÀñÎï\\]');
    aEmotion[38] = new Array('[²Êºç]', '\\[²Êºç\\]');
    aEmotion[39] = new Array('[ÔÂÁÁ]', '\\[ÔÂÁÁ\\]');
    aEmotion[40] = new Array('[Ì«Ñô]', '\\[Ì«Ñô\\]');
    aEmotion[41] = new Array('[Ç®Ç®]', '\\[Ç®Ç®\\]');
    aEmotion[42] = new Array('[µÆÅÝ]', '\\[µÆÅÝ\\]');
    aEmotion[43] = new Array('[¿§·È]', '\\[¿§·È\\]');
    aEmotion[44] = new Array('[µ°¸â]', '\\[µ°¸â\\]');
    aEmotion[45] = new Array('[ÒôÀÖ]', '\\[ÒôÀÖ\\]');
    aEmotion[46] = new Array('[°®Äã]', '\\[°®Äã\\]');
    aEmotion[47] = new Array('[Ê¤Àû]', '\\[Ê¤Àû\\]');
    aEmotion[48] = new Array('[ÔÞ]', '\\[ÔÞ\\]');
    aEmotion[49] = new Array('[Èõ]', '\\[Èõ\\]');
    aEmotion[50] = new Array('[OK]', '\\[OK\\]');
    aEmotion[51] = new Array('[D¿Þ]', '\\[D¿Þ\\]');
    aEmotion[52] = new Array('[D¼ÓÓÍ]', '\\[D¼ÓÓÍ\\]');
    aEmotion[53] = new Array('[D±ØÊ¤]', '\\[D±ØÊ¤\\]');
    aEmotion[54] = new Array('[D¼ú¼ú]', '\\[D¼ú¼ú\\]');
    aEmotion[55] = new Array('[DÅ£±Æ]', '\\[DÅ£±Æ\\]');
    aEmotion[56] = new Array('[DÏë¾²¾²]', '\\[DÏë¾²¾²\\]');
    aEmotion[57] = new Array('[DµßÇò]', '\\[DµßÇò\\]');
    aEmotion[58] = new Array('[DÉúÆø]', '\\[DÉúÆø\\]');
    aEmotion[59] = new Array('[DµÃÉª]', '\\[DµÃÉª\\]');
    aEmotion[60] = new Array('[D¿ñ±¼]', '\\[D¿ñ±¼\\]');
    aEmotion[61] = new Array('[DÔÞ]', '\\[DÔÞ\\]');
    aEmotion[62] = new Array('[E¼ÓÓÍ]', '\\[E¼ÓÓÍ\\]');
    aEmotion[63] = new Array('[D´ó¿Þ]', '\\[D´ó¿Þ\\]');
    aEmotion[64] = new Array('[DºìÅÆ·£ÏÂ]', '\\[DºìÅÆ·£ÏÂ\\]');
    aEmotion[65] = new Array('[D¼¤¶¯]', '\\[D¼¤¶¯\\]');
    aEmotion[66] = new Array('[D¹þ¹þ]', '\\[D¹þ¹þ\\]');
    aEmotion[101] = new Array('[MOOD=01]', '\\[MOOD=01\\]');
    aEmotion[102] = new Array('[MOOD=02]', '\\[MOOD=02\\]');
    aEmotion[103] = new Array('[MOOD=03]', '\\[MOOD=03\\]');
    aEmotion[104] = new Array('[MOOD=04]', '\\[MOOD=04\\]');
    aEmotion[104] = new Array('[MOOD=05]', '\\[MOOD=05\\]');
    aEmotion[106] = new Array('[MOOD=06]', '\\[MOOD=06\\]');
    aEmotion[107] = new Array('[MOOD=07]', '\\[MOOD=07\\]');
    aEmotion[108] = new Array('[MOOD=08]', '\\[MOOD=08\\]');
    aEmotion[109] = new Array('[MOOD=09]', '\\[MOOD=09\\]');
    aEmotion[110] = new Array('[MOOD=10]', '\\[MOOD=10\\]');
    aEmotion[111] = new Array('[MOOD=11]', '\\[MOOD=11\\]');
    aEmotion[112] = new Array('[MOOD=12]', '\\[MOOD=12\\]');
    aEmotion[113] = new Array('[MOOD=13]', '\\[MOOD=13\\]');
    aEmotion[114] = new Array('[MOOD=14]', '\\[MOOD=14\\]');
    aEmotion[115] = new Array('[MOOD=15]', '\\[MOOD=15\\]');
    aEmotion[116] = new Array('[MOOD=16]', '\\[MOOD=16\\]');
    aEmotion[117] = new Array('[MOOD=17]', '\\[MOOD=17\\]');
    aEmotion[118] = new Array('[MOOD=18]', '\\[MOOD=18\\]');
    aEmotion[119] = new Array('[MOOD=19]', '\\[MOOD=19\\]');
    aEmotion[120] = new Array('[MOOD=20]', '\\[MOOD=20\\]');
    aEmotion[121] = new Array('[MOOD=21]', '\\[MOOD=21\\]');
    aEmotion[122] = new Array('[MOOD=22]', '\\[MOOD=22\\]');
    aEmotion[123] = new Array('[MOOD=23]', '\\[MOOD=23\\]');
    aEmotion[124] = new Array('[MOOD=24]', '\\[MOOD=24\\]');

    __emotion__cache = true;
    this.each(function() {
        str = $(this).html();
        for (iEM in aEmotion) {
            reg = new RegExp(aEmotion[iEM][1], "ig");
                if (iEM > 50) {
            str = str.replace(reg, '<img src="/assets/face/i_f' + iEM + '.gif" />');
                }else{
            str = str.replace(reg, '<img src="/assets/face/i_f' + iEM + '.png" />');
                }
        }
        $(this).html(str);
    });
};
jQuery.fn.unemotions = function() {
    __emotion__cache = false;
    $('.emotion').each(function() {
        $(this).html(decodeURIComponent(this.title));
    });
}