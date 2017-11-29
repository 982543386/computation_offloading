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
%Դ�ڵ㼰Ŀ��ڵ��ʼ��
node_num = 30;
for i = 1 : node_num
    eval(['s', num2str(i), '=', '[randi([S_MIN S_MAX]), C(randi([1 length(C)])), C_S(randi([1 length(C_S)])), P(randi([1 length(P)])), P_S(randi([1 length(P_S)])), W_S(randi([1 length(W_S)]))]', ';']);  
    eval(['t', num2str(i), '=', '[randi([S_MIN S_MAX]), C(randi([1 length(C)])), C_S(randi([1 length(C_S)])), P(randi([1 length(P)])), P_S(randi([1 length(P_S)])), 0]', ';']);  
end
%չʾ
x = [];
y1 = [];
y2 = [];
for i = 1 : node_num
    %���нڵ�������ʼ��
    s_source = [];
    t_source = [];
    s_exist_time = [];
    t_exist_time = [];
    for j = 1 : i
        s_source(j) = get_node_source(eval(['s', num2str(j)]));
    end
    for j = 1 : i
        t_source(j) = get_node_source(eval(['t', num2str(j)]));
    end  
    %����
    x(i) = i;
    %����ƥ��
    for j = 1 : i
        [no_low_s_source, no_low_t_source] = double_source_consume(eval(['s', num2str(j)]), eval(['t', num2str(j)]), 0.1);
        [no_low_s_time, no_low_t_time] = double_time_consume(eval(['s', num2str(j)]), eval(['t', num2str(j)]), 0.1);
        s_exist_time(j) = s_source(j) / no_low_s_source * no_low_s_time;
        t_exist_time(j) = t_source(j) / no_low_t_source * no_low_t_time;
    end
    y1(i) = min([s_exist_time t_exist_time]);
    %����������ʱ��־���
    source_consume_matric = [];
    time_consume_matric = [];
    for j = 1 : i
        for k = 1 : i
            [no_low_s_source, no_low_t_source] = double_source_consume(eval(['s', num2str(j)]), eval(['t', num2str(k)]), 0.1);
            source_consume_matric(j, k) = no_low_t_source;
            [no_low_s_time, no_low_t_time] = double_time_consume(eval(['s', num2str(j)]), eval(['t', num2str(k)]), 0.1);
            time_consume_matric(j, k) = no_low_t_time;
        end        
    end
    %��������ת��ΪǨ�ƴ�������
    offload_num_matric = [];
    for j = 1 : i
        for k = 1 : i
            offload_num_matric(j, k) = t_source(k) / source_consume_matric(j, k);
        end        
    end
    %Ǩ�ƴ�������ת��Ϊʱ�����
    node_exist_time = [];
    for j = 1 : i
        for k = 1 : i
            node_exist_time(j, k) = offload_num_matric(j, k) * time_consume_matric(j, k);
        end        
    end
    saturation_exist_time = [];
    for j = 1 : i
       min_val = min(node_exist_time(:, j));
       saturation_exist_time(j) = min_val;
    end
    y2(i) = min([s_exist_time max(saturation_exist_time)])
end
% plot(x, y1, '-b', x, y2, '-r');
bar(x, [y1; y2]');
title('����������ʱ����ڵ������Ĺ�ϵ')
xlabel('���ܽڵ����');
ylabel('����Ǩ�ƴ���')
legend('����ƥ��','���Ͳ���');
