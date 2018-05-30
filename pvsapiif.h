/* 
 *	PVSAPIIF.H
 *	Description:
 *		The function prototype of Authentication library control is declared. 
 */


#if !defined (__PVSAPIIF_H_)
#define __PVSAPIIF_H_


#include "pvs_hal.h"

#ifdef WIN32
#define PvsAPIIF    __stdcall
#else
#define PvsAPIIF
#endif

#ifdef __cplusplus
extern "C" {
#endif

/* Prototype declaration */
PVS_APIIF_RESULT PvsAPIIF Pvs_APIIFInit( CALLBACK_FUNC *pFunc,
							PVS_BIOAPI_RETURN *pBioAPIReturn );

PVS_APIIF_RESULT PvsAPIIF Pvs_APIIFEnroll(PVS_VEIN_DATA * pVeinData,
							PVS_BIOAPI_RETURN * pBioAPIReturn );

PVS_APIIF_RESULT PvsAPIIF Pvs_APIIFCapture( PVS_CAPTURE_DATA * pVeinData,
							PVS_BIOAPI_RETURN * pBioAPIReturn );

PVS_APIIF_RESULT PvsAPIIF Pvs_APIIFCancel( PVS_APIIF_CANCEL_TYPE type,
							PVS_BIOAPI_RETURN * pBioAPIReturn );

PVS_APIIF_RESULT PvsAPIIF Pvs_APIIFTerminate( PVS_BIOAPI_RETURN * pBioAPIReturn );


#ifdef __cplusplus
}
#endif


#endif


