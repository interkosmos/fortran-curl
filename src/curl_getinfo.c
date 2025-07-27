/* curl_getinfo.c
 *
 * C wrapper for curl_easy_getinfo to fix platform-specific issues
 * particularly on macOS ARM64 where direct Fortran binding causes problems
 *
 * Author:  Christopher Albert
 * Licence: ISC
 */
#include <curl/curl.h>

/* Wrapper for getting long values (including HTTP response code) */
int curl_easy_getinfo_long_wrapper(void *curl, int info, long *value) {
    if (curl == NULL || value == NULL) {
        return CURLE_BAD_FUNCTION_ARGUMENT;
    }
    return (int)curl_easy_getinfo((CURL *)curl, (CURLINFO)info, value);
}

