#!\bin\sh

##script to parse the files *.all.pos.vcf in order to get a file that has only position and read deapth by position 
##the perls script it calls creates a file which has coverage for each of the positions in the genome 4411532 (change this number in built_total_coverage.pl)
##08.03.208

for FILE in *.all.pos.vcf;
do
echo parsing the file $FILE
awk -F '[\t;=]' '{if ($0 !~/#/) {print $2"\t"$9}}' $FILE >$FILE.coverage
perl built_total_coverage.pl $FILE.coverage > $FILE.total.coverage 
awk '{print $2}'  $FILE.total.coverage > $FILE.coverage.all.pos

rm $FILE.coverage
rm $FILE.total.coverage
   

done
