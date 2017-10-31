#include<iostream>
#include<math.h>
#include<stdlib.h>
#define MAX 20
#define k 4
using namespace std;
enum category{SHORT,TALL,AVERAGE};
class data{
int x,y;
category cat;
public:
void setd(int a,int b,category c){
x=a;
y=b;
cat=c;
}
int getx(){return x;}
int gety(){return y;}
category getcat(){
return cat;
}};//end of class
int dis(data d1,data d2)
{
return sqrt(pow((d2.getx()-d1.getx()),2)+pow((d2.gety()-d1.gety()),2));
}
int main()
{
do{
int p,q; //input
int a[MAX]; //store distances
int b[k];
//to get min distances, used in calc
int c[k];
//to store freq
for(int i=0;i<k;i++){ //initiLIZATION
b[i]=-1;
c[i]=0;
}
int min=1000;
cout<<"Enter x,y(neg value to exit): ";
cin>>p>>q;
if(p<0|q<0)
exit(0);
data n;
//data point to classify
n.setd(p,q,SHORT);
data d[MAX]; //training set
//
d[0].setd(1,1,SHORT);
d[1].setd(1,2,SHORT);
d[2].setd(1,3,SHORT);
d[3].setd(1,4,SHORT);
d[4].setd(1,5,SHORT);
d[5].setd(1,6,SHORT);
d[6].setd(1,7,SHORT);
d[7].setd(2,1,SHORT);
d[8].setd(2,2,SHORT);
d[9].setd(2,3,AVERAGE);d[10].setd(2,4,AVERAGE);
d[11].setd(2,5,AVERAGE);
d[12].setd(2,6,AVERAGE);
d[13].setd(2,7,AVERAGE);
d[14].setd(5,1,TALL);
d[15].setd(5,2,TALL);
d[16].setd(5,3,TALL);
d[17].setd(5,4,TALL);
d[18].setd(5,5,TALL);
d[19].setd(5,6,TALL);
for(int i=0;i<20;i++){
a[i]=dis(n,d[i]);
cout<<"\t\t"<<a[i]<<endl;
}
//k-nearest neighbours calculation i.e smallest k distances
for(int j=0;j<k;j++)
{
min=1000;
for(int i=0;i<20;i++)
{
if(i!=b[0]&&i!=b[1]&&i!=b[2])
{
if((a[i]<=min))
{
min=a[i];
b[j]=i;
}
}
}
cout<<min<<endl;
}
//counting frequency of a class in each neighbour
for(int i=0;i<k;i++)
{
switch (d[b[i]].getcat())
{case SHORT:
c[0]++;
break;
case AVERAGE:
c[2]++;
break;
case TALL:
c[1]++;
break;
}
}
//counting max frequency
int max=-1,j;
for(int i=0;i<k;i++)
{
if(c[i]>max){
max=c[i];
j=i;
}
}
cout<<"Prediction is : ";
switch (j)
{
case 0:
cout<<"SHORT"<<endl;
break;
case 1:
cout<<"TALL"<<endl;
break;
case 2:
cout<<"AVERAGE"<<endl;
break;
}
}while(true);
return 0;
}


/*output:
student@student-OptiPlex-3020:~$ g++ 22.cpp
student@student-OptiPlex-3020:~$ ./a.out
Enter x,y(neg value to exit): 4 10
		9
		8
		7
		6
		5
		5
		4
		9
		8
		7
		6
		5
		4
		3
		9
		8
		7
		6
		5
		4
3
4
4
4
Prediction is : AVERAGE
Enter x,y(neg value to exit): 5 10
		9
		8
		8
		7
		6
		5
		5
		9
		8
		7
		6
		5
		5
		4
		9
		8
		7
		6
		5
		4
4
4
5
5
Prediction is : TALL
Enter x,y(neg value to exit): -1
-2
student@student-OptiPlex-3020:~$ 
*/
