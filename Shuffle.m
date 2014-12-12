function [shuffled]=Shuffle(vector)



[bla, idx] = sort(rand([1 length(vector)]));
shuffled   = vector(idx);
