#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>
#include <omp.h>

float **A=NULL;
float **B=NULL;
float **S=NULL;
float **P=NULL;

void createMatrix(uint32_t n){
	uint32_t i=0;
	uint32_t j=0;
	A=(float **)calloc(n,sizeof(float *));
	B=(float **)calloc(n,sizeof(float *));
	S=(float **)calloc(n,sizeof(float *));
	P=(float **)calloc(n,sizeof(float *));
        for(i=0;i<n;i++){
                A[i]=(float *)calloc(n,sizeof(float));
		B[i]=(float *)calloc(n,sizeof(float));
       		S[i]=(float *)calloc(n,sizeof(float));
        	P[i]=(float *)calloc(n,sizeof(float));

		for(j=0;j<n;j++){
			A[i][j]=rand()%100;
			B[i][j]=rand()%100;
		}
        }
}

void freeMatrix(uint32_t n){
uint32_t i=0;
for(i=0;i<n;i++){
        free(A[i]);
	free(B[i]);
	free(S[i]);
        free(P[i]);
       }
        free(A);
	free(B);
	free(S);
	free(P);
}

void multiply_matrices_serial(uint32_t n){
	uint32_t i=0;
	uint32_t j=0;
	uint32_t k=0;

	for(i=0;i<n;i++){
		for(j=0;j<n;j++){
			for(k=0;k<n;k++){
				S[i][j]+=A[i][k]*B[k][j];
			}
		}
	}
}

void multiply_matrices_omp(uint32_t n){
	uint32_t i=0;
        uint32_t j=0;
        uint32_t k=0;
	//#pragma omp parallel for schedule(static) collapse(3) private (i,j,k) shared(A,B,P)
	#pragma omp parallel for schedule(dynamic) collapse(3) private (i,j,k) shared(A,B,P)
        for(i=0;i<n;i++){
                for(j=0;j<n;j++){
                        for(k=0;k<n;k++){
                                P[i][j]+=A[i][k]*B[k][j];
                        }
                }
        }

}

int main(int argc,char *argv[]){
	uint32_t N=0;
	double t[2]={};
	if(argc<2)N=2;
	else
		N=atoi(argv[1]);

	
	createMatrix(N);
	t[1]=omp_get_wtime();
	multiply_matrices_serial(N);
	t[0]=omp_get_wtime();
	printf("Serial: %.4lf",t[0]-t[1]);

	t[1]=omp_get_wtime();
        multiply_matrices_omp(N);
        t[0]=omp_get_wtime();
        printf("Serial: %.4lf",t[0]-t[1]);
	freeMatrix(N);
	return 0;
}
