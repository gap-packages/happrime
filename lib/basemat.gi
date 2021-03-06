#############################################################################
##
##  HAPPRIME - basemat.gi
##  Functions, Operations and Methods for matrices representing vector spaces
##  Paul Smith
##
##  Copyright (C)  2007-2008
##  Paul Smith
##  National University of Ireland Galway
##
##  This file is part of HAPprime. 
## 
##  HAPprime is free software; you can redistribute it and/or modify
##  it under the terms of the GNU General Public License as published by
##  the Free Software Foundation; either version 2 of the License, or
##  (at your option) any later version.
## 
##  HAPprime is distributed in the hope that it will be useful,
##  but WITHOUT ANY WARRANTY; without even the implied warranty of
##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##  GNU General Public License for more details.
## 
##  You should have received a copy of the GNU General Public License
##  along with this program.  If not, see <http://www.gnu.org/licenses/>.
## 
##  $Id: basemat.gi 317 2008-09-12 12:02:26Z pas $
##
#############################################################################


#####################################################################
##  <#GAPDoc Label="SumIntersectionMatDestructive_manBaseMat">
##  <ManSection>
##  <Oper Name="SumIntersectionMatDestructive" Arg="U, V"/>
##  <Oper Name="SumIntersectionMatDestructiveSE" Arg="Ubasis, Uheads, Vbasis, Vheads"/>
##
##  <Description>
##  Returns a list of length 2 with, at the first position, the sum of the 
##  vector spaces generated by the rows of <A>U</A> and <A>V</A>, and, 
##  at the second position, the intersection of the spaces.
##  <P/>
##  Like the &GAP; core function 
##  <Ref Oper="SumIntersectionMat" BookName="ref"/>, this performs 
##  Zassenhaus' algorithm to compute bases for the sum and the intersection.
##  However, this version operates directly on the input matrices (thus
##  corrupting them), and is rewritten to require only approximately 1.5 
##  times the space of the original input matrices. By contrast, the 
##  original &GAP; version uses three times the memory of the original matrices
##  to perform the calculation, and since it doesn't modify the input 
##  matrices will require a total of four times the space of the original 
##  matrices.
##  <P/>
##  The function <K>SumIntersectionMatDestructiveSE</K> takes as arguments
##  not a pair of generating matrices, but a pair of semi-echelon 
##  basis matrices and the corresponding head locations, such as 
##  is returned by a call to 
##  <Ref Oper="SemiEchelonMatDestructive" BookName="ref"/> (these arguments
##  must all be mutable, so <Ref Oper="SemiEchelonMat" BookName="ref"/> cannot 
##  be used). This 
##  function is used internally by <K>SumIntersectionMatDestructive</K>, and 
##  is provided for the occasions when the user might already have the 
##  semi-echelon versions available, in which case a small amount of time will 
##  be saved.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
#####################################################################
InstallMethod(SumIntersectionMatDestructive,
  "generic method",
  IsIdenticalObj,
  [IsMatrix and IsMutable, IsMatrix and IsMutable],
  0,
  function(U, V)
  
  local seU, seV;
  
  if  Length(U) = 0 then
    return [ ];
  elif Length(V) = 0 then
    return [];
  elif Length(U[1]) <> Length(U[1]) then
    Error( "dimensions of matrices are not compatible" );
  elif Zero(U[1][1]) <> Zero(V[1][1]) then
    Error( "fields of matrices are not compatible" );
  fi;

  # Do semi-echelon on both U and V
  seU := SemiEchelonMatDestructive(U);
  seV := SemiEchelonMatDestructive(V);
  
  # Now call IntersectionMatDestructiveSE
  return SumIntersectionMatDestructiveSE(seU.vectors, seU.heads, seV.vectors, seV.heads);
end);
#####################################################################
InstallOtherMethod(SumIntersectionMatDestructive,
  "method when V is empty",
  true,
  [IsMatrix, IsEmpty],
  0,
  function(U, V)
    return [BaseMatDestructive(U), [ ]];
  end
);
#####################################################################
InstallOtherMethod(SumIntersectionMatDestructive,
  "method when U is empty",
  true,
  [IsEmpty, IsMatrix],
  0,
  function(U, V)
    return [BaseMatDestructive(V), [ ]];
  end
);
#####################################################################
InstallOtherMethod(SumIntersectionMatDestructive,
  "method when U and V are empty",
  true,
  [IsEmpty, IsEmpty],
  0,
  function(U, V)
    return ([], []);
  end
);
#####################################################################
InstallMethod(SumIntersectionMatDestructiveSE,
  "generic method",
  true,
  [IsMatrix and IsMutable, IsVector and IsMutable, IsMatrix and IsMutable, IsMutable and IsVector],
  0,
  function(Ubasis, Uheads, Vbasis, Vheads)

  local 
    rU, 
    ncols,
    zero,
    Vsum1_basis,
    Vsum1_heads,
    i,
    c,
    zeros,
    Vsum2_basis,
    Vsum2_heads,
    intersection,
    row,
    head,
    e,
    r,
    reducingrow;

  # What is the rank of U?
  rU := Length(Ubasis);
  if  rU = 0 then
    return [ ];
  elif Length(Vbasis) = 0 then
    return [];
  fi;

  # And what is the dimension of the space?
  ncols := Length(Ubasis[1]);
  zero := Zero(Ubasis[1][1]);

  if ncols <> Length(Vbasis[1]) then
    Error( "dimensions of matrices are not compatible" );
  elif zero <> Zero(Vbasis[1][1]) then
    Error( "fields of matrices are not compatible" );
  elif Length(Uheads) <> ncols then
    Error( "U matrix and its heads are not compatible" );
  elif Length(Vheads) <> ncols then
    Error( "V matrix and its heads are not compatible" );
  fi;

  # Split the rows of V into two sets: those that have heads that aren't
  # in U and those that have heads that are the same as rows in u
  Vsum1_basis := [];
  Vsum1_heads := ListWithIdenticalEntries(ncols, 0);
  for i in [Length(Vbasis), Length(Vbasis)-1 .. 1] do
    c := PositionNonZero(Vbasis[i]);
    if Uheads[c] = 0 then
      Add(Vsum1_basis, Remove(Vbasis, i));
      Vheads[c] := 0;
      Vsum1_heads[c] := Length(Vsum1_basis);
    fi;
  od;

  # We now need to reduce the remaining rows in Vbasis. They will either generate
  # yet more basis elements for the sum, or will indicate a vector in the intersection
  zeros := ListWithIdenticalEntries(ncols, zero);  
  ConvertToVectorRepNC(zeros, Field(zero));
  
  Vsum2_basis := [];
  Vsum2_heads := ListWithIdenticalEntries(ncols, 0);
  intersection := [];
  for i in [Length(Vbasis), Length(Vbasis)-1 .. 1] do
    # Need to do a ShallowCopy to remove the IsLockedRepresentationVector flag
    # that otherwise prevents me from extending it
    row := ShallowCopy(Remove(Vbasis, i));
    # Extend this with an equal number of zeros to accumulate the 
    # rows of U I have used to reduce this
    Append(row, zeros);

    # Now reduce this
    head := 0;
    for c in [1..ncols] do
      e := row[c];
      if e <> zero then
        # Try using U
        r := Uheads[c];
        if r <> 0 then
          reducingrow := ShallowCopy(Ubasis[r]);
          Append(reducingrow, reducingrow);
          AddRowVector(row, reducingrow, -e);
        else
          # Try Vsum1 instead
          r := Vsum1_heads[c];
          if r <> 0 then
            reducingrow := ShallowCopy(Vsum1_basis[r]);
            Append(reducingrow, zeros);
            AddRowVector(row, reducingrow, -e, 1, ncols);
          else
            # Try Vsum2
            r := Vsum2_heads[c];
            if r <> 0 then
              AddRowVector(row, Vsum2_basis[r], -e);
            else
              # We can't reduce this any further, so we now have a 
              # new head at this column
              # Set the head to be the identity
              MultRowVector(row, Inverse(e));
              head := c;
              break;
            fi; 
          fi;
        fi;
      fi;
    od;

    # Has this been reduced to zero?
    # If so, we have a vector in the intersection
    if head = 0 then
      Add(intersection, row{[ncols+1..2*ncols]});
    else
      # Otherwise we have yet another row in the sum
      Add(Vsum2_basis, row);
      Vsum2_heads[head] := Length(Vsum2_basis);
    fi;
  od;
  Unbind(Vsum1_heads);
  Unbind(Vsum2_heads);
  Unbind(zeros);

  # Form the final sum by appending Vsum1 and Vsum2 to Ubasis
  if not IsEmpty(Vsum2_basis) then
    for i in [Length(Vsum2_basis), Length(Vsum2_basis) - 1 .. 1] do
      row := Remove(Vsum2_basis, i){[1..ncols]};
      c := PositionNonZero(row);
      Add(Ubasis, row);
      Uheads[c] := Length(Ubasis);
    od;
  fi;
  Unbind(Vsum2_basis);
  if not IsEmpty(Vsum1_basis) then
    for i in [Length(Vsum1_basis), Length(Vsum1_basis) - 1 .. 1] do
      row := Remove(Vsum1_basis, i);
      c := PositionNonZero(row);
      Add(Ubasis, row);
      Uheads[c] := Length(Ubasis);
    od;
  fi;
  Unbind(Vsum1_basis);

  # Now reduce intersection to a basis 
  # (since we have no guarantee yet that it is a basis)
  if not IsEmpty(intersection) then
    intersection := BaseMatDestructive(intersection);
  fi;
    
  return [Ubasis, intersection];
end);
#####################################################################
InstallOtherMethod(SumIntersectionMatDestructiveSE,
  "method when Ubasis is empty",
  true,
  [IsEmpty, IsVector and IsMutable, IsMatrix and IsMutable, IsMutable and IsVector],
  0,
  function(Ubasis, Uheads, Vbasis, Vheads)
    return [Vbasis, []];
end);
#####################################################################
InstallOtherMethod(SumIntersectionMatDestructiveSE,
  "method when Vbasis is empty",
  true,
  [IsMatrix and IsMutable, IsVector and IsMutable, IsEmpty, IsMutable and IsVector],
  0,
  function(Ubasis, Uheads, Vbasis, Vheads)
    return [Ubasis, []];
end);
#####################################################################
    

#####################################################################
##  <#GAPDoc Label="SolutionMat_manBaseMat">
##  <ManSection>
##  <Oper Name="SolutionMat" Arg="M, V" Label="for multiple vectors"/>
##  <Oper Name="SolutionMatDestructive" Arg="M, V" Label="for multiple vectors"/>
##
##  <Description>
##  Calculates, for each row vector <M>v_i</M> in the matrix <A>V</A>,
##  a solution to <M>x_i \times M = v_i</M>, and returns these solutions
##  in a matrix <M>X</M>, whose rows are the vectors <M>x_i</M>. If there is
##  not a solution for a <M>v_i</M>, then <K>fail</K> is returned for that
##  row.
##  <P/>
##  These functions are identical to the kernel functions 
##  <Ref Func="SolutionMat" BookName="ref"/> and 
##  <Ref Func="SolutionMatDestructive" BookName="ref"/>, but are provided
##  for cases where multiple solutions using the same matrix <A>M</A> are
##  required. In these cases, using this function is far faster, since the
##  matrix is only decomposed once. 
##  <P/>
##  The <C>Destructive</C> version corrupts both the input matrices, while the 
##  non-<C>Destructive</C> version operates on copies of these.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
#####################################################################
InstallMethod(SolutionMatDestructive,
  "method for list of vectors",
  IsIdenticalObj,
  [IsOrdinaryMatrix and IsMutable, IsMatrix and IsMutable],
  function( mat, V )
    local i, ncols, sem, vno, z, x, row, sol, Sols, vec;

    ncols := Length(V[1]);
    if ncols <> Length(mat[1]) then
      Error("SolutionMat: matrix and vector incompatible");
    fi;

    sem := SemiEchelonMatTransformationDestructive(mat);
    z := Zero(mat[1][1]);

    Sols := [];
    for vec in V do
      sol := ListWithIdenticalEntries(Length(mat), z);
      ConvertToVectorRepNC(sol);

      for i in [1..ncols] do
        vno := sem.heads[i];
        if vno <> 0 then
          x := vec[i];
          if x <> z then
            AddRowVector(vec, sem.vectors[vno], -x);
            AddRowVector(sol, sem.coeffs[vno], x);
          fi;
        fi;
      od;
      if IsZero(vec) then
        Add(Sols, sol);
      else
        Add(Sols, fail);
      fi;
    od;
    return Sols;
end);
#####################################################################
InstallMethod(
  SolutionMat,
  "method for list of vectors",
  IsIdenticalObj,
  [IsOrdinaryMatrix, IsMatrix],
  function( mat, V )
    return SolutionMatDestructive(
      MutableCopyMat(mat), MutableCopyMat(V));
end);
#####################################################################

#####################################################################
##  <#GAPDoc Label="IsSameSubspace_manBaseMat">
##  <ManSection>
##  <Oper Name="IsSameSubspace" Arg="U, V"/>
##
##  <Description>
##  Returns <K>true</K> if the subspaces spanned by the rows of 
##  <A>U</A> and <A>V</A> are the same, <K>false</K> otherwise.
##  <P/>
##  This function treats the rows of the two matrices as vectors from the 
##  same vector space (with the same basis), and tests whether the subspace
##  spanned by the two sets of vectors is the same.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
#####################################################################
InstallMethod(IsSameSubspace,
  "generic method",
  IsIdenticalObj,
  [IsMatrix, IsMatrix],
  0,
  function(U, V)

  local space;

  if Length(U[1]) <> Length(V[1]) then
    return false;
  elif Zero(U[1][1]) <> Zero(V[1][1]) then
    return false;
  fi;

  space := Field(U[1][1])^Length(U[1]);
  
  return Subspace(space, U) = Subspace(space, V);
end);
#####################################################################
InstallOtherMethod(IsSameSubspace,
  "trivial method when V is empty",
  true,
  [IsMatrix, IsEmpty],
  0,
  function(U, V)
    return false;
end);
#####################################################################
InstallOtherMethod(IsSameSubspace,
  "trivial method when U is empty",
  true,
  [IsEmpty, IsMatrix],
  0,
  function(U, V)
    return false;
end);
#####################################################################
InstallOtherMethod(IsSameSubspace,
  "trivial method when matrices are empty",
  true,
  [IsEmpty, IsEmpty],
  0,
  function(U, V)
    return true;
end);
#####################################################################
  


#####################################################################
##  <#GAPDoc Label="PrintDimensionsMat_manBaseMat">
##  <ManSection>
##  <Oper Name="PrintDimensionsMat" Arg="M"/>
##
##  <Description>
##  Returns a string containing the dimensions of the matrix <A>M</A> in the 
##  form <C>"mxn"</C>, where <K>m</K> is the number of rows and <K>n</K>
##  the number of columns. If the matrix is empty, the returned string is 
##  <C>"empty"</C>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
#####################################################################
InstallMethod(PrintDimensionsMat,
  "generic method",
  true,
  [IsMatrix],
  0,
  function(M)

  return Concatenation(String(Length(M)), "x", String(Length(M[1])));
end);
#####################################################################
InstallOtherMethod(PrintDimensionsMat,
  "method when matrix is empty",
  true,
  [IsEmpty],
  0,
  function(M)
    return "empty";
end);
#####################################################################


