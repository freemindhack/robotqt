#ifndef __AISOUND_H__
#define __AISOUND_H__

/*callback can return sound_to_text value for caller
 */
typedef void (*CallBack)(const char *sound_to_text);
#ifdef __cplusplus
extern "C" {
#endif

/*step 1: login
 *step 2: start_aisound_xxx
 *step 3: logout
 */
int login_aisound();
int logout_aisound();
int start_aisound_record(CallBack func);

#ifdef __cplusplus
} 
#endif

#endif
