/* curl_macro.c */
#include <curl/curl.h>
#include <curl/multi.h>
#include <curl/urlapi.h>

#ifdef __cplusplus
extern "C" {
#endif

void curl_easy_cleanup_(void **);
int  curl_easy_getinfo_c_long(void *, int, long *);
int  curl_easy_setopt_c_char(void *, int, char *);
int  curl_easy_setopt_c_funptr(void *, int, void *);
int  curl_easy_setopt_c_int(void *, int, int);
int  curl_easy_setopt_c_long(void *, int, long);
int  curl_easy_setopt_c_ptr(void *, int, void *);
void curl_free_(void **);
void curl_mime_free_(void **);
int  curl_multi_cleanup_(void **);
void curl_slist_free_all_(void **);
void curl_url_cleanup_(void **);
int  curl_version_now(void);

void curl_easy_cleanup_(void **easy)
{
    curl_easy_cleanup((CURL *) *easy);
    *easy = NULL;
}

void curl_free_(void **p)
{
    curl_free(*p);
    *p = NULL;
}

void curl_mime_free_(void **mime)
{
    curl_mime_free((curl_mime *) *mime);
    *mime = NULL;
}

int curl_multi_cleanup_(void **multi)
{
    CURLMcode code;
    code = curl_multi_cleanup((CURLM *) *multi);
    if (code == CURLM_OK) *multi = NULL;
    return (int) code;
}

void curl_slist_free_all_(void **list)
{
    curl_slist_free_all((struct curl_slist *) *list);
    *list = NULL;
}

void curl_url_cleanup_(void **url)
{
    curl_url_cleanup((CURLU *) *url);
    *url = NULL;
}

/*
 * C wrapper for curl_easy_getinfo() to fix platform-specific issues
 * particularly on macOS ARM64 where direct Fortran binding causes problems.
 *
 * Author:  Christopher Albert
 * Licence: ISC
 */
int curl_easy_getinfo_c_long(void *easy, int info, long *value)
{
    if (easy == NULL || value == NULL)
    {
        return CURLE_BAD_FUNCTION_ARGUMENT;
    }
    return (int) curl_easy_getinfo((CURL *) easy, (CURLINFO) info, value);
}

/* Non-variadic wrappers to `curl_easy_setopt()`. */
int curl_easy_setopt_c_char(void *easy, int option, char *value)
{
    if (easy == NULL || value == NULL)
    {
        return CURLE_BAD_FUNCTION_ARGUMENT;
    }
    return (int) curl_easy_setopt((CURL *) easy, (CURLoption) option, value);
}

int curl_easy_setopt_c_funptr(void *easy, int option, void *value)
{
    if (easy == NULL || value == NULL)
    {
        return CURLE_BAD_FUNCTION_ARGUMENT;
    }
    return (int) curl_easy_setopt((CURL *) easy, (CURLoption) option, value);
}

int curl_easy_setopt_c_int(void *easy, int option, int value)
{
    if (easy == NULL)
    {
        return CURLE_BAD_FUNCTION_ARGUMENT;
    }
    return (int) curl_easy_setopt((CURL *) easy, (CURLoption) option, value);
}

int curl_easy_setopt_c_long(void *easy, int option, long value)
{
    if (easy == NULL)
    {
        return CURLE_BAD_FUNCTION_ARGUMENT;
    }
    return (int) curl_easy_setopt((CURL *) easy, (CURLoption) option, value);
}

int curl_easy_setopt_c_ptr(void *easy, int option, void *value)
{
    if (easy == NULL || value == NULL)
    {
        return CURLE_BAD_FUNCTION_ARGUMENT;
    }
    return (int) curl_easy_setopt((CURL *) easy, (CURLoption) option, value);
}

/* Wrapper function that provides access to the constant `CURLVERSION_NOW`. */
int curl_version_now(void)
{
    return CURLVERSION_NOW;
}

#ifdef __cplusplus
}
#endif
