#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

/* define int64_t and uint64_t when using MinGW compiler */
#ifdef __MINGW32__
#include <stdint.h>
#endif

/* define int64_t and uint64_t when using MS compiler */
#ifdef _MSC_VER
#include <stdlib.h>
typedef __int64 int64_t;
typedef unsigned __int64 uint64_t;
#endif

#include "xxhash.h"
#include <inttypes.h>
#include <stdio.h>

MODULE = Crypt::xxHash  PACKAGE = Crypt::xxHash 

PROTOTYPES: DISABLE

U32
xxhash32( const char *input, int length(input), UV seed )
    CODE:
        RETVAL = XXH32(input, STRLEN_length_of_input, seed);
    OUTPUT:
        RETVAL

UV
xxhash64( const char *input, int length(input), UV seed )
    CODE:
        RETVAL = (UV) XXH64(input, STRLEN_length_of_input, seed);
    OUTPUT:
        RETVAL

UV
xxhash3_64bits( const char *input, int length(input), UV seed )
    CODE:
        RETVAL = (UV) XXH3_64bits_withSeed(input, STRLEN_length_of_input, seed);
    OUTPUT:
        RETVAL

char*
xxhash32_hex ( const char *input, int length(input), UV seed )
    CODE:
        static char value32[9];
        sprintf(value32, "%08x", (uint32_t) XXH32(input, STRLEN_length_of_input, seed) );
        RETVAL = value32;
    OUTPUT:
        RETVAL

char*
xxhash64_hex( const char *input, int length(input), UV seed )
    CODE:
        static char value64[17];
        sprintf(value64, "%016"PRIx64, (uint64_t) XXH64(input, STRLEN_length_of_input, seed) );
        RETVAL = value64;
    OUTPUT:
        RETVAL

char*
xxhash3_64bits_hex( const char *input, int length(input), UV seed )
    CODE:
        static char value64[17];
        sprintf(value64, "%016"PRIx64, (uint64_t) XXH3_64bits_withSeed(input, STRLEN_length_of_input, seed) );
        RETVAL = value64;
    OUTPUT:
        RETVAL

char*
xxhash3_128bits_hex( const char *input, int length(input), UV seed )
    CODE:
        static char value64[33];
        XXH128_hash_t hash = XXH3_128bits_withSeed(input, STRLEN_length_of_input, seed);
        sprintf(value64, "%016"PRIx64"%016"PRIx64, (uint64_t) hash.high64, (uint64_t) hash.low64 );
        RETVAL = value64;
    OUTPUT:
        RETVAL
