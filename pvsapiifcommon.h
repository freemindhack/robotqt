/* 
 *	PVSAPIIFCOMMON.H
 *	Description:
 *		Common declaration of Authentication library control.
 *
 *	History:
 *		NO	Date		Version		Updated by		Content of change
 *		1	2006/03 	V01L01		FUJITSU			princeps edition.
 *		2	2008/03 	V01L03		FUJITSU			- Add the flag and value definition of the operation mode of
 *													  the Authentication library.
 *													- Add the definition of the guidance message.
 *		3	2009/06		V01L05		FUJITSU			- Change "PVS_VEIN_DATA" from 2468 to 3072"
 *													- Delete the enum type "PVS_APIIF_GUIDANCE"
 *													- Add the enum type "PVS_APIIF_DUMMY"
 *													- Add the following items in enum type "PVS_BIOAPI"
 *														- PVS_PVAPI_PRESETPROFILE
 *														- PVS_PVAPI_PREIDENTIFYPOPULATION
 *													- Add the following member in enum type "PVS_APIIF_RESULT"
 *														- PVS_APIIF_GET_MEMORY_ERR
 *													- Add the following struct types
 *														- PVS_SENSOR_INFO
 *														- PVS_CAPTURE_DATA
 *													- Add the following #define preprocessor directives
 *														- "PVS_APIIF_PROFILE_ENROLL_INDEX_MODE",
 *														  "PVS_APIIF_PROFILE_INDEX_MODE_1","PVS_APIIF_PROFILE_INDEX_MODE_2"
 *														- "PVS_APIIF_PROFILE_IDENTIFY_MODE_INDEX_2"
 *													- Delete the following #define preprocessor directives
 *														- "PVS_APIIF_PROFILE_EXTRACT_KIND_1"
 *														- "PVS_APIIF_PROFILE_DISPLAY_KIND","PVS_APIIF_PROFILE_DISPLAY_KIND_APL",
 *														  "PVS_APIIF_PROFILE_DISPLAY_KIND_LIB"
 *														- "PVS_APIIF_PROFILE_SENSOR_TYPE","PVS_APIIF_PROFILE_SENSOR_TYPE_INI",
 *														  "PVS_APIIF_PROFILE_SENSOR_TYPE_AUTO","PVS_APIIF_PROFILE_SENSOR_TYPE_NO_SENSOR"
 *		4	2009/10		V01L06		FUJITSU			- Add the following #define preprocessor directives
 *														- "PVS_APIIF_INVALID_REGIST_SCORE","PVS_APIIF_REGIST_SCORE_QUALITY_1",
 *														  "PVS_APIIF_REGIST_SCORE_QUALITY_2","PVS_APIIF_REGIST_SCORE_QUALITY_3"
 *													- Add the following struct types
 *														- PVS_APIIF_REGIST_SCORE_INFO
 *													- Delete the following #define preprocessor directives
 *														- "PVS_APIIF_PROFILE_IDENTIFY_MODE_INDEX"
 *		5	2011/05		V01L07		FUJITSU			- Add the following define of type
 *														- PVS_APIIF_SCORE
 *													- Add the following struct types
 *														- PVS_APIIF_CANDIDATE_INFO
 *														- PVS_APIIF_AUTHENTICATION_SCORE_INFO
 */


#if !defined (__PVSAPIIFCOMMON_H_)
#define __PVSAPIIFCOMMON_H_

#ifdef WIN32
#include"PVSAPIIFTYPES.H"
#else
#include"pvsapiiftypes.h"
#endif

typedef INT  PVS_APIIF_BOOL;
#define PVS_APIIF_FALSE		(0)
#define PVS_APIIF_TRUE		(!PVS_APIIF_FALSE)

typedef enum PVS_APIIF_DUMMY{
	PVS_APIIF_DUMMY_VALUE
} PVS_APIIF_DUMMY;

typedef struct PVS_VEIN_DATA{
	CHAR veinData[(15000)];							/* Vein data	*/
} PVS_VEIN_DATA;

typedef struct PVS_CAPTURE_DATA{
	CHAR veinData[(8192)];							/* Vein data	*/
} PVS_CAPTURE_DATA;

typedef enum PVS_APIIF_RESULT {
	PVS_APIIF_OK					=0,				/* Normal						*/
	PVS_APIIF_CANCEL				=-1,			/* Processing canceled			*/
	PVS_APIIF_ARGUMENT_ERR			=-2,			/* Argument error				*/
	PVS_APIIF_BIOAPI_ERR			=-3,			/* Authentication library error	*/
	PVS_APIIF_GET_MEMORY_ERR		=-4,			/* Memory allocation error		*/
	PVS_APIIF_SENSE_TIMEOUT			=-5				/* sense time out*/
} PVS_APIIF_RESULT;

typedef enum PVS_BIOAPI {
	PVS_BIOAPI_MODULELOAD			=0,				/* BioAPI_ModuleLoad			*/
	PVS_BIOAPI_MODULEUNLOAD			=1,				/* BioAPI_ModuleUnload			*/
	PVS_BIOAPI_MODULEATTACH			=2,				/* BioAPI_ModuleAttach			*/
	PVS_BIOAPI_MODULEDETACH			=3,				/* BioAPI_ModuleDetach			*/
	PVS_BIOAPI_FREEBIRHANDLE		=4,				/* BioAPI_FreeBIRHandle			*/
	PVS_BIOAPI_GETBIRFROMHANDLE		=5,				/* BioAPI_GetBIRFromHandle 		*/
	PVS_BIOAPI_GETHEADERFROMHANDLE	=6,				/* BioAPI_GetHeaderFromHandle 	*/
	PVS_BIOAPI_ENROLL				=7,				/* BioAPI_Enroll				*/
	PVS_BIOAPI_VERIFY				=8,				/* BioAPI_Verify				*/
	PVS_BIOAPI_IDENTIFY				=9,				/* BioAPI_Identify				*/
	PVS_BIOAPI_SETGUICALLBACKS		=10,			/* BioAPI_SetGUICallbacks		*/
	PVS_BIOAPI_CAPTURE				=11,			/* BioAPI_Capture				*/
	PVS_BIOAPI_PROCESS				=12,			/* BioAPI_Process				*/
	PVS_BIOAPI_VERIFYMATCH			=13,			/* BioAPI_VerifyMatch			*/
	PVS_BIOAPI_IDENTIFYMATCH		=14,			/* BioAPI_IdentifyMatch			*/
	PVS_PVAPI_APAUTHENTICATE		=15,			/* PvAPI_ApAuthenticate			*/
	PVS_PVAPI_GETERRORINFO			=16,			/* PvAPI_GetErrorInfo			*/
	PVS_PVAPI_SETPROFILE			=17,			/* PvAPI_SetProfile				*/
	PVS_PVAPI_SENSE					=18,			/* PvAPI_Sense					*/
	PVS_PVAPI_CANCEL				=19,			/* PvAPI_Cancel					*/
	PVS_PVAPI_CREATEHANDLEFROMBD	=20,	/* PvAPI_CreateHandleFromBiometricData	*/
	PVS_PVAPI_PRESETPROFILE			=21,			/* PvAPI_PreSetProfile			*/
	PVS_PVAPI_PREIDENTIFYPOPULATION	=22,		/* PvAPI_PresetIdentifyPopulation	*/
} PVS_BIOAPI;

typedef struct Pvs_BioAPI_Return{
	PVS_BIOAPI bioAPI;						/* Authentication library function code	*/
	UINT ErrorLevel;						/* Error level							*/
											/*   0:Normal  1:Possible to recover	*/
											/*   2:Impossible to recover			*/
	UINT ErrorCode;							/* Error type	 						*/
											/*   1:Device	2:Resource				*/
											/*   3:Application 4:Others				*/
	UINT ErrorDetail;						/* Error detail							*/
	UINT ErrorModule;						/* Error detection module				*/
											/*   1:Interface section				*/
											/*   2:Authentication Library			*/
	UINT ErrorOptional1;					/* Internal information 1				*/
	UINT ErrorOptional2;					/* Internal information 2				*/
	UINT APIInfo[4];						/* Interface section information		*/
	UINT ErrorInfo1;						/* Error Information1					*/
	UINT ErrorInfo2;						/* Error Information2					*/
	UINT ErrorInfo3[4];						/* Error Information3					*/
} PVS_BIOAPI_RETURN;
	
typedef enum PVS_APIIF_CANCEL_TYPE {
	PVS_APIIF_CANCEL_CANCEL				=0,			/* Cancel		*/
	PVS_APIIF_CANCEL_RETRY				=1,			/* Retry		*/
} PVS_APIIF_CANCEL_TYPE;

typedef enum PVS_APIIF_GUI_STATE {
	PVS_APIIF_SAMPLE_AVAILABLE	=0x0000001,			/* Image		*/
	PVS_APIIF_MESSAGE_PROVIDED	=0x0000002,			/* Guidance		*/
	PVS_APIIF_PROGRESS_PROVIDED =0x0000004			/* PROGRESS		*/
} PVS_APIIF_GUI_STATE;

typedef enum PVS_APIIF_GUI_MESSAGE {
	PVS_APIIF_MESSAGE_STOP_MOVING		=1,			/* Do not move your hand			*/
	PVS_APIIF_MESSAGE_CORRECTLY			=2,			/* Hold up correctly.				*/
	PVS_APIIF_MESSAGE_CLOSE				=3,			/* Close.							*/
	PVS_APIIF_MESSAGE_KEEP_AWAY			=4,			/* Keep away.						*/
	PVS_APIIF_MESSAGE_SAVING			=5,			/* Saving.							*/
	PVS_APIIF_MESSAGE_AUTHENTICATING	=6,			/* Authenticating.					*/
	PVS_APIIF_MESSAGE_MOVE_AWAY			=7,			/* Move away						*/
	PVS_APIIF_MESSAGE_PLACE_RIGHT		=8,			/* Start capturing(Right hand)		*/
	PVS_APIIF_MESSAGE_TEST_RIGHT		=9,			/* Test verification.(Right hand)	*/
	PVS_APIIF_MESSAGE_RETRY_RIGHT		=10,		/* Enroll retry.(Right hand)		*/
	PVS_APIIF_MESSAGE_FAILED_RIGHT		=11,		/* Verification failed.(Right hand)	*/
	PVS_APIIF_MESSAGE_PLACE_LEFT		=12,		/* Start capturing(Left hand)		*/
	PVS_APIIF_MESSAGE_TEST_LEFT			=13,		/* Test verification.(Left hand)	*/
	PVS_APIIF_MESSAGE_RETRY_LEFT		=14,		/* Enroll retry.(Left hand)			*/
	PVS_APIIF_MESSAGE_FAILED_LEFT		=15,		/* Verification failed.(Left hand)	*/
	PVS_APIIF_MESSAGE_MOVE_LEFT			=16,		/* Move your hand slightly to the left. 			*/
	PVS_APIIF_MESSAGE_MOVE_RIGHT		=17,		/* Move your hand slightly to the right. 			*/
	PVS_APIIF_MESSAGE_MOVE_FORWARD		=18,		/* Move your hand slightly away from you. 			*/
	PVS_APIIF_MESSAGE_MOVE_BACKWARD		=19,		/* Move your hand slightly toward you. 				*/
	PVS_APIIF_MESSAGE_EVEN_UP			=20,		/* Lay your hand flat.								*/
	PVS_APIIF_MESSAGE_SENSOR_ORIENT		=21,		/* Place your hand parallel to the sensor.			*/
	PVS_APIIF_MESSAGE_FINGER_OPEN		=22,		/* Spread your fingers.								*/
	PVS_APIIF_MESSAGE_BRIGHT_MOMENT		=23,		/* Trying to capture again. don't move your hand. 	*/
	PVS_APIIF_MESSAGE_BRIGHT_NG			=24,		/* Trying to capture again. don't move your hand. 	*/
	PVS_APIIF_MESSAGE_HOLD_UP_HAND		=25,		/* Place your hand above the sensor.	*/
	PVS_APIIF_MESSAGE_FLATTEN_OUT		=26,		/* Flatten the hand, and bring it closer to the sensor a little.	*/
} PVS_APIIF_GUI_MESSAGE;

typedef void CALLBACK_FUNC;

typedef struct PVS_APIIF_DATA {
	INT Length;
	CHAR *Data;
} PVS_APIIF_DATA;

typedef struct PVS_APIIF_GUI_BITMAP {
	INT Width;
	INT Height;
	PVS_APIIF_DATA	* BitmapData;
} PVS_APIIF_GUI_BITMAP;

#endif


