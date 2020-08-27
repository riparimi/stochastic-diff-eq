%Source: http://individual.utoronto.ca/normand/Documents/MATH5501/Project-2/Polya_urn_general_distr.pdf
function[p] = polya(b, w, a, n)
p = zeros(n, 1);
for i = 1 : n
u = unifrnd(0, 1);
if u >= w/(b + w)
    b = b + a;
else
    w = w + a;
end
    p(i) = b/(b + w);
end
x = linspace(1, n, n);
plot(x, p);
hold on;
hold on;
end

% function[p] = polya(b, w, a, n)
%     for i = 1:n
%         u = unifrnd(0, 1);
%         if u >= w/(b + w)
%         b = b + a;
%     else
%     w = w + a;
% end
% end
% p = b/(b + w);
% end
% function[ ] = polya2(b, w, a, n)
% p = zeros(n, 1);
% for i = 1 : n
% p(i) = polya(b, w, a, n);
% end
% [e, f]= hist(p);
% bar(f, 10 * e/sum(e))
% hold on;
% x = linspace(0, 1, 100);
% y = betapdf(x, b/a, w/a);
% plot(x, y',-r',LineWidth', 3)
% end
