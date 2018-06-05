#ifndef __AWAKEN_H__
#define __AWAKEN_H__

typedef void (*CallBackFunc)();
#ifdef __cplusplus
extern "C" {
#endif

	/*Description: create wakeup task and register user callback function
	 * return : 0, success ; -1, failed;
	 * param: user function, it can be used to notify app that system be waken up by wakeup words
	 */
int create_wakeup_task(CallBackFunc func);

#ifdef __cplusplus
}
#endif



#endif
