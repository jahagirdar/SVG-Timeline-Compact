use Test::More;
use SVG::Slotted::Timeline;
use DateTime::Format::Natural;

use strict;
use warnings;
use diagnostics;
my $svg=SVG::Slotted::Timeline->new(
);
my $parser = DateTime::Format::Natural->new;
my $start=$parser->parse_datetime("12pm");
my $end=$parser->parse_datetime("1pm");

$svg->add_event(
		start=>$start,
		end=>$end,
		name=>"Event 1",
		tooltip=>"First Event of the example",
		color=>"#ff00ff"

);
 $start=$parser->parse_datetime("12:45pm");
 $end=$parser->parse_datetime("1:20pm");
$svg->add_event(
		start=>$start,
		end=>$end,
		name=>"Event 2",
		tooltip=>"Second Event of the example",
		color=>"#ff000f"

);
 $start=$parser->parse_datetime("3:00pm");
 $end=$parser->parse_datetime("5:20pm");
$svg->add_event(
		start=>$start,
		end=>$end,
		name=>"Event 3",
		tooltip=>"Third Event of the example",
		color=>"#fff00f"

);
open my $fh,">","test.svg" or die "unable to open test.svg for writing";
print $fh $svg->to_svg;
ok($svg);
done_testing;
