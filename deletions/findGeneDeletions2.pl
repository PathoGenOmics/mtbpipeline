#!/usr/bin/env perl
use warnings;


############################################################################################
# Find deletions using Artemis per base coverage file  								  	   #
# usage: perl findGeneDeletions [artemis coverage file] [annotation file] [%  threshold]   #
# Percentage cutoff set by command argument 3			   								   #
# Graham Rose 05.2011										   							   #
############################################################################################


############### Arguments from prompt ####################

if ($#ARGV != 2 ) {
	print "\nusage: perl findGeneDeletions.pl [artemis coverage file] [H37Rv annotation file] [% deletion threshold eg: 50]\n\n";
	exit;

}

open FILEIN_ONE, $ARGV[0] or die "Can't open STDOUT: $!\n";
@genomeCoverage = <FILEIN_ONE>;
close(FILEIN_ONE);

open FILEIN_TWO, $ARGV[1] or die "Can't open STDOUT: $!\n";
@annotations = <FILEIN_TWO>;
close(FILEIN_TWO);

$threshold = $ARGV[2];


############### Main logic #####################

foreach $line_in_annotations(@annotations)
{
	chomp($line_in_annotations);
	$line_in_annotations =~ /(\w+)\s+(\w+)\s+(\w+)\s+(\w+)/;
	$geneStart = $1-1; #catch +1 error
	$geneEnd = $2;
	#$direction = $3;
	$geneName = $4;
	
	$geneLength = $geneEnd-$geneStart;
	$geneLength2 = $geneLength;
	$zeros = 0;
	$numberNonZero = 0;
	
	while($geneStart != $geneEnd)
	{
		#push(@array,$genomeCoverage[$geneStart]);
	
		if($genomeCoverage[$geneStart]<5)
		{
			$zeros++;
		}
		$geneStart++;
	}
	#$length = @array;
	#print "$geneName length = $geneLength2\n";
	#print "$geneName Number of zeros = $zeros\n";
	$numberNonZero = ($geneLength2-$zeros);
	$percentZero = (($zeros/$geneLength2)*100);
	$rounded = sprintf "%.2f", $percentZero;
	
	
############### Output ##############
	
	if($rounded >= $threshold)
	{
		print "Deletion: $geneName (% deleted: $rounded)\n";
	
}
}	
	
	
print "\ndone!\n\n";



