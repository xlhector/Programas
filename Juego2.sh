#!/bin/bash

posx=1;
posy=1;
limite="";
limitpun=5;
campox=20;
campoy=10;
posxm=$(($RANDOM%($campox-1)+1))
posym=$(($RANDOM%($campoy-1)+1))
puntaje=0;
segrest=5;
segact=$(date +%S) segact=${segact#0}
segign=0;
segtemp=0;
segdec=0;



while true; do  #20

clear

echo "Mueva el punto con las Letras $limite"#20
echo "w o up:Arriba	q o Q:Salir"
echo "s o ↓:Abajo"
echo "a o ←:Izquierda	Puntaje	             : $puntaje"
echo "d o →:Derecha	Tiempo Restante      : $segrest"


#Pintar campo
for i in `seq 1 $campoy`; do
echo
#pintar las demas lineas 30
  if [ $posy -eq $i ] || [ $posym -eq $i ]; then #maquina o jugador están en esa linea
    for j in `seq 1 $campox`; do
      if [ $posx -eq $j ] && [ $posy -eq $i ]; then #Es jugador quien está ahí
        printf "*"
      elif [ $posxm -eq $j ] && [ $posym -eq $i ]; then #No, es máquina :D
        printf "^"
      else
        printf "-"
      fi
    done #40
  else
    for j in `seq 1 $campox`; do
      printf "-"
    done
  fi
done

echo
echo "________________________________"
#50
read -n 1 -p  "Presione una tecla:" tecla #captura la tecla para moverse
limite="";
case $tecla in
d | C )
 if [ $posx -eq $campox ]; then
   limite=" - Limite alcansado, haz llegado a la pared derecha"
   continue
 else
   posx=$(($posx+1));
 fi
 ;;
a | D )
 if [ $posx -eq 1 ]; then
   limite=" - Limite alcansado, haz llegado a la pared izquierda"
   continue
 else
   posx=$(($posx-1));
 fi
 ;;
s | B ) #70
 if [ $posy -eq $campoy ]; then
   limite=" - Limite alcansado, haz llegado a la pared baja"
   continue
 else
   posy=$(($posy+1));
 fi
 ;;
w | A )
 if [ $posy -eq 1 ]; then
   limite=" - Limite alcansado, haz llegado a la pared alta"
   continue
 else
   posy=$(($posy-1));
 fi
 ;;
q | Q) clear; echo "Gracias por jugar adios."; exit 0;;
esac

##simula el cronometro.
segtemp=$(date +%S) segtemp=${segtemp#0} 

     #ignora el código si trata de entrar 2 veces en un mismo segundo
if [ $segign -ne $segtemp ]; then  
while true; do
     #Si son iguales termina el ciclo
     if [ $segact -eq $segtemp ]; then
        break
     fi
  segdec=$(( $segdec + 1 )) #Lleva el conteo de los segundos que han pasado
     if [ $segact -eq 59 ]; then
        segact=0;
        continue;
     fi
   segact=$(( $segact + 1))
  done
fi

segign=$segtemp;
segrest=$(( $segrest - $segdec ))

#Si decrementó 1 seg. vuelve a obtener el tiempo actual
#esto significa que ya pasaron 1 o más segundos.
if [ $segdec -ge 1 ]; then
   segact=$(date +%S) segact=${segact#0} 
fi

#Reestablece el contador
segdec=0


#Verifica si perdiste por tiempo
if [ $segrest -le 0 ]; then
   clear
   echo "Usted ha perdido el juego :C!!!, se le acabó el tiempo"
   exit 0;
fi

##Verfica si alcanzaste el objetivo
if [ $posy -eq $posym ] && [ $posx -eq $posxm ]; then
puntaje=$((puntaje+1))
posxm=$(($RANDOM%($campox-1)+1))
posym=$(($RANDOM%($campoy-1)+1))
segrest=$(( $segrest + 2 ))
fi

#Cambia el nivel según el puntaje
if [ $puntaje -eq $limitpun ]; then
   campoy=$(($campoy+2))
   campox=$(($campox+5))
   limitpun=$(($limitpun*2))
fi
#Verifica si alcansaste el puntaje ganador
if [ $puntaje -eq 200 ]; then
   clear
   echo "************************************"
   echo "*Felicidades has ganado el juego!!!*"
   echo "************************************"
   echo
   echo "        *****************           "
   echo "        *****************           "
   echo "         ***************            "
   echo "           ***********              "
   echo "             *******                "
   echo "               ***                  "
   echo "                *                   "
   echo "                *                   "
   echo "            *********               "
   exit 0;
fi
done

