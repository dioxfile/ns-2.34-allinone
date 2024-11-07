#
# nodes: 8, max conn: 20, send rate: 0.10000000000000001, seed: 1
#
#
# 3 conectando a 1 no tempo 1.4204660437165137
#
set udp_(0) [new Agent/UDP]
$ns_ attach-agent $node_(3) $udp_(0)
set dest(0) [new Agent/LossMonitor]
$ns_ attach-agent $node_(1) $dest(0)
set cbr_(0) [new Application/Traffic/CBR]
$cbr_(0) set packetSize_ 1500
$cbr_(0) attach-agent $udp_(0)
$ns_ connect $udp_(0) $dest(0)
$ns_ at 1.4204660437165137 "$cbr_(0) start"
#
# 2 conectando a 3 no tempo 31.296177176430906
#
set udp_(1) [new Agent/UDP]
$ns_ attach-agent $node_(2) $udp_(1)
set dest(1) [new Agent/LossMonitor]
$ns_ attach-agent $node_(3) $dest(1)
set cbr_(1) [new Application/Traffic/CBR]
$cbr_(1) set packetSize_ 1500
$cbr_(1) attach-agent $udp_(1)
$ns_ connect $udp_(1) $dest(1)
$ns_ at 31.296177176430906 "$cbr_(1) start"
#
# 1 conectando a 2 no tempo 81.64760516101849
#
set udp_(2) [new Agent/UDP]
$ns_ attach-agent $node_(1) $udp_(2)
set dest(2) [new Agent/LossMonitor]
$ns_ attach-agent $node_(2) $dest(2)
set cbr_(2) [new Application/Traffic/CBR]
$cbr_(2) set packetSize_ 1500
$cbr_(2) attach-agent $udp_(2)
$ns_ connect $udp_(2) $dest(2)
$ns_ at 81.64760516101849 "$cbr_(2) start"
#
# 3 conectando a 0 no tempo 30.90790576809454
#
set udp_(3) [new Agent/UDP]
$ns_ attach-agent $node_(3) $udp_(3)
set dest(3) [new Agent/LossMonitor]
$ns_ attach-agent $node_(0) $dest(3)
set cbr_(3) [new Application/Traffic/CBR]
$cbr_(3) set packetSize_ 1500
$cbr_(3) attach-agent $udp_(3)
$ns_ connect $udp_(3) $dest(3)
$ns_ at 30.90790576809454 "$cbr_(3) start"
#
#Total sources/connections: 3/4
#
