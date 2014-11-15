USING: alien alien.c-types alien.enums alien.libraries
alien.syntax classes.struct combinators kernel math
system unix.types words ;

IN: curl.ffi

<< "curl" {
    { [ os macosx? ] [ "libcurl.dylib" ] }
    { [ os unix? ] [ "libcurl.so" ] }
} cond cdecl add-library >>

LIBRARY: curl

! curl.h

FUNCTION: c-string curl_version ( ) ;

FUNCTION: c-string curl_getenv ( c-string variable ) ;

CONSTANT: CURL_WRITEFUNC_PAUSE 0x10000001

ENUM: curlfiletype
    CURLFILETYPE_FILE
    CURLFILETYPE_DIRECTORY
    CURLFILETYPE_SYMLINK
    CURLFILETYPE_DEVICE_BLOCK
    CURLFILETYPE_DEVICE_CHAR
    CURLFILETYPE_NAMEDPIPE
    CURLFILETYPE_SOCKET
    CURLFILETYPE_DOOR
    CURLFILETYPE_UNKNOWN
;

ENUM: CURLcode
    CURLE_OK
    CURLE_UNSUPPORTED_PROTOCOL
    CURLE_FAILED_INIT
    CURLE_URL_MALFORMAT
    CURLE_NOT_BUILT_IN
    CURLE_COULDNT_RESOLVE_PROXY
    CURLE_COULDNT_RESOLVE_HOST
    CURLE_COULDNT_CONNECT
    CURLE_FTYP_WEIRD_SERVER_REPLY
    CURLE_REMOTE_ACCESS_DENIED
    CURLE_FTP_ACCEPT_FAILED
    CURLE_FTP_WEIRD_PASS_REPLY
    CURLE_FTP_ACCEPT_TIMEOUT
    CURLE_FTP_WEIRD_PASV_REPLY
    CURLE_FTP_WEIRD_227_FORMAT
    CURLE_FTP_CANT_GET_HOST
    CURLE_OBSOLETE16
    CURLE_FTP_COULDNT_SET_TYPE
    CURLE_PARTIAL_FILE
    CURLE_FTP_COULDNT_RETR_FILE
    CURLE_OBSOLETE20
    CURLE_QUOTE_ERROR
    CURLE_HTTP_RETURNED_ERROR
    CURLE_WRITE_ERROR
    CURLE_OBSOLETE24
    CURLE_UPLOAD_FAILED
    CURLE_READ_ERROR
    CURLE_OUT_OF_MEMORY
    CURLE_OPERATION_TIMEOUT
    CURLE_OBSOLETE29
    CURLE_FTP_PORT_FAILED
    CURLE_FTP_COULDNT_USE_REST
    CURLE_OBSOLETE32
    CURLE_RANGE_ERROR
    CURLE_HTTP_POST_ERROR
    CURLE_SSL_CONNECT_ERROR
    CURLE_BAD_DOWNLOAD_RESUME
    CURLE_FILE_COULDNT_READ_FILE
    CURLE_LDAP_CANNOT_BIND
    CURLE_LDAP_SEARCH_FAILED
    CURLE_OBSOLETE40
    CURLE_FUNCTION_NOT_FOUND
    CURLE_ABORTED_BY_CALLBACK
    CURLE_BAD_FUNCTION_ARGUMENT
    CURLE_OBSOLETE44
    CURLE_INTERFACE_FAILED
    CURLE_OBSOLETE46
    CURLE_TOO_MANY_REDIRECTS
    CURLE_UNKNOWN_OPTION
    CURLE_TELNET_OPTION_SYNTAX
    CURLE_OBSOLETE50
    CURLE_PEER_FAILED_VERIFICATION
    CURLE_GOT_NOTHING
    CURLE_SSL_ENGINE_NOTFOUND
    CURLE_SSL_ENGINE_SETFAILED
    CURLE_SEND_ERROR
    CURLE_RECV_ERROR
    CURLE_OBSOLETE57
    CURLE_SSL_CERTPROBLEM
    CURLE_SSL_CIPHER
    CURLE_SSL_CACERT
    CURLE_BAD_CONTENT_ENCODING
    CURLE_LDAP_INVALID_URL
    CURLE_FILESIZE_EXCEEDED
    CURLE_USE_SSL_FAILED
    CURLE_SEND_FAIL_REWIND
    CURLE_SSL_ENGINE_INITFAILED
    CURLE_LOGIN_DENIED
    CURLE_TFTP_NOTFOUND
    CURLE_TFTP_PERM
    CURLE_REMOTE_DISK_FULL
    CURLE_TFTP_ILLEGAL
    CURLE_TFTP_UNKNOWNID
    CURLE_REMOTE_FILE_EXISTS
    CURLE_TFTP_NOSUCHUSER
    CURLE_CONV_FAILED
    CURLE_CONV_REQD
    CURLE_SSL_CACERT_BADFILE
    CURLE_REMOTE_FILE_NOT_FOUND
    CURLE_SSH
    CURLE_SSL_SHUTDOWN_FAILED
    CURLE_AGAIN
    CURLE_SSL_CRL_BADFILE
    CURLE_SSL_ISSUER_ERROR
    CURLE_FTP_PRET_FAILED
    CURLE_RTSP_CSEQ_ERROR
    CURLE_RTSP_SESSION_ERROR
    CURLE_FTP_BAD_FILE_LIST
    CURLE_CHUNK_FAILED
    CURLE_NO_CONNECTION_AVAILABLE
;

ENUM: CURLoption
    { CURLOPT_FILE 10001 }
    { CURLOPT_URL 10002 }
    { CURLOPT_PORT 3 }
    { CURLOPT_PROXY 10004 }
    { CURLOPT_USERPWD 10005 }
    { CURLOPT_PROXYUSERPWD 10006 }
    { CURLOPT_RANGE 10007 }
    { CURLOPT_INFILE 10009 }
    { CURLOPT_ERRORBUFFER 10010 }
    { CURLOPT_WRITEFUNCTION 20011 }
    { CURLOPT_READFUNCTION 20012 }
    { CURLOPT_TIMEOUT 13 }
    { CURLOPT_INFILESIZE 14 }
    { CURLOPT_POSTFIELDS 10015 }
    { CURLOPT_REFERER 10016 }
    { CURLOPT_FTPPORT 10017 }
    { CURLOPT_USERAGENT 10018 }
    { CURLOPT_LOW_SPEED_LIMIT 19 }
    { CURLOPT_LOW_SPEED_TIME 20 }
    { CURLOPT_RESUME_FROM 21 }
    { CURLOPT_COOKIE 10022 }
    { CURLOPT_HTTPHEADER 10023 }
    { CURLOPT_HTTPPOST 10024 }
    { CURLOPT_SSLCERT 10025 }
    { CURLOPT_KEYPASSWD 10026 }
    { CURLOPT_CRLF 27 }
    { CURLOPT_QUOTE 10028 }
    { CURLOPT_WRITEHEADER 10029 }
    { CURLOPT_COOKIEFILE 10031 }
    { CURLOPT_SSLVERSION 32 }
    { CURLOPT_TIMECONDITION 33 }
    { CURLOPT_TIMEVALUE 34 }
    { CURLOPT_CUSTOMREQUEST 10036 }
    { CURLOPT_STDERR 10037 }
    { CURLOPT_POSTQUOTE 10039 }
    { CURLOPT_WRITEINFO 10040 }
    { CURLOPT_VERBOSE 41 }
    { CURLOPT_HEADER 42 }
    { CURLOPT_NOPROGRESS 43 }
    { CURLOPT_NOBODY 44 }
    { CURLOPT_FAILONERROR 45 }
    { CURLOPT_UPLOAD 46 }
    { CURLOPT_POST 47 }
    { CURLOPT_DIRLISTONLY 48 }
    { CURLOPT_APPEND 50 }
    { CURLOPT_NETRC 51 }
    { CURLOPT_FOLLOWLOCATION 52 }
    { CURLOPT_TRANSFERTEXT 53 }
    { CURLOPT_PUT 54 }
    { CURLOPT_PROGRESSFUNCTION 20056 }
    { CURLOPT_PROGRESSDATA 10057 }
    { CURLOPT_AUTOREFERER 58 }
    { CURLOPT_PROXYPORT 59 }
    { CURLOPT_POSTFIELDSIZE 60 }
    { CURLOPT_HTTPPROXYTUNNEL 61 }
    { CURLOPT_INTERFACE 10062 }
    { CURLOPT_KRBLEVEL 10063 }
    { CURLOPT_SSL_VERIFYPEER 64 }
    { CURLOPT_CAINFO 10065 }
    { CURLOPT_MAXREDIRS 68 }
    { CURLOPT_FILETIME 69 }
    { CURLOPT_TELNETOPTIONS 10070 }
    { CURLOPT_MAXCONNECTS 71 }
    { CURLOPT_CLOSEPOLICY 72 }
    { CURLOPT_FRESH_CONNECT 74 }
    { CURLOPT_FORBID_REUSE 75 }
    { CURLOPT_RANDOM_FILE 10076 }
    { CURLOPT_EGDSOCKET 10077 }
    { CURLOPT_CONNECTTIMEOUT 78 }
    { CURLOPT_HEADERFUNCTION 20079 }
    { CURLOPT_HTTPGET 80 }
    { CURLOPT_SSL_VERIFYHOST 81 }
    { CURLOPT_COOKIEJAR 10082 }
    { CURLOPT_SSL_CIPHER_LIST 10083 }
    { CURLOPT_HTTP_VERSION 84 }
    { CURLOPT_FTP_USE_EPSV 85 }
    { CURLOPT_SSLCERTTYPE 10086 }
    { CURLOPT_SSLKEY 10087 }
    { CURLOPT_SSLKEYTYPE 10088 }
    { CURLOPT_SSLENGINE 10089 }
    { CURLOPT_SSLENGINE_DEFAULT 90 }
    { CURLOPT_DNS_USE_GLOBAL_CACHE 91 }
    { CURLOPT_DNS_CACHE_TIMEOUT 92 }
    { CURLOPT_PREQUOTE 10093 }
    { CURLOPT_DEBUGFUNCTION 20094 }
    { CURLOPT_DEBUGDATA 10095 }
    { CURLOPT_COOKIESESSION 96 }
    { CURLOPT_CAPATH 10097 }
    { CURLOPT_BUFFERSIZE 98 }
    { CURLOPT_NOSIGNAL 99 }
    { CURLOPT_SHARE 10100 }
    { CURLOPT_PROXYTYPE 101 }
    { CURLOPT_ACCEPT_ENCODING 10102 }
    { CURLOPT_PRIVATE 10103 }
    { CURLOPT_HTTP200ALIASES 10104 }
    { CURLOPT_UNRESTRICTED_AUTH 105 }
    { CURLOPT_FTP_USE_EPRT 106 }
    { CURLOPT_HTTPAUTH 107 }
    { CURLOPT_SSL_CTX_FUNCTION 20108 }
    { CURLOPT_SSL_CTX_DATA 10109 }
    { CURLOPT_FTP_CREATE_MISSING_DIRS 110 }
    { CURLOPT_PROXYAUTH 111 }
    { CURLOPT_SERVER_RESPONSE_TIMEOUT 112 }
    { CURLOPT_IPRESOLVE 113 }
    { CURLOPT_MAXFILESIZE 114 }
    { CURLOPT_INFILESIZE_LARGE 30115 }
    { CURLOPT_RESUME_FROM_LARGE 30116 }
    { CURLOPT_MAXFILESIZE_LARGE 30117 }
    { CURLOPT_NETRC_FILE 10118 }
    { CURLOPT_USE_SSL 119 }
    { CURLOPT_POSTFIELDSIZE_LARGE 30120 }
    { CURLOPT_TCP_NODELAY 121 }
    { CURLOPT_FTPSSLAUTH 129 }
    { CURLOPT_IOCTLFUNCTION 20130 }
    { CURLOPT_IOCTLDATA 10131 }
    { CURLOPT_FTP_ACCOUNT 10134 }
    { CURLOPT_COOKIELIST 10135 }
    { CURLOPT_IGNORE_CONTENT_LENGTH 136 }
    { CURLOPT_FTP_SKIP_PASV_IP 137 }
    { CURLOPT_FTP_FILEMETHOD 138 }
    { CURLOPT_LOCALPORT 139 }
    { CURLOPT_LOCALPORTRANGE 140 }
    { CURLOPT_CONNECT_ONLY 141 }
    { CURLOPT_CONV_FROM_NETWORK_FUNCTION 20142 }
    { CURLOPT_CONV_TO_NETWORK_FUNCTION 20143 }
    { CURLOPT_CONV_FROM_UTF8_FUNCTION 20144 }
    { CURLOPT_MAX_SEND_SPEED_LARGE 30145 }
    { CURLOPT_MAX_RECV_SPEED_LARGE 30146 }
    { CURLOPT_FTP_ALTERNATIVE_TO_USER 10147 }
    { CURLOPT_SOCKOPTFUNCTION 20148 }
    { CURLOPT_SOCKOPTDATA 10149 }
    { CURLOPT_SSL_SESSIONID_CACHE 150 }
    { CURLOPT_SSH_AUTH_TYPES 151 }
    { CURLOPT_SSH_PUBLIC_KEYFILE 10152 }
    { CURLOPT_SSH_PRIVATE_KEYFILE 10153 }
    { CURLOPT_FTP_SSL_CCC 154 }
    { CURLOPT_TIMEOUT_MS 155 }
    { CURLOPT_CONNECTTIMEOUT_MS 156 }
    { CURLOPT_HTTP_TRANSFER_DECODING 157 }
    { CURLOPT_HTTP_CONTENT_DECODING 158 }
    { CURLOPT_NEWFILE_PERMS 159 }
    { CURLOPT_NEW_DIRECTORY_PERMS 160 }
    { CURLOPT_POSTREDIR 161 }
    { CURLOPT_SSH_HOST_PUBLIC_KEY_MD5 10162 }
    { CURLOPT_OPENSOCKETFUNCTION 20163 }
    { CURLOPT_OPENSOCKETDATA 10164 }
    { CURLOPT_COPYPOSTFIELD 10165 }
    { CURLOPT_PROXY_TRANSFER_MODE 166 }
    { CURLOPT_SEEKFUNCTION 20167 }
    { CURLOPT_SEEKDATA 10168 }
    { CURLOPT_CRLFILE 10169 }
    { CURLOPT_ISSUERCERT 10170 }
    { CURLOPT_ADDRESS_SCOPE 171 }
    { CURLOPT_CERTINFO 172 }
    { CURLOPT_USERNAME 10173 }
    { CURLOPT_PASSWORD 10174 }
    { CURLOPT_PROXYUSERNAME 10175 }
    { CURLOPT_PROXYPASSWORD 10176 }
    { CURLOPT_NOPROXY 10177 }
    { CURLOPT_TFTP_BLKSIZE 178 }
    { CURLOPT_SOCKS5_GSSAPI_SERVICE 10179 }
    { CURLOPT_SOCKS5_GSSAPI_NEC 10180 }
    { CURLOPT_PROTOCOLS 181 }
    { CURLOPT_REDIR_PROTOCOLS 182 }
    { CURLOPT_SSH_KNOWNHOSTS 10183 }
    { CURLOPT_SSH_KEYFUNCTION 20184 }
    { CURLOPT_SSH_KEYDATA 10185 }
    { CURLOPT_MAIL_FROM 10186 }
    { CURLOPT_MAIL_RCPT 10187 }
    { CURLOPT_FTP_USE_PRET 188 }
    { CURLOPT_RTSP_REQUEST 189 }
    { CURLOPT_RTSP_SESSION_ID 10190 }
    { CURLOPT_RTSP_STREAM_URI 10191 }
    { CURLOPT_RTSP_TRANSPORT 10192 }
    { CURLOPT_RTSP_CLIENT_CSEQ 193 }
    { CURLOPT_RTSP_SERVER_CSEQ 194 }
    { CURLOPT_INTERLEAVEDATA 10195 }
    { CURLOPT_INTERLEAVEFUNCTION 20196 }
    { CURLOPT_WILDCARDMATCH 197 }
    { CURLOPT_CHUNK_BGN_FUNCTION 20198 }
    { CURLOPT_CHUNK_END_FUNCTION 20199 }
    { CURLOPT_FNMATCH_FUNCTION 20200 }
    { CURLOPT_CHUNK_DATA 10201 }
    { CURLOPT_FNMATCH_DATA 10202 }
    { CURLOPT_RESOLVE 10203 }
    { CURLOPT_TLSAUTH_USERNAME 10204 }
    { CURLOPT_TLSAUTH_PASSWORD 10205 }
    { CURLOPT_TLSAUTH_TYPE 10206 }
    { CURLOPT_TRANSFER_ENCODING 207 }
    { CURLOPT_CLOSESOCKETFUNCTION 20208 }
    { CURLOPT_CLOSESOCKETDATA 10209 }
    { CURLOPT_GSSAPI_DELEGATION 210 }
    { CURLOPT_DNS_SERVERS 10211 }
    { CURLOPT_ACCEPTTIMEOUT_MS 212 }
    { CURLOPT_TCP_KEEPALIVE 213 }
    { CURLOPT_TCP_KEEPIDLE 214 }
    { CURLOPT_TCP_KEEPINTVL 215 }
    { CURLOPT_SSL_OPTIONS 216 }
    { CURLOPT_MAIL_AUTH 10217 }
;

ALIAS: CURLOPT_WRITEDATA CURLOPT_FILE
ALIAS: CURLOPT_READDATA CURLOPT_INFILE
ALIAS: CURLOPT_HEADERDATA CURLOPT_WRITEHEADER
ALIAS: CURLOPT_RTSPHEADER CURLOPT_HTTPHEADER

! easy.h

TYPEDEF: void CURL
TYPEDEF: int64_t curl_off_t

FUNCTION: CURL* curl_easy_init ( ) ;

FUNCTION-ALIAS: curl_easy_setopt_long
    CURLcode curl_easy_setopt ( CURL* curl, CURLoption option, long value ) ;

FUNCTION-ALIAS: curl_easy_setopt_string
    CURLcode curl_easy_setopt ( CURL* curl, CURLoption option, c-string value ) ;

FUNCTION-ALIAS: curl_easy_setopt_pointer
    CURLcode curl_easy_setopt ( CURL* curl, CURLoption option, void* value ) ;

FUNCTION-ALIAS: curl_easy_setopt_curl_off_t
    CURLcode curl_easy_setopt ( CURL* curl, CURLoption option, curl_off_t value ) ;

FUNCTION: CURLcode curl_easy_perform ( CURL* curl ) ;

FUNCTION: void curl_easy_cleanup ( CURL* curl ) ;

FUNCTION: c-string curl_easy_escape ( CURL* curl, c-string string, int length ) ;

FUNCTION: c-string curl_easy_unescape ( CURL* handle, c-string string, int length, int* outlength ) ;

: curl_easy_setopt ( curl option value -- code )
    over enum>number {
        { [ dup 30000 > ] [ drop curl_easy_setopt_curl_off_t ] }
        { [ dup 20000 > ] [ drop curl_easy_setopt_pointer ] }
        { [ dup 10000 > ] [ drop curl_easy_setopt_string ] }
        [ drop curl_easy_setopt_long ]
    } cond ;

CALLBACK: size_t write_callback ( char *buffer, size_t size, size_t nitems, void *outstream ) ;

CALLBACK: long chunk_bgn_callback ( void* transfer_info, void* ptr, int remains ) ;

CALLBACK: long chunk_end_callback ( void* ptr ) ;

CALLBACK: int fnmatch_callback ( void* ptr, c-string pattern, c-string string ) ;

CALLBACK: int seek_callback ( void* instream, curl_off_t offset, int origin ) ;

CALLBACK: size_t read_callback ( char* buffer, size_t size, size_t nitems, void* instream ) ;

ENUM: curlsocktype
    CURLSOCKTYPE_IPCXN
    CURLSOCKTYPE_ACCEPT
    CURLSOCKTYPE_LAST
;

CONSTANT: CURL_SOCKOPT_OK 0
CONSTANT: CURL_SOCKOPT_ERROR 1
CONSTANT: CURL_SOCKOPT_ALREADY_CONNECTED 2

TYPEDEF: int curl_socket_t

CALLBACK: int sockopt_callback ( void* clientp, curl_socket_t curlfd, curlsocktype purpose ) ;

STRUCT: curl_sockaddr
    { family int }
    { socktype int }
    { protocol int }
    { addrlen uint }
;

CALLBACK: curl_socket_t opensocket_callback ( void* clientp, curlsocktype purpose, curl_sockaddr* address ) ;

CALLBACK: int closesocket_callback ( void* clientp, curl_socket_t item ) ;

ENUM: curlioerr
    CURLIOE_OK
    CURLIOE_UNKNOWNCMD
    CURLIOE_FAILRESTART
    CURLIOE_LAST
;

ENUM: curliocmd
    CURLIOCMD_NOP
    CURLIOCMD_RESTARTREAD
    CURLIOCMD_LAST
;

CALLBACK: curlioerr ioctl_callback ( CURL* handle, int cmd, void* clientp ) ;

CALLBACK: void* malloc_callback ( size_t size ) ;
CALLBACK: void free_callback ( void* ptr ) ;
CALLBACK: void* realloc_callback ( void* ptr, size_t size ) ;
CALLBACK: char* strdup_callback ( char* str ) ;
CALLBACK: void* calloc_callback ( size_t nmemb, size_t size ) ;

ENUM: curl_infotype
    CURLINFO_TEXT
    CURLINFO_HEADER_IN
    CURLINFO_HEADER_OUT
    CURLINFO_DATA_IN
    CURLINFO_DATA_OUT
    CURLINFO_SSL_DATA_IN
    CURLINFO_SSL_DATA_OUT
    CURLINFO_END
;

CALLBACK: int debug_callback ( CURL* handle, curl_infotype type, char* data, size_t size, void* userptr ) ;

CALLBACK: CURLcode conv_callback ( char* buffer, size_t length ) ;

CALLBACK: CURLcode ssl_ctx_callback ( CURL* curl, void* ssl_ctx, void* userptr ) ;

ENUM: curl_proxytype
    { CURLPROXY_HTTP 0 }
    { CURLPROXY_HTTP_1_0 1 }
    { CURLPROXY_SOCKS4 4 }
    { CURLPROXY_SOCKS5 5 }
    { CURLPROXY_SOCKS4A 6 }
    { CURLPROXY_SOCKS5_HOSTNAME 7 }
;

! multi.h
