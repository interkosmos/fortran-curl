! curl_easy.f90
!
! Fortran 2008 ISO C binding interfaces to `curl.h` and `easy.h`.
!
! Author:  Philipp Engel
! Licence: ISC
module curl_easy
    use, intrinsic :: iso_c_binding
    use, intrinsic :: iso_fortran_env, only: i4 => int32, i8 => int64
    use :: curl_util
    implicit none
    private

    integer(kind=c_int), parameter, public :: CURLOPTTYPE_LONG          = 0
    integer(kind=c_int), parameter, public :: CURLOPTTYPE_OBJECTPOINT   = 10000
    integer(kind=c_int), parameter, public :: CURLOPTTYPE_FUNCTIONPOINT = 20000
    integer(kind=c_int), parameter, public :: CURLOPTTYPE_OFF_T         = 30000
    integer(kind=c_int), parameter, public :: CURLOPTTYPE_BLOB          = 40000
    integer(kind=c_int), parameter, public :: CURLOPTTYPE_STRINGPOINT   = CURLOPTTYPE_OBJECTPOINT
    integer(kind=c_int), parameter, public :: CURLOPTTYPE_SLISTPOINT    = CURLOPTTYPE_OBJECTPOINT
    integer(kind=c_int), parameter, public :: CURLOPTTYPE_CBPOINT       = CURLOPTTYPE_OBJECTPOINT
    integer(kind=c_int), parameter, public :: CURLOPTTYPE_VALUES        = CURLOPTTYPE_LONG

    ! CURLoption
    integer(kind=c_int), parameter, public :: CURLOPT_WRITEDATA                  = CURLOPTTYPE_OBJECTPOINT + 1
    integer(kind=c_int), parameter, public :: CURLOPT_URL                        = CURLOPTTYPE_OBJECTPOINT + 2
    integer(kind=c_int), parameter, public :: CURLOPT_PORT                       = CURLOPTTYPE_LONG + 3
    integer(kind=c_int), parameter, public :: CURLOPT_PROXY                      = CURLOPTTYPE_OBJECTPOINT + 4
    integer(kind=c_int), parameter, public :: CURLOPT_USERPWD                    = CURLOPTTYPE_OBJECTPOINT + 5
    integer(kind=c_int), parameter, public :: CURLOPT_PROXYUSERPWD               = CURLOPTTYPE_OBJECTPOINT + 6
    integer(kind=c_int), parameter, public :: CURLOPT_RANGE                      = CURLOPTTYPE_OBJECTPOINT + 7
    integer(kind=c_int), parameter, public :: CURLOPT_READDATA                   = CURLOPTTYPE_OBJECTPOINT + 9
    integer(kind=c_int), parameter, public :: CURLOPT_ERRORBUFFER                = CURLOPTTYPE_OBJECTPOINT + 10
    integer(kind=c_int), parameter, public :: CURLOPT_WRITEFUNCTION              = CURLOPTTYPE_FUNCTIONPOINT + 11
    integer(kind=c_int), parameter, public :: CURLOPT_READFUNCTION               = CURLOPTTYPE_FUNCTIONPOINT + 12
    integer(kind=c_int), parameter, public :: CURLOPT_TIMEOUT                    = CURLOPTTYPE_LONG + 13
    integer(kind=c_int), parameter, public :: CURLOPT_INFILESIZE                 = CURLOPTTYPE_LONG + 14
    integer(kind=c_int), parameter, public :: CURLOPT_POSTFIELDS                 = CURLOPTTYPE_OBJECTPOINT + 15
    integer(kind=c_int), parameter, public :: CURLOPT_REFERER                    = CURLOPTTYPE_OBJECTPOINT + 16
    integer(kind=c_int), parameter, public :: CURLOPT_FTPPORT                    = CURLOPTTYPE_OBJECTPOINT + 17
    integer(kind=c_int), parameter, public :: CURLOPT_USERAGENT                  = CURLOPTTYPE_OBJECTPOINT + 18
    integer(kind=c_int), parameter, public :: CURLOPT_LOW_SPEED_LIMIT            = CURLOPTTYPE_LONG + 19
    integer(kind=c_int), parameter, public :: CURLOPT_LOW_SPEED_TIME             = CURLOPTTYPE_LONG + 20
    integer(kind=c_int), parameter, public :: CURLOPT_RESUME_FROM                = CURLOPTTYPE_LONG + 21
    integer(kind=c_int), parameter, public :: CURLOPT_COOKIE                     = CURLOPTTYPE_OBJECTPOINT + 22
    integer(kind=c_int), parameter, public :: CURLOPT_HTTPHEADER                 = CURLOPTTYPE_OBJECTPOINT + 23
    integer(kind=c_int), parameter, public :: CURLOPT_HTTPPOST                   = CURLOPTTYPE_OBJECTPOINT + 24
    integer(kind=c_int), parameter, public :: CURLOPT_SSLCERT                    = CURLOPTTYPE_OBJECTPOINT + 25
    integer(kind=c_int), parameter, public :: CURLOPT_KEYPASSWD                  = CURLOPTTYPE_OBJECTPOINT + 26
    integer(kind=c_int), parameter, public :: CURLOPT_CRLF                       = CURLOPTTYPE_LONG + 27
    integer(kind=c_int), parameter, public :: CURLOPT_QUOTE                      = CURLOPTTYPE_OBJECTPOINT + 28
    integer(kind=c_int), parameter, public :: CURLOPT_HEADERDATA                 = CURLOPTTYPE_OBJECTPOINT + 29
    integer(kind=c_int), parameter, public :: CURLOPT_COOKIEFILE                 = CURLOPTTYPE_OBJECTPOINT + 31
    integer(kind=c_int), parameter, public :: CURLOPT_SSLVERSION                 = CURLOPTTYPE_LONG + 32
    integer(kind=c_int), parameter, public :: CURLOPT_TIMECONDITION              = CURLOPTTYPE_LONG + 33
    integer(kind=c_int), parameter, public :: CURLOPT_TIMEVALUE                  = CURLOPTTYPE_LONG + 34
    integer(kind=c_int), parameter, public :: CURLOPT_CUSTOMREQUEST              = CURLOPTTYPE_OBJECTPOINT + 36
    integer(kind=c_int), parameter, public :: CURLOPT_STDERR                     = CURLOPTTYPE_OBJECTPOINT + 37
    integer(kind=c_int), parameter, public :: CURLOPT_POSTQUOTE                  = CURLOPTTYPE_OBJECTPOINT + 39
    integer(kind=c_int), parameter, public :: CURLOPT_OBSOLETE40                 = CURLOPTTYPE_OBJECTPOINT + 40
    integer(kind=c_int), parameter, public :: CURLOPT_VERBOSE                    = CURLOPTTYPE_LONG + 41
    integer(kind=c_int), parameter, public :: CURLOPT_HEADER                     = CURLOPTTYPE_LONG + 42
    integer(kind=c_int), parameter, public :: CURLOPT_NOPROGRESS                 = CURLOPTTYPE_LONG + 43
    integer(kind=c_int), parameter, public :: CURLOPT_NOBODY                     = CURLOPTTYPE_LONG + 44
    integer(kind=c_int), parameter, public :: CURLOPT_FAILONERROR                = CURLOPTTYPE_LONG + 45
    integer(kind=c_int), parameter, public :: CURLOPT_UPLOAD                     = CURLOPTTYPE_LONG + 46
    integer(kind=c_int), parameter, public :: CURLOPT_POST                       = CURLOPTTYPE_LONG + 47
    integer(kind=c_int), parameter, public :: CURLOPT_DIRLISTONLY                = CURLOPTTYPE_LONG + 48
    integer(kind=c_int), parameter, public :: CURLOPT_APPEND                     = CURLOPTTYPE_LONG + 50
    integer(kind=c_int), parameter, public :: CURLOPT_NETRC                      = CURLOPTTYPE_LONG + 51
    integer(kind=c_int), parameter, public :: CURLOPT_FOLLOWLOCATION             = CURLOPTTYPE_LONG + 52
    integer(kind=c_int), parameter, public :: CURLOPT_TRANSFERTEXT               = CURLOPTTYPE_LONG + 53
    integer(kind=c_int), parameter, public :: CURLOPT_PUT                        = CURLOPTTYPE_LONG + 54
    integer(kind=c_int), parameter, public :: CURLOPT_PROGRESSFUNCTION           = CURLOPTTYPE_FUNCTIONPOINT + 56
    integer(kind=c_int), parameter, public :: CURLOPT_PROGRESSDATA               = CURLOPTTYPE_OBJECTPOINT + 57
    integer(kind=c_int), parameter, public :: CURLOPT_AUTOREFERER                = CURLOPTTYPE_LONG + 58
    integer(kind=c_int), parameter, public :: CURLOPT_PROXYPORT                  = CURLOPTTYPE_LONG + 59
    integer(kind=c_int), parameter, public :: CURLOPT_POSTFIELDSIZE              = CURLOPTTYPE_LONG + 60
    integer(kind=c_int), parameter, public :: CURLOPT_HTTPPROXYTUNNEL            = CURLOPTTYPE_LONG + 61
    integer(kind=c_int), parameter, public :: CURLOPT_INTERFACE                  = CURLOPTTYPE_OBJECTPOINT + 62
    integer(kind=c_int), parameter, public :: CURLOPT_KRBLEVEL                   = CURLOPTTYPE_OBJECTPOINT + 63
    integer(kind=c_int), parameter, public :: CURLOPT_SSL_VERIFYPEER             = CURLOPTTYPE_LONG + 64
    integer(kind=c_int), parameter, public :: CURLOPT_CAINFO                     = CURLOPTTYPE_OBJECTPOINT + 65
    integer(kind=c_int), parameter, public :: CURLOPT_MAXREDIRS                  = CURLOPTTYPE_LONG + 68
    integer(kind=c_int), parameter, public :: CURLOPT_FILETIME                   = CURLOPTTYPE_LONG + 69
    integer(kind=c_int), parameter, public :: CURLOPT_TELNETOPTIONS              = CURLOPTTYPE_OBJECTPOINT + 70
    integer(kind=c_int), parameter, public :: CURLOPT_MAXCONNECTS                = CURLOPTTYPE_LONG + 71
    integer(kind=c_int), parameter, public :: CURLOPT_OBSOLETE72                 = CURLOPTTYPE_LONG + 72
    integer(kind=c_int), parameter, public :: CURLOPT_FRESH_CONNECT              = CURLOPTTYPE_LONG + 74
    integer(kind=c_int), parameter, public :: CURLOPT_FORBID_REUSE               = CURLOPTTYPE_LONG + 75
    integer(kind=c_int), parameter, public :: CURLOPT_RANDOM_FILE                = CURLOPTTYPE_OBJECTPOINT + 76
    integer(kind=c_int), parameter, public :: CURLOPT_EGDSOCKET                  = CURLOPTTYPE_OBJECTPOINT + 77
    integer(kind=c_int), parameter, public :: CURLOPT_CONNECTTIMEOUT             = CURLOPTTYPE_LONG + 78
    integer(kind=c_int), parameter, public :: CURLOPT_HEADERFUNCTION             = CURLOPTTYPE_FUNCTIONPOINT + 79
    integer(kind=c_int), parameter, public :: CURLOPT_HTTPGET                    = CURLOPTTYPE_LONG + 80
    integer(kind=c_int), parameter, public :: CURLOPT_SSL_VERIFYHOST             = CURLOPTTYPE_LONG + 81
    integer(kind=c_int), parameter, public :: CURLOPT_COOKIEJAR                  = CURLOPTTYPE_OBJECTPOINT + 82
    integer(kind=c_int), parameter, public :: CURLOPT_SSL_CIPHER_LIST            = CURLOPTTYPE_OBJECTPOINT + 83
    integer(kind=c_int), parameter, public :: CURLOPT_HTTP_VERSION               = CURLOPTTYPE_LONG + 84
    integer(kind=c_int), parameter, public :: CURLOPT_FTP_USE_EPSV               = CURLOPTTYPE_LONG + 85
    integer(kind=c_int), parameter, public :: CURLOPT_SSLCERTTYPE                = CURLOPTTYPE_OBJECTPOINT + 86
    integer(kind=c_int), parameter, public :: CURLOPT_SSLKEY                     = CURLOPTTYPE_OBJECTPOINT + 87
    integer(kind=c_int), parameter, public :: CURLOPT_SSLKEYTYPE                 = CURLOPTTYPE_OBJECTPOINT + 88
    integer(kind=c_int), parameter, public :: CURLOPT_SSLENGINE                  = CURLOPTTYPE_OBJECTPOINT + 89
    integer(kind=c_int), parameter, public :: CURLOPT_SSLENGINE_DEFAULT          = CURLOPTTYPE_LONG + 90
    integer(kind=c_int), parameter, public :: CURLOPT_DNS_USE_GLOBAL_CACHE       = CURLOPTTYPE_LONG + 91
    integer(kind=c_int), parameter, public :: CURLOPT_DNS_CACHE_TIMEOUT          = CURLOPTTYPE_LONG + 92
    integer(kind=c_int), parameter, public :: CURLOPT_PREQUOTE                   = CURLOPTTYPE_OBJECTPOINT + 93
    integer(kind=c_int), parameter, public :: CURLOPT_DEBUGFUNCTION              = CURLOPTTYPE_FUNCTIONPOINT + 94
    integer(kind=c_int), parameter, public :: CURLOPT_DEBUGDATA                  = CURLOPTTYPE_OBJECTPOINT + 95
    integer(kind=c_int), parameter, public :: CURLOPT_COOKIESESSION              = CURLOPTTYPE_LONG + 96
    integer(kind=c_int), parameter, public :: CURLOPT_CAPATH                     = CURLOPTTYPE_OBJECTPOINT + 97
    integer(kind=c_int), parameter, public :: CURLOPT_BUFFERSIZE                 = CURLOPTTYPE_LONG + 98
    integer(kind=c_int), parameter, public :: CURLOPT_NOSIGNAL                   = CURLOPTTYPE_LONG + 99
    integer(kind=c_int), parameter, public :: CURLOPT_SHARE                      = CURLOPTTYPE_OBJECTPOINT + 100
    integer(kind=c_int), parameter, public :: CURLOPT_PROXYTYPE                  = CURLOPTTYPE_LONG + 101
    integer(kind=c_int), parameter, public :: CURLOPT_ACCEPT_ENCODING            = CURLOPTTYPE_OBJECTPOINT + 102
    integer(kind=c_int), parameter, public :: CURLOPT_PRIVATE                    = CURLOPTTYPE_OBJECTPOINT + 103
    integer(kind=c_int), parameter, public :: CURLOPT_HTTP200ALIASES             = CURLOPTTYPE_OBJECTPOINT + 104
    integer(kind=c_int), parameter, public :: CURLOPT_UNRESTRICTED_AUTH          = CURLOPTTYPE_LONG + 105
    integer(kind=c_int), parameter, public :: CURLOPT_FTP_USE_EPRT               = CURLOPTTYPE_LONG + 106
    integer(kind=c_int), parameter, public :: CURLOPT_HTTPAUTH                   = CURLOPTTYPE_LONG + 107
    integer(kind=c_int), parameter, public :: CURLOPT_SSL_CTX_FUNCTION           = CURLOPTTYPE_FUNCTIONPOINT + 108
    integer(kind=c_int), parameter, public :: CURLOPT_SSL_CTX_DATA               = CURLOPTTYPE_OBJECTPOINT + 109
    integer(kind=c_int), parameter, public :: CURLOPT_FTP_CREATE_MISSING_DIRS    = CURLOPTTYPE_LONG + 110
    integer(kind=c_int), parameter, public :: CURLOPT_PROXYAUTH                  = CURLOPTTYPE_LONG + 111
    integer(kind=c_int), parameter, public :: CURLOPT_FTP_RESPONSE_TIMEOUT       = CURLOPTTYPE_LONG + 112
    integer(kind=c_int), parameter, public :: CURLOPT_IPRESOLVE                  = CURLOPTTYPE_LONG + 113
    integer(kind=c_int), parameter, public :: CURLOPT_MAXFILESIZE                = CURLOPTTYPE_LONG + 114
    integer(kind=c_int), parameter, public :: CURLOPT_INFILESIZE_LARGE           = CURLOPTTYPE_OFF_T + 115
    integer(kind=c_int), parameter, public :: CURLOPT_RESUME_FROM_LARGE          = CURLOPTTYPE_OFF_T + 116
    integer(kind=c_int), parameter, public :: CURLOPT_MAXFILESIZE_LARGE          = CURLOPTTYPE_OFF_T + 117
    integer(kind=c_int), parameter, public :: CURLOPT_NETRC_FILE                 = CURLOPTTYPE_OBJECTPOINT + 118
    integer(kind=c_int), parameter, public :: CURLOPT_USE_SSL                    = CURLOPTTYPE_LONG + 119
    integer(kind=c_int), parameter, public :: CURLOPT_POSTFIELDSIZE_LARGE        = CURLOPTTYPE_OFF_T + 120
    integer(kind=c_int), parameter, public :: CURLOPT_TCP_NODELAY                = CURLOPTTYPE_LONG + 121
    integer(kind=c_int), parameter, public :: CURLOPT_FTPSSLAUTH                 = CURLOPTTYPE_LONG + 129
    integer(kind=c_int), parameter, public :: CURLOPT_IOCTLFUNCTION              = CURLOPTTYPE_FUNCTIONPOINT + 130
    integer(kind=c_int), parameter, public :: CURLOPT_IOCTLDATA                  = CURLOPTTYPE_OBJECTPOINT + 131
    integer(kind=c_int), parameter, public :: CURLOPT_FTP_ACCOUNT                = CURLOPTTYPE_OBJECTPOINT + 134
    integer(kind=c_int), parameter, public :: CURLOPT_COOKIELIST                 = CURLOPTTYPE_OBJECTPOINT + 135
    integer(kind=c_int), parameter, public :: CURLOPT_IGNORE_CONTENT_LENGTH      = CURLOPTTYPE_LONG + 136
    integer(kind=c_int), parameter, public :: CURLOPT_FTP_SKIP_PASV_IP           = CURLOPTTYPE_LONG + 137
    integer(kind=c_int), parameter, public :: CURLOPT_FTP_FILEMETHOD             = CURLOPTTYPE_LONG + 138
    integer(kind=c_int), parameter, public :: CURLOPT_LOCALPORT                  = CURLOPTTYPE_LONG + 139
    integer(kind=c_int), parameter, public :: CURLOPT_LOCALPORTRANGE             = CURLOPTTYPE_LONG + 140
    integer(kind=c_int), parameter, public :: CURLOPT_CONNECT_ONLY               = CURLOPTTYPE_LONG + 141
    integer(kind=c_int), parameter, public :: CURLOPT_CONV_FROM_NETWORK_FUNCTION = CURLOPTTYPE_FUNCTIONPOINT + 142
    integer(kind=c_int), parameter, public :: CURLOPT_CONV_TO_NETWORK_FUNCTION   = CURLOPTTYPE_FUNCTIONPOINT + 143
    integer(kind=c_int), parameter, public :: CURLOPT_CONV_FROM_UTF8_FUNCTION    = CURLOPTTYPE_FUNCTIONPOINT + 144
    integer(kind=c_int), parameter, public :: CURLOPT_MAX_SEND_SPEED_LARGE       = CURLOPTTYPE_OFF_T + 145
    integer(kind=c_int), parameter, public :: CURLOPT_MAX_RECV_SPEED_LARGE       = CURLOPTTYPE_OFF_T + 146
    integer(kind=c_int), parameter, public :: CURLOPT_FTP_ALTERNATIVE_TO_USER    = CURLOPTTYPE_OBJECTPOINT + 147
    integer(kind=c_int), parameter, public :: CURLOPT_SOCKOPTFUNCTION            = CURLOPTTYPE_FUNCTIONPOINT + 148
    integer(kind=c_int), parameter, public :: CURLOPT_SOCKOPTDATA                = CURLOPTTYPE_OBJECTPOINT + 149
    integer(kind=c_int), parameter, public :: CURLOPT_SSL_SESSIONID_CACHE        = CURLOPTTYPE_LONG + 150
    integer(kind=c_int), parameter, public :: CURLOPT_SSH_AUTH_TYPES             = CURLOPTTYPE_LONG + 151
    integer(kind=c_int), parameter, public :: CURLOPT_SSH_PUBLIC_KEYFILE         = CURLOPTTYPE_OBJECTPOINT + 152
    integer(kind=c_int), parameter, public :: CURLOPT_SSH_PRIVATE_KEYFILE        = CURLOPTTYPE_OBJECTPOINT + 153
    integer(kind=c_int), parameter, public :: CURLOPT_FTP_SSL_CCC                = CURLOPTTYPE_LONG + 154
    integer(kind=c_int), parameter, public :: CURLOPT_TIMEOUT_MS                 = CURLOPTTYPE_LONG + 155
    integer(kind=c_int), parameter, public :: CURLOPT_CONNECTTIMEOUT_MS          = CURLOPTTYPE_LONG + 156
    integer(kind=c_int), parameter, public :: CURLOPT_HTTP_TRANSFER_DECODING     = CURLOPTTYPE_LONG + 157
    integer(kind=c_int), parameter, public :: CURLOPT_HTTP_CONTENT_DECODING      = CURLOPTTYPE_LONG + 158
    integer(kind=c_int), parameter, public :: CURLOPT_NEW_FILE_PERMS             = CURLOPTTYPE_LONG + 159
    integer(kind=c_int), parameter, public :: CURLOPT_NEW_DIRECTORY_PERMS        = CURLOPTTYPE_LONG + 160
    integer(kind=c_int), parameter, public :: CURLOPT_POSTREDIR                  = CURLOPTTYPE_LONG + 161
    integer(kind=c_int), parameter, public :: CURLOPT_SSH_HOST_PUBLIC_KEY_MD5    = CURLOPTTYPE_OBJECTPOINT + 162
    integer(kind=c_int), parameter, public :: CURLOPT_OPENSOCKETFUNCTION         = CURLOPTTYPE_FUNCTIONPOINT + 163
    integer(kind=c_int), parameter, public :: CURLOPT_OPENSOCKETDATA             = CURLOPTTYPE_OBJECTPOINT + 164
    integer(kind=c_int), parameter, public :: CURLOPT_COPYPOSTFIELDS             = CURLOPTTYPE_OBJECTPOINT + 165
    integer(kind=c_int), parameter, public :: CURLOPT_PROXY_TRANSFER_MODE        = CURLOPTTYPE_LONG + 166
    integer(kind=c_int), parameter, public :: CURLOPT_SEEKFUNCTION               = CURLOPTTYPE_FUNCTIONPOINT + 167
    integer(kind=c_int), parameter, public :: CURLOPT_SEEKDATA                   = CURLOPTTYPE_OBJECTPOINT + 168
    integer(kind=c_int), parameter, public :: CURLOPT_CRLFILE                    = CURLOPTTYPE_OBJECTPOINT + 169
    integer(kind=c_int), parameter, public :: CURLOPT_ISSUERCERT                 = CURLOPTTYPE_OBJECTPOINT + 170
    integer(kind=c_int), parameter, public :: CURLOPT_ADDRESS_SCOPE              = CURLOPTTYPE_LONG + 171
    integer(kind=c_int), parameter, public :: CURLOPT_CERTINFO                   = CURLOPTTYPE_LONG + 172
    integer(kind=c_int), parameter, public :: CURLOPT_USERNAME                   = CURLOPTTYPE_OBJECTPOINT + 173
    integer(kind=c_int), parameter, public :: CURLOPT_PASSWORD                   = CURLOPTTYPE_OBJECTPOINT + 174
    integer(kind=c_int), parameter, public :: CURLOPT_PROXYUSERNAME              = CURLOPTTYPE_OBJECTPOINT + 175
    integer(kind=c_int), parameter, public :: CURLOPT_PROXYPASSWORD              = CURLOPTTYPE_OBJECTPOINT + 176
    integer(kind=c_int), parameter, public :: CURLOPT_NOPROXY                    = CURLOPTTYPE_OBJECTPOINT + 177
    integer(kind=c_int), parameter, public :: CURLOPT_TFTP_BLKSIZE               = CURLOPTTYPE_LONG + 178
    integer(kind=c_int), parameter, public :: CURLOPT_SOCKS5_GSSAPI_SERVICE      = CURLOPTTYPE_OBJECTPOINT + 179
    integer(kind=c_int), parameter, public :: CURLOPT_SOCKS5_GSSAPI_NEC          = CURLOPTTYPE_LONG + 180
    integer(kind=c_int), parameter, public :: CURLOPT_PROTOCOLS                  = CURLOPTTYPE_LONG + 181
    integer(kind=c_int), parameter, public :: CURLOPT_REDIR_PROTOCOLS            = CURLOPTTYPE_LONG + 182
    integer(kind=c_int), parameter, public :: CURLOPT_SSH_KNOWNHOSTS             = CURLOPTTYPE_OBJECTPOINT + 183
    integer(kind=c_int), parameter, public :: CURLOPT_SSH_KEYFUNCTION            = CURLOPTTYPE_FUNCTIONPOINT + 184
    integer(kind=c_int), parameter, public :: CURLOPT_SSH_KEYDATA                = CURLOPTTYPE_OBJECTPOINT + 185
    integer(kind=c_int), parameter, public :: CURLOPT_MAIL_FROM                  = CURLOPTTYPE_OBJECTPOINT + 186
    integer(kind=c_int), parameter, public :: CURLOPT_MAIL_RCPT                  = CURLOPTTYPE_OBJECTPOINT + 187
    integer(kind=c_int), parameter, public :: CURLOPT_FTP_USE_PRET               = CURLOPTTYPE_LONG + 188
    integer(kind=c_int), parameter, public :: CURLOPT_RTSP_REQUEST               = CURLOPTTYPE_LONG + 189
    integer(kind=c_int), parameter, public :: CURLOPT_RTSP_SESSION_ID            = CURLOPTTYPE_OBJECTPOINT + 190
    integer(kind=c_int), parameter, public :: CURLOPT_RTSP_STREAM_URI            = CURLOPTTYPE_OBJECTPOINT + 191
    integer(kind=c_int), parameter, public :: CURLOPT_RTSP_TRANSPORT             = CURLOPTTYPE_OBJECTPOINT + 192
    integer(kind=c_int), parameter, public :: CURLOPT_RTSP_CLIENT_CSEQ           = CURLOPTTYPE_LONG + 193
    integer(kind=c_int), parameter, public :: CURLOPT_RTSP_SERVER_CSEQ           = CURLOPTTYPE_LONG + 194
    integer(kind=c_int), parameter, public :: CURLOPT_INTERLEAVEDATA             = CURLOPTTYPE_OBJECTPOINT + 195
    integer(kind=c_int), parameter, public :: CURLOPT_INTERLEAVEFUNCTION         = CURLOPTTYPE_FUNCTIONPOINT + 196
    integer(kind=c_int), parameter, public :: CURLOPT_WILDCARDMATCH              = CURLOPTTYPE_LONG + 197
    integer(kind=c_int), parameter, public :: CURLOPT_CHUNK_BGN_FUNCTION         = CURLOPTTYPE_FUNCTIONPOINT + 198
    integer(kind=c_int), parameter, public :: CURLOPT_CHUNK_END_FUNCTION         = CURLOPTTYPE_FUNCTIONPOINT + 199
    integer(kind=c_int), parameter, public :: CURLOPT_FNMATCH_FUNCTION           = CURLOPTTYPE_FUNCTIONPOINT + 200
    integer(kind=c_int), parameter, public :: CURLOPT_CHUNK_DATA                 = CURLOPTTYPE_OBJECTPOINT + 201
    integer(kind=c_int), parameter, public :: CURLOPT_FNMATCH_DATA               = CURLOPTTYPE_OBJECTPOINT + 202
    integer(kind=c_int), parameter, public :: CURLOPT_RESOLVE                    = CURLOPTTYPE_OBJECTPOINT + 203
    integer(kind=c_int), parameter, public :: CURLOPT_TLSAUTH_USERNAME           = CURLOPTTYPE_OBJECTPOINT + 204
    integer(kind=c_int), parameter, public :: CURLOPT_TLSAUTH_PASSWORD           = CURLOPTTYPE_OBJECTPOINT + 205
    integer(kind=c_int), parameter, public :: CURLOPT_TLSAUTH_TYPE               = CURLOPTTYPE_OBJECTPOINT + 206
    integer(kind=c_int), parameter, public :: CURLOPT_TRANSFER_ENCODING          = CURLOPTTYPE_LONG + 207
    integer(kind=c_int), parameter, public :: CURLOPT_CLOSESOCKETFUNCTION        = CURLOPTTYPE_FUNCTIONPOINT + 208
    integer(kind=c_int), parameter, public :: CURLOPT_CLOSESOCKETDATA            = CURLOPTTYPE_OBJECTPOINT + 209
    integer(kind=c_int), parameter, public :: CURLOPT_GSSAPI_DELEGATION          = CURLOPTTYPE_LONG + 210
    integer(kind=c_int), parameter, public :: CURLOPT_DNS_SERVERS                = CURLOPTTYPE_OBJECTPOINT + 211
    integer(kind=c_int), parameter, public :: CURLOPT_ACCEPTTIMEOUT_MS           = CURLOPTTYPE_LONG + 212
    integer(kind=c_int), parameter, public :: CURLOPT_TCP_KEEPALIVE              = CURLOPTTYPE_LONG + 213
    integer(kind=c_int), parameter, public :: CURLOPT_TCP_KEEPIDLE               = CURLOPTTYPE_LONG + 214
    integer(kind=c_int), parameter, public :: CURLOPT_TCP_KEEPINTVL              = CURLOPTTYPE_LONG + 215
    integer(kind=c_int), parameter, public :: CURLOPT_SSL_OPTIONS                = CURLOPTTYPE_LONG + 216
    integer(kind=c_int), parameter, public :: CURLOPT_MAIL_AUTH                  = CURLOPTTYPE_OBJECTPOINT + 217
    integer(kind=c_int), parameter, public :: CURLOPT_SASL_IR                    = CURLOPTTYPE_LONG + 218
    integer(kind=c_int), parameter, public :: CURLOPT_XFERINFOFUNCTION           = CURLOPTTYPE_FUNCTIONPOINT + 219
    integer(kind=c_int), parameter, public :: CURLOPT_XOAUTH2_BEARER             = CURLOPTTYPE_OBJECTPOINT + 220
    integer(kind=c_int), parameter, public :: CURLOPT_DNS_INTERFACE              = CURLOPTTYPE_OBJECTPOINT + 221
    integer(kind=c_int), parameter, public :: CURLOPT_DNS_LOCAL_IP4              = CURLOPTTYPE_OBJECTPOINT + 222
    integer(kind=c_int), parameter, public :: CURLOPT_DNS_LOCAL_IP6              = CURLOPTTYPE_OBJECTPOINT + 223
    integer(kind=c_int), parameter, public :: CURLOPT_LOGIN_OPTIONS              = CURLOPTTYPE_OBJECTPOINT + 224
    integer(kind=c_int), parameter, public :: CURLOPT_SSL_ENABLE_NPN             = CURLOPTTYPE_LONG + 225
    integer(kind=c_int), parameter, public :: CURLOPT_SSL_ENABLE_ALPN            = CURLOPTTYPE_LONG + 226
    integer(kind=c_int), parameter, public :: CURLOPT_EXPECT_100_TIMEOUT_MS      = CURLOPTTYPE_LONG + 227
    integer(kind=c_int), parameter, public :: CURLOPT_PROXYHEADER                = CURLOPTTYPE_OBJECTPOINT + 228
    integer(kind=c_int), parameter, public :: CURLOPT_HEADEROPT                  = CURLOPTTYPE_LONG + 229
    integer(kind=c_int), parameter, public :: CURLOPT_PINNEDPUBLICKEY            = CURLOPTTYPE_OBJECTPOINT + 230
    integer(kind=c_int), parameter, public :: CURLOPT_UNIX_SOCKET_PATH           = CURLOPTTYPE_OBJECTPOINT + 231
    integer(kind=c_int), parameter, public :: CURLOPT_DEFAULT_PROTOCOL           = CURLOPTTYPE_STRINGPOINT + 238
    integer(kind=c_int), parameter, public :: CURLOPT_STREAM_WEIGHT              = CURLOPTTYPE_LONG + 239
    integer(kind=c_int), parameter, public :: CURLOPT_STREAM_DEPENDS             = CURLOPTTYPE_OBJECTPOINT + 240
    integer(kind=c_int), parameter, public :: CURLOPT_STREAM_DEPENDS_E           = CURLOPTTYPE_OBJECTPOINT + 241
    integer(kind=c_int), parameter, public :: CURLOPT_TFTP_NO_OPTIONS            = CURLOPTTYPE_LONG + 242
    integer(kind=c_int), parameter, public :: CURLOPT_CONNECT_TO                 = CURLOPTTYPE_SLISTPOINT + 243
    integer(kind=c_int), parameter, public :: CURLOPT_TCP_FASTOPEN               = CURLOPTTYPE_LONG + 244
    integer(kind=c_int), parameter, public :: CURLOPT_KEEP_SENDING_ON_ERROR      = CURLOPTTYPE_LONG + 245
    integer(kind=c_int), parameter, public :: CURLOPT_PROXY_CAINFO               = CURLOPTTYPE_STRINGPOINT + 246
    integer(kind=c_int), parameter, public :: CURLOPT_PROXY_CAPATH               = CURLOPTTYPE_STRINGPOINT + 247
    integer(kind=c_int), parameter, public :: CURLOPT_PROXY_SSL_VERIFYPEER       = CURLOPTTYPE_LONG + 248
    integer(kind=c_int), parameter, public :: CURLOPT_PROXY_SSL_VERIFYHOST       = CURLOPTTYPE_LONG + 249
    integer(kind=c_int), parameter, public :: CURLOPT_PROXY_SSLVERSION           = CURLOPTTYPE_VALUES + 250
    integer(kind=c_int), parameter, public :: CURLOPT_PROXY_TLSAUTH_USERNAME     = CURLOPTTYPE_STRINGPOINT + 251
    integer(kind=c_int), parameter, public :: CURLOPT_PROXY_TLSAUTH_PASSWORD     = CURLOPTTYPE_STRINGPOINT + 252
    integer(kind=c_int), parameter, public :: CURLOPT_PROXY_TLSAUTH_TYPE         = CURLOPTTYPE_STRINGPOINT + 253
    integer(kind=c_int), parameter, public :: CURLOPT_PROXY_SSLCERT              = CURLOPTTYPE_STRINGPOINT + 254
    integer(kind=c_int), parameter, public :: CURLOPT_PROXY_SSLCERTTYPE          = CURLOPTTYPE_STRINGPOINT + 255
    integer(kind=c_int), parameter, public :: CURLOPT_PROXY_SSLKEY               = CURLOPTTYPE_STRINGPOINT + 256
    integer(kind=c_int), parameter, public :: CURLOPT_PROXY_SSLKEYTYPE           = CURLOPTTYPE_STRINGPOINT + 257
    integer(kind=c_int), parameter, public :: CURLOPT_PROXY_KEYPASSWD            = CURLOPTTYPE_STRINGPOINT + 258
    integer(kind=c_int), parameter, public :: CURLOPT_PROXY_SSL_CIPHER_LIST      = CURLOPTTYPE_STRINGPOINT + 259
    integer(kind=c_int), parameter, public :: CURLOPT_PROXY_CRLFILE              = CURLOPTTYPE_STRINGPOINT + 260
    integer(kind=c_int), parameter, public :: CURLOPT_PROXY_SSL_OPTIONS          = CURLOPTTYPE_LONG + 261
    integer(kind=c_int), parameter, public :: CURLOPT_PRE_PROXY                  = CURLOPTTYPE_STRINGPOINT + 262
    integer(kind=c_int), parameter, public :: CURLOPT_PROXY_PINNEDPUBLICKEY      = CURLOPTTYPE_STRINGPOINT + 263
    integer(kind=c_int), parameter, public :: CURLOPT_ABSTRACT_UNIX_SOCKET       = CURLOPTTYPE_STRINGPOINT + 264
    integer(kind=c_int), parameter, public :: CURLOPT_SUPPRESS_CONNECT_HEADERS   = CURLOPTTYPE_LONG + 265
    integer(kind=c_int), parameter, public :: CURLOPT_REQUEST_TARGET             = CURLOPTTYPE_STRINGPOINT + 266
    integer(kind=c_int), parameter, public :: CURLOPT_SOCKS5_AUTH                = CURLOPTTYPE_LONG + 267
    integer(kind=c_int), parameter, public :: CURLOPT_SSH_COMPRESSION            = CURLOPTTYPE_LONG + 268
    integer(kind=c_int), parameter, public :: CURLOPT_MIMEPOST                   = CURLOPTTYPE_OBJECTPOINT + 269
    integer(kind=c_int), parameter, public :: CURLOPT_TIMEVALUE_LARGE            = CURLOPTTYPE_OFF_T + 270
    integer(kind=c_int), parameter, public :: CURLOPT_HAPPY_EYEBALLS_TIMEOUT_MS  = CURLOPTTYPE_LONG + 271
    integer(kind=c_int), parameter, public :: CURLOPT_RESOLVER_START_FUNCTION    = CURLOPTTYPE_FUNCTIONPOINT + 272
    integer(kind=c_int), parameter, public :: CURLOPT_RESOLVER_START_DATA        = CURLOPTTYPE_CBPOINT + 273
    integer(kind=c_int), parameter, public :: CURLOPT_HAPROXYPROTOCOL            = CURLOPTTYPE_LONG + 274
    integer(kind=c_int), parameter, public :: CURLOPT_DNS_SHUFFLE_ADDRESSES      = CURLOPTTYPE_LONG + 275
    integer(kind=c_int), parameter, public :: CURLOPT_TLS13_CIPHERS              = CURLOPTTYPE_STRINGPOINT + 276
    integer(kind=c_int), parameter, public :: CURLOPT_PROXY_TLS13_CIPHERS        = CURLOPTTYPE_STRINGPOINT + 277
    integer(kind=c_int), parameter, public :: CURLOPT_DISALLOW_USERNAME_IN_URL   = CURLOPTTYPE_LONG + 278
    integer(kind=c_int), parameter, public :: CURLOPT_DOH_URL                    = CURLOPTTYPE_STRINGPOINT + 279
    integer(kind=c_int), parameter, public :: CURLOPT_UPLOAD_BUFFERSIZE          = CURLOPTTYPE_LONG + 280
    integer(kind=c_int), parameter, public :: CURLOPT_UPKEEP_INTERVAL_MS         = CURLOPTTYPE_LONG + 281
    integer(kind=c_int), parameter, public :: CURLOPT_CURLU                      = CURLOPTTYPE_OBJECTPOINT + 282
    integer(kind=c_int), parameter, public :: CURLOPT_TRAILERFUNCTION            = CURLOPTTYPE_FUNCTIONPOINT + 283
    integer(kind=c_int), parameter, public :: CURLOPT_TRAILERDATA                = CURLOPTTYPE_CBPOINT + 284
    integer(kind=c_int), parameter, public :: CURLOPT_HTTP09_ALLOWED             = CURLOPTTYPE_LONG + 285
    integer(kind=c_int), parameter, public :: CURLOPT_ALTSVC_CTRL                = CURLOPTTYPE_LONG + 286
    integer(kind=c_int), parameter, public :: CURLOPT_ALTSVC                     = CURLOPTTYPE_STRINGPOINT + 287
    integer(kind=c_int), parameter, public :: CURLOPT_MAXAGE_CONN                = CURLOPTTYPE_LONG + 288
    integer(kind=c_int), parameter, public :: CURLOPT_SASL_AUTHZID               = CURLOPTTYPE_STRINGPOINT + 289
    integer(kind=c_int), parameter, public :: CURLOPT_MAIL_RCPT_ALLLOWFAILS      = CURLOPTTYPE_LONG + 290
    integer(kind=c_int), parameter, public :: CURLOPT_SSLCERT_BLOB               = CURLOPTTYPE_BLOB + 291
    integer(kind=c_int), parameter, public :: CURLOPT_SSLKEY_BLOB                = CURLOPTTYPE_BLOB + 292
    integer(kind=c_int), parameter, public :: CURLOPT_PROXY_SSLCERT_BLOB         = CURLOPTTYPE_BLOB + 293
    integer(kind=c_int), parameter, public :: CURLOPT_PROXY_SSLKEY_BLOB          = CURLOPTTYPE_BLOB + 294
    integer(kind=c_int), parameter, public :: CURLOPT_ISSUERCERT_BLOB            = CURLOPTTYPE_BLOB + 295
    integer(kind=c_int), parameter, public :: CURLOPT_PROXY_ISSUERCERT           = CURLOPTTYPE_STRINGPOINT + 296
    integer(kind=c_int), parameter, public :: CURLOPT_PROXY_ISSUERCERT_BLOB      = CURLOPTTYPE_BLOB + 297
    integer(kind=c_int), parameter, public :: CURLOPT_SSL_EC_CURVES              = CURLOPTTYPE_STRINGPOINT + 298
    integer(kind=c_int), parameter, public :: CURLOPT_HSTS_CTRL                  = CURLOPTTYPE_LONG + 299
    integer(kind=c_int), parameter, public :: CURLOPT_HSTS                       = CURLOPTTYPE_STRINGPOINT + 300
    integer(kind=c_int), parameter, public :: CURLOPT_HSTSREADFUNCTION           = CURLOPTTYPE_FUNCTIONPOINT + 301
    integer(kind=c_int), parameter, public :: CURLOPT_HSTSREADDATA               = CURLOPTTYPE_CBPOINT + 302
    integer(kind=c_int), parameter, public :: CURLOPT_HSTSWRITEFUNCTION          = CURLOPTTYPE_FUNCTIONPOINT + 303
    integer(kind=c_int), parameter, public :: CURLOPT_HSTSWRITEDATA              = CURLOPTTYPE_CBPOINT + 304
    integer(kind=c_int), parameter, public :: CURLOPT_AWS_SIGV4                  = CURLOPTTYPE_STRINGPOINT + 305
    integer(kind=c_int), parameter, public :: CURLOPT_DOH_SSL_VERIFYPEER         = CURLOPTTYPE_LONG + 306
    integer(kind=c_int), parameter, public :: CURLOPT_DOH_SSL_VERIFYHOST         = CURLOPTTYPE_LONG + 307
    integer(kind=c_int), parameter, public :: CURLOPT_DOH_SSL_VERIFYSTATUS       = CURLOPTTYPE_LONG + 308
    integer(kind=c_int), parameter, public :: CURLOPT_CAINFO_BLOB                = CURLOPTTYPE_BLOB + 309
    integer(kind=c_int), parameter, public :: CURLOPT_PROXY_CAINFO_BLOB          = CURLOPTTYPE_BLOB + 310
    integer(kind=c_int), parameter, public :: CURLOPT_SSH_HOST_PUBLIC_KEY_SHA256 = CURLOPTTYPE_STRINGPOINT + 311
    integer(kind=c_int), parameter, public :: CURLOPT_PREREQFUNCTION             = CURLOPTTYPE_FUNCTIONPOINT + 312
    integer(kind=c_int), parameter, public :: CURLOPT_PREREQDATA                 = CURLOPTTYPE_CBPOINT + 313
    integer(kind=c_int), parameter, public :: CURLOPT_MAXLIFETIME_CONN           = CURLOPTTYPE_LONG + 314
    integer(kind=c_int), parameter, public :: CURLOPT_MIME_OPTIONS               = CURLOPTTYPE_LONG + 315
    integer(kind=c_int), parameter, public :: CURLOPT_SSH_HOSTKEYFUNCTION        = CURLOPTTYPE_FUNCTIONPOINT + 316
    integer(kind=c_int), parameter, public :: CURLOPT_SSH_HOSTKEYDATA            = CURLOPTTYPE_CBPOINT + 317
    integer(kind=c_int), parameter, public :: CURLOPT_PROTOCOLS_STR              = CURLOPTTYPE_STRINGPOINT + 318
    integer(kind=c_int), parameter, public :: CURLOPT_REDIR_PROTOCOLS_STR        = CURLOPTTYPE_STRINGPOINT + 319
    integer(kind=c_int), parameter, public :: CURLOPT_WS_OPTIONS                 = CURLOPTTYPE_LONG + 320
    integer(kind=c_int), parameter, public :: CURLOPT_CA_CACHE_TIMEOUT           = CURLOPTTYPE_LONG + 321
    integer(kind=c_int), parameter, public :: CURLOPT_QUICK_EXIT                 = CURLOPTTYPE_LONG + 322
    integer(kind=c_int), parameter, public :: CURLOPT_HAPROXY_CLIENT_IP          = CURLOPTTYPE_STRINGPOINT + 323
    integer(kind=c_int), parameter, public :: CURLOPT_SERVER_RESPONSE_TIMEOUT_MS = CURLOPTTYPE_LONG + 324

    integer(kind=c_int), parameter, public :: CURL_IPRESOLVE_WHATEVER = 0
    integer(kind=c_int), parameter, public :: CURL_IPRESOLVE_V4       = 1
    integer(kind=c_int), parameter, public :: CURL_IPRESOLVE_V6       = 2

    integer(kind=c_int), parameter, public :: CURL_GLOBAL_SSL       = shiftl(1, 0)
    integer(kind=c_int), parameter, public :: CURL_GLOBAL_WIN32     = shiftl(1, 1)
    integer(kind=c_int), parameter, public :: CURL_GLOBAL_ALL       = ior(CURL_GLOBAL_SSL, CURL_GLOBAL_WIN32)
    integer(kind=c_int), parameter, public :: CURL_GLOBAL_NOTHING   = 0
    integer(kind=c_int), parameter, public :: CURL_GLOBAL_DEFAULT   = CURL_GLOBAL_ALL
    integer(kind=c_int), parameter, public :: CURL_GLOBAL_ACK_EINTR = shiftl(1, 2)

    integer(kind=c_long), parameter, public :: CURLAUTH_NONE         = 0
    integer(kind=c_long), parameter, public :: CURLAUTH_BASIC        = shiftl(1, 0)
    integer(kind=c_long), parameter, public :: CURLAUTH_DIGEST       = shiftl(1, 1)
    integer(kind=c_long), parameter, public :: CURLAUTH_NEGOTIATE    = shiftl(1, 2)
    integer(kind=c_long), parameter, public :: CURLAUTH_GSSNEGOTIATE = CURLAUTH_NEGOTIATE
    integer(kind=c_long), parameter, public :: CURLAUTH_GSSAPI       = CURLAUTH_NEGOTIATE
    integer(kind=c_long), parameter, public :: CURLAUTH_NTLM         = shiftl(1, 3)
    integer(kind=c_long), parameter, public :: CURLAUTH_DIGEST_IE    = shiftl(1, 4)
    integer(kind=c_long), parameter, public :: CURLAUTH_NTLM_WB      = shiftl(1, 5)
    integer(kind=c_long), parameter, public :: CURLAUTH_BEARER       = shiftl(1, 6)
    integer(kind=c_long), parameter, public :: CURLAUTH_AWS_SIGV4    = shiftl(1, 7)
    integer(kind=c_long), parameter, public :: CURLAUTH_ONLY         = shiftl(1, 31)
    integer(kind=c_long), parameter, public :: CURLAUTH_ANY          = not(CURLAUTH_DIGEST_IE)
    integer(kind=c_long), parameter, public :: CURLAUTH_ANYSAFE      = not(ior(CURLAUTH_BASIC, CURLAUTH_DIGEST_IE))

    integer(kind=c_int), parameter, public :: CURLSSH_AUTH_ANY       = not(0)
    integer(kind=c_int), parameter, public :: CURLSSH_AUTH_NONE      = 0
    integer(kind=c_int), parameter, public :: CURLSSH_AUTH_PUBLICKEY = shiftl(1, 0)
    integer(kind=c_int), parameter, public :: CURLSSH_AUTH_PASSWORD  = shiftl(1, 1)
    integer(kind=c_int), parameter, public :: CURLSSH_AUTH_HOST      = shiftl(1, 2)
    integer(kind=c_int), parameter, public :: CURLSSH_AUTH_KEYBOARD  = shiftl(1, 3)
    integer(kind=c_int), parameter, public :: CURLSSH_AUTH_AGENT     = shiftl(1, 4)
    integer(kind=c_int), parameter, public :: CURLSSH_AUTH_GSSAPI    = shiftl(1, 5)
    integer(kind=c_int), parameter, public :: CURLSSH_AUTH_DEFAULT   = CURLSSH_AUTH_ANY

    integer(kind=c_int), parameter, public :: CURL_SSLVERSION_DEFAULT = 0
    integer(kind=c_int), parameter, public :: CURL_SSLVERSION_TLSv1   = 1
    integer(kind=c_int), parameter, public :: CURL_SSLVERSION_SSLv2   = 2
    integer(kind=c_int), parameter, public :: CURL_SSLVERSION_SSLv3   = 3
    integer(kind=c_int), parameter, public :: CURL_SSLVERSION_TLSv1_0 = 4
    integer(kind=c_int), parameter, public :: CURL_SSLVERSION_TLSv1_1 = 5
    integer(kind=c_int), parameter, public :: CURL_SSLVERSION_TLSv1_2 = 6
    integer(kind=c_int), parameter, public :: CURL_SSLVERSION_TLSv1_3 = 7
    integer(kind=c_int), parameter, public :: CURL_SSLVERSION_LAST    = 8

    integer(kind=c_int), parameter, public :: CURLGSSAPI_DELEGATION_NONE        = 0
    integer(kind=c_int), parameter, public :: CURLGSSAPI_DELEGATION_POLICY_FLAG = shiftl(1, 0)
    integer(kind=c_int), parameter, public :: CURLGSSAPI_DELEGATION_FLAG        = shiftl(1, 1)

    integer(kind=c_int), parameter, public :: CURL_ERROR_SIZE = 256

    ! curl_usessl
    integer(kind=c_int), parameter, public :: CURLUSESSL_NONE    = 0
    integer(kind=c_int), parameter, public :: CURLUSESSL_TRY     = 1
    integer(kind=c_int), parameter, public :: CURLUSESSL_CONTROL = 2
    integer(kind=c_int), parameter, public :: CURLUSESSL_ALL     = 3
    integer(kind=c_int), parameter, public :: CURLUSESSL_LAST    = 4

    ! CURLcode
    integer(kind=c_int), parameter, public :: CURLE_OK                       = 0
    integer(kind=c_int), parameter, public :: CURLE_UNSUPPORTED_PROTOCOL     = 1
    integer(kind=c_int), parameter, public :: CURLE_FAILED_INIT              = 2
    integer(kind=c_int), parameter, public :: CURLE_URL_MALFORMAT            = 3
    integer(kind=c_int), parameter, public :: CURLE_NOT_BUILT_IN             = 4
    integer(kind=c_int), parameter, public :: CURLE_COULDNT_RESOLVE_PROXY    = 5
    integer(kind=c_int), parameter, public :: CURLE_COULDNT_RESOLVE_HOST     = 6
    integer(kind=c_int), parameter, public :: CURLE_COULDNT_CONNECT          = 7
    integer(kind=c_int), parameter, public :: CURLE_WEIRD_SERVER_REPLY       = 8
    integer(kind=c_int), parameter, public :: CURLE_REMOTE_ACCESS_DENIED     = 9
    integer(kind=c_int), parameter, public :: CURLE_FTP_ACCEPT_FAILED        = 10
    integer(kind=c_int), parameter, public :: CURLE_FTP_WEIRD_PASS_REPLY     = 11
    integer(kind=c_int), parameter, public :: CURLE_FTP_ACCEPT_TIMEOUT       = 12
    integer(kind=c_int), parameter, public :: CURLE_FTP_WEIRD_PASV_REPLY     = 13
    integer(kind=c_int), parameter, public :: CURLE_FTP_WEIRD_227_FORMAT     = 14
    integer(kind=c_int), parameter, public :: CURLE_FTP_CANT_GET_HOST        = 15
    integer(kind=c_int), parameter, public :: CURLE_HTTP2                    = 16
    integer(kind=c_int), parameter, public :: CURLE_FTP_COULDNT_SET_TYPE     = 17
    integer(kind=c_int), parameter, public :: CURLE_PARTIAL_FILE             = 18
    integer(kind=c_int), parameter, public :: CURLE_FTP_COULDNT_RETR_FILE    = 19
    integer(kind=c_int), parameter, public :: CURLE_OBSOLETE20               = 20
    integer(kind=c_int), parameter, public :: CURLE_QUOTE_ERROR              = 21
    integer(kind=c_int), parameter, public :: CURLE_HTTP_RETURNED_ERROR      = 22
    integer(kind=c_int), parameter, public :: CURLE_WRITE_ERROR              = 23
    integer(kind=c_int), parameter, public :: CURLE_OBSOLETE24               = 24
    integer(kind=c_int), parameter, public :: CURLE_UPLOAD_FAILED            = 25
    integer(kind=c_int), parameter, public :: CURLE_READ_ERROR               = 26
    integer(kind=c_int), parameter, public :: CURLE_OUT_OF_MEMORY            = 27
    integer(kind=c_int), parameter, public :: CURLE_OPERATION_TIMEDOUT       = 28
    integer(kind=c_int), parameter, public :: CURLE_OBSOLETE29               = 29
    integer(kind=c_int), parameter, public :: CURLE_FTP_PORT_FAILED          = 30
    integer(kind=c_int), parameter, public :: CURLE_FTP_COULDNT_USE_REST     = 31
    integer(kind=c_int), parameter, public :: CURLE_OBSOLETE32               = 32
    integer(kind=c_int), parameter, public :: CURLE_RANGE_ERROR              = 33
    integer(kind=c_int), parameter, public :: CURLE_HTTP_POST_ERROR          = 34
    integer(kind=c_int), parameter, public :: CURLE_SSL_CONNECT_ERROR        = 35
    integer(kind=c_int), parameter, public :: CURLE_BAD_DOWNLOAD_RESUME      = 36
    integer(kind=c_int), parameter, public :: CURLE_FILE_COULDNT_READ_FILE   = 37
    integer(kind=c_int), parameter, public :: CURLE_LDAP_CANNOT_BIND         = 38
    integer(kind=c_int), parameter, public :: CURLE_LDAP_SEARCH_FAILED       = 39
    integer(kind=c_int), parameter, public :: CURLE_OBSOLETE40               = 40
    integer(kind=c_int), parameter, public :: CURLE_FUNCTION_NOT_FOUND       = 41
    integer(kind=c_int), parameter, public :: CURLE_ABORTED_BY_CALLBACK      = 42
    integer(kind=c_int), parameter, public :: CURLE_BAD_FUNCTION_ARGUMENT    = 43
    integer(kind=c_int), parameter, public :: CURLE_OBSOLETE44               = 44
    integer(kind=c_int), parameter, public :: CURLE_INTERFACE_FAILED         = 45
    integer(kind=c_int), parameter, public :: CURLE_OBSOLETE46               = 46
    integer(kind=c_int), parameter, public :: CURLE_TOO_MANY_REDIRECTS       = 47
    integer(kind=c_int), parameter, public :: CURLE_UNKNOWN_OPTION           = 48
    integer(kind=c_int), parameter, public :: CURLE_TELNET_OPTION_SYNTAX     = 49
    integer(kind=c_int), parameter, public :: CURLE_OBSOLETE50               = 50
    integer(kind=c_int), parameter, public :: CURLE_PEER_FAILED_VERIFICATION = 51
    integer(kind=c_int), parameter, public :: CURLE_GOT_NOTHING              = 52
    integer(kind=c_int), parameter, public :: CURLE_SSL_ENGINE_NOTFOUND      = 53
    integer(kind=c_int), parameter, public :: CURLE_SSL_ENGINE_SETFAILED     = 54
    integer(kind=c_int), parameter, public :: CURLE_SEND_ERROR               = 55
    integer(kind=c_int), parameter, public :: CURLE_RECV_ERROR               = 56
    integer(kind=c_int), parameter, public :: CURLE_OBSOLETE57               = 57
    integer(kind=c_int), parameter, public :: CURLE_SSL_CERTPROBLEM          = 58
    integer(kind=c_int), parameter, public :: CURLE_SSL_CIPHER               = 59
    integer(kind=c_int), parameter, public :: CURLE_SSL_CACERT               = 60
    integer(kind=c_int), parameter, public :: CURLE_BAD_CONTENT_ENCODING     = 61
    integer(kind=c_int), parameter, public :: CURLE_LDAP_INVALID_URL         = 62
    integer(kind=c_int), parameter, public :: CURLE_FILESIZE_EXCEEDED        = 63
    integer(kind=c_int), parameter, public :: CURLE_USE_SSL_FAILED           = 64
    integer(kind=c_int), parameter, public :: CURLE_SEND_FAIL_REWIND         = 65
    integer(kind=c_int), parameter, public :: CURLE_SSL_ENGINE_INITFAILED    = 66
    integer(kind=c_int), parameter, public :: CURLE_LOGIN_DENIED             = 67
    integer(kind=c_int), parameter, public :: CURLE_TFTP_NOTFOUND            = 68
    integer(kind=c_int), parameter, public :: CURLE_TFTP_PERM                = 69
    integer(kind=c_int), parameter, public :: CURLE_REMOTE_DISK_FULL         = 70
    integer(kind=c_int), parameter, public :: CURLE_TFTP_ILLEGAL             = 71
    integer(kind=c_int), parameter, public :: CURLE_TFTP_UNKNOWNID           = 72
    integer(kind=c_int), parameter, public :: CURLE_REMOTE_FILE_EXISTS       = 73
    integer(kind=c_int), parameter, public :: CURLE_TFTP_NOSUCHUSER          = 74
    integer(kind=c_int), parameter, public :: CURLE_CONV_FAILED              = 75
    integer(kind=c_int), parameter, public :: CURLE_CONV_REQD                = 76
    integer(kind=c_int), parameter, public :: CURLE_SSL_CACERT_BADFILE       = 77
    integer(kind=c_int), parameter, public :: CURLE_REMOTE_FILE_NOT_FOUND    = 78
    integer(kind=c_int), parameter, public :: CURLE_SSH                      = 79
    integer(kind=c_int), parameter, public :: CURLE_SSL_SHUTDOWN_FAILED      = 80
    integer(kind=c_int), parameter, public :: CURLE_AGAIN                    = 81
    integer(kind=c_int), parameter, public :: CURLE_SSL_CRL_BADFILE          = 82
    integer(kind=c_int), parameter, public :: CURLE_SSL_ISSUER_ERROR         = 83
    integer(kind=c_int), parameter, public :: CURLE_FTP_PRET_FAILED          = 84
    integer(kind=c_int), parameter, public :: CURLE_RTSP_CSEQ_ERROR          = 85
    integer(kind=c_int), parameter, public :: CURLE_RTSP_SESSION_ERROR       = 86
    integer(kind=c_int), parameter, public :: CURLE_FTP_BAD_FILE_LIST        = 87
    integer(kind=c_int), parameter, public :: CURLE_CHUNK_FAILED             = 88
    integer(kind=c_int), parameter, public :: CURLE_NO_CONNECTION_AVAILABLE  = 89
    integer(kind=c_int), parameter, public :: CURLE_SSL_PINNEDPUBKEYNOTMATCH = 90
    integer(kind=c_int), parameter, public :: CURLE_SSL_INVALIDCERTSTATUS    = 91
    integer(kind=c_int), parameter, public :: CURLE_HTTP2_STREAM             = 92
    integer(kind=c_int), parameter, public :: CURLE_RECURSIVE_API_CALL       = 93
    integer(kind=c_int), parameter, public :: CURLE_AUTH_ERROR               = 94
    integer(kind=c_int), parameter, public :: CURLE_HTTP3                    = 95
    integer(kind=c_int), parameter, public :: CURLE_QUIC_CONNECT_ERROR       = 96
    integer(kind=c_int), parameter, public :: CURLE_PROXY                    = 97
    integer(kind=c_int), parameter, public :: CURLE_SSL_CLIENTCERT           = 98
    integer(kind=c_int), parameter, public :: CURLE_UNRECOVERABLE_POLL       = 99
    integer(kind=c_int), parameter, public :: CURLE_TOO_LARGE                = 100
    integer(kind=c_int), parameter, public :: CURLE_LAST                     = 101 ! never use this

    integer(kind=c_int), parameter, public :: CURL_VERSION_IPV6         = shiftl(1, 0)
    integer(kind=c_int), parameter, public :: CURL_VERSION_KERBEROS4    = shiftl(1, 1)
    integer(kind=c_int), parameter, public :: CURL_VERSION_SSL          = shiftl(1, 2)
    integer(kind=c_int), parameter, public :: CURL_VERSION_LIBZ         = shiftl(1, 3)
    integer(kind=c_int), parameter, public :: CURL_VERSION_NTLM         = shiftl(1, 4)
    integer(kind=c_int), parameter, public :: CURL_VERSION_GSSNEGOTIATE = shiftl(1, 5)
    integer(kind=c_int), parameter, public :: CURL_VERSION_DEBUG        = shiftl(1, 6)
    integer(kind=c_int), parameter, public :: CURL_VERSION_ASYNCHDNS    = shiftl(1, 7)
    integer(kind=c_int), parameter, public :: CURL_VERSION_SPNEGO       = shiftl(1, 8)
    integer(kind=c_int), parameter, public :: CURL_VERSION_LARGEFILE    = shiftl(1, 9)
    integer(kind=c_int), parameter, public :: CURL_VERSION_IDN          = shiftl(1, 10)
    integer(kind=c_int), parameter, public :: CURL_VERSION_SSPI         = shiftl(1, 11)
    integer(kind=c_int), parameter, public :: CURL_VERSION_CONV         = shiftl(1, 12)
    integer(kind=c_int), parameter, public :: CURL_VERSION_CURLDEBUG    = shiftl(1, 13)
    integer(kind=c_int), parameter, public :: CURL_VERSION_TLSAUTH_SRP  = shiftl(1, 14)
    integer(kind=c_int), parameter, public :: CURL_VERSION_NTLM_WB      = shiftl(1, 15)
    integer(kind=c_int), parameter, public :: CURL_VERSION_HTTP2        = shiftl(1, 16)
    integer(kind=c_int), parameter, public :: CURL_VERSION_GSSAPI       = shiftl(1, 17)
    integer(kind=c_int), parameter, public :: CURL_VERSION_KERBEROS5    = shiftl(1, 18)
    integer(kind=c_int), parameter, public :: CURL_VERSION_UNIX_SOCKETS = shiftl(1, 19)
    integer(kind=c_int), parameter, public :: CURL_VERSION_PSL          = shiftl(1, 20)
    integer(kind=c_int), parameter, public :: CURL_VERSION_HTTPS_PROXY  = shiftl(1, 21)
    integer(kind=c_int), parameter, public :: CURL_VERSION_MULTI_SSL    = shiftl(1, 22)
    integer(kind=c_int), parameter, public :: CURL_VERSION_BROTLI       = shiftl(1, 23)
    integer(kind=c_int), parameter, public :: CURL_VERSION_ALTSVC       = shiftl(1, 24)
    integer(kind=c_int), parameter, public :: CURL_VERSION_HTTP3        = shiftl(1, 25)
    integer(kind=c_int), parameter, public :: CURL_VERSION_ZSTD         = shiftl(1, 26)
    integer(kind=c_int), parameter, public :: CURL_VERSION_UNICODE      = shiftl(1, 27)
    integer(kind=c_int), parameter, public :: CURL_VERSION_HSTS         = shiftl(1, 28)
    integer(kind=c_int), parameter, public :: CURL_VERSION_GSASL        = shiftl(1, 29)
    integer(kind=c_int), parameter, public :: CURL_VERSION_THREADSAFE   = shiftl(1, 30)

    ! CURLversion
    integer(kind=c_int), parameter, public :: CURLVERSION_FIRST    = 0
    integer(kind=c_int), parameter, public :: CURLVERSION_SECOND   = 1
    integer(kind=c_int), parameter, public :: CURLVERSION_THIRD    = 2
    integer(kind=c_int), parameter, public :: CURLVERSION_FOURTH   = 3
    integer(kind=c_int), parameter, public :: CURLVERSION_FIFTH    = 4
    integer(kind=c_int), parameter, public :: CURLVERSION_SIXTH    = 5
    integer(kind=c_int), parameter, public :: CURLVERSION_SEVENTH  = 6
    integer(kind=c_int), parameter, public :: CURLVERSION_EIGHTH   = 7
    integer(kind=c_int), parameter, public :: CURLVERSION_NINTH    = 8
    integer(kind=c_int), parameter, public :: CURLVERSION_TENTH    = 9
    integer(kind=c_int), parameter, public :: CURLVERSION_ELEVENTH = 10
    integer(kind=c_int), parameter, public :: CURLVERSION_LAST     = 11

    ! curl_infotype
    integer(kind=c_int), parameter, public :: CURLINFO_TEXT         = 0
    integer(kind=c_int), parameter, public :: CURLINFO_HEADER_IN    = 1
    integer(kind=c_int), parameter, public :: CURLINFO_HEADER_OUT   = 2
    integer(kind=c_int), parameter, public :: CURLINFO_DATA_IN      = 3
    integer(kind=c_int), parameter, public :: CURLINFO_DATA_OUT     = 4
    integer(kind=c_int), parameter, public :: CURLINFO_SSL_DATA_IN  = 5
    integer(kind=c_int), parameter, public :: CURLINFO_SSL_DATA_OUT = 6
    integer(kind=c_int), parameter, public :: CURLINFO_END          = 7

    integer(kind=c_int), parameter, public :: CURLINFO_STRING   = int(z'100000')
    integer(kind=c_int), parameter, public :: CURLINFO_LONG     = int(z'200000')
    integer(kind=c_int), parameter, public :: CURLINFO_DOUBLE   = int(z'300000')
    integer(kind=c_int), parameter, public :: CURLINFO_SLIST    = int(z'400000')
    integer(kind=c_int), parameter, public :: CURLINFO_PTR      = int(z'400000') ! same as SLIST
    integer(kind=c_int), parameter, public :: CURLINFO_SOCKET   = int(z'500000')
    integer(kind=c_int), parameter, public :: CURLINFO_OFF_T    = int(z'600000')
    integer(kind=c_int), parameter, public :: CURLINFO_MASK     = int(z'0fffff')
    integer(kind=c_int), parameter, public :: CURLINFO_TYPEMASK = int(z'f00000')

    ! CURLINFO
    integer(kind=c_int), parameter, public :: CURLINFO_NONE                      = 0 ! first, never use this
    integer(kind=c_int), parameter, public :: CURLINFO_EFFECTIVE_URL             = CURLINFO_STRING + 1
    integer(kind=c_int), parameter, public :: CURLINFO_RESPONSE_CODE             = CURLINFO_LONG + 2
    integer(kind=c_int), parameter, public :: CURLINFO_HTTP_CODE                 = CURLINFO_RESPONSE_CODE
    integer(kind=c_int), parameter, public :: CURLINFO_TOTAL_TIME                = CURLINFO_DOUBLE + 3
    integer(kind=c_int), parameter, public :: CURLINFO_NAMELOOKUP_TIME           = CURLINFO_DOUBLE + 4
    integer(kind=c_int), parameter, public :: CURLINFO_CONNECT_TIME              = CURLINFO_DOUBLE + 5
    integer(kind=c_int), parameter, public :: CURLINFO_PRETRANSFER_TIME          = CURLINFO_DOUBLE + 6
    integer(kind=c_int), parameter, public :: CURLINFO_SIZE_UPLOAD               = CURLINFO_DOUBLE + 7
    integer(kind=c_int), parameter, public :: CURLINFO_SIZE_UPLOAD_T             = CURLINFO_OFF_T + 7
    integer(kind=c_int), parameter, public :: CURLINFO_SIZE_DOWNLOAD             = CURLINFO_DOUBLE + 8
    integer(kind=c_int), parameter, public :: CURLINFO_SIZE_DOWNLOAD_T           = CURLINFO_OFF_T + 8
    integer(kind=c_int), parameter, public :: CURLINFO_SPEED_DOWNLOAD            = CURLINFO_DOUBLE + 9
    integer(kind=c_int), parameter, public :: CURLINFO_SPEED_DOWNLOAD_T          = CURLINFO_OFF_T + 9
    integer(kind=c_int), parameter, public :: CURLINFO_SPEED_UPLOAD              = CURLINFO_DOUBLE + 10
    integer(kind=c_int), parameter, public :: CURLINFO_SPEED_UPLOAD_T            = CURLINFO_OFF_T + 10
    integer(kind=c_int), parameter, public :: CURLINFO_HEADER_SIZE               = CURLINFO_LONG + 11
    integer(kind=c_int), parameter, public :: CURLINFO_REQUEST_SIZE              = CURLINFO_LONG + 12
    integer(kind=c_int), parameter, public :: CURLINFO_SSL_VERIFYRESULT          = CURLINFO_LONG + 13
    integer(kind=c_int), parameter, public :: CURLINFO_FILETIME                  = CURLINFO_LONG + 14
    integer(kind=c_int), parameter, public :: CURLINFO_FILETIME_T                = CURLINFO_OFF_T + 14
    integer(kind=c_int), parameter, public :: CURLINFO_CONTENT_LENGTH_DOWNLOAD   = CURLINFO_DOUBLE + 15
    integer(kind=c_int), parameter, public :: CURLINFO_CONTENT_LENGTH_DOWNLOAD_T = CURLINFO_OFF_T + 15
    integer(kind=c_int), parameter, public :: CURLINFO_CONTENT_LENGTH_UPLOAD     = CURLINFO_DOUBLE + 16
    integer(kind=c_int), parameter, public :: CURLINFO_CONTENT_LENGTH_UPLOAD_T   = CURLINFO_OFF_T + 16
    integer(kind=c_int), parameter, public :: CURLINFO_STARTTRANSFER_TIME        = CURLINFO_DOUBLE + 17
    integer(kind=c_int), parameter, public :: CURLINFO_CONTENT_TYPE              = CURLINFO_STRING + 18
    integer(kind=c_int), parameter, public :: CURLINFO_REDIRECT_TIME             = CURLINFO_DOUBLE + 19
    integer(kind=c_int), parameter, public :: CURLINFO_REDIRECT_COUNT            = CURLINFO_LONG + 20
    integer(kind=c_int), parameter, public :: CURLINFO_PRIVATE                   = CURLINFO_STRING + 21
    integer(kind=c_int), parameter, public :: CURLINFO_HTTP_CONNECTCODE          = CURLINFO_LONG + 22
    integer(kind=c_int), parameter, public :: CURLINFO_HTTPAUTH_AVAIL            = CURLINFO_LONG + 23
    integer(kind=c_int), parameter, public :: CURLINFO_PROXYAUTH_AVAIL           = CURLINFO_LONG + 24
    integer(kind=c_int), parameter, public :: CURLINFO_OS_ERRNO                  = CURLINFO_LONG + 25
    integer(kind=c_int), parameter, public :: CURLINFO_NUM_CONNECTS              = CURLINFO_LONG + 26
    integer(kind=c_int), parameter, public :: CURLINFO_SSL_ENGINES               = CURLINFO_SLIST + 27
    integer(kind=c_int), parameter, public :: CURLINFO_COOKIELIST                = CURLINFO_SLIST + 28
    integer(kind=c_int), parameter, public :: CURLINFO_LASTSOCKET                = CURLINFO_LONG + 29
    integer(kind=c_int), parameter, public :: CURLINFO_FTP_ENTRY_PATH            = CURLINFO_STRING + 30
    integer(kind=c_int), parameter, public :: CURLINFO_REDIRECT_URL              = CURLINFO_STRING + 31
    integer(kind=c_int), parameter, public :: CURLINFO_PRIMARY_IP                = CURLINFO_STRING + 32
    integer(kind=c_int), parameter, public :: CURLINFO_APPCONNECT_TIME           = CURLINFO_DOUBLE + 33
    integer(kind=c_int), parameter, public :: CURLINFO_CERTINFO                  = CURLINFO_PTR + 34
    integer(kind=c_int), parameter, public :: CURLINFO_CONDITION_UNMET           = CURLINFO_LONG + 35
    integer(kind=c_int), parameter, public :: CURLINFO_RTSP_SESSION_ID           = CURLINFO_STRING + 36
    integer(kind=c_int), parameter, public :: CURLINFO_RTSP_CLIENT_CSEQ          = CURLINFO_LONG + 37
    integer(kind=c_int), parameter, public :: CURLINFO_RTSP_SERVER_CSEQ          = CURLINFO_LONG + 38
    integer(kind=c_int), parameter, public :: CURLINFO_RTSP_CSEQ_RECV            = CURLINFO_LONG + 39
    integer(kind=c_int), parameter, public :: CURLINFO_PRIMARY_PORT              = CURLINFO_LONG + 40
    integer(kind=c_int), parameter, public :: CURLINFO_LOCAL_IP                  = CURLINFO_STRING + 41
    integer(kind=c_int), parameter, public :: CURLINFO_LOCAL_PORT                = CURLINFO_LONG + 42
    integer(kind=c_int), parameter, public :: CURLINFO_TLS_SESSION               = CURLINFO_PTR + 43
    integer(kind=c_int), parameter, public :: CURLINFO_ACTIVESOCKET              = CURLINFO_SOCKET + 44
    integer(kind=c_int), parameter, public :: CURLINFO_TLS_SSL_PTR               = CURLINFO_PTR + 45
    integer(kind=c_int), parameter, public :: CURLINFO_HTTP_VERSION              = CURLINFO_LONG + 46
    integer(kind=c_int), parameter, public :: CURLINFO_PROXY_SSL_VERIFYRESULT    = CURLINFO_LONG + 47
    integer(kind=c_int), parameter, public :: CURLINFO_PROTOCOL                  = CURLINFO_LONG + 48
    integer(kind=c_int), parameter, public :: CURLINFO_SCHEME                    = CURLINFO_STRING + 49
    integer(kind=c_int), parameter, public :: CURLINFO_TOTAL_TIME_T              = CURLINFO_OFF_T + 50
    integer(kind=c_int), parameter, public :: CURLINFO_NAMELOOKUP_TIME_T         = CURLINFO_OFF_T + 51
    integer(kind=c_int), parameter, public :: CURLINFO_CONNECT_TIME_T            = CURLINFO_OFF_T + 52
    integer(kind=c_int), parameter, public :: CURLINFO_PRETRANSFER_TIME_T        = CURLINFO_OFF_T + 53
    integer(kind=c_int), parameter, public :: CURLINFO_STARTTRANSFER_TIME_T      = CURLINFO_OFF_T + 54
    integer(kind=c_int), parameter, public :: CURLINFO_REDIRECT_TIME_T           = CURLINFO_OFF_T + 55
    integer(kind=c_int), parameter, public :: CURLINFO_APPCONNECT_TIME_T         = CURLINFO_OFF_T + 56
    integer(kind=c_int), parameter, public :: CURLINFO_RETRY_AFTER               = CURLINFO_OFF_T + 57
    integer(kind=c_int), parameter, public :: CURLINFO_EFFECTIVE_METHOD          = CURLINFO_STRING + 58
    integer(kind=c_int), parameter, public :: CURLINFO_PROXY_ERROR               = CURLINFO_LONG + 59
    integer(kind=c_int), parameter, public :: CURLINFO_REFERER                   = CURLINFO_STRING + 60
    integer(kind=c_int), parameter, public :: CURLINFO_CAINFO                    = CURLINFO_STRING + 61
    integer(kind=c_int), parameter, public :: CURLINFO_CAPATH                    = CURLINFO_STRING + 62
    integer(kind=c_int), parameter, public :: CURLINFO_XFER_ID                   = CURLINFO_OFF_T + 63
    integer(kind=c_int), parameter, public :: CURLINFO_CONN_ID                   = CURLINFO_OFF_T + 64
    integer(kind=c_int), parameter, public :: CURLINFO_QUEUE_TIME_T              = CURLINFO_OFF_T + 65
    integer(kind=c_int), parameter, public :: CURLINFO_USED_PROXY                = CURLINFO_LONG + 66
    integer(kind=c_int), parameter, public :: CURLINFO_LASTONE                   = 66

    integer(kind=c_size_t), parameter, public :: CURL_ZERO_TERMINATED   = int(-1, kind=c_size_t)
    integer(kind=c_int),    parameter, public :: CURLMIMEOPT_FORMESCAPE = shiftl(1, 0)

    integer(kind=c_int), parameter, public :: CURL_HTTP_VERSION_NONE              = 0
    integer(kind=c_int), parameter, public :: CURL_HTTP_VERSION_1_0               = 1
    integer(kind=c_int), parameter, public :: CURL_HTTP_VERSION_1_1               = 2
    integer(kind=c_int), parameter, public :: CURL_HTTP_VERSION_2_0               = 3
    integer(kind=c_int), parameter, public :: CURL_HTTP_VERSION_2TLS              = 4
    integer(kind=c_int), parameter, public :: CURL_HTTP_VERSION_2_PRIOR_KNOWLEDGE = 5
    integer(kind=c_int), parameter, public :: CURL_HTTP_VERSION_3                 = 30
    integer(kind=c_int), parameter, public :: CURL_HTTP_VERSION_3ONLY             = 31
    integer(kind=c_int), parameter, public :: CURL_HTTP_VERSION_LAST              = 32
    integer(kind=c_int), parameter, public :: CURL_HTTP_VERSION_2                 = CURL_HTTP_VERSION_2_0

    integer(kind=c_int), parameter, public :: CURLPAUSE_RECV      = shiftl(1, 0)
    integer(kind=c_int), parameter, public :: CURLPAUSE_RECV_CONT = 0
    integer(kind=c_int), parameter, public :: CURLPAUSE_SEND      = shiftl(1, 2)
    integer(kind=c_int), parameter, public :: CURLPAUSE_SEND_CONT = 0
    integer(kind=c_int), parameter, public :: CURLPAUSE_ALL       = ior(CURLPAUSE_RECV, CURLPAUSE_SEND)
    integer(kind=c_int), parameter, public :: CURLPAUSE_CONT      = ior(CURLPAUSE_RECV_CONT, CURLPAUSE_SEND_CONT)

    ! curl_slist
    type, bind(c), public :: curl_slist
        type(c_ptr) :: data = c_null_ptr
        type(c_ptr) :: next = c_null_ptr
    end type curl_slist

    ! curl_version_info_data
    type, bind(c), public :: curl_version_info_data
        integer(kind=c_int)  :: age             = 0
        type(c_ptr)          :: version         = c_null_ptr
        integer(kind=c_int)  :: version_num     = 0
        type(c_ptr)          :: host            = c_null_ptr
        integer(kind=c_int)  :: features        = 0
        type(c_ptr)          :: ssl_version     = c_null_ptr
        integer(kind=c_long) :: ssl_version_num = 0_c_long
        type(c_ptr)          :: libz_version    = c_null_ptr
        type(c_ptr)          :: protocols       = c_null_ptr
        type(c_ptr)          :: ares            = c_null_ptr
        integer(kind=c_int)  :: ares_num        = 0
        type(c_ptr)          :: libidn          = c_null_ptr
        integer(kind=c_int)  :: iconv_ver_num   = 0
        type(c_ptr)          :: libssh_version  = c_null_ptr
        integer(kind=c_int)  :: brotli_ver_num  = 0
        type(c_ptr)          :: brotli_version  = c_null_ptr
        integer(kind=c_int)  :: nghttp2_ver_num = 0
        type(c_ptr)          :: nghttp2_version = c_null_ptr
        type(c_ptr)          :: quic_version    = c_null_ptr
        type(c_ptr)          :: cainfo          = c_null_ptr
        type(c_ptr)          :: capath          = c_null_ptr
        integer(kind=c_int)  :: zstd_ver_num    = 0
        type(c_ptr)          :: zstd_version    = c_null_ptr
        type(c_ptr)          :: hyper_version   = c_null_ptr
        type(c_ptr)          :: gsasl_version   = c_null_ptr
        type(c_ptr)          :: feature_names   = c_null_ptr
    end type curl_version_info_data

    public :: curl_easy_cleanup
    public :: curl_easy_escape
    public :: curl_easy_getinfo
    public :: curl_easy_init
    public :: curl_easy_pause
    public :: curl_easy_perform
    public :: curl_easy_setopt
    public :: curl_easy_setopt_char
    public :: curl_easy_setopt_funptr
    public :: curl_easy_setopt_int
    public :: curl_easy_setopt_long
    public :: curl_easy_setopt_ptr
    public :: curl_easy_strerror
    public :: curl_easy_unescape
    public :: curl_escape
    public :: curl_free
    public :: curl_global_cleanup
    public :: curl_global_init
    public :: curl_mime_addpart
    public :: curl_mime_data
    public :: curl_mime_encoder
    public :: curl_mime_filedata
    public :: curl_mime_filename
    public :: curl_mime_free
    public :: curl_mime_headers
    public :: curl_mime_init
    public :: curl_mime_name
    public :: curl_mime_subparts
    public :: curl_mime_type
    public :: curl_slist_append
    public :: curl_slist_free_all
    public :: curl_unescape
    public :: curl_version
    public :: curl_version_info
    public :: curl_version_now

    interface
        ! char *curl_easy_escape(CURL *handle, const char *string, int length)
        function curl_easy_escape_(curl, string, length) bind(c, name='curl_easy_escape')
            import :: c_char, c_int, c_ptr
            implicit none
            type(c_ptr),            intent(in), value :: curl
            character(kind=c_char), intent(in)        :: string
            integer(kind=c_int),    intent(in), value :: length
            type(c_ptr)                               :: curl_easy_escape_
        end function curl_easy_escape_

        ! CURLcode curl_easy_getinfo(CURL *curl, CURLoption option, ...)
        function curl_easy_getinfo_(curl, option, parameter) bind(c, name='curl_easy_getinfo')
            import :: c_int, c_ptr
            implicit none
            type(c_ptr),         intent(in), value :: curl
            integer(kind=c_int), intent(in), value :: option
            type(c_ptr),         intent(in), value :: parameter
            integer(kind=c_int)                    :: curl_easy_getinfo_
        end function curl_easy_getinfo_

        ! CURL *curl_easy_init(void)
        function curl_easy_init() bind(c, name='curl_easy_init')
            import :: c_ptr
            implicit none
            type(c_ptr) :: curl_easy_init
        end function curl_easy_init

        ! CURLcode curl_easy_pause(CURL *handle, int bitmask)
        function curl_easy_pause(curl, bitmask) bind(c, name='curl_easy_pause')
            import :: c_int, c_ptr
            implicit none
            type(c_ptr),         intent(in), value :: curl
            integer(kind=c_int), intent(in), value :: bitmask
            integer(kind=c_int)                    :: curl_easy_pause
        end function curl_easy_pause

        ! CURLcode curl_easy_perform(CURL *curl)
        function curl_easy_perform(curl) bind(c, name='curl_easy_perform')
            import :: c_int, c_ptr
            implicit none
            type(c_ptr), intent(in), value :: curl
            integer(kind=c_int)            :: curl_easy_perform
        end function curl_easy_perform

        ! CURLcode curl_easy_setopt(CURL *curl, CURLoption option, ...)
        function curl_easy_setopt_c_char(curl, option, parameter) bind(c, name='curl_easy_setopt_c_char')
            import :: c_char, c_int, c_ptr
            implicit none
            type(c_ptr),            intent(in), value :: curl
            integer(kind=c_int),    intent(in), value :: option
            character(kind=c_char), intent(in)        :: parameter
            integer(kind=c_int)                       :: curl_easy_setopt_c_char
        end function curl_easy_setopt_c_char

        ! CURLcode curl_easy_setopt(CURL *curl, CURLoption option, ...)
        function curl_easy_setopt_c_long(curl, option, parameter) bind(c, name='curl_easy_setopt_c_long')
            import :: c_int, c_long, c_ptr
            implicit none
            type(c_ptr),          intent(in), value :: curl
            integer(kind=c_int),  intent(in), value :: option
            integer(kind=c_long), intent(in), value :: parameter
            integer(kind=c_int)                     :: curl_easy_setopt_c_long
        end function curl_easy_setopt_c_long

        ! CURLcode curl_easy_setopt(CURL *curl, CURLoption option, ...)
        function curl_easy_setopt_c_ptr(curl, option, parameter) bind(c, name='curl_easy_setopt_c_ptr')
            import :: c_int, c_ptr
            implicit none
            type(c_ptr),         intent(in), value :: curl
            integer(kind=c_int), intent(in), value :: option
            type(c_ptr),         intent(in), value :: parameter
            integer(kind=c_int)                    :: curl_easy_setopt_c_ptr
        end function curl_easy_setopt_c_ptr

        ! CURLcode curl_easy_setopt(CURL *curl, CURLoption option, ...)
        function curl_easy_setopt_c_funptr(curl, option, parameter) bind(c, name='curl_easy_setopt_c_funptr')
            import :: c_funptr, c_int, c_ptr
            implicit none
            type(c_ptr),         intent(in), value :: curl
            integer(kind=c_int), intent(in), value :: option
            type(c_funptr),      intent(in), value :: parameter
            integer(kind=c_int)                    :: curl_easy_setopt_c_funptr
        end function curl_easy_setopt_c_funptr

        ! const char *curl_easy_strerror(CURLcode code)
        function curl_easy_strerror_(code) bind(c, name='curl_easy_strerror')
            import :: c_int, c_ptr
            implicit none
            integer(kind=c_int), intent(in), value :: code
            type(c_ptr)                            :: curl_easy_strerror_
        end function curl_easy_strerror_

        ! char *curl_easy_unescape(CURL *handle, const char *string, int length, int *outlength)
        function curl_easy_unescape_(curl, string, length, outlength) bind(c, name='curl_easy_unescape')
            import :: c_char, c_int, c_ptr
            implicit none
            type(c_ptr),            intent(in), value :: curl
            character(kind=c_char), intent(in)        :: string
            integer(kind=c_int),    intent(in), value :: length
            integer(kind=c_int),    intent(out)       :: outlength
            type(c_ptr)                               :: curl_easy_unescape_
        end function curl_easy_unescape_

        ! char *curl_escape(const char *string, int length)
        function curl_escape_(string, length) bind(c, name='curl_escape')
            import :: c_char, c_int, c_ptr
            implicit none
            character(kind=c_char), intent(in)        :: string
            integer(kind=c_int),    intent(in), value :: length
            type(c_ptr)                               :: curl_escape_
        end function curl_escape_

        ! CURLcode curl_global_init(long flags)
        function curl_global_init_(flags) bind(c, name='curl_global_init')
            import :: c_int, c_long
            implicit none
            integer(kind=c_long), intent(in), value :: flags
            integer(kind=c_int)                     :: curl_global_init_
        end function curl_global_init_

        ! curl_mimepart *curl_mime_addpart(curl_mime *mime)
        function curl_mime_addpart(curl) bind(c, name='curl_mime_addpart')
            import :: c_ptr
            implicit none
            type(c_ptr), intent(in), value :: curl
            type(c_ptr)                    :: curl_mime_addpart
        end function curl_mime_addpart

        ! CURLcode curl_mime_data(curl_mimepart *part, const char *data, size_t datasize)
        function curl_mime_data(part, data, datasize) bind(c, name='curl_mime_data')
            import :: c_char, c_int, c_ptr, c_size_t
            implicit none
            type(c_ptr),            intent(in), value :: part
            character(kind=c_char), intent(in)        :: data
            integer(kind=c_size_t), intent(in), value :: datasize
            integer(kind=c_int)                       :: curl_mime_data
        end function curl_mime_data

        ! CURLcode curl_mime_encoder(curl_mimepart *part, const char *encoding)
        function curl_mime_encoder_(part, encoding) bind(c, name='curl_mime_encoder')
            import :: c_char, c_int, c_ptr
            implicit none
            type(c_ptr),            intent(in), value :: part
            character(kind=c_char), intent(in)        :: encoding
            integer(kind=c_int)                       :: curl_mime_encoder_
        end function curl_mime_encoder_

        ! CURLcode curl_mime_filedata(curl_mimepart *part, const char *filename)
        function curl_mime_filedata_(part, filename) bind(c, name='curl_mime_filedata')
            import :: c_char, c_int, c_ptr
            implicit none
            type(c_ptr),            intent(in), value :: part
            character(kind=c_char), intent(in)        :: filename
            integer(kind=c_int)                       :: curl_mime_filedata_
        end function curl_mime_filedata_

        ! CURLcode curl_mime_filename(curl_mimepart *part, const char *filename)
        function curl_mime_filename_(part, filename) bind(c, name='curl_mime_filename')
            import :: c_char, c_int, c_ptr
            implicit none
            type(c_ptr),            intent(in), value :: part
            character(kind=c_char), intent(in)        :: filename
            integer(kind=c_int)                       :: curl_mime_filename_
        end function curl_mime_filename_

        ! CURLcode curl_mime_headers(curl_mimepart *part, struct curl_slist *headers, int take_ownership)
        function curl_mime_headers(part, headers, take_ownership) bind(c, name='curl_mime_headers')
            import :: c_int, c_ptr
            implicit none
            type(c_ptr),         intent(in), value :: part
            type(c_ptr),         intent(in), value :: headers
            integer(kind=c_int), intent(in), value :: take_ownership
            integer(kind=c_int)                    :: curl_mime_headers
        end function curl_mime_headers

        ! curl_mime *curl_mime_init(CURL *easy)
        function curl_mime_init(curl) bind(c, name='curl_mime_init')
            import :: c_ptr
            implicit none
            type(c_ptr), intent(in), value :: curl
            type(c_ptr)                    :: curl_mime_init
        end function curl_mime_init

        ! CURLcode curl_mime_name(curl_mimepart *part, const char *name)
        function curl_mime_name_(part, name) bind(c, name='curl_mime_name')
            import :: c_char, c_int, c_ptr
            implicit none
            type(c_ptr),            intent(in), value :: part
            character(kind=c_char), intent(in)        :: name
            integer(kind=c_int)                       :: curl_mime_name_
        end function curl_mime_name_

        ! CURLcode curl_mime_subparts(curl_mimepart *part, curl_mime *subparts)
        function curl_mime_subparts(part, subparts) bind(c, name='curl_mime_subparts')
            import :: c_int, c_ptr
            implicit none
            type(c_ptr), intent(in), value :: part
            type(c_ptr), intent(in), value :: subparts
            integer(kind=c_int)            :: curl_mime_subparts
        end function curl_mime_subparts

        ! CURLcode curl_mime_type(curl_mimepart *part, const char *mimetype)
        function curl_mime_type_(part, mimetype) bind(c, name='curl_mime_type')
            import :: c_char, c_int, c_ptr
            implicit none
            type(c_ptr),            intent(in), value :: part
            character(kind=c_char), intent(in)        :: mimetype
            integer(kind=c_int)                       :: curl_mime_type_
        end function curl_mime_type_

        ! struct curl_slist *curl_slist_append(struct curl_slist *list, const char *string)
        function curl_slist_append_(list, string) bind(c, name='curl_slist_append')
            import :: c_char, c_ptr
            implicit none
            type(c_ptr),            intent(in), value :: list
            character(kind=c_char), intent(in)        :: string
            type(c_ptr)                               :: curl_slist_append_
        end function curl_slist_append_

        ! char *curl_unescape(const char *string, int length)
        function curl_unescape_(string, length) bind(c, name='curl_unescape')
            import :: c_char, c_int, c_ptr
            implicit none
            character(kind=c_char), intent(in)        :: string
            integer(kind=c_int),    intent(in), value :: length
            type(c_ptr)                               :: curl_unescape_
        end function curl_unescape_

        ! char *curl_version(void)
        function curl_version_() bind(c, name='curl_version')
            import :: c_ptr
            implicit none
            type(c_ptr) :: curl_version_
        end function curl_version_

        ! curl_version_info_data *curl_version_info(CURLversion age)
        function curl_version_info_(age) bind(c, name='curl_version_info')
            import :: c_int, c_ptr
            implicit none
            integer(kind=c_int), intent(in), value :: age
            type(c_ptr)                            :: curl_version_info_
        end function curl_version_info_

        ! void curl_easy_cleanup(CURL *curl)
        subroutine curl_easy_cleanup(curl) bind(c, name='curl_easy_cleanup')
            import :: c_ptr
            implicit none
            type(c_ptr), intent(in), value :: curl
        end subroutine curl_easy_cleanup

        ! void curl_free(void *p)
        subroutine curl_free(p) bind(c, name='curl_free')
            import :: c_ptr
            implicit none
            type(c_ptr), intent(in), value :: p
        end subroutine curl_free

        ! void curl_global_cleanup(void)
        subroutine curl_global_cleanup() bind(c, name='curl_global_cleanup')
        end subroutine curl_global_cleanup

        ! void curl_mime_free(curl_mime *mime)
        subroutine curl_mime_free(mime) bind(c, name='curl_mime_free')
            import :: c_ptr
            implicit none
            type(c_ptr), intent(in), value :: mime
        end subroutine curl_mime_free

        ! void curl_slist_free_all(struct curl_slist *list)
        subroutine curl_slist_free_all(list) bind(c, name='curl_slist_free_all')
            import :: c_ptr
            implicit none
            type(c_ptr), intent(in), value :: list
        end subroutine curl_slist_free_all
    end interface

    interface
        ! int curl_version_now()
        function curl_version_now() bind(c, name='curl_version_now')
            !! Interface to wrapper function `curl_version_now()` for C constant
            !! `CURLVERSION_NOW`.
            import :: c_int
            implicit none
            integer(kind=c_int) :: curl_version_now
        end function curl_version_now
    end interface

    interface curl_easy_getinfo
        !! Fortran 2008 generic interface `curl_easy_getinfo()`.
        module procedure :: curl_easy_getinfo_char
        module procedure :: curl_easy_getinfo_double
        module procedure :: curl_easy_getinfo_int
        module procedure :: curl_easy_getinfo_long
        module procedure :: curl_easy_getinfo_ptr
    end interface

    interface curl_easy_setopt
        !! Fortran 2008 generic interface `curl_easy_setopt()`.
        module procedure :: curl_easy_setopt_char
        module procedure :: curl_easy_setopt_funptr
        module procedure :: curl_easy_setopt_int
        module procedure :: curl_easy_setopt_long
        module procedure :: curl_easy_setopt_ptr
    end interface
contains
    ! char *curl_easy_escape(CURL *handle, const char *string, int length)
    function curl_easy_escape(curl, string, length) result(escaped)
        type(c_ptr),      intent(in)           :: curl
        character(len=*), intent(in)           :: string
        integer,          intent(in), optional :: length
        character(len=:), allocatable          :: escaped

        integer     :: n
        type(c_ptr) :: ptr

        if (present(length)) then
            n = length
        else
            n = len(string)
        end if

        ptr = curl_easy_escape_(curl, string, n)
        call c_f_str_ptr(ptr, escaped)
    end function curl_easy_escape

    ! CURLcode curl_easy_getinfo(CURL *curl, CURLoption option, ...)
    function curl_easy_getinfo_char(curl, option, parameter) result(rc)
        type(c_ptr),                   intent(in)  :: curl
        integer,                       intent(in)  :: option
        character(len=:), allocatable, intent(out) :: parameter
        integer                                    :: rc

        type(c_ptr), target :: ptr

        ptr = c_null_ptr
        rc = curl_easy_getinfo_(curl, option, c_loc(ptr))
        call c_f_str_ptr(ptr, parameter)
    end function curl_easy_getinfo_char

    ! CURLcode curl_easy_getinfo(CURL *curl, CURLoption option, ...)
    function curl_easy_getinfo_double(curl, option, parameter) result(rc)
        type(c_ptr),                 intent(in)  :: curl
        integer,                     intent(in)  :: option
        real(kind=c_double), target, intent(out) :: parameter
        integer                                  :: rc

        rc = curl_easy_getinfo_(curl, option, c_loc(parameter))
    end function curl_easy_getinfo_double

    ! CURLcode curl_easy_getinfo(CURL *curl, CURLoption option, ...)
    function curl_easy_getinfo_int(curl, option, parameter) result(rc)
        type(c_ptr),      intent(in)  :: curl
        integer,          intent(in)  :: option
        integer(kind=i4), intent(out) :: parameter
        integer                       :: rc

        integer(kind=c_long), target  :: i

        rc = curl_easy_getinfo_(curl, option, c_loc(i))
        parameter = int(i)
    end function curl_easy_getinfo_int

    ! CURLcode curl_easy_getinfo(CURL *curl, CURLoption option, ...)
    function curl_easy_getinfo_long(curl, option, parameter) result(rc)
        type(c_ptr),      intent(in)  :: curl
        integer,          intent(in)  :: option
        integer(kind=i8), intent(out) :: parameter
        integer                       :: rc

        integer(kind=c_long), target  :: i

        rc = curl_easy_getinfo_(curl, option, c_loc(i))
        parameter = int(i, kind=i8)
    end function curl_easy_getinfo_long

    ! CURLcode curl_easy_getinfo(CURL *curl, CURLoption option, ...)
    function curl_easy_getinfo_ptr(curl, option, parameter) result(rc)
        type(c_ptr), intent(in)    :: curl
        integer,     intent(in)    :: option
        type(c_ptr), intent(inout) :: parameter
        integer                    :: rc

        rc = curl_easy_getinfo_(curl, option, parameter)
    end function curl_easy_getinfo_ptr

    ! CURLcode curl_easy_setopt(CURL *curl, CURLoption option, ...)
    function curl_easy_setopt_char(curl, option, parameter) result(rc)
        type(c_ptr),      intent(in) :: curl
        integer,          intent(in) :: option
        character(len=*), intent(in) :: parameter
        integer                      :: rc

        rc = curl_easy_setopt_c_char(curl, option, parameter // c_null_char)
    end function curl_easy_setopt_char

    ! CURLcode curl_easy_setopt(CURL *curl, CURLoption option, ...)
    function curl_easy_setopt_funptr(curl, option, parameter) result(rc)
        type(c_ptr),    intent(in) :: curl
        integer,        intent(in) :: option
        type(c_funptr), intent(in) :: parameter
        integer                    :: rc

        rc = curl_easy_setopt_c_funptr(curl, option, parameter)
    end function curl_easy_setopt_funptr

    ! CURLcode curl_easy_setopt(CURL *curl, CURLoption option, ...)
    function curl_easy_setopt_int(curl, option, parameter) result(rc)
        type(c_ptr),      intent(in) :: curl
        integer,          intent(in) :: option
        integer(kind=i4), intent(in) :: parameter
        integer                      :: rc

        rc = curl_easy_setopt_c_long(curl, option, int(parameter, kind=c_long))
    end function curl_easy_setopt_int

    ! CURLcode curl_easy_setopt(CURL *curl, CURLoption option, ...)
    function curl_easy_setopt_long(curl, option, parameter) result(rc)
        type(c_ptr),      intent(in) :: curl
        integer,          intent(in) :: option
        integer(kind=i8), intent(in) :: parameter
        integer                      :: rc

        rc = curl_easy_setopt_c_long(curl, option, int(parameter, kind=c_long))
    end function curl_easy_setopt_long

    ! CURLcode curl_easy_setopt(CURL *curl, CURLoption option, ...)
    function curl_easy_setopt_ptr(curl, option, parameter) result(rc)
        type(c_ptr), intent(in) :: curl
        integer,     intent(in) :: option
        type(c_ptr), intent(in) :: parameter
        integer                 :: rc

        rc = curl_easy_setopt_c_ptr(curl, option, parameter)
    end function curl_easy_setopt_ptr

    ! const char *curl_easy_strerror(CURLcode code)
    function curl_easy_strerror(code) result(str)
        integer, intent(in)           :: code
        character(len=:), allocatable :: str

        type(c_ptr) :: ptr

        ptr = curl_easy_strerror_(code)
        call c_f_str_ptr(ptr, str)
    end function curl_easy_strerror

    ! char *curl_easy_unescape(CURL *handle, const char *string, int length, int *outlength)
    function curl_easy_unescape(curl, string, length, outlength) result(unescaped)
        type(c_ptr),      intent(in)            :: curl
        character(len=*), intent(in)            :: string
        integer,          intent(in),  optional :: length
        integer,          intent(out), optional :: outlength
        character(len=:), allocatable           :: unescaped

        integer     :: n, o
        type(c_ptr) :: ptr

        if (present(length)) then
            n = length
        else
            n = len(string)
        end if

        ptr = curl_easy_unescape_(curl, string, n, o)
        call c_f_str_ptr(ptr, unescaped, int(o, kind=i8))
        if (present(outlength)) outlength = o
    end function curl_easy_unescape

    ! char *curl_escape(const char *string, int length)
    function curl_escape(string, length) result(escaped)
        character(len=*), intent(in)           :: string
        integer,          intent(in), optional :: length
        character(len=:), allocatable          :: escaped

        integer     :: n
        type(c_ptr) :: ptr

        if (present(length)) then
            n = length
        else
            n = len(string)
        end if

        ptr = curl_escape_(string, n)
        call c_f_str_ptr(ptr, escaped)
    end function curl_escape

    ! CURLcode curl_global_init(long flags)
    function curl_global_init(flags) result(rc)
        integer, intent(in) :: flags
        integer             :: rc

        rc = curl_global_init_(int(flags, kind=c_long))
    end function curl_global_init

    ! CURLcode curl_mime_encoder(curl_mimepart *part, const char *encoding)
    function curl_mime_encoder(part, encoding) result(rc)
        type(c_ptr),      intent(in) :: part
        character(len=*), intent(in) :: encoding
        integer                      :: rc

        rc = curl_mime_encoder_(part, encoding // c_null_char)
    end function curl_mime_encoder

    ! CURLcode curl_mime_filedata(curl_mimepart *part, const char *filename)
    function curl_mime_filedata(part, filename) result(rc)
        type(c_ptr),      intent(in) :: part
        character(len=*), intent(in) :: filename
        integer                      :: rc

        rc = curl_mime_filedata_(part, filename // c_null_char)
    end function curl_mime_filedata

    ! CURLcode curl_mime_filename(curl_mimepart *part, const char *filename)
    function curl_mime_filename(part, filename) result(rc)
        type(c_ptr),      intent(in) :: part
        character(len=*), intent(in) :: filename
        integer                      :: rc

        rc = curl_mime_filename_(part, filename // c_null_char)
    end function curl_mime_filename

    ! CURLcode curl_mime_name(curl_mimepart *part, const char *name)
    function curl_mime_name(part, name) result(rc)
        type(c_ptr),      intent(in) :: part
        character(len=*), intent(in) :: name
        integer                      :: rc

        rc = curl_mime_name_(part, name // c_null_char)
    end function curl_mime_name

    ! CURLcode curl_mime_type(curl_mimepart *part, const char *mimetype)
    function curl_mime_type(part, mimetype) result(rc)
        type(c_ptr),      intent(in) :: part
        character(len=*), intent(in) :: mimetype
        integer                      :: rc

        rc = curl_mime_type_(part, mimetype // c_null_char)
    end function curl_mime_type

    ! char *curl_unescape(const char *string, int length)
    function curl_unescape(string, length) result(unescaped)
        character(len=*), intent(in)           :: string
        integer,          intent(in), optional :: length
        character(len=:), allocatable          :: unescaped

        integer     :: n
        type(c_ptr) :: ptr

        if (present(length)) then
            n = length
        else
            n = len(string)
        end if

        ptr = curl_unescape_(string, n)
        call c_f_str_ptr(ptr, unescaped)
    end function curl_unescape

    ! struct curl_slist *curl_slist_append(struct curl_slist *list, const char *string)
    function curl_slist_append(list, string) result(ptr)
        type(c_ptr),      intent(in) :: list
        character(len=*), intent(in) :: string

        type(c_ptr) :: ptr

        ptr = curl_slist_append_(list, string // c_null_char)
    end function curl_slist_append

    ! char *curl_version(void)
    function curl_version()
        character(len=:), allocatable :: curl_version

        type(c_ptr) :: ptr

        ptr = curl_version_()
        call c_f_str_ptr(ptr, curl_version)
    end function curl_version

    ! curl_version_info_data *curl_version_info(CURLversion age)
    function curl_version_info(age)
        !! Wrapper for `curl_version_info_()` that converts the returned C
        !! pointer to Fortran pointer of derived type `curl_version_info_data`.
        integer, intent(in)                   :: age
        type(curl_version_info_data), pointer :: curl_version_info

        type(c_ptr) :: ptr

        ptr = curl_version_info_(age)

        if (c_associated(ptr)) then
            call c_f_pointer(ptr, curl_version_info)
            return
        end if

        allocate (curl_version_info)
    end function curl_version_info
end module curl_easy
