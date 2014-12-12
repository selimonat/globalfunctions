/* $Revision: 1.9 $ */

#include "mex.h"

/* This file takes as input two arrays of arbitrary, but equal(!) dimensions. It performs a elementwise multiplication
    of all the elements and sums up all the products. So the output is one double number.
    
    NOTE: There are no checks, if the input arrays are of same size. There will be a general error message, if they
          are not.
    MK 2003*/

void mexFunction(int nlhs, mxArray *plhs[],
                 int nrhs, const mxArray *prhs[])
{
  /* Declare variables. */ 
  int elements,i;
  int out_size = 0;
  double *pr_1,*pr_2,*pind;

  /* Get the number of elements in the input argument. */
  elements = mxGetNumberOfElements(prhs[0]);

  /* Get the data. */
  pr_1 = (double *)mxGetPr(prhs[0]);
  pr_2 = (double *)mxGetPr(prhs[1]);
  
  /* Get the number of dimensions in the input argument. 
     Allocate the space for the return argument */
  plhs[0] = mxCreateDoubleMatrix(1,1, mxREAL);
  pind = mxGetPr(plhs[0]);

  /* Make elementwise multiplication and add products */
  pind[0]=0;
  for (i= 0; i < elements; i++) {
     pind[0] += pr_1[i]*pr_2[i];
  }
}
