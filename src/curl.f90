! curl.f90
!
! Fortran 2008 ISO C binding interfaces to libcurl.
!
! Author:  Philipp Engel
! Licence: ISC
module curl
    use, intrinsic :: iso_c_binding
    use, intrinsic :: iso_fortran_env, only: i4 => int32, i8 => int64, r4 => real32, r8 => real64
    implicit none
    private

    integer(kind=c_int), parameter, public :: CURLOPTTYPE_LONG          = 0
    integer(kind=c_int), parameter, public :: CURLOPTTYPE_OBJECTPOINT   = 10000
    integer(kind=c_int), parameter, public :: CURLOPTTYPE_STRINGPOINT   = 10000
    integer(kind=c_int), parameter, public :: CURLOPTTYPE_FUNCTIONPOINT = 20000
    integer(kind=c_int), parameter, public :: CURLOPTTYPE_OFF_T         = 30000

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

    integer(kind=c_int), parameter, public :: CURLGSSAPI_DELEGATION_NONE        = 0
    integer(kind=c_int), parameter, public :: CURLGSSAPI_DELEGATION_POLICY_FLAG = shiftl(1, 0)
    integer(kind=c_int), parameter, public :: CURLGSSAPI_DELEGATION_FLAG        = shiftl(1, 1)

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
    integer(kind=c_int), parameter, public :: CURLE_LAST                     = 100 ! never use this

    ! CURLversion
    integer(kind=c_int), parameter, public :: CURLVERSION_FIRST  = 0
    integer(kind=c_int), parameter, public :: CURLVERSION_SECOND = 1
    integer(kind=c_int), parameter, public :: CURLVERSION_THIRD  = 2
    integer(kind=c_int), parameter, public :: CURLVERSION_FOURTH = 3
    integer(kind=c_int), parameter, public :: CURLVERSION_FIFTH  = 4
    integer(kind=c_int), parameter, public :: CURLVERSION_LAST   = 5

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
    integer(kind=c_int), parameter, public :: CURLINFO_LASTONE                   = 62

    ! curl_version_info_data
    type, bind(c), public :: curl_version
        integer(kind=c_int)  :: age
        type(c_ptr)          :: version
        integer(kind=c_int)  :: version_num
        type(c_ptr)          :: host
        integer(kind=c_int)  :: features
        type(c_ptr)          :: ssl_version
        integer(kind=c_long) :: ssl_version_num
        type(c_ptr)          :: libz_version
        type(c_ptr)          :: protocols
        type(c_ptr)          :: ares
        integer(kind=c_int)  :: ares_num
        type(c_ptr)          :: libidn
        integer(kind=c_int)  :: iconv_ver_num
        type(c_ptr)          :: libssh_version
        integer(kind=c_int)  :: brotli_ver_num
        type(c_ptr)          :: brotli_version
        integer(kind=c_int)  :: nghttp2_ver_num
        type(c_ptr)          :: nghttp2_version
        type(c_ptr)          :: quic_version
    end type curl_version

    interface
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

        ! CURLcode curl_easy_perform(CURL *curl)
        function curl_easy_perform(curl) bind(c, name='curl_easy_perform')
            import :: c_int, c_ptr
            implicit none
            type(c_ptr), intent(in), value :: curl
            integer(kind=c_int)            :: curl_easy_perform
        end function curl_easy_perform

        ! CURLcode curl_easy_setopt(CURL *curl, CURLoption option, ...)
        function curl_easy_setopt_c_long(curl, option, parameter) bind(c, name='curl_easy_setopt')
            import :: c_int, c_long, c_ptr
            implicit none
            type(c_ptr),          intent(in), value :: curl
            integer(kind=c_int),  intent(in), value :: option
            integer(kind=c_long), intent(in), value :: parameter
            integer(kind=c_int)                     :: curl_easy_setopt_c_long
        end function curl_easy_setopt_c_long

        ! CURLcode curl_easy_setopt(CURL *curl, CURLoption option, ...)
        function curl_easy_setopt_c_ptr(curl, option, parameter) bind(c, name='curl_easy_setopt')
            import :: c_int, c_ptr
            implicit none
            type(c_ptr),         intent(in), value :: curl
            integer(kind=c_int), intent(in), value :: option
            type(c_ptr),         intent(in), value :: parameter
            integer(kind=c_int)                    :: curl_easy_setopt_c_ptr
        end function curl_easy_setopt_c_ptr

        ! CURLcode curl_easy_setopt(CURL *curl, CURLoption option, ...)
        function curl_easy_setopt_c_funptr(curl, option, parameter) bind(c, name='curl_easy_setopt')
            import :: c_funptr, c_int, c_ptr
            implicit none
            type(c_ptr),         intent(in), value :: curl
            integer(kind=c_int), intent(in), value :: option
            type(c_funptr),      intent(in), value :: parameter
            integer(kind=c_int)                    :: curl_easy_setopt_c_funptr
        end function curl_easy_setopt_c_funptr

        ! struct curl_slist *curl_slist_append(struct curl_slist *list, const char *string)
        function curl_slist_append(list, string) bind(c, name='curl_slist_append')
            import :: c_char, c_ptr
            implicit none
            type(c_ptr),            intent(in), value :: list
            character(kind=c_char), intent(in)        :: string
            type(c_ptr)                               :: curl_slist_append
        end function curl_slist_append

        ! const char *curl_easy_strerror(CURLcode code)
        function curl_easy_strerror_(code) bind(c, name='curl_easy_strerror')
            import :: c_int, c_ptr
            implicit none
            integer(kind=c_int), intent(in), value :: code
            type(c_ptr)                            :: curl_easy_strerror_
        end function curl_easy_strerror_

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

    interface
        ! size_t strlen(const char *str)
        function c_strlen(str) bind(c, name='strlen')
            import :: c_ptr, c_size_t
            implicit none
            type(c_ptr), intent(in), value :: str
            integer(kind=c_size_t)         :: c_strlen
        end function c_strlen
    end interface

    interface curl_easy_getinfo
        ! Fortran 2008 generic interface `curl_easy_getinfo()`.
        module procedure :: curl_easy_getinfo_char
        module procedure :: curl_easy_getinfo_double
        module procedure :: curl_easy_getinfo_int
        module procedure :: curl_easy_getinfo_long
        module procedure :: curl_easy_getinfo_ptr
    end interface

    interface curl_easy_setopt
        ! Fortran 2008 generic interface `curl_easy_setopt()`.
        module procedure :: curl_easy_setopt_char
        module procedure :: curl_easy_setopt_funptr
        module procedure :: curl_easy_setopt_int
        module procedure :: curl_easy_setopt_long
        module procedure :: curl_easy_setopt_ptr
    end interface

    public :: c_f_str_ptr
    public :: curl_easy_cleanup
    public :: curl_easy_getinfo
    public :: curl_easy_getinfo_
    public :: curl_easy_init
    public :: curl_easy_perform
    public :: curl_easy_setopt
    public :: curl_easy_setopt_char
    public :: curl_easy_setopt_funptr
    public :: curl_easy_setopt_int
    public :: curl_easy_setopt_long
    public :: curl_easy_setopt_ptr
    public :: curl_easy_strerror
    public :: curl_slist_append
    public :: curl_slist_free_all
    public :: curl_version_info
    public :: curl_version_now

    private :: copy
contains
    pure function copy(a)
        character, intent(in)  :: a(:)
        character(len=size(a)) :: copy
        integer(kind=i8)       :: i

        do i = 1, size(a)
            copy(i:i) = a(i)
        end do
    end function copy

    ! CURLcode curl_easy_getinfo(CURL *curl, CURLoption option, ...)
    function curl_easy_getinfo_char(curl, option, parameter) result(rc)
        type(c_ptr),                   intent(in)  :: curl
        integer,                       intent(in)  :: option
        character(len=:), allocatable, intent(out) :: parameter
        integer                                    :: rc
        type(c_ptr), target                        :: ptr

        ptr = c_null_ptr
        rc = curl_easy_getinfo_(curl, option, c_loc(ptr))
        if (rc == CURLE_OK .and. c_associated(ptr)) call c_f_str_ptr(ptr, parameter)
    end function curl_easy_getinfo_char

    ! CURLcode curl_easy_getinfo(CURL *curl, CURLoption option, ...)
    function curl_easy_getinfo_double(curl, option, parameter) result(rc)
        type(c_ptr),           intent(in)  :: curl
        integer,               intent(in)  :: option
        real(kind=r8), target, intent(out) :: parameter
        integer                            :: rc

        rc = curl_easy_getinfo_(curl, option, c_loc(parameter))
    end function curl_easy_getinfo_double

    ! CURLcode curl_easy_getinfo(CURL *curl, CURLoption option, ...)
    function curl_easy_getinfo_int(curl, option, parameter) result(rc)
        type(c_ptr),              intent(in)  :: curl
        integer    ,              intent(in)  :: option
        integer(kind=i4), target, intent(out) :: parameter
        integer                               :: rc

        rc = curl_easy_getinfo_(curl, option, c_loc(parameter))
    end function curl_easy_getinfo_int

    ! CURLcode curl_easy_getinfo(CURL *curl, CURLoption option, ...)
    function curl_easy_getinfo_long(curl, option, parameter) result(rc)
        type(c_ptr),              intent(in)  :: curl
        integer,                  intent(in)  :: option
        integer(kind=i8), target, intent(out) :: parameter
        integer                               :: rc

        rc = curl_easy_getinfo_(curl, option, c_loc(parameter))
    end function curl_easy_getinfo_long

    ! CURLcode curl_easy_getinfo(CURL *curl, CURLoption option, ...)
    function curl_easy_getinfo_ptr(curl, option, parameter) result(rc)
        type(c_ptr), intent(in)  :: curl
        integer,     intent(in)  :: option
        type(c_ptr), intent(out) :: parameter
        integer                  :: rc

        rc = curl_easy_getinfo_(curl, option, parameter)
    end function curl_easy_getinfo_ptr

    ! CURLcode curl_easy_setopt(CURL *curl, CURLoption option, ...)
    function curl_easy_setopt_char(curl, option, parameter) result(rc)
        type(c_ptr),              intent(in) :: curl
        integer,                  intent(in) :: option
        character(len=*), target, intent(in) :: parameter
        integer                              :: rc

        rc = curl_easy_setopt_c_ptr(curl, option, c_loc(parameter))
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
        integer    ,      intent(in) :: option
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
        type(c_ptr)                   :: ptr

        ptr = c_null_ptr
        ptr = curl_easy_strerror_(code)

        if (.not. c_associated(ptr)) then
            str = ''
            return
        end if

        call c_f_str_ptr(ptr, str)
    end function curl_easy_strerror

    ! curl_version_info_data *curl_version_info(CURLversion age)
    function curl_version_info(age)
        !! Wrapper for `curl_version_info_()` that converts the returned C
        !! pointer to Fortran pointer of derived type `curl_version` (a.k.a. C
        !! struct `curl_version_info_data`).
        integer, intent(in)         :: age
        type(curl_version), pointer :: curl_version_info
        type(c_ptr)                 :: ptr

        ptr = curl_version_info_(age)

        if (c_associated(ptr)) then
            call c_f_pointer(ptr, curl_version_info)
            return
        end if

        allocate (curl_version_info)
    end function curl_version_info

    subroutine c_f_str_ptr(c_str, f_str, size)
        !! Utility routine that copies a C string, passed as a C pointer, to a
        !! Fortran string.
        type(c_ptr),                   intent(in)           :: c_str
        character(len=:), allocatable, intent(out)          :: f_str
        integer(kind=i8),              intent(in), optional :: size

        character(kind=c_char), pointer :: ptrs(:)
        integer(kind=i8)                :: sz

        if (.not. c_associated(c_str)) return

        if (present(size)) then
            sz = size
        else
            sz = c_strlen(c_str)
        end if

        if (sz < 0) return
        call c_f_pointer(c_str, ptrs, [ sz ])
        allocate (character(len=sz) :: f_str)
        f_str = copy(ptrs)
    end subroutine c_f_str_ptr
end module curl
