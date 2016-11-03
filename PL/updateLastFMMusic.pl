#!/usr/bin/perl
use lib "/home/jnovaslp/perl/usr/lib/perl5/site_perl/5.8.8";
####
#Last FM Music feed fethcer
#
#Originally Developed by: Tyler Worman tsworman@lurkingplacestudios.com
#
#Please report all bugs to: support@lurkingplacestudios.com
#Last Updated: 7/3/2010
#
# 
#Version 1.0
#
#
#Purpose:
#Fetch and parse an RSS Feed from Last FM for Music.
#
#Open Source, but you may not sell any dirivative of this code. 
#You need not publish any changes you make, but if you do let us know.
#Contact: Support@lurkingplacestudios.com with any questions on licensing.
#

##Includes, basic stuff for web.

use XML::Simple;
use HTTP::Request;
use LWP::UserAgent;
use Data::Dumper;


#Fetch RSS Feed
$rss = "http://ws.audioscrobbler.com/2.0/user/MajesticMantra/recenttracks.rss";

my $ua = LWP::UserAgent->new;

#Fetch data
my $res = $ua->get($rss); # Post message to the Service Provider

if ($res->is_success) {
    $xml = XML::Simple->new;
    #parse the XML
    $data = $xml->XMLin($res->content);
    ##print Dumper($data);
    ##Get number of entries not to exceed 10
    $count = @{$data->{channel}{item}};
    ##Print text
    for ($i = 0; $i < $count; $i++) {
	print "<a href=$data->{channel}{item}[$i]{link}>$data->{channel}{item}[$i]{title}</a> @ $data->{channel}{item}[$i]{pubDate}<br>\n";
    }
} else {
	print Dumper($res);
        die "Something failed";
}

##End
exit 0;
