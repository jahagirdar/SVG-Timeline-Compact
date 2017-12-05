package SVG::Slotted::Event;
use DateTime;
use Data::Printer;
use DateTime::Duration;
use v5.10;
use Moose;
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
	return $self->distance($self->origin,$self->start);
}
sub width{
	my $self=shift;
	return $self->distance($self->start,$self->end);
}
sub distance {
	my ($self,$start,$end)=@_;
	if ($self->resolution eq "minutes") {
		my $dist=$start->delta_ms($end)->{minutes};
		$dist=$self->min_width if $dist<$self->min_width;
		return $dist;
	}
	if ($self->resolution eq"hours") {
		my $dist=$start->delta_ms($end)->{minutes}/60;
		$dist=$self->min_width if $dist<$self->min_width;
		return $dist;
	}
	if ($self->resolution eq"days") {
		my $dist=$start->delta_days($end)->{days};
		$dist=$self->min_width if $dist<$self->min_width;
		return $dist;
	}
	if ($self->resolution eq"weeks") {
		my $dist=$start->delta_days($end)->{days}/7;
		$dist=$self->min_width if $dist<$self->min_width;
		return $dist;
	}
	if ($self->resolution eq "months") {
		my $dist=$start->delta_months($end)->{months};
		$dist=$self->min_width if $dist<$self->min_width;
		return $dist;
	}
	if ($self->resolution eq "years") {
		my $dist=($end-$start)->{years};
		$dist=$self->min_width if $dist<$self->min_width;
		return $dist;
	}
}
1;
