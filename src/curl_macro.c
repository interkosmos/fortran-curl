/* curl_macro.c */
#include <curl/curl.h>

/* Wrapper function that provides access to the constant `CURLVERSION_NOW`. */
int curl_version_now()
{
    return CURLVERSION_NOW;
}

/* Non-variadic wrappers to `curl_easy_setopt()`. */
int curl_easy_setopt_c_int(CURL *curl, CURLoption option, int value)
{
    return curl_easy_setopt(curl, option, value);
}

int curl_easy_setopt_c_long(CURL *curl, CURLoption option, long value)
{
    return curl_easy_setopt(curl, option, value);
}

int curl_easy_setopt_c_ptr(CURL *curl, CURLoption option, void *value)
{
    return curl_easy_setopt(curl, option, value);
}

int curl_easy_setopt_c_char(CURL *curl, CURLoption option, char *value)
{
    return curl_easy_setopt(curl, option, value);
}

int curl_easy_setopt_c_funptr(CURL *curl, CURLoption option, void *value)
{
    return curl_easy_setopt(curl, option, value);
}
