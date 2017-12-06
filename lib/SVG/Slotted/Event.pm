package SVG::Slotted::Event;

# ABSTRACT: Event Container for SVG::Slotted::Timeline

use DateTime;
use Data::Printer;
use DateTime::Duration;
use v5.10;
use Moose;

=head1 DESCRIPTION

This module should not be called by the user. It is for internal use of SVG::Slotted::Timeline.

=method new

=for :list
= id Optional, Event ID.
= start Required, DateTime Object representing the Start Time.
= end Required, DateTime Object representing the End Time.
= name Required, Event Name.
= tooltip Optional, Event Tooltip.
= color, Optional, The RGB value for filling the rectangle representing the event.


=cut

has resolution=>(is=>'rw',isa=>'Str');
has id =>(is=>'rw',isa=>'Int');
has origin=>(is=>'rw',isa=>'DateTime');
has start =>(is=>'ro',isa=>'DateTime');
has end=>(is=>'ro',isa=>'DateTime');
has name =>(is=>'ro');
has tooltip =>(is=>'ro');
has color =>(is=>'ro', isa=>"Str");
has min_width =>(is=>'ro',isa=>'Int');
has _start =>(is=>'rw',isa=>'DateTime');
has _width =>(is=>'rw',isa=>'Int');
sub x0{
	my $self=shift;
	return $self->distance($self->origin,$self->start,0);
}
sub width{
	my $self=shift;
	return $self->distance($self->start,$self->end);
}
sub distance {
	my ($self,$start,$end,$minwidth)=@_;
	$minwidth=$self->min_width if !defined $minwidth;
	if ($self->resolution eq "minutes") {
		my $dist=$start->delta_ms($end)->{minutes};
		$dist=$minwidth if $dist<$minwidth;
		return $dist;
	}
	if ($self->resolution eq"hours") {
		my $dist=$start->delta_ms($end)->{minutes}/60;
		$dist=$minwidth if $dist<$minwidth;
		return $dist;
	}
	if ($self->resolution eq"days") {
		my $dist=$start->delta_days($end)->{days};
		$dist=$minwidth if $dist<$minwidth;
		return $dist;
	}
	if ($self->resolution eq"weeks") {
		my $dist=$start->delta_days($end)->{days}/7;
		$dist=$minwidth if $dist<$minwidth;
		return $dist;
	}
	if ($self->resolution eq "months") {
		my $dist=$start->delta_months($end)->{months};
		$dist=$minwidth if $dist<$minwidth;
		return $dist;
	}
	if ($self->resolution eq "years") {
		my $dist=($end-$start)->{years};
		$dist=$minwidth if $dist<$minwidth;
		return $dist;
	}
}
1;
