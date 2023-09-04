#!/bin/bash

#Para o ícon utilizamos a tabela de ícones do gnome (https://developer-old.gnome.org/icon-naming-spec/)

inicio=$(zenity --icon-name="security-high" --info \
	--title="Iptables" --text="
	Bem-vindo ao nosso sistema
       	de configuração de iptables
	Aqui você poderá criar, editar
	e excluir regras de iptables

	Este trabalho foi feito por

       	Magno, Murilo e Roger
	
	:) 

	"\
	--width=100\
	--height=100)



#Funções

criar_regra(){
	echo "Criar uma regra"
	temporario=$(mktemp)

       item1=$(zenity --list --radiolist \
    		--title="Criar Regra" \
    		--text "Selecione em qual posição a regra será criada" \
    		--column "Marcar" \
    		--column "Posição" \
    		TRUE "Início da lista" \
    		FALSE "Final da lista" \
    		--ok-label "Próximo" \
    		--cancel-label "Sair" \
    		--separator=" " \
		2>/dev/null
    		> "$temporario"
	)
	if [ "$item1" == "Início da lista" ];then
	       	item1="1"
	else 
		item1="A"
	fi	

	echo "$item1"
	
		if [ $? -eq 1 ]; then
    			rm "$temporario"
    		exit 1
		fi

	item2=$(zenity --list --radiolist \
                --title="Criar Regra" \
                --text "Qual cadeia será criada a regra" \
                --column "Marcar" \
                --column "Cadeia" \
                TRUE "INPUT" \
                FALSE "OUTPUT" \
                FALSE "FORWARD" \
                --ok-label "Confirmar" \
                 --cancel-label "Sair" \
                --separator=" " \
                2>/dev/null
        >> "$temporario"
        
        )



        echo "$item2"

        if [ $? -eq 1 ]; then
                rm "$temporario"
        exit 1
        fi





	item3=$(zenity --list --radiolist \
    		--title="Criar Regra" \
    		--text "Selecione o Alvo da Regra" \
    		--column "Marcar" \
    		--column "Alvo da Regra" \
    		TRUE "Aceitar" \
    		FALSE "Rejeitar" \
   		FALSE "Descartar" \
    		--ok-label "Confirmar" \
   		 --cancel-label "Sair" \
    		--separator=" " \
		2>/dev/null
    	>> "$temporario"
	
	)
	
	if [ "$item3" == "Inicio" ]; then
		item3=0
	elif [ "$item3" == "Meio" ]; then
		item3=1
	else
		item3=2
	fi


	echo "$item3"
	
	if [ $? -eq 1 ]; then
    		rm "$temporario"
    	exit 1
	fi
	
     item3=$(zenity --forms --title="Criar Regra" \
	--text="Opções de filtragem" \
	--separator="," \
	--add-entry="Endereço de Origem" \
	--add-entry="Endereço de Destino" \
	--add-entry="Protocolo" \
	--add-entry="Porta de Origem" \
	--add-entry="Porta de Destino" \
	--add-entry="Endereço MAC" \
	--add-entry="Estado" \
	--add-entry="Interface de Entrada" \
	--add-entry="Interface de Saída"
        2>/dev/null
	)
echo "$item3"
	>> "$temporario"

        if [ $? -eq 1 ]; then
                rm "$temporario"
        exit 1
        fi


	selecionadoss=$(cat "$temporario")

	echo  "Opção escolhida: $selecionados"

	rm "$temporario"

}


configurar_politica() {
	echo "Configurar Política"
}

apagar_regra(){
	echo "Apagar uma regra"
}



listar_regras(){
	echo "Listar regras"
	sudo iptables -L > regras.txt
	file="regras.txt"
	file_text=$(cat "$file")
	zenity --info --icon-name="folder-open" --title "Listar todas as regras" --text="$file_text" 

}

apagar_todas_regras(){
	echo "Apagar todas as regras"
}

salvar_regras(){
	echo "Salvas as regras do firewall"
}

restaurar_regras(){
	echo "Restaurar as regras do firewall"
}

if [ $inicio ]
       	verificador=$1
	while [ $verificador==1 ]
	do		
		item=$(zenity --list --title="Opções iptables" --width=500 --height=350 --text "Selecione uma opção"\
			--radiolist \
			--ok-label "Confirmar" \
		       	--cancel-label "Sair" \
			--column "Marcar" \
			--column "Ação" \
			TRUE "Criar uma regra" \
			FALSE "Configurar Política Padrão" \
			FALSE "Apagar um regra" \
			FALSE "Listar todas as regras" \
			FALSE "Apagar todas as regreas" \
			FALSE "Salvar as regrass do firewall" \
			FALSE "Restaurar as regras do firewall"\
			

		)
		if [[ "$?" != "0" ]]; then
			    exit 1
		 else
			    case $item in
				"Criar uma regra")
			    	criar_regra;;
			"Configurar Política Padrão")
				configurar_politica;;
			"Apagar um regra")
				apagar_regra;;
			"Listar todas as regras")
				listar_regras;;
			"Apagar todas as regreas")
				apagar_todas_regras;;
			"Salvar as regrass do firewall")
				salvar_regras;;
			"Restaurar as regras do firewall")
				restaurar_regras;;

		esac

				
		fi

	       	
	done
		echo "Saiu"

then echo "Deu certo $item"
fi

