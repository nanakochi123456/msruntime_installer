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
	next if($infname!~/^VC/);
	$title=$inf{$inf{LIST}{$i}}{TITLE};
	$title=~s/\ \*\*$//g;
	$url=$inf{$inf{LIST}{$i}}{FILE};
	$cmd=$inf{$inf{LIST}{$i}}{RENAME};
	$opt=$inf{$inf{LIST}{$i}}{CMD};
	$size=$inf{$inf{LIST}{$i}}{SIZE};
	$title=~s/\(/i/g;
	$title=~s/\)/j/g;
	if($title=~/x64/) {
		$lines64++;
		$addline64.="$url,$cmd,$opt,$title,$size\n";
	} else {
		$lines++;
		$addline.="$url,$cmd,$opt,$title,$size\n";
	}
}

open(W,">vcregist_x86.inf");

$l=1;
foreach(split(/\n/,$addline)) {
	print W "$_\n";
}
close(W);

open(W,">vcregist_x64.inf");

$l=1;
foreach(split(/\n/,$addline64)) {
	print W "$_\n";
}
close(W);

`nkf -sjis <vcregist_x86.inf>vcredist_x86.inf`;
`nkf -sjis <vcregist_x64.inf>vcredist_x64.inf`;
unlink("vcregist_x86.inf");
unlink("vcregist_x64.inf");
