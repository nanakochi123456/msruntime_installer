open(R,"cat default_w7_x64.lst|nkf --oc=UTF-8|");
@lst=<R>;
close(R);

foreach(@lst) {
	$buf=~s/[\r\n]//g;
	$buf.="$_\t";
}
foreach(split(/\t\[/,$buf)) {
	$infname=$_;
	$infname=~s/\].*//g;
	$data=$_;
	$data=~s/.*\]//g;
	foreach $line(split(/\t/,$data)) {
		($l,$r)=split(/=/,$line);
		$inf{$infname}{$l}=$r;
	}
}

for($i=1; $i<=$inf{LIST}{COUNT}; $i++) {
	$infname=$inf{LIST}{$i};
	next if($infname!~/^DIRECTX/);
	$title=$inf{$inf{LIST}{$i}}{TITLE};
	$title=~s/\ \*$//g;
	$url=$inf{$inf{LIST}{$i}}{FILE};
	$cmd=$infname;
	$opt=$inf{$inf{LIST}{$i}}{CMD};
	$size=$inf{$inf{LIST}{$i}}{SIZE};
	$lines++;
	$title=~s/\(/（/g;
	$title=~s/\)/）/g;
	$addline.="$url,$cmd.exe,$opt,$title,$size\n";
}

open(W,">_directx.inf");

$l=1;
foreach(split(/\n/,$addline)) {
	print W "$_\n";
}
close(W);

`nkf -sjis <_directx.inf>directx.inf`;
unlink("_directx.inf");
