/* HIGH ACCURACY TIMER
 *
 * compile command for Windows (needs Windows SDK)
 * mex -O hat.c
 %
 * compile command for Linux 
 * mex -O hat.c -lrt
 *
 * Ivo Houtzager
 */

#include "mex.h"
 
#if defined(_WIN32)
/* Include the windows SDK header for handling time functions. */
#include "windows.h"

__inline void hightimer( double *hTimePtr )
{
    HANDLE hCurrentProcess = GetCurrentProcess();
    DWORD dwProcessAffinity;
    DWORD dwSystemAffinity;
    LARGE_INTEGER frequency, counter;
    double sec_per_tick, total_ticks;
    
    /* force thread on first cpu */
    GetProcessAffinityMask(hCurrentProcess,&dwProcessAffinity,&dwSystemAffinity);
    SetProcessAffinityMask(hCurrentProcess, 1);
    
    /* retrieves the frequency of the high-resolution performance counter */
    QueryPerformanceFrequency(&frequency);
    
    /* retrieves the current value of the high-resolution performance counter */
    QueryPerformanceCounter(&counter);
    
     /* reset thread */
    SetProcessAffinityMask(hCurrentProcess,dwProcessAffinity);

    /* time in seconds */
    sec_per_tick = (double)1/(double)frequency.QuadPart;
    total_ticks = (double)counter.QuadPart;  
    *hTimePtr = sec_per_tick * total_ticks;
}   /* end hightimer */
#else
/* Include the standard ANSI C header for handling time functions. */
#if !defined(_POSIX_C_SOURCE) || _POSIX_C_SOURCE < 199309L
#define _POSIX_C_SOURCE 199309L
#endif
#include <time.h>

/* Function of the high performance counter (in seconds). */
__inline void hightimer( double *hTimePtr )
{    
    struct timespec time;

    /* retrieves the monotonic time */
    clock_gettime(CLOCK_MONOTONIC, &time); 

    /* time in seconds */
    /* tv_sec is long with max 10 digits, 
       gives remainder 6 digits of double for tv_nsec */
    *hTimePtr = ( (double)time.tv_sec + 1e-9*(double)time.tv_nsec );
}   /* end hightimer */
#endif

void mexFunction( int nlhs, mxArray *plhs[], int nrhs,
                  const mxArray *prhs[] )
{
    double hTime;

    /* check for proper number of arguments */
    if ( nrhs != 0 ) {
        mexErrMsgTxt( "No arguments required." );
    }

    /* do the actual computations in a subroutine */
    hightimer( &hTime );

    /* create a matrix for the return argument */
    plhs[0] = mxCreateDoubleScalar( hTime );
}   /* end mexFunction */