#! @System ConstructibleSets

LoadPackage( "ZariskiFrames" );

#! @Example
LoadPackage( "RingsForHomalg" );
#! true
Q := HomalgFieldOfRationalsInSingular( );
#! Q
R := Q * "x,y";
#! Q[x,y]
I := HomalgMatrix( "y", 1, 1, R );
#! <A 1 x 1 matrix over an external ring>
x := ClosedSubsetOfSpec( I );
#! V_{Q[x,y]}( <...> )
IsClosed( x );
#! true
J := HomalgMatrix( "x", 1, 1, R );
#! <A 1 x 1 matrix over an external ring>
y := ClosedSubsetOfSpec( J );
#! V_{Q[x,y]}( <...> )
K := HomalgMatrix( "x+y-1", 1, 1, R );
#! <A 1 x 1 matrix over an external ring>
d := ClosedSubsetOfSpec( K );
#! V_{Q[x,y]}( <...> )
xuy := x + y;
#! V_{Q[x,y]}( <...> )
IsClosed( xuy );
#! true
mxuy := -xuy;
#! V_{Q[x,y]}( I ) \ V_{Q[x,y]}( J )
IsClosed( mxuy );
#! false
IsOpen( mxuy );
#! true
e := -d;
#! V_{Q[x,y]}( I ) \ V_{Q[x,y]}( J )
Display( e );
#! V( <> ) \ V( <x+y-1> )
xmy := x - y;
#! V_{Q[x,y]}( I ) \ V_{Q[x,y]}( J )
Display( xmy );
#! V( <y> ) \ V( <x> )
xmy2 := xmy - y;
#! V_{Q[x,y]}( I ) \ V_{Q[x,y]}( J )
Display( xmy2 );
#! V( <y> ) \ V( <x> )
lc := xuy - d;
#! V_{Q[x,y]}( I ) \ V_{Q[x,y]}( J )
lc0 := lc - 0;
#! V_{Q[x,y]}( I ) \ V_{Q[x,y]}( J )
IsIdenticalObj( lc, lc0 );
#! true
IsLocallyClosed( lc );
#! true
IsClosed( lc );
#! false
c := lc + d * xuy;
#! ( V_{Q[x,y]}( I1 ) \ V_{Q[x,y]}( J1 ) ) + ( V_{Q[x,y]}( I2 ) \ V_{Q[x,y]}( J2 ) )
c0 := c - 0;
#! ( V_{Q[x,y]}( I1 ) \ V_{Q[x,y]}( J1 ) ) + ( V_{Q[x,y]}( I2 ) \ V_{Q[x,y]}( J2 ) )
IsIdenticalObj( c, c0 );
#! true
c[1];
#! V_{Q[x,y]}( I ) \ V_{Q[x,y]}( J )
c[2];
#! V_{Q[x,y]}( I ) \ V_{Q[x,y]}( J )
c = xuy;
#! true
cc := CanonicalObject( c );
#! V_{Q[x,y]}( <...> )
cc = xuy;
#! true
t := c - lc;
#! ( V_{Q[x,y]}( I1 ) \ V_{Q[x,y]}( J1 ) ) + ( V_{Q[x,y]}( I2 ) \ V_{Q[x,y]}( J2 ) ) +
#! ( V_{Q[x,y]}( I3 ) \ V_{Q[x,y]}( J3 ) ) + ( V_{Q[x,y]}( I4 ) \ V_{Q[x,y]}( J4 ) )
IsClosed( t );
#! true
t := StandardObject( t );
#! ( V_{Q[x,y]}( I1 ) \ V_{Q[x,y]}( J1 ) )
Display( t );
#! V( <x+y-1,y^2-y> ) \ 0
z := c - c;
#! ( V_{Q[x,y]}( I1 ) \ V_{Q[x,y]}( J1 ) ) + ( V_{Q[x,y]}( I2 ) \ V_{Q[x,y]}( J2 ) ) +
#! ( V_{Q[x,y]}( I3 ) \ V_{Q[x,y]}( J3 ) ) + ( V_{Q[x,y]}( I4 ) \ V_{Q[x,y]}( J4 ) ) +
#! ( V_{Q[x,y]}( I5 ) \ V_{Q[x,y]}( J5 ) ) + ( V_{Q[x,y]}( I6 ) \ V_{Q[x,y]}( J6 ) ) +
#! ( V_{Q[x,y]}( I7 ) \ V_{Q[x,y]}( J7 ) ) + ( V_{Q[x,y]}( I8 ) \ V_{Q[x,y]}( J8 ) )
z := StandardObject( z );
#! ( V_{Q[x,y]}( I1 ) \ V_{Q[x,y]}( J1 ) )
Display( z );
#! 0 \ 0
#! @EndExample
