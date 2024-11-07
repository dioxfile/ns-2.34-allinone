#Script TCL MANET (Mobile Ad Hoc Network)
#Ambiente de Simula��o Com nodos Ego�stas
#=================DEFINIÇÕES=====================================================================================
  global val defaultRNG 
  set val(canal)           Channel/WirelessChannel  ;# Tipo de Canal (1-11)
  set val(propacacao)      Propagation/TwoRayGround ;# Modelo de propaga��o de r�dio
  set val(antena)          Antenna/OmniAntenna      ;# Tipo de antena (omni ou direta)
  set val(layer2)          LL                       ;# Tipo de camada de Enlace
  set val(drop)             Queue/DropTail/PriQueue ;# Inerface de tipo de fila (fila = f; f<=50; se f> 50 pk s�o descartados)
  set val(fileSize)        50                       ;# Comprimento da fila
  set val(wlan0)           Phy/WirelessPhy          ;# Tipo de Interface de rede (Assimila-se ao DSSS)
  set val(mac)             Mac/802_11               ;# Tipo de MAC, nesse caso IEEE 802.11 modo DCF 
  set val(routP)           AODV                     ;# Protocolo de roteamento Ad Hoc
  set val(nodo)             10                      ;# N�mero de nodos m�veis
  set val(x)               600                      ;# Tamanho da posi��o do eixo X
  set val(y)               600                      ;# Tamanho da posi��o do eixo X
  set val(trafego)           4                      ;# Numero de fontes de Tr�fego
  set val(TX)               0.5                     ;# Energia gasta para transmiss�o
  set val(RX)               0.5                     ;# Energia gasta para Recep��o 
  set val(IniEner)         100.00                   ;# Energia Inicial total do nodo
  set val(ModEner)         EnergyModel              ;# Define a qtd de energia gasta p/  transmitir um pacote 
  set val(termina)         200
#===============================================================================================================

#==================Criando uma NIC para o padr�o IEEE 802.11b=====================================
#===========================HR-DSSS (IEEE802.11b) ================================================
   $val(mac)       set SlotTime_          0.000020        ;# 20us
   $val(mac)       set SIFS_              0.000010        ;# 10us
   $val(mac)       set PreambleLength_    144             ;# 144 bit
   $val(mac)       set PLCPHeaderLength_  48              ;# 48 bits
   $val(mac)       set PLCPDataRate_      1.0e6           ;# 1Mbps
   $val(mac)       set dataRate_          11.0e6          ;# 11Mbps
   $val(mac)       set basicRate_         1.0e6           ;# 1Mbps
   $val(wlan0)     set freq_              2.4e+9          ;# Frequ�ncia configurada para 2.4GHz
   $val(wlan0)     set Pt_                3.3962527e-2    ;# Pot�ncia do transmissor da placa TX
   $val(wlan0)     set RXThresh_          6.309573e-12    ;# Pot�ncia da Sensibilidade do Receptor RX.
   $val(wlan0)     set CSThresh_          6.309573e-12    ;# Pot�ncia da Sensibilidade da Portadora CS.


#In�cio da Simula��o
set ns_ [new Simulator]
$defaultRNG seed NEW_SEED
#Usar o novo formato de trace file
#$ns_ use-newtrace

# Abrindo e Gravando no arquivo NAM
set ArquivoNam [open NAM_Arquivo.nam w]
$ns_ namtrace-all $ArquivoNam
$ns_ namtrace-all-wireless $ArquivoNam $val(x) $val(y)


# Abrindo e Gravando no arquivo trace
set ArquivoTrace [open TRACE_Arquivo.tr w]
$ns_ trace-all $ArquivoTrace


#trace da Vaz�o (Throughput)
#Configura  o trace da vaz�o
for {set v 0} {$v < $val(trafego)} {incr v} {
set th($v) [open throughput$v.tr w]
#if { $v >=  0 && $v < $val(trafego)} { set th($v) [open throughput$v.tr w] }
}

#Defini��o da Topologia
set topologia [new Topography]
$topologia  load_flatgrid $val(x) $val(y)

#Inicializando o canal 1
set chan_1_ [new $val(canal)]

#Defini��o T�cnica do Nodo IEEE 802.11 DCF Mode
$ns_ node-config -adhocRouting $val(routP) \
                -llType $val(layer2) \
		-macType $val(mac) \
		-ifqType $val(drop) \
		-ifqLen $val(fileSize) \
		-antType $val(antena) \
		-propType $val(propacacao) \
		-phyType $val(wlan0) \
		-topoInstance $topologia \
		-channel $chan_1_ \
		-agentTrace ON \
		-routerTrace ON \
		-macTrace OFF \
		-movementTrace OFF \
		-energyModel $val(ModEner) \
		-initialEnergy $val(IniEner) \
		-rxPower $val(RX) \
 		-txPower $val(TX)  

#Armazena Informa��o de conectividade da Topologia
set god_ [create-god $val(nodo)]

#Cria��o dos nodos
for {set n 0} {$n < $val(nodo)} {incr n} {
set node_($n) [$ns_ node]
$node_($n) random-motion 0 ;#desativado 
}

#Distribui��o dos nodos usando modelo de mobilidade Random WayPoint
puts "Iniciando o padr�o de movimenta��o Random Waypoint..."
source "PM_10n_600xy.tcl"

#Define a posi��o inicial do nodo no nam
for {set n 0} {$n < $val(nodo) } {incr n} {
 $ns_ initial_node_pos $node_($n) 20
}

#Local onde se insere o n�mero de conex�es criadas geradoras de tr�fego FTP sobre TCP
puts "Iniciando o Tr�fego..."
source "D_cbrTraf4.tcl"

#Fun��o Random para desligar nodo
#puts "Carregando nodos ego�stas..."
#source "Selfish.tcl"

# Diz aos nodos quando a simula��o para
for {set n 0} {$n < $val(nodo) } {incr n} {
 $ns_ at $val(termina) "$node_($n) reset";
}


proc final {} {
global ns_ ArquivoTrace ArquivoNam th val 
$ns_ flush-trace
close $ArquivoTrace
close $ArquivoNam
 for {set i 0} {$i < $val(trafego) } {incr i} {
close $th($i)
}
exec nam NAM_Arquivo.nam &
exec xgraph throughput*.tr -geometry 800x400 & 
exit 0 
}

#Procedimento para gravar o throughput.
proc grava {} {
        global dest th val ns_ 
        #Obt�m uma instancia do simulador 
        set ns_ [Simulator instance]
        
        # Defina o per�odo de tempo ap�s o qual o processo deveria ser chamado novamente
        set time 0.5
        
        #Qual a quantidade de bytes recebidos por tr�fego recebidos nos sinks?
        for {set i 0} {$i < $val(trafego) } {incr i} {
        set bw($i) [$dest($i) set bytes_ ]
        #$dest($i) set bytes_ 0
       }
        
        #Obt�m o tempo atual (corrente)
        set now [$ns_ now]
        
        #Calcula a vaz�o ( em Mbps) e a escreve nos arquivos .tr
        for {set i 0} {$i < $val(trafego) } {incr i} {
        puts $th($i) "$now [expr $bw($i)/$time*8/1000000]"
        }
        
        #inicializa as vari�veis dos nodos destinos (sorvedouros)
       for {set i 0} {$i < $val(trafego) } {incr i} {
       $dest($i) set bytes_ 0
       }
        
        #Replaneja o procedimento em uma chamada recursiva
        $ns_ at [expr $now+$time] "grava"
}


puts "Iniciando a SIMULA��O (DioxSimulator)..."
$ns_ at 0.0 "grava"
$ns_ at $val(termina).001 "$ns_ nam-end-wireless $val(termina)"
$ns_ at $val(termina) "final"
$ns_ at $val(termina).002 "puts \"Fim da simula��o...\"; $ns_ halt" 
$ns_ run 











