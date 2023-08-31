#!/bin/bash

#Para o ícone utilizamos a tabela de ícones do gnome (https://developer-old.gnome.org/icon-naming-spec/)

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

if [ $inicio ]
       	verificador=$1
	while [ $verificador==1 ]
	do		
		item=$(zenity --list --title="Opções iptables" --width=500 --height=250 --text "Selecione uma opção"\
			--radiolist \
			--ok-label "Confirmar" \
		       	--cancel-label "Sair" \
			--column "Marcar" \
			--column "Ação" \
			TRUE "Criar uma regra" \
			FALSE "Configurar Política Padrão" \
			FALSE "Apagar um regra" \
			FALSE "Listar uma Regra" \
			FALSE "Listar todas as regras" \
			FALSE "Apagar todas as regreas" \
			FALSE "Salvar as regrass do firewall" \
			FALSE "Restaurar as regras do firewall"\
			

		)
		if [[ "$?" != "0" ]] ; then
			    exit 1
		fi

	       	
	done
		echo "Saiu"

then echo "Deu certo $item"
fi

