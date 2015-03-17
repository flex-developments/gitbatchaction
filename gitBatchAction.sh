########## Variables con su valor por defecto
action="push";
repo="a";
brand="master";

########## Opciones por defecto desabilitadas
verbose=false

########## Captura y evaluacion de parametros
while getopts a:r:b:vuh "option"
do
	case $option in
	########## De aqui en adelante se colocan las acciones de los parametros indicados
		a) action=$OPTARG;;

		r) repo=$OPTARG;;

		b) brand=$OPTARG;;

		v) verbose=true;;

		u) echo "Usage $0 \-[a|r|b|v|u|h]"
			exit 0;;

		h) echo "Ayuda\n-a Action: Accion de push o pull (push por default)\n-r Repository: Repositorio remoto contra el que se ejecutará la acción (gitlab por default)\n-b Brand: Rama contra la que se ejecutará la acción (master por default)"
			exit 0;;

	########## De aqui en adeñante son opciones por defecto
		\?) echo "Opción inválida -$OPTARG. Ejecutando '$0 -h' encontrará ayuda."
			exit 1;;
		:) echo "La opción -$OPTARG requiere un argumento. Ejecutando '$0 -h' encontrará ayuda."
			exit 1;;
	esac
done

if [ $# -ge 1 ]; then
	echo "Iniciando Ejecución con argumentos: $*";
else
	echo "Iniciando Ejecución con push gitlab master";
fi

########## Evaluacion de valores de variables


########## Funciones
gitBatchAction() {
	for i in `ls -d */ | sed 's/\///g'`
	do
		{
			if $verbose;then echo "*************************************"; pwd;fi
			cd $i;
			if $verbose;then pwd;fi
			git $action $repo $brand;
			cd ..;
		} || {
			cd ..;
		}
	done
}

gitFullInit() {
	for i in `ls -d */ | sed 's/\///g'`
	do
		{
			if $verbose;then echo "*************************************"; pwd;fi
			cd $i;
			if $verbose;then pwd;fi
			git init
			git add .
			git commit -m "First Commit"
			git config http.postBuffer 524288000
			git remote add a http://flopez@git.lab/flopez/$i.git
			git remote add hub https://flex-developments@github.com/flex-developments/$i.git
			git remote add lab https://flex.developments@gitlab.com/flex.developments/$i.git
			git remote add hubSUS https://flex-developments@github.com/suscerte/$i.git
			git remote add labSUS https://flex.developments@gitlab.com/suscerte/$i.git
			git remote add all http://flopez@git.lab/flopez/$i.git
			git config --add remote.all.url https://flex-developments@github.com/flex-developments/$i.git
			git config --add remote.all.url https://flex.developments@gitlab.com/flex.developments/$i.git
			git config --add remote.all.url https://flex-developments@github.com/suscerte/$i.git
			git config --add remote.all.url https://flex.developments@gitlab.com/suscerte/$i.git
			cd ..;
		} || {
			cd ..;
		}
	done
}

other() {
	echo "Nothing...";
}

########## Programacion
echo "";
echo "----- Iniciando Rutinas -----";
if [ "$action" = "fullInit" ]; then
	gitFullInit;
elif [ "$action" = "other" ]; then
	other;
else
	gitBatchAction;
fi
