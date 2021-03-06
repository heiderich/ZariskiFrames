#
# ZariskiFrames: (Co)frames/Locales of Zariski closed/open subsets
#
# Implementations
#

SetInfoLevel( InfoZariskiFrames, 1 );

##
InstallGlobalFunction( ITERATED_INTERSECTION_OF_IDEALS_USING_CategoryOfRows,
  function( L )
    local biased_weak_fiber_product;
    
    if Length( L ) = 1 then
        return L[1];
    fi;
    
    biased_weak_fiber_product := function( I, J )
        return PreCompose( ProjectionOfBiasedWeakFiberProduct( I, J ), I );
    end;
    
    return Iterated( L, biased_weak_fiber_product );
    
end );

##
InstallGlobalFunction( INTERSECTION_OF_IDEALS_USING_CategoryOfRows,
  function( L )
    local id;
    
    if Length( L ) = 1 then
        return L[1];
    fi;
    
    id := IdentityMorphism( Range( L[1] ) );
    
    id := ListWithIdenticalEntries( Length( L ), id );
    
    id := UniversalMorphismIntoDirectSum( id );
    
    L := DirectSumFunctorial( L );
    
    return ProjectionOfBiasedWeakFiberProduct( id, L );
    
end );

##
InstallMethod( ListOfMorphismsOfRank1RangeOfUnderlyingCategory,
        "for an object in a Zariski frame or coframe",
        [ IsObjectInZariskiFrameOrCoframe and HasPreMorphismOfUnderlyingCategory ],

  function( A )
    local g, R, C, D;
    
    A := PreMorphismOfUnderlyingCategory( A );
    
    g := RankOfObject( Range( A ) );
    
    R := CategoryOfRowsObject( 1, CapCategory( A ) );
    
    if g = 0 then
        return [ IdentityMorphism( R ) ];
    elif g = 1 then
        return [ A ];
    fi;
    
    D := ListWithIdenticalEntries( g, R );
    
    A := List( [ 1 .. g ], i -> PreCompose( A, ProjectionInFactorOfDirectSum( D, i ) ) );
    
    A := DuplicateFreeList( A );
    
    return A;
    
end );

##
InstallMethod( ListOfMorphismsOfRank1RangeOfUnderlyingCategory,
        "for an object in a Zariski frame or coframe",
        [ IsObjectInZariskiFrameOrCoframe and HasListOfReducedMorphismsOfUnderlyingCategory ],

  ListOfReducedMorphismsOfUnderlyingCategory );

##
InstallMethod( ListOfMorphismsOfRank1RangeOfUnderlyingCategory,
        "for an object in a Zariski frame or coframe",
        [ IsObjectInZariskiFrameOrCoframe and HasReducedMorphismOfUnderlyingCategory ],

  function( A )
    
    return [ ReducedMorphismOfUnderlyingCategory( A ) ];
    
end );

##
InstallMethod( ListOfMorphismsOfRank1RangeOfUnderlyingCategory,
        "for an object in a Zariski frame or coframe",
        [ IsObjectInZariskiFrameOrCoframe and HasStandardMorphismOfUnderlyingCategory ],

  function( A )
    
    return [ StandardMorphismOfUnderlyingCategory( A ) ];
    
end );

##
InstallMethod( ReducedMorphismOfUnderlyingCategory,
        "for an object in a Zariski frame or coframe",
        [ IsObjectInZariskiFrameOrCoframe ],

  function( A )
    
    A := ListOfReducedMorphismsOfUnderlyingCategory( A );
    
    return ITERATED_INTERSECTION_OF_IDEALS_USING_CategoryOfRows( A );
    
end );

##
InstallMethod( ReducedMorphismOfUnderlyingCategory,
        "for an object in a Zariski frame or coframe",
        [ IsObjectInZariskiFrameOrCoframe and HasStandardMorphismOfUnderlyingCategory ],

  StandardMorphismOfUnderlyingCategory );

##
InstallMethod( MorphismOfUnderlyingCategory,
        "for an object in a Zariski frame or coframe",
        [ IsObjectInZariskiFrameOrCoframe ],

  ReducedMorphismOfUnderlyingCategory );

##
InstallMethod( StandardMorphismOfUnderlyingCategory,
        "for an object in a Zariski frame or coframe",
        [ IsObjectInZariskiFrameOrCoframe ],

  function( A )
    local mat;
    
    mat := UnderlyingMatrix( ReducedMorphismOfUnderlyingCategory( A ) );
    
    return AsCategoryOfRowsMorphism( BasisOfRows( mat ) );
    
end );

##
InstallMethod( MorphismOfUnderlyingCategory,
        "for an object in a Zariski frame or coframe",
        [ IsObjectInZariskiFrameOrCoframe and HasStandardMorphismOfUnderlyingCategory ],

  StandardMorphismOfUnderlyingCategory );

##
InstallGlobalFunction( ADD_COMMON_METHODS_FOR_FRAMES_AND_COFRAMES_DEFINED_USING_CategoryOfRows,
  function( zariski_frame_or_coframe )
    
    ##
    AddIsWellDefinedForObjects( zariski_frame_or_coframe,
      function( A )
        
        A := MorphismOfUnderlyingCategory( A );
        
        return IsWellDefined( A );
        
    end );
    
end );

##
InstallMethod( IsSubset,
        "for an object in a Zariski frame and an object in a Zariski coframe",
        [ IsObjectInZariskiFrame, IsObjectInZariskiCoframe ],
        
  function( A, B )
    
    return IsHomSetInhabited( B, AsDifferenceOfClosed( A ) );
    
end );

##
InstallMethod( IsSubset,
        "for an object in a Zariski coframe and an object in a Zariski frame",
        [ IsObjectInZariskiCoframe, IsObjectInZariskiFrame ],
        
  function( A, B )
    
    return IsHomSetInhabited( AsDifferenceOfClosed( B ), A );
    
end );

##
InstallMethod( IsSubset,
        "for two objects in a Zariski frame or coframe",
        [ IsObjectInZariskiFrameOrCoframe, IsObjectInZariskiFrameOrCoframe ],
        
  function( A, B )
    
    return IsHomSetInhabited( B, A );
    
end );

##
InstallMethod( \=,
        "for an object in a Zariski frame and an object in a Zariski coframe",
        [ IsObjectInZariskiFrame, IsObjectInZariskiCoframe ],
        
  function( A, B )
    
    return AsDifferenceOfClosed( A ) = B;
    
end );

##
InstallMethod( \=,
        "for an object in a Zariski coframe and an object in a Zariski frame",
        [ IsObjectInZariskiCoframe, IsObjectInZariskiFrame ],
        
  function( A, B )
    
    return A = AsDifferenceOfClosed( B );
    
end );

##
InstallMethod( IsClosed,
        "for an object in a Zariski frame or coframe",
        [ IsObjectInZariskiFrameOrCoframe ],
        
  IsClosedSubobject );

##
InstallMethod( NormalizeObject,
        "for an object in a Zariski frame or coframe",
        [ IsObjectInZariskiFrameOrCoframe ],
        
  function( A )
    
    ReducedMorphismOfUnderlyingCategory( A );
    
    IsInitial( A );
    IsTerminal( A );
    
    return A;
    
end );

##
InstallMethod( StandardizeObject,
        "for an object in a Zariski frame or coframe",
        [ IsObjectInZariskiFrameOrCoframe ],
        
  function( A )
    
    StandardMorphismOfUnderlyingCategory( A );
    
    IsInitial( A );
    IsTerminal( A );
    
    return A;
    
end );

##
InstallMethod( DistinguishedLocallyClosedApproximation,
        "for a constructible object",
        [ IsConstructibleObject ],
        
  function( A )
    
    return DistinguishedLocallyClosedApproximation( LocallyClosedApproximation( A ) );
    
end );

##
InstallMethod( AffineApproximation,
        "for an object in a thin category",
        [ IsObjectInThinCategory ],
        
  function( A )
    local Ap, R, indets, t, R_f, C;
    
    if IsInitial( A ) then
        Error( "the input A is empty\n" );
    elif IsClosed( A ) then
        A := Closure( A );
        if IsObjectInZariskiFrameOrCoframeOfAnAffineVariety( A ) then
            return A;
        fi;
        TryNextMethod( );
    fi;
    
    A := DistinguishedLocallyClosedApproximation( A );
    
    if IsObjectInMeetSemilatticeOfMultipleDifferences( A ) then
        A := AsDifference( A );
    fi;
    
    Ap := A.J;
    
    R := UnderlyingRing( Ap );
    
    Ap := UnderlyingMatrix( MorphismOfUnderlyingCategory( Ap ) );
    
    Ap := MatElm( Ap, 1, 1 );
    
    indets := Indeterminates( R );
    
    indets := List( indets, String );
    
    t := UnusedVariableName( R, "inv" );
    
    R_f := R * [ t ];
    
    t := t / R_f;
    Ap := Ap / R_f;
    
    A := A.I;
    
    C := CapCategory( A );
    
    A := UnderlyingMatrix( MorphismOfUnderlyingCategory( A ) );
    
    A := R_f * A;
    
    A := UnionOfRows( A, HomalgMatrix( [ Ap * t - 1 ], 1, 1, R_f ) );
    
    A := ClosedSubsetOfFiberedSpecByReducedMorphism( A );
    
    A!.auxiliary_indeterminate := t;
    
    return A;
    
end );

## the fallback method
InstallMethod( AClosedSuperset,
        "for an object in a thin category",
        [ IsObjectInThinCategory ],
        
  Closure );

##
InstallMethod( AClosedSuperset,
        "for an object in a meet-semilattice of differences",
        [ IsObjectInMeetSemilatticeOfDifferences ],
        
  function( A )
    
    ## faster than A.I:
    return A[1].I;
    
end );

##
InstallMethod( AClosedSuperset,
        "for an object in a Zariski frame",
        [ IsObjectInZariskiFrame ],
        
  Closure );

##
InstallMethod( AClosedSuperset,
        "for an object in a thin category",
        [ IsObjectInThinCategory and HasClosure ], 1001,
        
  Closure );

##
InstallMethod( RingMorphismOfClosedSuperset,
        "for an object in a thin category",
        [ IsObjectInThinCategory ],
        
  function( A )
    local R;
    
    A := AClosedSuperset( A );
    
    R := UnderlyingRing( A );
    
    A := UnderlyingMatrix( StandardMorphismOfUnderlyingCategory( A ) );
    
    return RingMapOntoSimplifiedResidueClassRing( R / A );
    
end );

##
InstallMethod( RingMorphismOfClosure,
        "for an object in a thin category",
        [ IsObjectInThinCategory ],
        
  function( A )
    local R;
    
    Closure( A );
    
    return RingMorphismOfClosedSuperset( A );
    
end );

##
InstallMethod( Pullback,
        "for a homalg ring map and an object in a Zariski frame or coframe",
        [ IsHomalgRingMap, IsObjectInZariskiFrameOrCoframe ],
        
  function( phi, A )
    local T, fibered, C, B;
    
    T := Range( phi );
    
    fibered := not IsIdenticalObj( CoefficientsRing( T ), BaseRing( T ) );
    
    if IsObjectInZariskiCoframe( A ) then
        if IsObjectInZariskiCoframeOfAProjectiveVariety( A ) and IsHomalgGradedRing( T ) then
            C := ZariskiCoframeOfProjUsingCategoryOfRows( T );
        elif HasZariskiCoframeOfAffineSpectrumUsingCategoryOfRows( Source( phi ) ) then
            if fibered then
                C := ZariskiCoframeOfFiberedAffineSpectrumUsingCategoryOfRows( T );
            else
                C := ZariskiCoframeOfAffineSpectrumUsingCategoryOfRows( T );
            fi;
        else
            C := CapCategory( A );
        fi;
    else
        if IsObjectInZariskiFrameOfAProjectiveVariety( A ) and IsHomalgGradedRing( T ) then
            C := ZariskiFrameOfProjUsingCategoryOfRows( T );
        elif HasZariskiFrameOfAffineSpectrumUsingCategoryOfRows( Source( phi ) ) then
            #if fibered then
            #    C := ZariskiFrameOfFiberedAffineSpectrumUsingCategoryOfRows( T );
            #else
                C := ZariskiFrameOfAffineSpectrumUsingCategoryOfRows( T );
            #fi;
        else
            C := CapCategory( A );
        fi;
    fi;
    
    B := Pullback( phi, UnderlyingMatrix( MorphismOfUnderlyingCategory( A ) ) );
    
    if HasIsIsomorphism( phi ) and IsIsomorphism( phi ) then
        if HasStandardMorphismOfUnderlyingCategory( A ) then
            return C!.ConstructorByStandardMorphism( B );
        elif HasReducedMorphismOfUnderlyingCategory( A ) then
            return C!.ConstructorReducedMorphism( B );
        fi;
    fi;
    
    B := C!.Constructor( B );
    
    if HasParametrizedObject( A ) then
        SetParametrizedObject( B, Pullback( phi, ParametrizedObject( A ) ) );
    fi;
    
    return B;
    
end );

##
InstallMethod( Pullback,
        "for a homalg ring map and an object in a meet-semilattice of formal single differences",
        [ IsHomalgRingMap, IsObjectInMeetSemilatticeOfSingleDifferences ],
        
  function( phi, A )
    local B;
    
    B := List( PairInUnderlyingLattice( A ), a -> Pullback( phi, a ) );
    
    B := B[1] - B[2];
    
    if HasParametrizedObject( A ) then
        SetParametrizedObject( B, Pullback( phi, ParametrizedObject( A ) ) );
    fi;
    
    if HasNormalizedDistinguishedSubtrahend( A ) then
        SetPreDistinguishedSubtrahend( B, Pullback( phi, NormalizedDistinguishedSubtrahend( A ) ) );
    elif HasPreDistinguishedSubtrahend( A ) then
        SetPreDistinguishedSubtrahend( B, Pullback( phi, PreDistinguishedSubtrahend( A ) ) );
    fi;
    
    return B;
    
end );

##
InstallMethod( Pullback,
        "for a homalg ring map and an object in a meet-semilattice of formal multiple differences",
        [ IsHomalgRingMap, IsObjectInMeetSemilatticeOfMultipleDifferences ],
        
  function( phi, A )
    local B;
    
    B := List( A, a -> Pullback( phi, a ) );
    
    B := CallFuncList( AsFormalMultipleDifference, B );
    
    if HasParametrizedObject( A ) then
        SetParametrizedObject( B, Pullback( phi, ParametrizedObject( A ) ) );
    fi;
    
    return B;
    
end );

##
InstallMethod( Pullback,
        "for a homalg ring map and a constructible object as a union of formal single differences",
        [ IsHomalgRingMap, IsConstructibleObjectAsUnionOfDifferences ],
        
  function( phi, A )
    local B;
    
    A := List( A, a -> Pullback( phi, a ) );
    
    B := CallFuncList( UnionOfDifferences, A );
    
    if HasParametrizedObject( A ) then
        SetParametrizedObject( B, Pullback( phi, ParametrizedObject( A ) ) );
    fi;
    
    return B;
    
end );

##
InstallMethod( Pullback,
        "for a homalg ring map and a constructible object as a union of formal multiple differences",
        [ IsHomalgRingMap, IsConstructibleObjectAsUnionOfMultipleDifferences ],
        
  function( phi, A )
    local B;
    
    A := List( A, a -> Pullback( phi, a ) );
    
    B := CallFuncList( UnionOfMultipleDifferences, A );
    
    if HasParametrizedObject( A ) then
        SetParametrizedObject( B, Pullback( phi, ParametrizedObject( A ) ) );
    fi;
    
    return B;
    
end );

##
InstallMethod( EmbedInSmallerAmbientSpaceByEmbeddingAClosedSuperset,
        "for an object in a thin category",
        [ IsObjectInThinCategory ],
        
  function( A )
    local phi, S, T;
    
    phi := RingMorphismOfClosedSuperset( A );
    
    S := Source( phi );
    
    if HasAmbientRing( S ) then
        S := AmbientRing( S );
    fi;
    
    T := Range( phi );
    
    if HasAmbientRing( T ) then
        T := AmbientRing( T );
        phi := RingMap( T * ImagesOfRingMapAsColumnMatrix( phi ), S, T );
    fi;
    
    return Pullback( phi, A );
    
end );

##
InstallMethod( EmbedInSmallerAmbientSpace,
        "for an object in a thin category",
        [ IsObjectInThinCategory ],
        
  function( A )
    local b;
    
    b := HasClosure( A );
    
    A := EmbedInSmallerAmbientSpaceByEmbeddingAClosedSuperset( A );
    
    if not b then
        # this should only be slightly more expensive than Closure( A ):
        StandardizeObject( A );
        A := EmbedInSmallerAmbientSpaceByEmbeddingAClosedSuperset( A );
    fi;
    
    return A;
    
end );

##
InstallMethod( AClosedSingleton,
        "for an object in a thin category",
        [ IsObjectInThinCategory ],
        
  function( A )
    local Aa, p;
    
    if IsInitial( A ) then
        Error( "the input A is empty\n" );
    elif IsObjectInZariskiCoframe( A ) then
        TryNextMethod( );
    fi;
    
    Aa := AffineApproximation( A );
    
    p := AClosedSingleton( Aa );
    
    if IsIdenticalObj( CapCategory( p ), CapCategory( Closure( A ) ) ) then
        return p;
    fi;
    
    p := ImageClosureOfProjection( p );
    
    Assert( 4, IsClosed( p ) );
    SetIsClosedSubobject( p, true );
    SetClosure( p, p );
    
    return p;
    
end );

##
InstallMethod( PseudoIteratorOfClosedSingletons,
        "for an object in a thin category",
        [ IsObjectInThinCategory ],
        
  function( A )
    local iter;
    
    iter := rec( variety := A );
    
    iter.NextIterator :=
      function( iter )
        local A, p;
        
        A := iter!.variety;
        
        p := AClosedSingleton( A );
        
        iter!.variety := A - p;
        
        return p;
        
    end;
    
    iter.IsDoneIterator :=
      iter -> IsInitial( iter!.variety );
    
    iter.ViewObj :=
      function( iter )
        Print( "<iterator of closed singletons of " );
        ViewObj( iter!.variety );
        Print( ">" );
    end;
    
    iter.ShallowCopy :=
      function( iter )
        local iter_copy;
        
        iter_copy := rec( );
        
        iter_copy!.variety := iter!.variety;
        iter_copy!.NextIterator := iter!.NextIterator;
        iter_copy!.IsDoneIterator := iter!.IsDoneIterator;
        iter_copy!.ViewObj := iter!.ViewObj;
        iter_copy!.ShallowCopy := iter!.ShallowCopy;
        
        return iter_copy;
        
    end;
    
    return IteratorByFunctions( iter );
    
end );

##
InstallMethod( RingMorphismOfAClosedPoint,
        "for an object in a thin category",
        [ IsObjectInThinCategory ],
        
  function( A )
    local singleton, map, R, S;
    
    singleton := AClosedSingleton( A );
    
    map := RingMorphismOfClosure( singleton );
    
    A := Closure( A );
    
    R := UnderlyingRing( A );
    
    A := UnderlyingMatrix( StandardMorphismOfUnderlyingCategory( A ) );
    
    S := Range( map );
    
    map := ImagesOfRingMapAsColumnMatrix( map );
    
    map := RingMap( map, R / A, S );
    
    SetIsMorphism( map, true );
    
    map!.singleton := singleton;
    
    return map;
    
end );

##
InstallMethod( AClosedPoint,
        "for an object in a thin category",
        [ IsObjectInThinCategory ],
        
  function( A )
    
    return ImagesOfRingMapAsColumnMatrix( RingMorphismOfAClosedPoint( A ) );
    
end );

##
InstallMethod( AClosedPoint,
        "for an object in a thin category",
        [ IsObjectInThinCategory and HasParametrizedObject ],
        
  function( A )
    
    return Pullback( RingMorphismOfAClosedPoint( A ), ParametrizedObject( A ) );
    
end );

##
InstallMethod( PseudoIteratorOfClosedPoints,
        "for an object in a thin category",
        [ IsObjectInThinCategory ],
        
  function( A )
    local iter;
    
    iter := rec( variety := A );
    
    iter.NextIterator :=
      function( iter )
        local A, phi, s, p, A_s;
        
        A := iter!.variety;
        
        phi := RingMorphismOfAClosedPoint( A );
        s := phi!.singleton;
        
        if HasParametrizedObject( A ) then
            p := Pullback( phi, ParametrizedObject( A ) );
        else
            p := ImagesOfRingMapAsColumnMatrix( phi );
        fi;
        
        A_s := A - s;
        
        if HasParametrizedObject( A ) then
            SetParametrizedObject( A_s, ParametrizedObject( A ) );
        fi;
        
        iter!.variety := A_s;
        
        return p;
        
    end;
    
    iter.IsDoneIterator :=
      iter -> IsInitial( iter!.variety );
    
    iter.ViewObj :=
      function( iter )
        Print( "<iterator of closed singletons of " );
        ViewObj( iter!.variety );
        Print( ">" );
    end;
    
    iter.ShallowCopy :=
      function( iter )
        local iter_copy;
        
        iter_copy := rec( );
        
        iter_copy!.variety := iter!.variety;
        iter_copy!.NextIterator := iter!.NextIterator;
        iter_copy!.IsDoneIterator := iter!.IsDoneIterator;
        iter_copy!.ViewObj := iter!.ViewObj;
        iter_copy!.ShallowCopy := iter!.ShallowCopy;
        
        return iter_copy;
        
    end;
    
    return IteratorByFunctions( iter );
    
end );

##
InstallMethod( CanonicalObject,
        "for an object in a Zariski frame or coframe",
        [ IsObjectInZariskiFrameOrCoframe ],
        
  LocallyClosedApproximation );

##
InstallMethod( StandardPairInUnderlyingHeytingOrCoHeytingAlgebra,
        "for an object in a meet-semilattice of formal single differences",
        [ IsObjectInMeetSemilatticeOfSingleDifferences ],
        
  function( A )
    
    A := NormalizedPairInUnderlyingHeytingOrCoHeytingAlgebra( A );
    
    List( A, StandardizeObject );
    
    return A;
    
end );
