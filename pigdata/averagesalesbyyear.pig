A = load '/home/magesh/Documents/pigdata/2000.txt' using PigStorage(',') as (productid, productname,jan:double,feb:double,mar:double,apr:double,may:double,jun:double,july:double,aug:double,sep:double,oct:double,nov:double,dec:double);
A1 = foreach A generate $0, $1, ($2:+$3+$4+$5+$6+$7+$8+$9+$10+$11+$12+$13);


B = load '/home/magesh/Documents/pigdata/2001.txt' using PigStorage(',') as (productid, productname,jan:double,feb:double,mar:double,apr:double,may:double,jun:double,july:double,aug:double,sep:double,oct:double,nov:double,dec:double);
B1 = foreach B generate $0, $1, ($2:+$3+$4+$5+$6+$7+$8+$9+$10+$11+$12+$13);


C = load '/home/magesh/Documents/pigdata/2002.txt' using PigStorage(',') as (productid, productname,jan:double,feb:double,mar:double,apr:double,may:double,jun:double,july:double,aug:double,sep:double,oct:double,nov:double,dec:double);
C1 = foreach C generate $0, $1, ($2:+$3+$4+$5+$6+$7+$8+$9+$10+$11+$12+$13);

joinedsale = join A1 by $0, B1 by $0, C1 by $0;

totaldata = foreach joinedsale generate $0,$1,$2,$5,$8;

totalgrowth = foreach totaldata generate $0,$1,$2,$3,$4,(($3-$2)/$2)*100,(($4-$3)/$3)*100;

avggrowth = foreach totalgrowth generate $0, $1,($6+$5/2);

growthten = filter avggrowth by ($2>10);

growthfive = filter avggrowth by ($2<-5);

top5 = order avggrowth by $3 DESC;
top5limit = limit top 5;

