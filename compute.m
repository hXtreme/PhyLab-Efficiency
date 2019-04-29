load('data.mat')

zeros = [-2.047 -2.034, -2.073, -2. 071];
I = [0.63, 0.69, 0.78, 0.87];
V = [1.07, 1.07, 1.07, 1.07];

P_E = I.*V;

%% 0g
i = 1;
P_M(i) = myfunc(F0, zeros(i), L0, T0);

%% 2g
i = 2;
P_M(i) = myfunc(F2, zeros(i), L2, T2);

%% 4g
i = 3;
P_M(i) = myfunc(F4, zeros(i), L4, T4);

%% 6g
i = 4;
P_M(i) = myfunc(F6, zeros(i), L6, T6);

%% Efficiency
r = (P_M./P_E)*100;
figure;
plot(r);

%% Compute
function P = myfunc(f, zero, L, T)
    R = 7.48E-3;
    [pk, lc] = findpeaks(L, T);
    t = [];
    j = 1;
    last = 1;
    mu = mean(L);
    for i = 2:(size(lc)-1)
        if pk(i) >= mu
            t(j) = lc(i) - lc(last);
            j = j+1;
            last = i;
        end
    end
%     figure; plot(t);
    w = 2*pi./t;
    w = rmoutliers(w);
    F = (f - zero);
    P = mean(F)*mean(w)*R;
end

