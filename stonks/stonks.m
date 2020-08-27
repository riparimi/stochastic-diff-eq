%% load stonks data
dunkin = readtable("DNKN.csv");
elf = readtable("ELF.csv");
netflix = readtable("NFLX.csv");
target = readtable("TGT.csv");

%% plot stonks
f=figure;
plot(table2array(dunkin(:,1)),table2array(dunkin(:,2)));
xlabel("Date");
ylabel("Opening price");
title("Dunkin Stock Price");
saveas(f,"dunkin.png");


f=figure;
plot(table2array(elf(:,1)),table2array(elf(:,2)));
xlabel("Date");
ylabel("Opening price");
title("e.l.f Stock Price");
saveas(f,"elf.png");

f=figure;
plot(table2array(netflix(:,1)),table2array(netflix(:,2)));
xlabel("Date");
ylabel("Opening price");
title("Netflix Stock Price");
saveas(f,"netflix.png");

f=figure;
plot(table2array(target(:,1)),table2array(target(:,2)));
xlabel("Date");
ylabel("Opening price");
title("Target Stock Price");
saveas(f,"target.png");

