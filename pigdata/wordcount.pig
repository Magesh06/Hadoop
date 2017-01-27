book = load '$inp' using PigStorage()  as (lines:chararray);

transforms = foreach book generate FLATTEN(TOKENIZE(lines)) as word;


listofallwords = foreach transforms generate word, 1;

groupbyword = group listofallwords by word;

countofeachword = foreach groupbyword generate group, COUNT(listofallwords.$1);

--store countofeachword into '$outdirectory';

dump countofeachword;


