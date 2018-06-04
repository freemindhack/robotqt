#ifndef __TTS_H__
#define __TTS_H__

#define MAX_TTEXT_BUF (8*1024-1)

typedef struct _tts_session_params {
	/*合成音频数字发音方式
	 *0 数值优先,
	 * 1 完全数值,
	 *2 完全字符串，
	 *3 字符串优先，*/
	int rdn; 
      /* 合成音频的音量 0-100 */
        int volume; 
     /*合成音频的音调 0-100 */
	int pitch; 
     /*合成音频对应的语速 0-100 */
	int speed;
     /*合成发音人
      * women:xiaoyan man:xiaofeng
      */
	char voice_name[20];
    /*合成音频采样率 16000,8000 */
	int sample_rate;
    /*合成文本编码格式
     * utf-8,GB2312,GBK,BIG5,UNICODE,GB18030
     */
	char text_encoding[20];
    /*tts resource path
     * tts_res_path = fo|pathname/msc/res/tts/voice_name.jet;fo|pathname/msc/res/tts/common.jet*/
	char tts_res_path[100];
} tts_session_params;


#ifdef __cplusplus

extern "C" {
#endif
int start_tts(tts_session_params *param, char *text, char *filename);

//clear session params
void clearTTSessionParams(tts_session_params *param);
//set session params
void initTTSessionParams(tts_session_params *param);

#ifdef __cplusplus
}
#endif


#endif
