# ボード線図とは
## 伝達関数の定義
次のような微分方程式

```math
\begin{align} \dfrac{d^n}{dt^n} y(t) &+ a_{n-1} \dfrac{d^{n-1}}{dt^{n-1}}y(t) + \cdots + a_{1} \dfrac{d}{dt} y(t) + a_{0} y(t)\\ &=b_m \dfrac{d^m}{dt^m} u(t) + b_{m-1} \dfrac{d^{m-1}}{dt^{m-1}} u(t) + \cdots + b_{1} \dfrac{d}{dt} u(t) + b_{0} u(t) \end{align}
```

で表される系の伝達関数を考えます。微分方程式をラプラス変換すると伝達関数は

```math
G(s)=\frac{b_{m} s^{m} + \cdots + b_{1} s + b_{0} }{s^{n} + a_{n-1} s^{n-1} + \cdots + a_{1}s + a_{0}}
```
のようになります。

##ボード線図
制御工学にはシステムを解析するためのボード線図があり、ゲイン線図と位相線図の組み合わせで使われることが多いです。
ゲイン線図を書くにはまず$s=j\omega$を代入すればよく


```math
\begin{align} G(j \omega) =\frac{b_{m} (j \omega)^{m} + \cdots + j b_{1}  \omega + b_{0} }{(j \omega)^{n} + a_{n-1} (j \omega)^{n-1} + \cdots + j a_{1} \omega + a_{0}}\end{align}
```

の後ゲインを

```math
20 \log \left | G(j \omega) \right | 
```

によって求めます。また、位相線図は

```math
\angle G(j \omega)
```

によって求めます。

## 使用する伝達関数
今回は一般で解くわけにも行きませんので、バネマスダンパ系

```math
G(s)=\frac{Y(s)}{X(s)}=\frac{1}{Ms^{2}+Cs+K}
```

を例に使用します。バネマスダンパ系については過去記事[1]を参照してください。


# 結果
## コマンドを用いた描画
コマンドを叩くだけ。
bodeが関数、sysには伝達関数を引数で与えます。

```matlab
bode(sys)
grid on
```

伝達関数は

```matlab
num=[1];
den=[4 2 5]; 
sys=tf(num,den);
```
のように定義します。


結果は

![untitled.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/138730/314416a2-13dd-e8a9-3b7d-179c285b63bd.jpeg)


## 自作したソース

```matlab
%% 関数を使わずに作成
% 対数的に等間隔な行列を用意
omega = logspace(-1,2,1000); 
figure;
plot(omega)
grid on
```

logspace(A,B,C)で対数的に等間隔な行列を用意します。
この例では-1から2までの間を1000個対数的に等間隔に分割しています。

![3.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/138730/767523fe-afd4-05da-08a7-266ac68365c6.jpeg)


```
Gjw = polyval(num,sqrt(-1)*omega)./polyval(den,sqrt(-1)*omega);

Mag = 20*log10(abs(Gjw)); 
Phase = rad2deg(unwrap(angle(Gjw)));
```
polyval(A,B)は多項式AにBを代入します。
あとは定義通りです。
結果は
![2.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/138730/2730c5a1-6a2b-5c3a-cc2c-ac5cea621c73.jpeg)


# ソース全体

```matlab
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
```

# github
https://github.com/rein-chihaya/DrawBode


# 参考文献
[[1]【MATLAB/Simulink】バネマスダンパ系の例を使って伝達関数と状態空間表現が一致するか確かめてみた](https://qiita.com/rein/items/c2397a49078f043e9868)
