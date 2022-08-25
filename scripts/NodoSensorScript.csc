#Sets the battery level to 100 Joules
battery set 100
set ite 0
set ant 999

atget id id
getpos2 lonSen latSen

loop
wait 100
read mens
rdata mens tipo valor

#Increments ite variables, and stops after 1000 cycles
inc ite
print ite
if (ite >= 1000)
	stop
end

if((tipo=="hola") && (ant == 999))
   set ant valor
   data mens tipo id
   send mens * valor
end

if(tipo=="alerta")
   send mens ant
end

# Stops if receives a mens of "stop"
if (tipo=="stop")
	data mens "stop"
	send mens * valor
	cprint "Para sensor: " id
	wait 1000
	stop
end

delay 1000

areadsensor tempSen
rdata tempSen SensTipo idSens temp

if( temp>30)
   data mens "alerta" lonSen latSen
   send mens ant
end

#Runs if battery value Bat is lower than 5 Joules
battery bat
cprint "Para sensor: " id "Nivel de bateria: " bat
if(bat<5)
	data mens "critico" lonSen latSen
	send mens ant
end