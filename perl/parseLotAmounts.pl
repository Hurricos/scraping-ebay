#!/usr/bin/perl

use Text::CSV;
$csv = Text::CSV->new({
		       binary =>1, #special chars
		       eol => "\n",
		      });


open (QUERY, "iconv -c -t ascii < '$ARGV[0]' |");

my @outHeader = (
		 "Name", "Status", "Price", "Stars", "Ratings",
		 "Units", "Unit Price", "regex method"
		);

$csv->print(*STDOUT, \@outHeader);

my $header = <QUERY>;
while (my $line = <QUERY>) {
    &CleanGently($line);
    $csv->parse("$line") or die;

    @listing = $csv->fields();
    &CleanGently(@listing);

    my (
	$name,
	$status,
	$price,
	$stars,
	$ratings
       ) = @listing;

    my $method;
    my $lotamt;

    $price =~ s/[\$,]//g;

    $method = 1 if ($name =~ /(\d+)\s*pc[s\s\.]/i);
    ($lotamt) = ($name =~ /(\d+)\s*pc[s\s\.]/i);

    $method = 2 if ($name =~ /lot\s+o?f?[\s\(\)]*([\d]+)/i and !$lotamt);
    ($lotamt) = ($name =~ /lot\s+o?f?[\s\(\)]*([\d]+)/i) if !$lotamt;

    $method = 3 if ($name =~ /x[\s]*(\d{1,2})/ and !$lotamt);
    ($lotamt) = ($name =~ /x[\s]*(\d{1,2})/) if !$lotamt;

    # wrap-up
    my $unit_price = ($lotamt) ? ($price / $lotamt) : -1;

    my @toPrint = (@listing, $lotamt, $unit_price, $method);
    $csv->print(*STDOUT, \@toPrint);
}

sub CleanGently
{
    local($_);
    for $_ (@_) {
        $_ = "" if (!$_ and $_ ne 0);
        s/^\s+//;
        s/\s+$//;
        s/\r//g;
        s/^\n+//g;
    }
}
