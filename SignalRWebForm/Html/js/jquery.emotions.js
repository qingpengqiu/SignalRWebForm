var __emotion__cache = false;
jQuery.fn.emotions = function() {
var aEmotion = new Array();
    aEmotion[1] = new Array('[΢Ц]', '\\[΢Ц\\]');
    aEmotion[2] = new Array('[��Ц]', '\\[��Ц\\]');
    aEmotion[3] = new Array('[��Ƥ]', '\\[��Ƥ\\]');
    aEmotion[4] = new Array('[����]', '\\[����\\]');
    aEmotion[5] = new Array('[ˣ��]', '\\[ˣ��\\]');
    aEmotion[6] = new Array('[����]', '\\[����\\]');
    aEmotion[7] = new Array('[�Ǻ�]', '\\[�Ǻ�\\]');
    aEmotion[8] = new Array('[��ˮ]', '\\[��ˮ\\]');
    aEmotion[9] = new Array('[���]', '\\[���\\]');
    aEmotion[10] = new Array('[����]', '\\[����\\]');
    aEmotion[11] = new Array('[����]', '\\[����\\]');
    aEmotion[12] = new Array('[�ѹ�]', '\\[�ѹ�\\]');
    aEmotion[13] = new Array('[�佱]', '\\[�佱\\]');
    aEmotion[14] = new Array('[����]', '\\[����\\]');
    aEmotion[15] = new Array('[����]', '\\[����\\]');
    aEmotion[16] = new Array('[�ߺ�]', '\\[�ߺ�\\]');
    aEmotion[17] = new Array('[����]', '\\[����\\]');
    aEmotion[18] = new Array('[Ӵ��]', '\\[Ӵ��\\]');
    aEmotion[19] = new Array('[����]', '\\[����\\]');
    aEmotion[20] = new Array('[����]', '\\[����\\]');
    aEmotion[21] = new Array('[����]', '\\[����\\]');
    aEmotion[22] = new Array('[��Ц]', '\\[��Ц\\]');
    aEmotion[23] = new Array('[�ε�]', '\\[�ε�\\]');
    aEmotion[24] = new Array('[�ɰ�]', '\\[�ɰ�\\]');
    aEmotion[25] = new Array('[��Ц]', '\\[��Ц\\]');
    aEmotion[26] = new Array('[����]', '\\[����\\]');
    aEmotion[27] = new Array('[����]', '\\[����\\]');
    aEmotion[28] = new Array('[��������]', '\\[��������\\]');
    aEmotion[29] = new Array('[��]', '\\[��\\]');
    aEmotion[30] = new Array('[��]', '\\[��\\]');
    aEmotion[31] = new Array('[����]', '\\[����\\]');
    aEmotion[32] = new Array('[�Ծ�]', '\\[�Ծ�\\]');
    aEmotion[33] = new Array('[��ˮ]', '\\[��ˮ\\]');
    aEmotion[34] = new Array('[��]', '\\[��\\]');
    aEmotion[35] = new Array('[����]', '\\[����\\]');
    aEmotion[36] = new Array('[õ��]', '\\[õ��\\]');
    aEmotion[37] = new Array('[����]', '\\[����\\]');
    aEmotion[38] = new Array('[�ʺ�]', '\\[�ʺ�\\]');
    aEmotion[39] = new Array('[����]', '\\[����\\]');
    aEmotion[40] = new Array('[̫��]', '\\[̫��\\]');
    aEmotion[41] = new Array('[ǮǮ]', '\\[ǮǮ\\]');
    aEmotion[42] = new Array('[����]', '\\[����\\]');
    aEmotion[43] = new Array('[����]', '\\[����\\]');
    aEmotion[44] = new Array('[����]', '\\[����\\]');
    aEmotion[45] = new Array('[����]', '\\[����\\]');
    aEmotion[46] = new Array('[����]', '\\[����\\]');
    aEmotion[47] = new Array('[ʤ��]', '\\[ʤ��\\]');
    aEmotion[48] = new Array('[��]', '\\[��\\]');
    aEmotion[49] = new Array('[��]', '\\[��\\]');
    aEmotion[50] = new Array('[OK]', '\\[OK\\]');
    aEmotion[51] = new Array('[D��]', '\\[D��\\]');
    aEmotion[52] = new Array('[D����]', '\\[D����\\]');
    aEmotion[53] = new Array('[D��ʤ]', '\\[D��ʤ\\]');
    aEmotion[54] = new Array('[D����]', '\\[D����\\]');
    aEmotion[55] = new Array('[Dţ��]', '\\[Dţ��\\]');
    aEmotion[56] = new Array('[D�뾲��]', '\\[D�뾲��\\]');
    aEmotion[57] = new Array('[D����]', '\\[D����\\]');
    aEmotion[58] = new Array('[D����]', '\\[D����\\]');
    aEmotion[59] = new Array('[D��ɪ]', '\\[D��ɪ\\]');
    aEmotion[60] = new Array('[D��]', '\\[D��\\]');
    aEmotion[61] = new Array('[D��]', '\\[D��\\]');
    aEmotion[62] = new Array('[E����]', '\\[E����\\]');
    aEmotion[63] = new Array('[D���]', '\\[D���\\]');
    aEmotion[64] = new Array('[D���Ʒ���]', '\\[D���Ʒ���\\]');
    aEmotion[65] = new Array('[D����]', '\\[D����\\]');
    aEmotion[66] = new Array('[D����]', '\\[D����\\]');
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