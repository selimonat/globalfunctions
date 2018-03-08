function bd=GetBiggestDivisor(N)
%returns the biggest divisor of N, except itself.
bd =[];
for i = primes(N)
    bd = N/i;
    if bd == round(bd)
        break
    end
end
