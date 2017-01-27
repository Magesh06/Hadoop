web = load '/home/magesh/Documents/pigdata/WebLog.txt' using PigStorage(',') as (custname,bankname,accesstime);

payment = load '/home/magesh/Documents/pigdata/PaymentGateway.txt' using PigStorage(',') as (bankname,successrate:float);

joindata = join web by $1, payment by $0;

--dump joindata;

maindata = foreach joindata generate $0, $1, $4;

--dump maindata;

groupbyname = group maindata by custname;

--dump groupbyname;

avgrate = foreach groupbyname generate $0,AVG(maindata.$2);

--dump avgrate;

filterrate = filter avgrate by ($1>90);

dump filterrate;

