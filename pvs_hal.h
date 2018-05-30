#ifndef __PVS_HAL_H__
#define __PVS_HAL_H__
#include <pvsapiiftypes.h>
#include <pvsapiifcommon.h>
#include <pvsapiif.h>
/* 
*	Function	:	Pvs_APIIFGuiStateCallback()
*	Description	:	回调函数，用于显示识别库返回的实时提示信息.
*	param[in]	:	*PVS_APIIF_GUI_STATE	GuiState					: 提示信息类型
*	param[in]	:	 PVS_APIIF_GUI_MESSAGE Message					: 提示信息对应值.
*	param[in]	:	PVS_APIIF_GUI_BITMAP *pBitmapArea                           ：掌静脉图片信息，该处未使用 
*	return      ：    总是返回PVS_APIIF_OK
*/
//PVS_APIIF_RESULT Pvs_APIIFGuiStateCallback(PVS_APIIF_GUI_STATE GuiState,
//							PVS_APIIF_GUI_MESSAGE Message,
//							PVS_APIIF_GUI_BITMAP *pBitmapArea)
//{
//	pBitmapArea=pBitmapArea;
//
//	if ((GuiState & PVS_APIIF_MESSAGE_PROVIDED) == PVS_APIIF_MESSAGE_PROVIDED)
//	{
//		switch (Message)
//		{
//		case PVS_APIIF_MESSAGE_PLACE_RIGHT: 
//			{
//				printf("放上手掌\n");
//				break;
//			}
//		case PVS_APIIF_MESSAGE_HOLD_UP_HAND:
//			{
//				printf("放上手掌\n");
//				break;
//			}
//		case PVS_APIIF_MESSAGE_CORRECTLY:
//			{
//				printf("请正确放置手\n");
//				break;
//			}
//		case PVS_APIIF_MESSAGE_CLOSE:
//			{
//				printf("请将手靠近\n");
//				break;
//			}
//		case PVS_APIIF_MESSAGE_KEEP_AWAY:
//			{
//				printf("请抬高手掌\n");
//				break;
//			}
//		case PVS_APIIF_MESSAGE_MOVE_AWAY:
//			{
//				printf("请移开手,稍后再放回\n");
//				break;
//			}
//		case PVS_APIIF_MESSAGE_TEST_RIGHT:
//		case PVS_APIIF_MESSAGE_SAVING:
//		case PVS_APIIF_MESSAGE_AUTHENTICATING:
//		case PVS_APIIF_MESSAGE_STOP_MOVING:
//			{
//				printf("请保持\n");
//				break;
//			}
//		case PVS_APIIF_MESSAGE_EVEN_UP:
//		case PVS_APIIF_MESSAGE_SENSOR_ORIENT:
//		case PVS_APIIF_MESSAGE_FLATTEN_OUT:
//			{
//				printf("手掌放平\n");
//				break;
//			}
//		case PVS_APIIF_MESSAGE_FINGER_OPEN:
//			{
//				printf("请张开手指\n");
//				break;
//			}
//		case PVS_APIIF_MESSAGE_MOVE_FORWARD:
//			{
//				printf("向前移动\n");
//				break;
//			}
//		case PVS_APIIF_MESSAGE_MOVE_BACKWARD:
//			{
//				printf("向后移动\n");
//				break;
//			}
//		case PVS_APIIF_MESSAGE_MOVE_LEFT:
//			{
//				printf("向左移动\n");
//				break;
//			}
//		case PVS_APIIF_MESSAGE_MOVE_RIGHT:
//			{
//				printf("向右移动\n");
//				break;
//			}
//
//		case PVS_APIIF_MESSAGE_RETRY_RIGHT:
//			{
//				printf("重新开始采集\n");
//				break;
//			}
//		case PVS_APIIF_MESSAGE_FAILED_RIGHT:
//		case PVS_APIIF_MESSAGE_BRIGHT_MOMENT:
//		case PVS_APIIF_MESSAGE_BRIGHT_NG:
//			{
//				printf("重新采集,请不要移动您的手\n");
//				break;
//			}
//
//		default:
//			{
//				printf("采集中...\n");		
//				break;	
//			}
//		}
//	}
//
//	return PVS_APIIF_OK;
//}



/* Prototype declaration */
PVS_APIIF_RESULT hal_pvs_init( CALLBACK_FUNC *pFunc,
							PVS_BIOAPI_RETURN *pBioAPIReturn );

/* descrip: get enroll data from device 
 * param1: buffer for enroll data
 * param2: detail return value
 * return: this function return value
 */
PVS_APIIF_RESULT hal_pvs_enroll(std::string &EnrollDatabuf,
							PVS_BIOAPI_RETURN * pBioAPIReturn );

PVS_APIIF_RESULT  hal_pvs_capture( std::string &CapDatabuf,
							PVS_BIOAPI_RETURN * pBioAPIReturn );

PVS_APIIF_RESULT hal_pvs_cancel( PVS_APIIF_CANCEL_TYPE type,
							PVS_BIOAPI_RETURN * pBioAPIReturn );

PVS_APIIF_RESULT hal_pvs_terminate( PVS_BIOAPI_RETURN * pBioAPIReturn );














#endif
