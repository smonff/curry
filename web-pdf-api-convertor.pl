#!/usr/bin/perl
package PdfApiConvertor;
use strict;
use warnings;
use Data::Dumper;
use LWP::Simple;
use Text::Buffer;

my $location = "http://shurf.pl/~smonff/cvhtml/index.html";
my $API_key = "387387404";
my $output_file_name="CV_sebastien_feugere_2012.pdf";

my $data = get("http://do.convertapi.com/Web2Pdf?curl=$location&apikey=$API_key&outputfilename=$output_file_name");


my $html_buffer = new Text::Buffer();
$html_buffer->append($data);

if ( $html_buffer->save("CV_sebastien_feugere_2012.pdf")){
	
	# From http://bytes.com/topic/perl/answers/568399-opening-pdf-file-browser-using-perl
	open(PDF, "CV_sebastien_feugere_2012.pdf") or die "could not open PDF [$!]";
	binmode PDF;
	my $output = do { local $/; <PDF> };
	close(PDF);
	 
	print "Content-Type: application/pdf\n";
	print "Content-Length: " .length($output) . "\n\n";
	print $output;


	# From http://objectmix.com/perl/120596-sending-pdf-file-perl.html
	# open my $fh, '<', "$output_file_name" or die $!;
	# binmode STDOUT;
	# print "Content-Type: application/pdf\n",
	# "Content-Disposition: attachment; filename=$output_file_name\n",
	# 'Content-Length: ' . (stat "$output_file_name")[7] . "\n\n";
	# while ( read $fh, my $buffer, 1024 ) {
	# 	print $buffer;
	# }
} 
else {
	if ($html_buffer->isError()) { 
   	  my $error = "Error: " . $html_buffer->getError() . "\n"; 
   	  print "Error: " . $html_buffer->getError() . "\n";
   	  print "Impossible to write into the cache file. Please fix write rights! 666 is a good solution..."
	} 
}






