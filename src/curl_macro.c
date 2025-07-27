/* curl_macro.c */
#include <curl/curl.h>

#ifdef __cplusplus
extern "C" {
#endif

int curl_easy_getinfo_c_long(void *, int, long *);
int curl_easy_setopt_c_char(void *, int, char *);
int curl_easy_setopt_c_funptr(void *, int, void *);
int curl_easy_setopt_c_int(void *, int, int);
int curl_easy_setopt_c_long(void *, int, long);
int curl_easy_setopt_c_ptr(void *, int, void *);
int curl_version_now(void);

/*
 * C wrapper for curl_easy_getinfo() to fix platform-specific issues
 * particularly on macOS ARM64 where direct Fortran binding causes problems
 *
 * Author:  Christopher Albert
 * Licence: ISC
 */
int curl_easy_getinfo_c_long(void *curl, int info, long *value)
{
    if (curl == NULL || value == NULL)
    {
        return CURLE_BAD_FUNCTION_ARGUMENT;
    }
    return (int) curl_easy_getinfo((CURL *) curl, (CURLINFO) info, value);
}

/* Non-variadic wrappers to `curl_easy_setopt()`. */
int curl_easy_setopt_c_char(void *curl, int option, char *value)
{
    if (curl == NULL || value == NULL)
    {
        return CURLE_BAD_FUNCTION_ARGUMENT;
    }
    return (int) curl_easy_setopt((CURL *) curl, (CURLoption) option, value);
}

int curl_easy_setopt_c_funptr(void *curl, int option, void *value)
{
    if (curl == NULL || value == NULL)
    {
        return CURLE_BAD_FUNCTION_ARGUMENT;
    }
    return (int) curl_easy_setopt((CURL *) curl, (CURLoption) option, value);
}

int curl_easy_setopt_c_int(void *curl, int option, int value)
{
    if (curl == NULL)
    {
        return CURLE_BAD_FUNCTION_ARGUMENT;
    }
    return (int) curl_easy_setopt((CURL *) curl, (CURLoption) option, value);
}

int curl_easy_setopt_c_long(void *curl, int option, long value)
{
    if (curl == NULL)
    {
        return CURLE_BAD_FUNCTION_ARGUMENT;
    }
    return (int) curl_easy_setopt((CURL *) curl, (CURLoption) option, value);
}

int curl_easy_setopt_c_ptr(void *curl, int option, void *value)
{
    if (curl == NULL || value == NULL)
    {
        return CURLE_BAD_FUNCTION_ARGUMENT;
    }
    return (int) curl_easy_setopt((CURL *) curl, (CURLoption) option, value);
}

/* Wrapper function that provides access to the constant `CURLVERSION_NOW`. */
int curl_version_now(void)
{
    return CURLVERSION_NOW;
}

#ifdef __cplusplus
}
#endif
