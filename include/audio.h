#ifndef _AUDIO_H_
#define _AUDIO_H_

#include <stdio.h>

#include "mi_common.h"
#include "mi_sys.h"
#include "mi_ao.h"

#ifdef __cplusplus
extern "C" {
#endif

#define ExecFunc(result, value)\
    if (result != value)\
    {\
        printf("[%s %d]exec function failed\n", __FUNCTION__, __LINE__);\
        return -1;\
    }\

extern void Mp3PlayStopDec(void);
extern int mp3_codec(char *mp3_file);
extern int set_volume(int AoVolume);

#ifdef __cplusplus
}
#endif

#endif