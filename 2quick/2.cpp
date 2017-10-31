#include<iostream>
#include<stdlib.h>
#include<omp.h>
using namespace std;
class quick_sort
{
int a[1000];
int n;
public:
void get_array()
{
cout<<"Enter N \n";
cin>>n;
cout<<"Unsorted Array is \n";
for(int i=0;i<n;i++){
a[i]=rand()%1000;
cout<<a[i]<<" ";
}
}
void disp_array()
{
cout<<"Sorted Array is \n";
for(int i=0;i<n;i++)
cout<<a[i]<<" ";
}
int partition(int p,int r)
{
int lt[r-p];
int gt[r-p];
int i,j;
int key=a[r];
int lt_n=0;
int gt_n=0;
#pragma omp parallel for
for(i=p;i<r;i++)
{
if(a[i]<key)
{
lt[lt_n++]=a[i];
}
else
{
gt[gt_n++]=a[i];
}}
#pragma omp parallel for
for(i=0;i<lt_n;i++)
{
a[p+i]=lt[i];
}
a[p+lt_n]=key;
#pragma omp parallel for
for(j=0;j<gt_n;j++)
{
a[p+lt_n+j+1]=gt[j];
}
return p+lt_n;
}
void quicksort()
{
quicksort(0,n-1);
}
void quicksort(int p,int r)
{
int div;
if(p<r)
{
div=partition(p,r);
#pragma omp parallel sections
{
#pragma omp section
{
cout<<"\n Thread is"<<omp_get_thread_num()<<endl;
quicksort(p,div-1);
}
#pragma omp section
{
cout<<"\n Thread is"<<omp_get_thread_num()<<endl;
quicksort(div+1,r);
}
}
}
}
};
int main()
{
quick_sort q;
q.get_array();
q.quicksort();q.disp_array();
return 0;
}


/* Ouput: 
student@student-OptiPlex-3020:~$ g++ -fopenmp 2.cpp
student@student-OptiPlex-3020:~$ ./a.out
Enter N 
6
Unsorted Array is 
383 886 777 915 793 335 
 Thread is0
 Thread is2


 Thread is0

 Thread is0

 Thread is0

 Thread is0

 Thread is0

 Thread is0
Sorted Array is 
335 383 777 793 886 915 student@student-OptiPlex-3020:~$*/
