clear;
%sΪԴ�ڵ㣬tΪĿ��ڵ㣻һά�����������Ϊ�ڵ��������������ʡ��������ʡ����㹦�ʡ����书�ʡ�������������
s1=[2000, 5, 2, 20, 10, 400];
s2=[1500, 2, 1, 10, 5, 500];
s3=[1200, 5, 2, 20, 10, 100];
t1=[1800, 3, 2, 15, 10, 0];
t2=[2500, 5, 2, 20, 10, 0];
t3=[2400, 9, 4, 30, 15, 0];
%Դ�ڵ�����n
n = 3;
%Ŀ��ڵ�����m
m = 3;

%����ȫ���м�����
t_permutation = perms([1, 2, 3]);
permutation_rows =size(t_permutation,1);
%���������ʼ��
x = [];
y = [];
for i = 1 : permutation_rows
    %һ��Ǩ�Ƶ����ܺ�
    group_sum = 0;
    for j = 1 : m
        group_sum = group_sum + source_consume_method(eval(['s', num2str(j)]),eval(['t',num2str(t_permutation(i, j))]),0.2);
    end
    x(i) = i;
    y(i) = group_sum;
end
bar(x, y);
xlabel('Ŀ��ڵ����'),ylabel('�����������');