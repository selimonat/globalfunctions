function [h p] = signrank_mat(mat)

for i = 1:size(mat,2)
    [p(i) h(i)] = signrank(mat(:,i));
end