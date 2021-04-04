t = 0:31;
f = 0:31;

% NOTE: input range = (-32,32)
x = 25 * cos(4 * t);
y = zeros(1,32);

% radix-2 method
for i = 1:32
    y(i) = dft_32(x, i);
end

%{
figure;
plot(f,abs(y));
%}

% matlab fft
X = fft(x);

%{
figure;
plot(f,abs(X));
%}

q = quantizer('double');
x_bin = num2bin(q,x);

dlmwrite('input_1.txt',x,'\n');

function y = dft_2(x,k)
    y = x(1) * exp(-1i * 2 * pi * k * 1 / 2) + x(2) * exp(-1i * 2 * pi * k * 2 / 2);
end

function y = dft_4(x,k)
    x_odd = [x(1) x(3)];
    x_even = [x(2) x(4)];
    y = dft_2(x_odd,k) * exp(-1i * 2 * pi * k / 4) + dft_2(x_even,k);
end

function y = dft_8(x,k)
    x_odd = [x(1) x(3) x(5) x(7)];
    x_even = [x(2) x(4) x(6) x(8)];
    y = dft_4(x_odd,k) * exp(-1i * 2 * pi * k / 8) + dft_4(x_even,k);
end

function y = dft_16(x,k)
    x_odd = [x(1) x(3) x(5) x(7) x(9) x(11) x(13) x(15)];
    x_even = [x(2) x(4) x(6) x(8) x(10) x(12) x(14) x(16)];
    y = dft_8(x_odd,k) * exp(-1i * 2 * pi * k / 16) + dft_8(x_even,k);
end

function y = dft_32(x,k)
    x_odd = [x(1) x(3) x(5) x(7) x(9) x(11) x(13) x(15) x(17) x(19) x(21) x(23) x(25) x(27) x(29) x(31)];
    x_even = [x(2) x(4) x(6) x(8) x(10) x(12) x(14) x(16) x(18) x(20) x(22) x(24) x(26) x(28) x(30) x(32)];
    y = dft_16(x_odd,k) * exp(-1i * 2 * pi * k / 32) + dft_16(x_even,k);
end

