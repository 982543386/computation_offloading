clear;
%sΪԴ�ڵ㣬tΪĿ��ڵ㣻һά�����������Ϊ�ڵ��������������ʡ��������ʡ����㹦�ʡ����书�ʡ�������������
%����
S_MIN = 0;S_MAX = 8000;
%��������
C = 200 : 100 : 1500;
%��������
C_S = 50 : 50 : 300;
%���㹦��
P = 200 : 100 : 2000;
%���书��
P_S = 100 : 100 : 1000;
%����������
W_S = 0.1 : 0.5 : 8;
W_T = 0;
%Դ�ڵ㼰Ŀ��ڵ��ʼ��(Ŀ��ڵ�����=Դ�ڵ�����+diff)
node_num = 100;
diff = 5;
for i = 1 : node_num + diff
    eval(['s', num2str(i), '=', '[randi([S_MIN S_MAX]), C(randi([1 length(C)])), C_S(randi([1 length(C_S)])), P(randi([1 length(P)])), P_S(randi([1 length(P_S)])), W_S(randi([1 length(W_S)]))]', ';']);  
    eval(['t', num2str(i), '=', '[randi([S_MIN S_MAX]), C(randi([1 length(C)])), C_S(randi([1 length(C_S)])), P(randi([1 length(P)])), P_S(randi([1 length(P_S)])), 0]', ';']);  
end
%չʾ
ab = 0.8;
x = [];
y1 = [];
y2 = [];
for i = 1 : node_num
    %����
    x(i) = i
    %����ƥ��
    y1_item = 0;
    for j = 1 : i
        %[no_low_s_source, no_low_t_source] = double_source_consume(eval(['s', num2str(j)]), eval(['t', num2str(j)]), 0.1);
        %y1_item = y1_item + no_low_s_source + no_low_t_source;
        [no_low_s_source, no_low_t_source] = double_source_consume(eval(['s', num2str(j)]), eval(['t', num2str(j)]), 0.1);
        [no_low_s_time, no_low_t_time] = double_time_consume(eval(['s', num2str(j)]), eval(['t', num2str(j)]), 0.1);
        y1_item = y1_item + ab * (no_low_s_source + no_low_t_source) + (1 - ab) * (no_low_s_time + no_low_t_time);
    end
    y1(i) = y1_item
    %���ܺĵ�ʱ�Ӳ���
    %Ч�����
    matric = [];
    for j = 1 : i
        for k = 1 : i + diff
            %[double_low_s_source, double_low_t_source] = double_source_consume(eval(['s', num2str(j)]), eval(['t', num2str(k)]), 0.1);
            %matric(j, k) =  double_low_s_source + double_low_t_source;
            [double_low_s_source, double_low_t_source] = double_source_consume(eval(['s', num2str(j)]), eval(['t', num2str(k)]), 0.1);
            [double_low_s_time, double_low_t_time] = double_time_consume(eval(['s', num2str(j)]), eval(['t', num2str(k)]), 0.1);
            matric(j, k) =  ab * (double_low_s_source + double_low_t_source) + (1 - ab) * (double_low_s_time + double_low_t_time);
        end
    end
    [match, cost] = edmonds(matric);
    y2(i) = cost
end
plot(x, y1, '--', x, y2, '-r');
title('������ʱ���������ڵ������Ĺ�ϵ')
xlabel('���ܽڵ����');
ylabel('������ʱ���������')
legend('����ƥ��','���ܺĵ�ʱ��');
