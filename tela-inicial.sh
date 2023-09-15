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
    		TRUE "ACCEPT" \
    		FALSE "REJECT" \
   		FALSE "DROP" \
    		--ok-label "Confirmar" \
   		 --cancel-label "Sair" \
    		--separator=" " \
		2>/dev/null
    	>> "$temporario"
	
	)
	

	echo "$item3"
	
	if [ $? -eq 1 ]; then
    		rm "$temporario"
    	exit 1
	fi
	
     item4=$(zenity --forms --title="Criar Regra" \
	--text="Opções de filtragem" \
	--separator="," \
	--add-entry="Endereço de Origem" \
	--add-entry="Endereço de Destino" \
	--add-entry="Protocolo" \
	--add-entry="Porta de Origem" \
	--add-entry="Porta de Destino" \
	--add-entry="Estado" \
	--add-entry="Interface de Entrada" \
	--add-entry="Interface de Saída"
        2>/dev/null
	
)

IFS=',' read -r endereco_origem endereco_destino protocolo porta_origem porta_destino estado interface_entrada interface_saida <<< "$item4"


echo "Endereço de Origem: $endereco_origem"
echo "Endereço de Destino: $endereco_destino"
echo "Protocolo: $protocolo"
echo "Porta de Origem: $porta_origem"
echo "Porta de Destino: $porta_destino"
echo "Estado: $estado"
echo "Interface de Entrada: $interface_entrada"
echo "Interface de Saída: $interface_saida"


echo "$item4"
	>> "$temporario"

        if [ $? -eq 1 ]; then
                rm "$temporario"
		zenity --error --text="Erro ao criar regra!"
        exit 1
        fi


	selecionadoss=$(cat "$temporario")

	echo  "Opção escolhida: $selecionados"

	rm "$temporario"

     if [ "$item1" == "1" ]; then
 	     sudo iptables -I "$item2" 1  -s $endereco_origem -d $endereco_destino \
		     -p $protocolo --sport $porta_origem --dport $porta_destino \
		     -m state --state "$estado" -i "$interface_entrada"  -j $item3
    else

	   if [ "$item2" == "INPUT" ];then		   
	    	sudo iptables -A "$item2" -s $endereco_origem -d $endereco_destino \
		   -p $protocolo --sport $porta_origem --dport $porta_destino \
		   -m state --state "$estado" -i "$interface_entrada"   -j $item3
		else
				   sudo iptables -A "$item2" -s $endereco_origem -d $endereco_destino \
                   -p $protocolo --sport $porta_origem --dport $porta_destino \
                   -m state --state "$estado" -o "$interface_saida"   -j $item3
	   fi

     fi
    echo "Regra criada com sucesso!"

   if [ $? -eq 0 ]; then
	  zenity --info --text="Regra criada com sucesso!"
  else
	 zenity --error --text="Erro ao criar regra!"
   fi 
}






configurar_politica() {
	echo "Configurar Política"
	politica=$(zenity --list --radiolist \
        --title="Configurar Política Padrão" \
        --text "Selecione a política padrão:" \
        --column "Marcar" \
        --column "Política" \
        TRUE "ACCEPT" \
        FALSE "REJECT" \
        FALSE "DROP" \
        --ok-label "Confirmar" \
        --cancel-label "Sair" \
        --separator=" " \
        2>/dev/null)

    if [ $? -eq 1 ]; then
        return 1
    fi

    cadeia=$(zenity --list --radiolist \
        --title="Configurar Política Padrão" \
        --text "Selecione a cadeia para configurar a política padrão:" \
        --column "Marcar" \
        --column "Cadeia" \
        TRUE "INPUT" \
        FALSE "OUTPUT" \
        FALSE "FORWARD" \
        --ok-label "Confirmar" \
        --cancel-label "Sair" \
        --separator=" " \
        2>/dev/null)

    if [ $? -eq 1 ]; then
        return 1
    fi

    sudo iptables -P $cadeia $politica

    if [ $? -eq 0 ]; then
        zenity --info --text="Política padrão configurada com sucesso para a cadeia $cadeia."
    else
        zenity --error --text="Erro ao configurar a política padrão para a cadeia $cadeia."
    fi
}


apagar_regra(){
	echo "Apagar uma regra"

	cadeia=$(zenity --list --radiolist \
        --title="Apagar uma regra" \
        --text "Selecione a cadeia da qual deseja apagar a regra:" \
        --column "Marcar" \
        --column "Cadeia" \
        TRUE "INPUT" \
        FALSE "OUTPUT" \
        FALSE "FORWARD" \
        --ok-label "Confirmar" \
        --cancel-label "Sair" \
        --separator=" " \
        2>/dev/null)

    if [ $? -eq 1 ]; then
        return 1
    fi

    regra_numero=$(zenity --entry --title="Apagar uma regra" --text="Digite o número da regra que deseja apagar:")

    if [ $? -eq 1 ] || [ -z "$regra_numero" ]; then
        return 1
    fi

    sudo iptables -D $cadeia $regra_numero

    if [ $? -eq 0 ]; then
        zenity --info --text="Regra $regra_numero da cadeia $cadeia apagada com sucesso."
    else
        zenity --error --text="Erro ao apagar a regra $regra_numero da cadeia $cadeia."
    fi
}



listar_regras(){
	echo "Listar regras"
	sudo iptables -L > regras.txt
	file="regras.txt"
	file_text=$(cat "$file")
	zenity --info --icon-name="folder-open" --title "Listar todas as regras" --text="$file_text" 

}

apagar_todas_regras(){
        echo "Apagando todas as regras do firewall"
        sudo iptables -F
        sudo iptables -X  
        zenity --info --title "Apagar todas as regras do firewall" --text "Todas as regras do firewall foram removidas."
}

salvar_regras(){
        nome_arquivo=$(zenity --entry --title "Salvar regras do firewall" --text "Digite o nome do arquivo para salvar as regras do firewall:")
        if [ -z "$nome_arquivo" ]; then
           zenity --error --title "Erro" --text "Nome do arquivo inválido. Insira um nome válido!"
           return
        fi

        nome_arquivo="$nome_arquivo.txt"
        sudo iptables-save > "$nome_arquivo"
        zenity --info --title "Salvar regras do firewall" --text "As regras do firewall foram salvas em $nome_arquivo"
}


restaurar_regras(){
        nome_arquivo=$(zenity --file-selection --title "Restaurar regras do firewall" --file-filter="Arquivos de regras de firewall (*.rules *.txt) | *.rules *.txt")
        if [ -z "$nome_arquivo" ]; then
           zenity --error --title "Erro" --text "Nome do arquivo inválido. Selecione um arquivo válido!"
           return
        fi

        sudo iptables-restore < "$nome_arquivo"
        zenity --info --title "Restaurar regras do firewall" --text "As regras do firewall foram restauradas a partir de $nome_arquivo."
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

