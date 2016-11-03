#!/usr/bin/perl
##use lib "/home/jnovaslp/perl/usr/lib/perl5/site_perl/5.8.8";
####
#Meetup Feed Fetcher
#
#Originally Developed by: Tyler Worman nova1313@novaslp.net
#
#Please report all bugs to: operations@allhandsactive.org
#Last Updated: 11/3/2016
#
#Version 1.0
#
#Purpose:
#Fetch and parse an RSS Feed from Meetup for events.
#
#Open Source, but you may not sell any dirivative of this code. 
#You need not publish any changes you make, but if you do let us know.

#Contact: support@novaslp.net with any questions on licensing.
#

##Includes, basic stuff for web.
use XML::Simple;
use HTTP::Request;
use LWP::UserAgent;
use Data::Dumper;

#Fetch RSS Feed
$rss = "https://www.meetup.com/AllHandsActive/events/rss/";

my $ua = LWP::UserAgent->new;

#Fetch data
my $res = $ua->get($rss); # Post message to the Service Provider

if ($res->is_success) {
    $xml = XML::Simple->new;
    #parse the XML
    $data = $xml->XMLin($res->content);
    ##print Dumper($data);
    ##Get number of entries not to exceed 10
    $count = @{$data->{item}};
	if ($count > 10) {
	   $count = 10;
	}
    ##Print text
    for ($i = 0; $i < $count; $i++) {
		print "<a href=$data->{item}[$i]{guid}>$data->{item}[$i]{title}</a> @ $data->{channel}{item}[$i]{pubDate}<br>\n";
    }
} else {
	print Dumper($res);
        die "Something failed";
}

##End
exit 0;
