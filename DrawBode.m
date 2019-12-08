clear 
close all

%% 伝達関数を定義
num=[1];
den=[4 2 5]; 
sys=tf(num,den);

%% コマンドで描画
bode(sys)
grid on

%% 関数を使わずに作成
% 対数的に等間隔な行列を用意
omega = logspace(-1,2,1000); 
figure;
plot(omega)
grid on

Gjw = polyval(num,sqrt(-1)*omega)./polyval(den,sqrt(-1)*omega);

Mag = 20*log10(abs(Gjw)); 
Phase = rad2deg(unwrap(angle(Gjw)));

figure;
subplot(211)
semilogx(omega,Mag)
ylabel('Magnitude (dB)');
xlim([-10^-1 10^1]);
ylim([-60 0]);
yticks([-60 -50 -40 -30 -20 -10 0]);
grid on

subplot(212)
semilogx(omega,Phase)
xlabel('Frequency (rad/s)'); 
ylabel('Phase (deg)');
xlim([-10^-1 10^1])
ylim([-182 0]);
yticks([-180 -135 -90 -45 0]);
grid on
