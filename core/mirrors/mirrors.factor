! Copyright (C) 2007, 2008 Slava Pestov.
! See http://factorcode.org/license.txt for BSD license.
USING: assocs hashtables kernel sequences generic words
arrays classes slots slots.private classes.tuple math vectors
quotations accessors combinators ;
IN: mirrors

TUPLE: mirror { object read-only } ;

C: <mirror> mirror

: object-slots ( mirror -- slots ) object>> class all-slots ; inline

M: mirror at*
    [ nip object>> ] [ object-slots slot-named ] 2bi
    dup [ offset>> slot t ] [ 2drop f f ] if ;

: check-set-slot ( val slot -- val offset )
    {
        { [ dup not ] [ "No such slot" throw ] }
        { [ dup read-only>> ] [ "Read only slot" throw ] }
        { [ 2dup class>> instance? not ] [ class>> bad-slot-value ] }
        [ offset>> ]
    } cond ; inline

M: mirror set-at ( val key mirror -- )
    [ object-slots slot-named check-set-slot ] [ object>> ] bi
    swap set-slot ;

M: mirror delete-at ( key mirror -- )
    f -rot set-at ;

M: mirror clear-assoc ( mirror -- )
    [ object>> ] [ object-slots ] bi [
        [ initial>> ] [ offset>> ] bi swapd set-slot
    ] with each ;

M: mirror >alist ( mirror -- alist )
    [ object-slots [ [ name>> ] map ] [ [ offset>> ] map ] bi ]
    [ object>> [ swap slot ] curry ] bi
    map zip ;

M: mirror assoc-size mirror-slots length ;

INSTANCE: mirror assoc

GENERIC: make-mirror ( obj -- assoc )
M: hashtable make-mirror ;
M: integer make-mirror drop f ;
M: array make-mirror <enum> ;
M: vector make-mirror <enum> ;
M: quotation make-mirror <enum> ;
M: object make-mirror <mirror> ;
