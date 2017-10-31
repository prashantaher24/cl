#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include<stdlib.h>
#include<string>
#include<math.h>
using namespace std;
class file_row
{
vector<string> data;
public:
string operator[](int index)
{
return data[index];
}
int size()
{
return data.size();
}
void readNextRow(istream& str)
{
string line;
getline(str,line);
stringstream lineStream(line);
string cell;
data.clear();
while(getline(lineStream,cell,','))
{
data.push_back(cell);
}
}
};
istream& operator>>(istream& str,file_row& row)
{
row.readNextRow(str);
return str;
}
int main()
{
ifstream in_file("k_means_input.csv");
ofstream out_file;
file_row row;
int a[1000][3],i=0;while(in_file>>row)
{
a[i][0]=atoi(row[0].c_str());
a[i][1]=atoi(row[1].c_str());
a[i++][2]=0;
}
stringstream ss;
string str_a;
int k;
cout<<"enter the value of k\n";
cin>>k;
int n=i,sum=0,j,p,q;
int centroid[k][2],clusters[k][100],sizeof_cluster[k];
for(i=0;i<k;i++)
{
centroid[i][0]=a[i][0];
centroid[i][1]=a[i][1];
a[i][2]=i;
sizeof_cluster[i]=1;
clusters[i][0]=i;
}
for(i=0;i<n;i++)
{
int dist=99999;
for(j=0;j<k;j++)
{
int
x=sqrt((centroid[j][0]-a[i][0])*(centroid[j][0]-a[i][0])+(centroid[j][1]-
a[i][1])*(centroid[j][1]-a[i][1]));
if(x<=dist )
{
p=j;
dist=x;
}
}
q=sizeof_cluster[p]++;
clusters[p][q]=i;
a[i][2]=p;
}
int check=1;
int iter=0;
while(check)
{
cout<<"\niteration "<<++iter<<endl;
check=0;
for(i=0;i<n;i++)
{
cout<<a[i][0]<<" "<<a[i][1]<<" "<<a[i][2]<<"\t";}
for(i=0;i<k;i++)
{
int x=0,y=0;
for(j=0;j<sizeof_cluster[i];j++)
{
p=clusters[i][j];
x+=a[p][0];
y+=a[p][1];
}
centroid[i][0]=x/sizeof_cluster[i];
centroid[i][1]=y/sizeof_cluster[i];
sizeof_cluster[i]=0;
}
for(i=0;i<n;i++)
{
int dist=99999;
for(j=0;j<k;j++)
{
int
x=sqrt((centroid[j][0]-a[i][0])*(centroid[j][0]-
a[i][0])+(centroid[j][1]-a[i][1])*(centroid[j][1]-a[i][1]));
if(x<dist )
{
p=j;
dist=x;
}
}
q=sizeof_cluster[p]++;
clusters[p][q]=i;
if(a[i][2]!=p)
check=1;
a[i][2]=p;
}
}
out_file.open("k_means_output.csv");
for(i=0;i<k;i++)
{
for(j=0;j<sizeof_cluster[i];j++)
{
q=clusters[i][j];
ss.str(std::string());
ss << a[q][0];
str_a = ss.str();
out_file<<str_a;
for(p=0;p<=i;p++)
out_file<<",";
out_file<<a[q][1]<<"\n";
}
}in_file.close();
out_file.close();
return 0;
}
