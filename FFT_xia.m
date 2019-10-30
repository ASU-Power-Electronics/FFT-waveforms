% 2013.7.1    by Xia
% ´Ë³ÌÐò¼ÆËãÓÉÊ¾²¨Æ÷²Éµ½µÄ²¨ÐÎµÄFFT£¬»ù×¼ÖµÊÇ»ù²¨·ùÖµÉèÎª1£¬Ð³²¨·ùÖµ±íÊ¾Ïà¶ÔÓÚ»ù²¨·ùÖµµÄ´óÐ¡£¬×Ô¶¯µ÷Õû×Ý×ø±ê·ùÖµ£¬ºá×ø±êÎª»ùÆµ50HzµÄ»ù²¨´ÎÊý¡£
% har_order_for_display±íÊ¾ÏÔÊ¾µÄÐ³²¨´ÎÊý£¬»ù²¨Îª50Hz¡£ÈôÏë¿´Ô¶µã¾ÍÉèÖÃÎª300£¬±íÊ¾300´ÎÐ³²¨¡£
% har_order_for_calculation±íÊ¾ÔÚÖ÷½çÃæÖÐ¼ÆËã³öµÄÐ³²¨´ÎÊý£¬ÈçµÈÓÚ20 Ê±£¬±íÊ¾´Ó0´ÎÒ»Ö±¼ÆËãµ½20´Î£¬ÔÚÖ÷½çÃæÖÐÏÔÊ¾
% ³ýÁËÊä³öÔ­²¨ÐÎ£¬FFTºóµÄÆµÆ×£¬»¹ÔÚÖ÷½çÃæÖÐÊä³öÔ­²¨ÐÎµÄ²ÉÑùÊ±¼ä£¬²ÉÑùÆµÂÊµÈÐÅÏ¢
% ×¢ÊÍµôµÄÐÐyn = sin(100*pi*time)+0.1*sin(100*pi*time*3)+0.1*sin(100*pi*time*5)+0.02*sin(100*pi*time*50)+0.1; Îª²âÊÔÐÐ£¬¿ÉÒÔÈÏÎªÉèÖÃÐ³²¨¶øÑÔÖ®±¾FFT³ÌÐòµÄÕýÈ·ÐÔ


function FFT_xia()

clear all;
close all;

% base_frequency = 50;
base_frequency = 60;

% ¿ÉÒÔÉèÖÃ»ù²¨ÆµÂÊ£¬µ«ÊÇÒ»¶¨Òª×¢Òâ£¬²É½øÀ´µÄÒªÊÇÕûÊý¸öÖÜÆÚ²ÅÐÐ£¬±ÈÈç50Hz£¬ÄÇÃ´¿ÉÒÔÊÇ´Ó-0.01µ½0.01£¨1¸öÖÜÆÚ£©£¬-0.02µ½0.02£¨2¸öÖÜÆÚ£©£¬-0.05µ½0.05£¨5¸öÖÜÆÚ£©£¬-0.1µ½0.1£¨10¸öÖÜÆÚ£©
% 60HzÊ±£¬Í¬ÑùÒªÎªÕûÊýÖÜÆÚ£¬×¢ÒâÊ¾²¨Æ÷²É½øÀ´µÄÐÅºÅÊÇ·ñÊÇÕûÊýÖÜÆÚ

har_order_for_display = 200;                                          % ÉèÖÃÒªÔÚÍ¼ÐÎÏÔÊ¾µÄÐ³²¨×î¸ß´ÎÊý
har_order_for_calculation = 20000;                                      % ÉèÖÃÒªÔÚÖ÷ÆÁÄ»ÏÔÊ¾µÄÐ³²¨×î¸ß´ÎÊý
time = xlsread('C4Trace00001.csv','C4Trace00001','A6:A999983');                   % ÊµÀý£º¶ÔÓÚ50Hz£¬T0020£¬T0021£¬T0023£¬T0026ÎªÊ¾²¨Æ÷´æÏÂÀ´µÄCSV²¨ÐÎ£»ÊµÀý£º¶ÔÓÚ60Hz£¬ÓÐT0021£¬T0026
Ig = xlsread('C4Trace00001.csv','C4Trace00001','B6:B999983');         
Vg = xlsread('C4Trace00001.csv','C4Trace00001','B6:B999983'); 
% [time,Vg] = textread('C1_v6_00016.txt','%f%f');
% [time,Ig] = textread('C2_v6_00015.txt','%f%f');
% Vg = Vg / 100;
% yn = sin(100*pi*time)+0.01*sin(100*pi*time*3+1)+0.05*sin(100*pi*time*5+pi)+0.02*sin(100*pi*time*30+1)+0.02;       % ÈËÎªÉèÖÃ50Hz¼°ÆäÐ³²¨£¬²âÊÔËã·¨µÄÕýÈ·ÐÔ
Ig = 1*sin(120*pi*time+10*pi/180)+0.1*sin(120*pi*time*3+-80*pi/180+0.1)+0.05*sin(120*pi*time*5+-205*pi/180+0.1)+0.08*sin(120*pi*time*30+-15*pi/180+0.1)+0.02;     % ÈËÎªÉèÖÃ60Hz¼°ÆäÐ³²¨£¬²âÊÔËã·¨µÄÕýÈ·ÐÔ
Vg = 2*sin(120*pi*time)+0.01*sin(120*pi*time*3+1)+0.05*sin(120*pi*time*5+2)+0.02*sin(120*pi*time*30+1)+0.02;

Sample_number = length(Ig);                                          % µÃµ½ynÊý×éµÄ³¤¶È
time_from = time(1);                              
time_to = time(length(time)); 
delta_time = time_to - time_from;
Fs = Sample_number / delta_time;
Number_of_T = round((round(time(length(time))*2*base_frequency)-round (time(1)*2*base_frequency))/2);

figure(1)
plot(time,Ig,'b');
hold on
plot(time,Vg,'r');
U_and_I = [Ig;Vg];
axis([1.1*min(time)  1.1*max(time)  1.1*min(U_and_I)  1.1*max(U_and_I)]);      % »æÖÆÔ­ÐÅºÅ²¨ÐÎ
title('input signals')
xlabel('time/s')
ylabel('magnitude/A or V')
grid

Y = fft(Ig,Sample_number);                                                         % ×öFFT±ä»»
X = Y;
Y = abs(Y);
Xabs=abs(X);
Xabs(1) = 0; %Ö±Á÷·ÖÁ¿ÖÃ0
[Amax,index]=max(Xabs);
if(Xabs(index-1) > Xabs(index+1))
    a1 = Xabs(index-1) / Xabs(index);
    r1 = 1/(1+a1);
    k01 = index -1;
else
    a1 = Xabs(index) / Xabs(index+1);
    r1 = 1/(1+a1);
    k01 = index;
end
Fn = (k01+r1-1)*Fs/Sample_number; %»ù²¨ÆµÂÊ
An = 2*pi*r1*Xabs(k01)/(Sample_number*sin(r1*pi)); %»ù²¨·ùÖµ
An_Ig = An;
Fn_Ig = Fn;
Pn_Ig = phase(X(index)); %»ù²¨ÏàÎ» µ¥Î»»¡¶È
Pn_Ig = mod(Pn_Ig(1),2*pi);


Base_Y = max(Y);
for i = 1:1:length(Y)/Number_of_T
    Y_out(i) = Y(Number_of_T*(i-1)+1)/Base_Y;                        % ¸ù¾Ý²»Í¬µÄ»ù²¨ÆµÂÊ½øÐÐÏÔÊ¾
end
Y_out(1) = Y_out(1) / 2;                                             % ¶ÔÓÚÖ±Á÷µÄ¼ÆËã½á¹ûÒª³ýÒÔ2£¬Õâµã¿ÉÄÜºÍmatlabµÄFFTº¯Êý¼ÆËã·½·¨ÓÐ¹Ø

second_max_Y_out = 0;
Y_cal = Y_out(1:500);
Y_cal(:,2) = [];
second_max_Y_out = max(Y_cal);

for i = 1:1:length(Y)/Number_of_T-1
    phase_Ig(i) = phase(X(Number_of_T*(i)+1))*180/pi;                        % ¸ù¾Ý²»Í¬µÄ»ù²¨ÆµÂÊ½øÐÐÏÔÊ¾
end  

figure(2)
f = (0:1:har_order_for_display-1);                                   % ´Ó0´ÎÐ³²¨ÏÔÊ¾µ½Ö¸¶¨´ÎµÄÐ³²¨
bar(f,Y_out(1:1:har_order_for_display)) 
axis([-0.5  har_order_for_display+1  0  1.5*second_max_Y_out]);      % ½«×ø±êÖáµÄ×Ý×ø±êÉèÎª³ý»ù²¨ÍâµÄ·ùÖµ×î´óµÄÐ³²¨·ùÖµµÄ1.5±¶
title('FFT of current')
xlabel('harmonic order')
ylabel('amplitude(scaled by fundamental wave)')
grid

Base = max(Y_out);
THD = 0;
calculate_har_num = 20000;                                             % thd¹²¼ÆËãµ½500´ÎÐ³²¨
for i = 1:1:calculate_har_num
    THD = THD + Y_out(i) * Y_out(i);
end
THD = THD - Base;
THD = sqrt(THD);

fprintf('\nCurrent:')
fprintf('\nFundamental frequency: %6.6f Hz    ',Fn_Ig)
% fprintf('\nstart time: %6.6fs     stop time: %6.6fs     number of cycles: %1.0f\n', time_from,time_to,Number_of_T)
% fprintf('number of samples: %6.0f         sample frequency: %6.3fMHz\n',Sample_number,Fs/1000000)
fprintf('THD: %6.4f\n',THD)
% for i = 0:1:har_order_for_calculation                                % ÔÚÖ÷½çÃæÖÐÏÔÊ¾Ö¸¶¨´ÎÐ³²¨µÄ·ùÖµ
%     fprintf(' %1.0f harmonics amplitude: %6.3f\n',i,Y_out(i+1))
% end


Y = fft(Vg,Sample_number);                                                         % ×öFFT±ä»»
X = Y;
Y = abs(Y);
Xabs=abs(X);
Xabs(1) = 0; %Ö±Á÷·ÖÁ¿ÖÃ0
[Amax,index]=max(Xabs);
if(Xabs(index-1) > Xabs(index+1))
    a1 = Xabs(index-1) / Xabs(index);
    r1 = 1/(1+a1);
    k01 = index -1;
else
    a1 = Xabs(index) / Xabs(index+1);
    r1 = 1/(1+a1);
    k01 = index;
end
Fn = (k01+r1-1)*Fs/Sample_number; %»ù²¨ÆµÂÊ
Fn_Vg = Fn;
An = 2*pi*r1*Xabs(k01)/(Sample_number*sin(r1*pi)); %»ù²¨·ùÖµ
An_Vg = An;
Pn_Vg = phase(X(index)); %»ù²¨ÏàÎ» µ¥Î»»¡¶È
Pn_Vg = mod(Pn_Vg(1),2*pi);


Base_Y = max(Y);
for i = 1:1:length(Y)/Number_of_T
    Y_out(i) = Y(Number_of_T*(i-1)+1)/Base_Y;                        % ¸ù¾Ý²»Í¬µÄ»ù²¨ÆµÂÊ½øÐÐÏÔÊ¾
end
Y_out(1) = Y_out(1) / 2;                                             % ¶ÔÓÚÖ±Á÷µÄ¼ÆËã½á¹ûÒª³ýÒÔ2£¬Õâµã¿ÉÄÜºÍmatlabµÄFFTº¯Êý¼ÆËã·½·¨ÓÐ¹Ø

second_max_Y_out = 0;
Y_cal = Y_out(1:500);
Y_cal(:,2) = [];
second_max_Y_out = max(Y_cal);

for i = 1:1:length(Y)/Number_of_T-1
    phase_Vg(i) = phase(X(Number_of_T*(i)+1))*180/pi;                        % ¸ù¾Ý²»Í¬µÄ»ù²¨ÆµÂÊ½øÐÐÏÔÊ¾
end  

figure(3)
f = (0:1:har_order_for_display-1);                                   % ´Ó0´ÎÐ³²¨ÏÔÊ¾µ½Ö¸¶¨´ÎµÄÐ³²¨
bar(f,Y_out(1:1:har_order_for_display)) 
% axis([-0.5  har_order_for_display+1  0  1.1]);      % ½«×ø±êÖáµÄ×Ý×ø±êÉèÎª³ý»ù²¨ÍâµÄ·ùÖµ×î´óµÄÐ³²¨·ùÖµµÄ1.5±¶
axis([-0.5  har_order_for_display+1  0  2*second_max_Y_out]);      % ½«×ø±êÖáµÄ×Ý×ø±êÉèÎª³ý»ù²¨ÍâµÄ·ùÖµ×î´óµÄÐ³²¨·ùÖµµÄ1.5±¶
title('FFT of voltage')
xlabel('harmonic order')
ylabel('amplitude(scaled by fundamental wave)')
grid

Base = max(Y_out);
THD = 0;
calculate_har_num = 20000;                                             % thd¹²¼ÆËãµ½500´ÎÐ³²¨
for i = 1:1:calculate_har_num
    THD = THD + Y_out(i) * Y_out(i);
end
THD = THD - Base;
THD = sqrt(THD);

fprintf('Voltage:')
fprintf('\nFundamental frequency: %6.6f Hz    ',Fn_Vg)
% fprintf('\nstart time: %6.6fs     stop time: %6.6fs     number of cycles: %1.0f\n', time_from,time_to,Number_of_T)
% fprintf('number of samples: %6.0f         sample frequency: %6.3fMHz\n',Sample_number,Fs/1000000)
fprintf('THD: %6.4f\n',THD)
% for i = 0:1:har_order_for_calculation                                % ÔÚÖ÷½çÃæÖÐÏÔÊ¾Ö¸¶¨´ÎÐ³²¨µÄ·ùÖµ
%     fprintf(' %1.0f harmonics amplitude: %6.3f\n',i,Y_out(i+1))
% end





for i = 1:1:length(Y)/Number_of_T-1
    Phase_diff(i) = (phase_Vg(i) - phase_Ig(i));                        % ¸ù¾Ý²»Í¬µÄ»ù²¨ÆµÂÊ½øÐÐÏÔÊ¾
    Phase_diff(i) = mod(Phase_diff(i),360);
    if Phase_diff(i)>180 && Phase_diff(i)<=360
        Phase_diff(i) = Phase_diff(i) - 360;
    end
end  

figure(4)
f = (1:2:15);                                   % ´Ó0´ÎÐ³²¨ÏÔÊ¾µ½Ö¸¶¨´ÎµÄÐ³²¨
bar(f,Phase_diff(1:2:15),0.3) 
title('Phase difference')
xlabel('harmonic order')
ylabel('degree, I(i) lagging U(i)')
grid

for i = 1:1:length(Y)/Number_of_T-1
    Phase_diff2(i) = (phase_Vg(1) - phase_Ig(i));                        % ¸ù¾Ý²»Í¬µÄ»ù²¨ÆµÂÊ½øÐÐÏÔÊ¾
    Phase_diff2(i) = mod(Phase_diff2(i),360);
    if Phase_diff2(i)>180 && Phase_diff2(i)<=360
        Phase_diff2(i) = Phase_diff2(i) - 360;
    end
end  

P_Vg_Ig = An_Vg * 100 * An_Ig * cos(Phase_diff(1)*pi/180) / 2;
fprintf('Power: %6.6f W\n',P_Vg_Ig)

% figure(5)
% f = (1:2:15);                                   % ´Ó0´ÎÐ³²¨ÏÔÊ¾µ½Ö¸¶¨´ÎµÄÐ³²¨
% bar(f,Phase_diff2(1:2:15),0.3) 
% title('Phase difference')
% xlabel('harmonic order')
% ylabel('degree, I(i) lagging U(1)')
% grid



% X=fft(Ig); % FFT
% X=X(1:Sample_number/2);
% Xabs=abs(X);
% Xabs(1) = 0; %Ö±Á÷·ÖÁ¿ÖÃ0
% [Amax,index]=max(Xabs);
% if(Xabs(index-1) > Xabs(index+1))
%     a1 = Xabs(index-1) / Xabs(index);
%     r1 = 1/(1+a1);
%     k01 = index -1;
% else
%     a1 = Xabs(index) / Xabs(index+1);
%     r1 = 1/(1+a1);
%     k01 = index;
% end
% Fn = (k01+r1-1)*Fs/Sample_number %»ù²¨ÆµÂÊ
% An = 2*pi*r1*Xabs(k01)/(Sample_number*sin(r1*pi)); %»ù²¨·ùÖµ
% Pn1 = phase(X(k01))-pi*r1; %»ù²¨ÏàÎ» µ¥Î»»¡¶È
% Pn1 = phase(X(index)); %»ù²¨ÏàÎ» µ¥Î»»¡¶È
% Pn1 = mod(Pn1(1),2*pi);
% 
% X=fft(Vg); % FFT
% X=X(1:Sample_number/2);
% Xabs=abs(X);
% Xabs(1) = 0; %Ö±Á÷·ÖÁ¿ÖÃ0
% [Amax,index]=max(Xabs);
% if(Xabs(index-1) > Xabs(index+1))
%     a1 = Xabs(index-1) / Xabs(index);
%     r1 = 1/(1+a1);
%     k01 = index -1;
% else
%     a1 = Xabs(index) / Xabs(index+1);
%     r1 = 1/(1+a1);
%     k01 = index;
% end
% Fn = (k01+r1-1)*Fs/Sample_number %»ù²¨ÆµÂÊ
% An = 2*pi*r1*Xabs(k01)/(Sample_number*sin(r1*pi)); %»ù²¨·ùÖµ
% Pn2 = phase(X(k01))-pi*r1; %»ù²¨ÏàÎ» µ¥Î»»¡¶È
% Pn2 = phase(X(index)); %»ù²¨ÏàÎ» µ¥Î»»¡¶È
% Pn2 = mod(Pn2(1),2*pi);
% 
% Phase_diff = Pn1 - Pn2;
% Phase_diff = Phase_diff * 180 / pi;
% fprintf('\n Phase diff:%6.0f  \n',Phase_diff)


