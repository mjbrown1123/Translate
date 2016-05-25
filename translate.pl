#File: translate.pl
#Using the structure of spanishdict.com, this program creates a translator for some words on the command line 
#(spanish to english or english to spanish)

use warnings;
use strict;
use LWP::Simple;
use WWW::Mechanize;


#indicate when
print "To exit, enter 'e'.\n";

#continue translating until the user indicates otherwise
while(true) {


	print "Enter translation below.\n";

	#get the word to be translated from the user
	my $in = <STDIN>;

	#shorten the input
	chomp($in); 

   	#check if the input is the terminal command
	if($in eq "e") {

		#if the user wants to exit, exit the loop
		last;
	}

	# the url of a spanish translation website with the word you want to translate
	my $url = "http://www.spanishdict.com/translate/" . $in;

	# create a new mech object
	my $mech = WWW::Mechanize->new();

	# get the webpage
	$mech->get($url);

	#create an array with links on the page
	my @array = $mech->links();

	#go through each link in the array
	for my $link(@array) {

		#make sure the url is more than 37 characters (indicates 'http://www.spanishdict.com/translate/' + translated word)
		if(length($link->url) > 37) {

			#make sure the link has text
			if(!($link->text) eq "") {

				#make sure the word in the url corresponds to the word in the link's text
				if(substr($link->url, 37, length($link->url)) eq $link->text) {

					#print translation, but no new line b/c there can be multiple translations 
					print $link->text . " ";
				}
			}
		}
	}

	print "\n";
}
