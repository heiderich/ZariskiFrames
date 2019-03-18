#
# ZariskiFrames: The frame of Zariski open subsets in a projective variety
#
# Declarations
#

#! @Chapter The frame of Zariski open subsets in a projective variety

#! @Section GAP Categories

#! @Description
#!  The &GAP; category of objects in a Zariski frame of a projective variety.
#! @Arguments object
DeclareCategory( "IsObjectInZariskiFrameOfAProjectiveVariety",
        IsObjectInZariskiFrame and
        IsObjectInZariskiFrameOrCoframeOfAProjectiveVariety );

#! @Description
#!  The &GAP; category of morphisms in a Zariski frame of a projective variety.
#! @Arguments morphism
DeclareCategory( "IsMorphismInZariskiFrameOfAProjectiveVariety",
        IsMorphismInZariskiFrame and
        IsMorphismInZariskiFrameOrCoframeOfAProjectiveVariety );

#! @Section Constructors

#! @Description
#!  Construct the Zariski frame of open sets in a projective variety defined as the complements of
#!  vanishing loci of (radical) ideals of a &homalg; ring <A>R</A>.
#! @Arguments R
#! @Returns a &CAP; category
DeclareAttribute( "ZariskiFrameOfProjUsingCategoryOfRows",
        IsHomalgRing );

#! @Description
#!  Construct a Zariski open subset (as an object in the Zariski frame
#!  of open subsets in a projective variety) from a morphism <A>I</A>=<C>AsCategoryOfRowsMorphism</C>( <A>mat</A> )
#!  in the category of rows with <C>RankOfObject</C>( <C>Range</C>( <A>I</A> ) ) = 1.
#!  The morphism <A>I</A> stands for its module-theoretic image which is an ideal.
#! @Arguments I
#! @Returns a &CAP; object
#! @Group OpenSubsetOfProj
DeclareOperation( "OpenSubsetOfProj",
        [ IsCapCategoryMorphism ] );

#! @Arguments mat
#! @Group OpenSubsetOfProj
DeclareOperation( "OpenSubsetOfProj",
        [ IsHomalgMatrix ] );

#! @Arguments str, R
#! @Group OpenSubsetOfProj
DeclareOperation( "OpenSubsetOfProj",
        [ IsString, IsHomalgRing ] );
#! @InsertSystem OpenSubsetOfProj

#! @Description
#!  <C>OpenSubsetOfProjByReducedMorphism</C> assumes that the image is a radical ideal.
#! @Arguments I
#! @Group OpenSubsetOfProjByReducedMorphism
DeclareOperation( "OpenSubsetOfProjByReducedMorphism",
        [ IsCapCategoryMorphism ] );

#! @Arguments mat
#! @Group OpenSubsetOfProjByReducedMorphism
DeclareOperation( "OpenSubsetOfProjByReducedMorphism",
        [ IsHomalgMatrix ] );

#! @Arguments str, R
#! @Group OpenSubsetOfProjByReducedMorphism
DeclareOperation( "OpenSubsetOfProjByReducedMorphism",
        [ IsString, IsHomalgRing ] );

#! @Description
#!  <C>OpenSubsetOfProjByStandardMorphism</C> assumes that the image is a radical ideal given by some sort of a <Q>standard</Q> basis.
#! @Arguments I
#! @Group OpenSubsetOfProjByStandardMorphism
DeclareOperation( "OpenSubsetOfProjByStandardMorphism",
        [ IsCapCategoryMorphism ] );

#! @Arguments mat
#! @Group OpenSubsetOfProjByStandardMorphism
DeclareOperation( "OpenSubsetOfProjByStandardMorphism",
        [ IsHomalgMatrix ] );

#! @Arguments str, R
#! @Group OpenSubsetOfProjByStandardMorphism
DeclareOperation( "OpenSubsetOfProjByStandardMorphism",
        [ IsString, IsHomalgRing ] );