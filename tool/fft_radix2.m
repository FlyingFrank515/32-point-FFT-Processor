t = 0:31;
f = 0:31;

<<<<<<< HEAD
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input_1 :10sin4t                 
% input_2 : 
% input_3 :  sin4t
% input_4 :10cos4t
% input_5 : 
% input_6 :  cos4t
% input_7 : 
% input_8 : 5cos4t +  sin4t
% input_9 :  cos4t + 5sin4t
% input_0 :  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% NOTE: input range = (-32,32)
x = 10*sin(4*t);
=======
% =================================
% input1: cos(4*t)
% input2: 10*sin(4*t)
% input3: 5*sin(4*t)
% input4: sin(4*t)
% input5: rectangularPulse(8,23,t)
% input6: triangularPulse(8,23,t)
% input7: heaviside(t-16)
% input8: 0.5*t 
% input9: sin(2*t)+sin(4*t)+sin(6*t)
% input10: 5*cos(t)+sin(5*t)
% =================================

% NOTE: input range = (-16,16)
x = 5*cos(t)+sin(5*t);
>>>>>>> a7d05063e013326267d86cd945fe0db9cc0c4af9
x = round(x,3);
y = zeros(1,32);

% radix-2 method
for i = 0:31
    y(i+1) = dft_32(x, i);
end

y = round(y,3);

figure;
%subplot(3,1,1)
plot(t, x);
title('Time domain');
%subplot(3,1,2);
figure;
plot(f,real(y));
title('Real Part');
%subplot(3,1,3);
figure;
plot(f,imag(y));
title('Imaginary Part');
%sgtitle('Radix-II FFT');

% matlab fft
X = fft(x);

%{
figure;
subplot(2,1,1);
plot(f,real(X));
title('Real Part');
subplot(2,1,2);
plot(f,imag(X));
title('Imaginary Part');
sgtitle('Matlab FFT');
%}


%dlmwrite('input_8.txt',x,'\n');
%dlmwrite('output_real_2.txt',real(y),'\n');
%dlmwrite('output_imag_2.txt',imag(y),'\n');

function y = dft_2(x,k)
    y = x(1) * exp(-1i * 2 * pi * k * 0 / 2) + x(2) * exp(-1i * 2 * pi * k * 1 / 2);
end

function y = dft_4(x,k)
    x_odd = [x(1) x(3)];
    x_even = [x(2) x(4)];
    y = dft_2(x_odd,k) + dft_2(x_even,k) * exp(-1i * 2 * pi * k / 4);
end

function y = dft_8(x,k)
    x_odd = [x(1) x(3) x(5) x(7)];
    x_even = [x(2) x(4) x(6) x(8)];
    y = dft_4(x_odd,k) + dft_4(x_even,k) * exp(-1i * 2 * pi * k / 8);
end

function y = dft_16(x,k)
    x_odd = [x(1) x(3) x(5) x(7) x(9) x(11) x(13) x(15)];
    x_even = [x(2) x(4) x(6) x(8) x(10) x(12) x(14) x(16)];
    y = dft_8(x_odd,k) + dft_8(x_even,k) * exp(-1i * 2 * pi * k / 16);
end

function y = dft_32(x,k)
    x_odd = [x(1) x(3) x(5) x(7) x(9) x(11) x(13) x(15) x(17) x(19) x(21) x(23) x(25) x(27) x(29) x(31)];
    x_even = [x(2) x(4) x(6) x(8) x(10) x(12) x(14) x(16) x(18) x(20) x(22) x(24) x(26) x(28) x(30) x(32)];
    y = dft_16(x_odd,k) + dft_16(x_even,k) * exp(-1i * 2 * pi * k / 32);
end


