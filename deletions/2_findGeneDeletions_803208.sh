#! \bin\sh

for FILE in *.coverage.all.pos;
do 
echo "processing $FILE"



perl findGeneDeletions2.pl $FILE annotated_genes.txt 10 > $FILE.deletions

done


# $FILE contains all positions in the genome follwed by the coverage, second argument annotation file, third argument percent of the gene you consider as deletion
