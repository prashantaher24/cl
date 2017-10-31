#include <iostream>
using namespace std;
int g=0;
int binarySearch (int* A, int first, int last, int key) {
if (last < first)
return -1;
else {
int mid = (last + first) / 2;
int x;
if (A[mid] == key)
return mid;
else if (A[mid] > key)
x = binarySearch(A, first, mid - 1, key);
else
x = binarySearch(A, mid + 1, last, key);
return x;
}
}
int main () {
int n,key;
cout<<"\n Enter size of array: ";
cin>>n;
int a[n];
for(int i=0;i<n;i++){
a[i]=i;
cout<<a[i]<<" ";
};
cout<<"\n Enter key: ";
cin>>key;
int index = binarySearch(a, 0, n, key);
cout<<"\n Position :"<<index<<endl;
return 0;
}


/*Output:
student@student-OptiPlex-3020:~$ g++ 1.cpp
student@student-OptiPlex-3020:~$ ./a.out

 Enter size of array:  10
0 1 2 3 4 5 6 7 8 9 
 Enter key: 4

 Position :4
student@student-OptiPlex-3020:~$ g++ 1.cpp
student@student-OptiPlex-3020:~$ ./a.out

 Enter size of array: 10
0 1 2 3 4 5 6 7 8 9 
 Enter key: 10

 Position :-1
student@student-OptiPlex-3020:~$ ./a.out
*/
