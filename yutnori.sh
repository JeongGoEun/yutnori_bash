#!/bin/bash

# File : main.sh
# Content : software practice project 1 #2
# Name : Jeong Go Eun
# Last modified 06/17/2016
# Environment : Ubuntu 14.04 LTS, vim

# global variable

IFS=''

p1_color=0 p2_color=0 color=0
p1_name=0 p2_name=0 name=0
declare -i p1_xpos=(71 71 71 71) p1_ypos=(36 36 36 36) p1_where=(0 0 0 0)
declare -i p2_xpos=(71 71 71 71) p2_ypos=(36 36 36 36) p2_where=(0 0 0 0)
declare -i yut_cnt=0 yut_pos=81
declare -i piece_num=0
declare -a p1_goal p2_goal
declare -a p1_choice=(1 2 3 4) p2_choice=(1 2 3 4) bback_num=(1 0 0 0)
declare -i hasugu_in hasugu_out
declare -a p1_overlap p2_overlap p1_overlap2 p2_overlap2
declare -i end=0 j_check=0 remain_p1 remain_p2 ter_num=0
declare -i taken=0 over_num1 over_num2 over_num 
declare -i bback_check=0 goal_bback=0 bback_goal=0 pop_check=0

# user library function

gotoxy() {
	tput cup $1 $2
}
gotoxy_put() {
	tput cup $1 $2
	echo $3
}

# divide by function for maintain

entrance_screen() {
	gotoxy 10 0
	echo "                    __   __     _                    _  "
	echo "                    \ \ / /   _| |_ _ __   ___  _ __(_) "
	echo "                     \ v / | | | __| '_ \ / _ \| '__| | "
	echo "                      | || |_| | |_| | | | (_) | |  | | "
	echo "                      |_| \__,_|\__|_| |_|\___/|_|  |_| "
	gotoxy_put 20 25 "Press space to continue"
	read -s -d ' '
}

choice_color()
{
	gotoxy_put 17 23 "Press Number"
	for (( ; ; )); do
		gotoxy 18 23
		read -s -N 1 -p ">>" num    # input one key 
		if [[ "$num" == $'\x0a' ]] && [ "$color" != 0 ]; then
			return	# if key is enter and color is seleted
		elif [ "$num" != 0 ] && [ "$p1_color" = "$num" ]; then
			echo "[35mAlready Selected[0m     "		# check overlap
			num=0
		elif [ "$num" = "1" ]; then
			echo "[33mYELLO[0m                "
		elif [ "$num" = "2" ]; then
			echo "[31mRED[0m                  "
		elif [ "$num" = "3" ]; then
			echo "[34mBLUE[0m                 "
		elif [ "$num" = "4" ]; then
			echo "[32mGREEN[0m                "
		else
			continue
		fi
		color=$num
	done
}
color_menu() {
	gotoxy_put 12 30 "1.[33m ● YELLO [0m"
	gotoxy_put 13 30 "2.[31m ● RED [0m"
	gotoxy_put 14 30 "3.[34m ● BLUE [0m"
	gotoxy_put 15 30 "4.[32m ● GREEN [0m" 
}
select_color() {
# player 1 select
	tput clear
	gotoxy_put 10 30 "[31m<1P>  [0mSELECT COLOR"
	color_menu
	while [ $color = 0 ]; do choice_color; done
	p1_color=$color
# player 2 select
	color=0
	tput clear
	gotoxy_put 10 30 "[34m<2P>  [0mSELECT COLOR"
	color_menu
	while [ $color = 0 ]; do choice_color; done
	p2_color=$color
	case "$p1_color" in
		1) p1_color=33;;
		2) p1_color=31;;
		3) p1_color=34;;
		4) p1_color=32;;
	esac
	case "$p2_color" in
		1) p2_color=33;;
		2) p2_color=31;;
		3) p2_color=34;;
		4) p2_color=32;;
	esac
}

valid_name() {
	tput sc	# save cursor position
	read -p "Name : " name
	if [ -z "$name" ]; then # input is null, no process.
		tput rc	# restore cursor position
		valid_name	# recursion
	elif [ "$p1_name" = "$name" ]; then
		gotoxy_put 12 43 "[35mAlready Exists type again[0m            "
		read -s -n 1 	# delay for error message
		gotoxy_put 12 43 "                                                "
		tput rc	# restore cursor position
		valid_name
	else
		return
	fi
}
select_name() {
#player 1 select
	tput clear
	gotoxy 10 30
	echo -e "[${p1_color}m<1P>  [0m\c"
	valid_name
	p1_name=$name
#player 2 select
	gotoxy 12 30
	echo -e "[${p2_color}m<2P>  [0m\c"
	valid_name
	p2_name=$name
}
hasugu_rule()
{
	local -i i=0 yut_cnt
	
	hasugu_in=`expr $RANDOM % 19 + 1`
	hasugu_out=`expr $RANDOM % 19 + 1`
	hasugu_cnt=`expr $hasugu_out - $hasugu_in`

	if [ $hasugu_in -ge $hasugu_out ];then
		hasugu_rule
	elif [ $hasugu_in -lt $hasugu_out ];then

	case $hasugu_in in
	1) a=1;;
	2)b=1;;
	3)c=1;;
	4)d=1;;
	5)e=1;;
	6)f=1;;
	7)g=1;;
	8)h=1;;
	9)ii=1;;
	10)jj=1;;
	11)kk=1;;
	12)ll=1;;
	13)m=1;;
	14)n=1;;
	15)o=1;;
	16)p=1;;
	17)q=1;;
	18)r=1;;
	19)s=1;;
	esac

	case $hasugu_out in
	1) a=2;;
	2)b=2;;
	3)c=2;;
	4)d=2;;
	5)e=2;;
	6)f=2;;
	7)g=2;;
	8)h=2;;
	9)ii=2;;
	10)jj=2;;
	11)kk=2;;
	12)ll=2;;
	13)m=2;;
	14)n=2;;
	15)o=2;;
	16)p=2;;
	17)q=2;;
	18)r=2;;
	19)s=2;;
	esac

	else
		hasugu_rule

	fi
	
	
}
yut_back() {
	gotoxy_put 13 $yut_pos "[33m┌───┐  [0m"
	gotoxy_put 14 $yut_pos "[33m│   │  [0m"
	gotoxy_put 15 $yut_pos "[33m│   │  [0m"
	gotoxy_put 16 $yut_pos "[33m│   │  [0m"
	gotoxy_put 17 $yut_pos "[33m│   │  [0m"
	gotoxy_put 18 $yut_pos "[33m│   │  [0m"
	gotoxy_put 19 $yut_pos "[33m│   │  [0m"
	gotoxy_put 20 $yut_pos "[33m│   │  [0m"
	gotoxy_put 21 $yut_pos "[33m│   │  [0m"
	gotoxy_put 22 $yut_pos "[33m│   │  [0m"
	gotoxy_put 23 $yut_pos "[33m│   │  [0m"
	gotoxy_put 24 $yut_pos "[33m│   │  [0m"
	gotoxy_put 25 $yut_pos "[33m└───┘  [0m"
	yut_pos=`expr $yut_pos + 7`
}
yut_front() {
	gotoxy_put 13 $yut_pos "[33m┌───┐  [0m"
	gotoxy_put 14 $yut_pos "[33m│   │  [0m"
	gotoxy_put 15 $yut_pos "[33m│ x │  [0m"
	gotoxy_put 16 $yut_pos "[33m│   │  [0m"
	gotoxy_put 17 $yut_pos "[33m│ x │  [0m"
	gotoxy_put 18 $yut_pos "[33m│   │  [0m"
	gotoxy_put 19 $yut_pos "[33m│ x │  [0m"
	gotoxy_put 20 $yut_pos "[33m│   │  [0m"
	gotoxy_put 21 $yut_pos "[33m│ x │  [0m"
	gotoxy_put 22 $yut_pos "[33m│   │  [0m"
	gotoxy_put 23 $yut_pos "[33m│ x │  [0m"
	gotoxy_put 24 $yut_pos "[33m│   │  [0m"
	gotoxy_put 25 $yut_pos "[33m└───┘  [0m"
	yut_pos=`expr $yut_pos + 7`
}
effect_yut_back() {
	gotoxy_put 13 $yut_pos "[34m┌───┐  [0m"
	gotoxy_put 14 $yut_pos "[34m│   │  [0m"
	gotoxy_put 15 $yut_pos "[34m│   │  [0m"
	gotoxy_put 16 $yut_pos "[34m│   │  [0m"
	gotoxy_put 17 $yut_pos "[34m│   │  [0m"
	gotoxy_put 18 $yut_pos "[34m│   │  [0m"
	gotoxy_put 19 $yut_pos "[34m│   │  [0m"
	gotoxy_put 20 $yut_pos "[34m│   │  [0m"
	gotoxy_put 21 $yut_pos "[34m│   │  [0m"
	gotoxy_put 22 $yut_pos "[34m│   │  [0m"
	gotoxy_put 23 $yut_pos "[34m│   │  [0m"
	gotoxy_put 24 $yut_pos "[34m│   │  [0m"
	gotoxy_put 25 $yut_pos "[34m└───┘  [0m"
	yut_pos=`expr $yut_pos + 7`
}
effect_yut_front() {
	gotoxy_put 13 $yut_pos "[34m┌───┐  [0m"
	gotoxy_put 14 $yut_pos "[34m│   │  [0m"
	gotoxy_put 15 $yut_pos "[34m│ x │  [0m"
	gotoxy_put 16 $yut_pos "[34m│   │  [0m"
	gotoxy_put 17 $yut_pos "[34m│ x │  [0m"
	gotoxy_put 18 $yut_pos "[34m│   │  [0m"
	gotoxy_put 19 $yut_pos "[34m│ x │  [0m"
	gotoxy_put 20 $yut_pos "[34m│   │  [0m"
	gotoxy_put 21 $yut_pos "[34m│ x │  [0m"
	gotoxy_put 22 $yut_pos "[34m│   │  [0m"
	gotoxy_put 23 $yut_pos "[34m│ x │  [0m"
	gotoxy_put 24 $yut_pos "[34m│   │  [0m"
	gotoxy_put 25 $yut_pos "[34m└───┘  [0m"
	yut_pos=`expr $yut_pos + 7`
}
yut_bback() {
	gotoxy_put 13 $yut_pos "[33m┌───┐  [0m"
	gotoxy_put 14 $yut_pos "[33m│   │  [0m"
	gotoxy_put 15 $yut_pos "[33m│ [31mB[33m │  [0m"
	gotoxy_put 16 $yut_pos "[33m│   │  [0m"
	gotoxy_put 17 $yut_pos "[33m│ [31mB[33m │  [0m"
	gotoxy_put 18 $yut_pos "[33m│   │  [0m"
	gotoxy_put 19 $yut_pos "[33m│ [31mB[33m │  [0m"
	gotoxy_put 20 $yut_pos "[33m│   │  [0m"
	gotoxy_put 21 $yut_pos "[33m│ [31mB[33m │  [0m"
	gotoxy_put 22 $yut_pos "[33m│   │  [0m"
	gotoxy_put 23 $yut_pos "[33m│ [31mB[33m │  [0m"
	gotoxy_put 24 $yut_pos "[33m│   │  [0m"
	gotoxy_put 25 $yut_pos "[33m└───┘  [0m"
	yut_pos=`expr $yut_pos + 7`
}
throw_yut() {
	local i=0,j=0,k=0
	local sign=0, sign2=0
	yut_pos=81 yut_cnt=0
	for ((i=0; i<4; i++)); do
		rand_val=`expr $RANDOM % 2`
		if [ "$rand_val" = 0  ]; then	# if randnum is even, front
			yut_cnt=`expr $yut_cnt + 1`		# if front, increase cnt
		else
			: 
		fi
		yut_num[$i]=$rand_val
	done

	for ((k=0; k<4; k++));do
		if [ ${bback_num[$k]} = ${yut_num[$k]} ]; then
			sign2=`expr $sign2 + 1`
		else
			:
		fi
	done
	
	if [ "$sign2" = 4 ];then
		yut_bback
		yut_front
		yut_front
		yut_front
		yut_cnt=6
		bback_check=1
	else
	bback_check=0
	for ((j=0; j<4; j++)); do
		if [ ${yut_num[$j]} = 0 ];then
			if  [ "$yut_cnt" = 0 ];then
				sign=1
				effect_yut_front
				gotoxy_put 40 10 "                                       "	#delete enter
			elif	[ "$yut_cnt" = 4 ];then
				sign=2
				effect_yut_front
				gotoxy_put 40 10 "                                       "

			else
				yut_front
			fi
		else
			if  [ "$yut_cnt" = 0 ];then
				sign=1
				effect_yut_back
				gotoxy_put 40 10 "                                       "
			elif  [ "$yut_cnt" = 4 ];then
				sign=2
				effect_yut_back
				gotoxy_put 40 10 "                                       "
			else
				yut_back
			fi
		fi
	done
	if [ "$yut_cnt" = 0 ]; then	#effect
		yut_pos=81
		for((i=0;i<4;i++))do
		effect_yut_back
		done
		sleep 1
		yut_pos=81
		for((i=0;i<4;i++))do
		yut_back
		done
	elif [ "$yut_cnt" = 4 ];then
		yut_pos=81
		for((i=0;i<4;i++))do
		effect_yut_front
		done
		sleep 1
		yut_pos=81
		for((i=0;i<4;i++))do
		yut_front
		done
	fi

	fi

	case "$yut_cnt" in
		0) yut_cnt=4;;
		1) yut_cnt=3;;
		2) yut_cnt=2;;
		3) yut_cnt=1;;
		4) yut_cnt=5;;
		6) yut_cnt=1;;
	esac
	
}
erase_p1_piece() {
	local ypos=${p1_ypos[(($1 - 1))]}
	gotoxy_put $ypos ${p1_xpos[(($1 - 1))]} "    "
	gotoxy_put $((ypos + 1)) ${p1_xpos[(($1 - 1))]} "    "
}
erase_p2_piece() {
	local ypos=${p2_ypos[(($1 - 1))]}
	gotoxy_put $ypos ${p2_xpos[(($1 - 1))]} "    "
	gotoxy_put $((ypos + 1)) ${p2_xpos[(($1 - 1))]} "    "
}
take_p1_piece() {
	erase_p2_piece $1		# draw p2 call take p1, so it must erase p2
	local i j k p2pos=${p2_where[(($1 - 1))]}
	for (( i=0; i<4; i++ )); do
		if [ ${p1_where[$i]} = $p2pos ]; then		# if p1 piece and p2 piece overlap
			p1_where[$i]=0		# initial pos with 0
			p1_xpos[$i]=71
			p1_ypos[$i]=36
			gotoxy_put 1 $((79+${#p1_name}+3+i*4)) "[${p1_color}m● $((i+1))[0m"		# draw again
			for j in ${p1_overlap[*]}; do		# if overlapped piece is taken
				if [ $j = $((i+1)) ]; then
					unset p1_overlap			# overlapped piece is assigned by overlapped2
					for k in ${p1_overlap2[*]}; do
						p1_overlap+=($k)
					done
					unset p1_overlap2			# and unset overlapped2
					break
				fi
			done
			for j in ${p1_overlap2[*]}; do		# if overlapped2 piece is taken
				if [ $j = $((i+1)) ]; then
					unset p1_overlap2			# unset overlapped2
				fi
			done
			taken=2
		fi
	done
}
take_p2_piece() {
	erase_p1_piece $1		# draw p1 call take p2, so it must erase p1
	local i j k p1pos=${p1_where[(($1 - 1))]}				# symmteric with p1 func
	for (( i=0; i<4; i++ )); do
		if [ ${p2_where[$i]} = $p1pos ]; then
			p2_where[$i]=0
			p2_xpos[$i]=71
			p2_ypos[$i]=36
			gotoxy_put 37 $((79+${#p2_name}+3+i*4)) "[${p2_color}m● $((i+1))[0m"
			for j in ${p2_overlap[*]}; do
				if [ $j = $((i+1)) ]; then
					unset p2_overlap
					for k in ${p2_overlap2[*]}; do
						p2_overlap+=($k)
					done
					unset p2_overlap2
					break
				fi
			done
			for j in ${p2_overlap2[*]}; do
				if [ $j = $((i+1)) ]; then
					unset p2_overlap2
				fi
			done
			taken=1
		fi
	done
}
sort_p1_overlap() {		# bubble sort
	local i j tmp len=${#p1_overlap[@]}
	for (( i=0; i<len; i++ )); do
		for (( j=0; j<len-1-i; j++ )); do	# (len-1)-i가 깔끔하지만 GNOME에서 작동안함
			if [ ${p1_overlap[$j]} -gt ${p1_overlap[$((j + 1))]} ]; then
				tmp=${p1_overlap[$j]}
				p1_overlap[$j]=${p1_overlap[$((j + 1))]}
				p1_overlap[$((j + 1))]=$tmp
			fi
		done
	done
}
sort_p1_overlap2() {	# overlapped2 must have two elements
	local tmp
	if [ ${p1_overlap2[0]} -gt ${p1_overlap2[1]} ]; then
		tmp=${p1_overlap2[0]}
		p1_overlap2[0]=${p1_overlap2[1]}
		p1_overlap2[1]=$tmp
	fi
}
draw_p1_overlap() {
	sort_p1_overlap
	take_p2_piece $1
	local i ypos=${p1_ypos[(($1 - 1))]} xpos=${p1_xpos[(($1 - 1))]} over_num1
	local idx=${p1_overlap[0]}
	for i in ${p1_overlap[*]}; do p1_where[$((i-1))]=${p1_where[$((idx-1))]}; done		# overlapped pieces sync pos
	gotoxy_put $ypos $xpos "[${p1_color}m● x${#p1_overlap[@]}[0m"					# output overlapped number
	ypos=`expr $ypos + 1`
	gotoxy_put $ypos $xpos "    "
	for i in ${p1_overlap[*]}; do									# output overlapped piece
		gotoxy_put $ypos $xpos "[${p1_color}m$i[0m"
		over_num1=`expr $over_num1 + 1`		
		xpos=`expr $xpos + 1`
	done
	over_num=$over_num1
	over_num1=0
	
}
draw_p1_overlap2() {		# symmetric with overlap
	sort_p1_overlap2
	take_p2_piece $1
	local i ypos=${p1_ypos[(($1 - 1))]} xpos=${p1_xpos[(($1 - 1))]}
	local idx=${p1_overlap2[0]}
	for i in ${p1_overlap2[*]}; do p1_where[$((i-1))]=${p1_where[$((idx-1))]}; done
	gotoxy_put $ypos $xpos "[${p1_color}m● x${#p1_overlap2[@]}[0m"
	ypos=`expr $ypos + 1`
	gotoxy_put $ypos $xpos "    "
	for i in ${p1_overlap2[*]}; do
		gotoxy_put $ypos $xpos "[${p1_color}m$i[0m"
		xpos=`expr $xpos + 1`
	done
}
sort_p2_overlap() {			# symmetric with p1
	local i j tmp len=${#p2_overlap[@]}
	for (( i=0; i<len; i++ )); do
		for (( j=0; j<len-1-i; j++ )); do
			if [ ${p2_overlap[$j]} -gt ${p2_overlap[$((j + 1))]} ]; then
				tmp=${p2_overlap[$j]}
				p2_overlap[$j]=${p2_overlap[$((j + 1))]}
				p2_overlap[$((j + 1))]=$tmp
			fi
		done
	done
}
sort_p2_overlap2() {		# symmetric with p1
	local tmp
	if [ ${p2_overlap2[0]} -gt ${p2_overlap2[1]} ]; then
		tmp=${p2_overlap2[0]}
		p2_overlap2[0]=${p2_overlap2[1]}
		p2_overlap2[1]=$tmp
	fi
}
draw_p2_overlap() {			# symmetric with p1 ################################
	sort_p2_overlap
	take_p1_piece $1
	local i ypos=${p2_ypos[(($1 - 1))]} xpos=${p2_xpos[(($1 - 1))]} zz=0 
	local idx=${p2_overlap[0]}
	for i in ${p2_overlap[*]}; do p2_where[$((i-1))]=${p2_where[$((idx-1))]}; done
	gotoxy_put $ypos $xpos "[${p2_color}m● x${#p2_overlap[@]}[0m"
	ypos=`expr $ypos + 1`
	gotoxy_put $ypos $xpos "    "
	for i in ${p2_overlap[*]}; do
		gotoxy_put $ypos $xpos "[${p2_color}m$i[0m"
		xpos=`expr $xpos + 1`
		zz=`expr $zz + 1`
	done
	over_num2=$zz
	zz=0
}
draw_p2_overlap2() {
	sort_p2_overlap
	take_p1_piece $1
	local i ypos=${p2_ypos[(($1 - 1))]} xpos=${p2_xpos[(($1 - 1))]}
	local idx=${p2_overlap[0]}
	for i in ${p2_overlap[*]}; do p2_where[$((i-1))]=${p2_where[$((idx-1))]}; done
	gotoxy_put $ypos $xpos "[${p2_color}m● x${#p2_overlap[@]}[0m"
	ypos=`expr $ypos + 1`
	gotoxy_put $ypos $xpos "    "
	for i in ${p2_overlap[*]}; do
		gotoxy_put $ypos $xpos "[${p2_color}m$i[0m"
		xpos=`expr $xpos + 1`
	done
}
draw_p1_piece() {
	for i in ${p1_overlap[*]}; do		# exception handling
		if [ $i = $1 ]; then
			draw_p1_overlap $1
			return;
		fi
	done
	for i in ${p1_overlap2[*]}; do
		if [ $i = $1 ]; then
			draw_p1_overlap2 $1
			return;
		fi
	done
	take_p2_piece $1
	gotoxy_put ${p1_ypos[(($1 - 1))]} ${p1_xpos[(($1 - 1))]} "[${p1_color}m● $1[0m"
}
draw_p2_piece() {
	for i in ${p2_overlap[*]}; do
		if [ $i = $1 ]; then
			draw_p2_overlap $1
			return;
		fi
	done
	for i in ${p2_overlap2[*]}; do
		if [ $i = $1 ]; then
			draw_p2_overlap2 $1
			return;
		fi
	done
	take_p1_piece $1
	gotoxy_put ${p2_ypos[(($1 - 1))]} ${p2_xpos[(($1 - 1))]} "[${p2_color}m● $1[0m"
}
p1_win() {
	tput clear
	gotoxy 10 0
	echo "                    ____    _    __  __ _____ _____     _______ ____   "
	echo "                   / ___|  / \  |  \/  | ____/ _ \ \   / / ____|  _ \  "
	echo "                  | |  _  / _ \ | |\/| |  _|| | | \ \ / /|  _| | | ) | "
	echo "                  | |_| |/ ___ \| |  | | |__| |_| |\ v / | |___|  _ <  "
	echo "                   \____/_/   \_\_|  |_|_____\___/  \_/  |_____|_| \_\ "
	gotoxy_put 18 35 "[${p1_color}m<$p1_name>[0m  Win !!"
	gotoxy_put 40 20 "드디어 [34m소실[0m 플젝이 끝났다                    "
	gotoxy_put 41 20 "내가 달려온 15주...너무 힘들고 고단했다       "
	sleep 2
	############
	tput clear
	gotoxy 10 0
	echo "                    ____    _    __  __ _____ _____     _______ ____   "
	echo "                   / ___|  / \  |  \/  | ____/ _ \ \   / / ____|  _ \  "
	echo "                  | |  _  / _ \ | |\/| |  _|| | | \ \ / /|  _| | | ) | "
	echo "                  | |_| |/ ___ \| |  | | |__| |_| |\ v / | |___|  _ <  "
	echo "                   \____/_/   \_\_|  |_|_____\___/  \_/  |_____|_| \_\ "
	gotoxy_put 18 35 "[${p1_color}m<$p1_name>[0m  Win !!"
	gotoxy_put 32 20 "드디어 [34m소실[0m 플젝이 끝났다                    "
	gotoxy_put 33 20 "내가 달려온 15주...너무 힘들고 고단했다       "
	gotoxy_put 35 20 "하지만 1점, 0.5점을 얻을때마다 느끼는 희열.   "
	gotoxy_put 36 20 "이것때문에 내가 여기까지 온게 아닌가 싶다.     "
	sleep 2
	############
	tput clear
	gotoxy 10 0
	echo "                    ____    _    __  __ _____ _____     _______ ____   "
	echo "                   / ___|  / \  |  \/  | ____/ _ \ \   / / ____|  _ \  "
	echo "                  | |  _  / _ \ | |\/| |  _|| | | \ \ / /|  _| | | ) | "
	echo "                  | |_| |/ ___ \| |  | | |__| |_| |\ v / | |___|  _ <  "
	echo "                   \____/_/   \_\_|  |_|_____\___/  \_/  |_____|_| \_\ "
	gotoxy_put 18 35 "[${p1_color}m<$p1_name>[0m  Win !!"
	gotoxy_put 24 20 "드디어 [34m소실[0m 플젝이 끝났다                    "
	gotoxy_put 25 20 "내가 달려온 15주...너무 힘들고 고단했다       "
	gotoxy_put 27 20 "하지만 1점, 0.5점을 얻을때마다 느끼는 희열.   "
	gotoxy_put 28 20 "이것때문에 내가 여기까지 온게 아닌가 싶다.     "
	gotoxy_put 30 20 "조교님들 저희 가르치시느라 너무 고생하셨습니다! "
	gotoxy_put 31 20 "이제 여름방학을 즐기러 가겠습니다 :->         "
	read -s -d ' '
	end=1
}
p2_win() {
	tput clear
	gotoxy 10 0
	echo "                    ____    _    __  __ _____ _____     _______ ____   "
	echo "                   / ___|  / \  |  \/  | ____/ _ \ \   / / ____|  _ \  "
	echo "                  | |  _  / _ \ | |\/| |  _|| | | \ \ / /|  _| | | ) | "
	echo "                  | |_| |/ ___ \| |  | | |__| |_| |\ v / | |___|  _ <  "
	echo "                   \____/_/   \_\_|  |_|_____\___/  \_/  |_____|_| \_\ "
	gotoxy_put 18 35 "[${p2_color}m<$p2_name>[0m  Win !!"
	gotoxy_put 40 20 "드디어 [34m소실[0m 플젝이 끝났다                    "
	gotoxy_put 41 20 "내가 달려온 15주...너무 힘들고 고단했다       "
	sleep 2
	############
	tput clear
	gotoxy 10 0
	echo "                    ____    _    __  __ _____ _____     _______ ____   "
	echo "                   / ___|  / \  |  \/  | ____/ _ \ \   / / ____|  _ \  "
	echo "                  | |  _  / _ \ | |\/| |  _|| | | \ \ / /|  _| | | ) | "
	echo "                  | |_| |/ ___ \| |  | | |__| |_| |\ v / | |___|  _ <  "
	echo "                   \____/_/   \_\_|  |_|_____\___/  \_/  |_____|_| \_\ "
	gotoxy_put 18 35 "[${p2_color}m<$p2_name>[0m  Win !!"
	gotoxy_put 32 20 "드디어 [34m소실[0m 플젝이 끝났다                    "
	gotoxy_put 33 20 "내가 달려온 15주...너무 힘들고 고단했다       "
	gotoxy_put 35 20 "하지만 1점, 0.5점을 얻을때마다 느끼는 희열.   "
	gotoxy_put 36 20 "이것때문에 내가 여기까지 온게 아닌가 싶다.     "
	sleep 2
	############
	tput clear
	gotoxy 10 0
	echo "                    ____    _    __  __ _____ _____     _______ ____   "
	echo "                   / ___|  / \  |  \/  | ____/ _ \ \   / / ____|  _ \  "
	echo "                  | |  _  / _ \ | |\/| |  _|| | | \ \ / /|  _| | | ) | "
	echo "                  | |_| |/ ___ \| |  | | |__| |_| |\ v / | |___|  _ <  "
	echo "                   \____/_/   \_\_|  |_|_____\___/  \_/  |_____|_| \_\ "
	gotoxy_put 18 35 "[${p2_color}m<$p2_name>[0m  Win !!"
	gotoxy_put 24 20 "드디어 [34m소실[0m 플젝이 끝났다                    "
	gotoxy_put 25 20 "내가 달려온 15주...너무 힘들고 고단했다       "
	gotoxy_put 27 20 "하지만 1점, 0.5점을 얻을때마다 느끼는 희열.   "
	gotoxy_put 28 20 "이것때문에 내가 여기까지 온게 아닌가 싶다.     "
	gotoxy_put 30 20 "조교님들 저희 가르치시느라 너무 고생하셨습니다! "
	gotoxy_put 31 20 "이제 여름방학을 즐기러 가겠습니다 :->         "
	read -s -d ' '
	end=1
}
move_p1() {	#윷 카운트만큼 반복 
	local i=0 j=0 k=0 flag=0 oflag=0 bback_goal=0 l=0 terminate=71 
	local idx=`expr $1 - 1`
	if [ $2 = '1' ]; then erase_p1_piece $1; fi		# erase when sec param is 1
	for i in ${p1_goal[*]}; do						# exception handling
		if [ $i = $1 ]; then
			return;
		fi
	done
	
		if [ "${p1_where[`expr $piece_num - 1`]}" = 1 ] && [ "$bback_check" = 1 ];then
			bback_goal=1
		else
			bback_goal=0
		fi	
		

	if [[ "${p1_where[$idx]}" -ge 0 && "${p1_where[$idx]}" -lt 5 && "$bback_check" = 0 ]] && [ "$bback_goal" = 0 ]; then			# move piece
		p1_ypos[$idx]=`expr ${p1_ypos[$idx]} - 7`
	elif [[ "${p1_where[$idx]}" -ge 0 && "${p1_where[$idx]}" -lt 5 && "$bback_check" = 1 ]] && [ "$bback_goal" = 0 ]; then			# move piece
		p1_ypos[$idx]=`expr ${p1_ypos[$idx]} + 7`
	elif [[ "${p1_where[$idx]}" -ge 5 && "${p1_where[$idx]}" -lt 10 && "$bback_check" = 0 ]]; then
		p1_xpos[$idx]=`expr ${p1_xpos[$idx]} - 14`
	elif [[ "${p1_where[$idx]}" -ge 5 && "${p1_where[$idx]}" -lt 10 && "$bback_check" = 1 ]]; then
		p1_xpos[$idx]=`expr ${p1_xpos[$idx]} + 14`
	elif [[ "${p1_where[$idx]}" -ge 10 && "${p1_where[$idx]}" -lt 15 && "$bback_check" = 0 ]]; then
		p1_ypos[$idx]=`expr ${p1_ypos[$idx]} + 7`
	elif [[ "${p1_where[$idx]}" -ge 10 && "${p1_where[$idx]}" -lt 15 && "$bback_check" = 1 ]]; then
		p1_ypos[$idx]=`expr ${p1_ypos[$idx]} - 7`
	elif [[ "${p1_where[$idx]}" -ge 15 && "${p1_where[$idx]}" -lt 19 && "$bback_check" = 0 ]]; then
		p1_xpos[$idx]=`expr ${p1_xpos[$idx]} + 14`
	elif [[ "${p1_where[$idx]}" -ge 15 && "${p1_where[$idx]}" -lt 19 && "$bback_check" = 1 ]]; then
		p1_xpos[$idx]=`expr ${p1_xpos[$idx]} - 14`
	else			# goal
		
		for i in ${p1_overlap[*]}; do		# if goal piece is overlapped piece
			if [ $i = $1 ]; then
				flag=1						# flag is 1
				break;
			fi
		done
		
		for i in ${p1_overlap2[*]}; do		# if goal piece is overlapped2 piece
			if [ $i = $1 ]; then
				flag=2						# flag is 2
				break;
			fi
		done
		

		if [ $flag = 0 ] || [ $bback_goal -eq 1 ]; then				# goal piece is single
			p1_where[$idx]=0
			p1_goal+=($1)
			unset p1_choice[$idx]			# subtract from choice
		elif [ $flag = 1 ] || [ $bback_goal -eq 1 ]; then
			for i in ${p1_overlap[*]}; do
				p1_where[$((i-1))]=0
				p1_goal+=($i)
				unset p1_choice[$((i-1))]
			done
	
		else
			for i in ${p1_overlap2[*]}; do
				p1_where[$((i-1))]=0
				p1_goal+=($i)
				unset p1_choice[$((i-1))]
			done
		fi
		gotoxy_put 3 80 "[${p1_color}mGOAL > [0m"
		for i in ${p1_goal[*]}; do			# output goal piece
			gotoxy_put 3 $((83+i*4)) "[${p1_color}m● $i[0m"
		done
		if [ ${#p1_goal[@]} = '4' ]; then p1_win; fi		# if goal piece number is 4, win
		return;
	fi

	if [ "$bback_check" = 0 ];then
	p1_where[$idx]=`expr ${p1_where[$idx]} + 1`
	elif [ "$bback_check" = 1 ];then
	p1_where[$idx]=`expr ${p1_where[$idx]} - 1`
	fi	
	
	if [ $2 = '2' ] || [ $3 = '1' ]; then					# if second param is 2 or third param is 1
	local overlap_cnt=${#p1_overlap[@]}						# check overlap
	for (( i=0; i<4; i++ )); do
		if [ $i != $idx ] && [ ${p1_where[$i]} = ${p1_where[$idx]} ]; then
			if [ $overlap_cnt = '0' ]; then
				p1_overlap+=($((i+1)) $((idx+1)))
				draw_p1_overlap $1
				return
			else
				if [ ${#p1_overlap2[@]} = 2 ]; then
					unset p1_overlap2
					p1_overlap=(1 2 3 4)
					draw_p1_overlap $1
					return
				fi
				for j in ${p1_overlap[*]}; do
					if [ $j = $((idx+1)) ]; then
						p1_overlap+=($((i+1)))
						draw_p1_overlap $1
						return;
					fi
					if [ $j = $((i+1)) ]; then
						p1_overlap+=($((idx+1)))
						draw_p1_overlap $1
						return;
					fi
				done
				p1_overlap2+=($((i+1)) $((idx+1)))
				draw_p1_overlap2 $1
				return;
			fi
		fi
	done
	fi
	if [ $2 = '2' ] || [ $3 = '1' ]; then draw_p1_piece $1; fi		# draw piece when sec param is 2 or third param is 1
}
move_p2() {				# symmetric with p1
	local i=0 j=0 k=0 flag=0 terminate=71
	local idx=`expr $1 - 1`
	if [ $2 = '1' ]; then erase_p2_piece $1; fi
	for i in ${p2_goal[*]}; do
		if [ $i = $1 ]; then
			return;
		fi
	done

	if [ "${p2_where[`expr $piece_num - 1`]}" = 1 ] && [ "$bback_check" = 1 ];then
			bback_goal=1
		else
			bback_goal=0
		fi	

	if [[ "${p2_where[$idx]}" -ge 0 && "${p2_where[$idx]}" -lt 5 && "$bback_check" = 0 ]] && [ "$bback_goal" = 0 ]; then			# move piece
		p2_ypos[$idx]=`expr ${p2_ypos[$idx]} - 7`
	elif [[ "${p2_where[$idx]}" -ge 0 && "${p2_where[$idx]}" -lt 5 && "$bback_check" = 1 ]] && [ "$bback_goal" = 0 ]; then			# move piece
		p2_ypos[$idx]=`expr ${p2_ypos[$idx]} + 7`
	elif [[ "${p2_where[$idx]}" -ge 5 && "${p2_where[$idx]}" -lt 10 && "$bback_check" = 0 ]]; then
		p2_xpos[$idx]=`expr ${p2_xpos[$idx]} - 14`
	elif [[ "${p2_where[$idx]}" -ge 5 && "${p2_where[$idx]}" -lt 10 && "$bback_check" = 1 ]]; then
		p2_xpos[$idx]=`expr ${p2_xpos[$idx]} + 14`
	elif [[ "${p2_where[$idx]}" -ge 10 && "${p2_where[$idx]}" -lt 15 && "$bback_check" = 0 ]]; then
		p2_ypos[$idx]=`expr ${p2_ypos[$idx]} + 7`
	elif [[ "${p2_where[$idx]}" -ge 10 && "${p2_where[$idx]}" -lt 15 && "$bback_check" = 1 ]]; then
		p2_ypos[$idx]=`expr ${p2_ypos[$idx]} - 7`
	elif [[ "${p2_where[$idx]}" -ge 15 && "${p2_where[$idx]}" -lt 19 && "$bback_check" = 0 ]]; then
		p2_xpos[$idx]=`expr ${p2_xpos[$idx]} + 14`
	elif [[ "${p2_where[$idx]}" -ge 15 && "${p2_where[$idx]}" -lt 19 && "$bback_check" = 1 ]]; then
		p2_xpos[$idx]=`expr ${p2_xpos[$idx]} - 14`
	else
		for i in ${p2_overlap[*]}; do
			if [ $i = $1 ]; then
				flag=1
				break;
			fi
		done
		for i in ${p2_overlap2[*]}; do
			if [ $i = $1 ]; then
				flag=2
				break;
			fi
		done
		if [ $flag = 0 ]; then
			p2_goal+=($1)
			p2_where[$idx]=0
			unset p2_choice[$idx]
		elif [ $flag = 1 ]; then
			for i in ${p2_overlap[*]}; do
				p2_where[$((i-1))]=0
				p2_goal+=($i)
				unset p2_choice[$((i-1))]
			done
		else
			for i in ${p2_overlap2[*]}; do
				p2_where[$((i-1))]=0
				p2_goal+=($i)
				unset p2_choice[$((i-1))]
			done
		fi
		gotoxy_put 35 80 "[${p2_color}mGOAL > [0m"
		for i in ${p2_goal[*]}; do
			gotoxy_put 35 $((83+i*4)) "[${p2_color}m● $i[0m"
		done
		if [ ${#p2_goal[@]} = '4' ]; then p2_win; fi
		return;
	fi

	if [ "$bback_check" = 0 ];then
	p2_where[$idx]=`expr ${p2_where[$idx]} + 1`
	elif [ "$bback_check" = 1 ];then
	p2_where[$idx]=`expr ${p2_where[$idx]} - 1`
	fi	

	if [ $2 = '2' ] || [ $3 = '1' ]; then
	local overlap_cnt=${#p2_overlap[@]}
	for (( i=0; i<4; i++ )); do
		if [ $i != $idx ] && [ ${p2_where[$i]} = ${p2_where[$idx]} ]; then
			if [ $overlap_cnt = '0' ]; then
				p2_overlap+=($((i+1)) $((idx+1)))
				draw_p2_overlap $1
				return
			else
				if [ ${#p2_overlap2[@]} = 2 ]; then
					unset p2_overlap2
					p2_overlap=(1 2 3 4)
					draw_p2_overlap $1
					return
				fi
				for j in ${p2_overlap[*]}; do
					if [ $j = $((idx+1)) ]; then
						p2_overlap+=($((i+1)))
						draw_p2_overlap $1
						return;
					fi
					if [ $j = $((i+1)) ]; then
						p2_overlap+=($((idx+1)))
						draw_p2_overlap $1
						return;
					fi
				done
				p2_overlap2+=($((i+1)) $((idx+1)))
				draw_p2_overlap2 $1
				return;
			fi
		fi
	done
	fi
	if [ $2 = '2' ] || [ $3 = '1' ]; then draw_p2_piece $1; fi
}
decide_yut() {
	local key
	local i=0
	read -s -N 1 key
	yut_pos=81
	if [[ "$key" == $'\x20' ]]; then		# input is space
		throw_yut
	elif [ "$key" = 'Q' ] || [ "$key" = 'q' ]; then
		yut_front
		yut_front
		yut_back
		yut_front
		bback_check=0
		yut_cnt=1
	elif [ "$key" = 'W' ] || [ "$key" = 'w' ]; then
		yut_front
		yut_front
		yut_back
		yut_back
		bback_check=0
		yut_cnt=2
	elif [ "$key" = 'E' ] || [ "$key" = 'e' ]; then
		yut_front
		yut_back
		yut_back
		yut_back
		bback_check=0
		yut_cnt=3
	elif [ "$key" = 'R' ] || [ "$key" = 'r' ]; then
		effect_yut_back
		effect_yut_back
		effect_yut_back
		effect_yut_back
		gotoxy_put 40 10 "                                       "
		sleep 1
		yut_pos=81
		for((i=0;i<4;i++))do
		yut_back
		done
		bback_check=0
		yut_cnt=4
	elif [ "$key" = 'T' ] || [ "$key" = 't' ]; then
		effect_yut_front
		effect_yut_front
		effect_yut_front
		effect_yut_front
		gotoxy_put 40 10 "                                       "
		sleep 1
		yut_pos=81
		for((i=0;i<4;i++))do
		yut_front
		done
		bback_check=0
		yut_cnt=5
	elif [ "$key" = 'Y' ] || [ "$key" = 'y' ]; then
		yut_bback
		yut_front
		yut_front
		yut_front
		yut_cnt=1
		bback_check=1
	else
		decide_yut
	fi
}
decide_p1_piece() {
	local num i j pos=37 remain_num
	local sign2=0
	
	for ((l=0; l<4; l++));do
		if [ ${p1_where[$l]} -eq 0 ] && [ $bback_check = 1 ]; then
			sign2=`expr $sign2 + 1` 
		else
			:
		fi
	done
	
	if [ "$sign2" = 4 ];then  	#first mal bback
		gotoxy_put 40 10 "                                       "
		gotoxy_put 40 10 "움직일 수 있는 말이 없습니다. 다음 턴으로 넘어갑니다. "	
		yut_cnt=0
		sleep 1
	else
	gotoxy_put 40 10 "                                       "
	gotoxy_put 40 10 "이동 할 말을 선택해주세요.                                      "
	for i in ${p1_choice[*]}; do
		gotoxy_put 40 $pos "$i)"		#	1) 2) 3) 4)
		pos=`expr $pos + 3`
		remain_num=`expr $remain_num + 1`
		
	done
	remain_p1=$remain_num
	remain_num=0
	read -s -n 1 num
	for i in ${p1_choice[*]}; do
		if [ "$num" = "$i" ]; then
			gotoxy_put 1 $((79+${#p1_name}+3+(num-1)*4)) "   "		# erase running piece
			for j in ${p1_overlap[*]}; do				# if input is under overlapped
				if [ $j = $num ]; then
					piece_num=${p1_overlap[0]}			# num is assigned with overlapped first piece
					return;
				fi
			done
			for j in ${p1_overlap2[*]}; do
				if [ $j = $num ]; then
					piece_num=${p1_overlap2[0]}
					return;
				fi
			done
			piece_num=$num
			return;
		fi
	sign2=0
	done
	decide_p1_piece
	fi
}
decide_p2_piece() {
	local num i j pos=37 vvv=0 
	local sign2=0
	
	for ((l=0; l<4; l++));do
		if [ ${p2_where[$l]} -eq 0 ] && [ $bback_check = 1 ]; then
			sign2=`expr $sign2 + 1` 
		else
			:
		fi
	done
	
	if [ "$sign2" = 4 ];then  	#first mal bback
		gotoxy_put 40 10 "                                       "
		gotoxy_put 40 10 "움직일 수 있는 말이 없습니다. 다음 턴으로 넘어갑니다. "	
		yut_cnt=0
		sleep 1
	else
	gotoxy_put 40 10 "                                       "
	gotoxy_put 40 10 "이동 할 말을 선택해주세요.                                "
	for i in ${p2_choice[*]}; do
		gotoxy_put 40 $pos "$i)"
		pos=`expr $pos + 3`
		vvv=`expr $vvv + 1`
	done
	remain_p2=$vvv
	vvv=0
	read -s -n 1 num
	for i in ${p2_choice[*]}; do
		if [ "$num" = "$i" ]; then
			gotoxy_put 37 $((79+${#p2_name}+3+(num-1)*4)) "   "
			for j in ${p2_overlap[*]}; do
				if [ $j = $num ]; then
					piece_num=${p2_overlap[0]}
					return;
				fi
			done
			for j in ${p2_overlap2[*]}; do
				if [ $j = $num ]; then
					piece_num=${p2_overlap2[0]}
					return;
				fi
			done
			piece_num=$num
			return;
		fi
	sign2=0
	done
	decide_p2_piece
	fi
}
move_piece() {
	local -i i=0 first_bback=0 mal_go=0 pop_p1=0 pop_p2=0 ter_pos=71
	#local idx=`expr $1 - 1`
	local j=0, l=0, sign2=0 hasugu_check=0
	local k=1
	for (( i=0 ; end==0 ; i++ )); do				# loop until end is 1
	
	
		if (( ((i % 2)) == 0)); then
			gotoxy_put 27 89 "[${p1_color}m<1P>[0m Turn"
			gotoxy_put 40 10 "     Space Bar로 윷을 던지세요                                                     "
			decide_yut
			check_yut=$yut_cnt
			decide_p1_piece
			where1=`expr $piece_num - 1`
			
			if [ "$bback_check" = 1 ];then		#빽도로 하수구 들어갈 때 
				if [ `expr ${p1_where[$where1]} - 1` -eq $hasugu_in ]; then
					yut_cnt=`expr $hasugu_cnt - 1`
					bback_check=0
				else
				:
				fi
			elif [ "$bback_check" = 0 ];then	#그냥 하수구 들어갈 때 
				if [ `expr $yut_cnt + ${p1_where[$where1]}` -eq $hasugu_in ]; then
					yut_cnt=`expr $hasugu_cnt + $yut_cnt`
				else
				:
				fi
			fi
			
			
			for (( j=0; j<$yut_cnt; j++ )); do
				j_check=j
				if [ $j = 0 ] && [ $j = $((yut_cnt - 1)) ]; then
					move_p1 $piece_num 1 1		# erase and draw
				elif [ $j = 0 ]; then
					move_p1 $piece_num 1 0		# just erase
				elif [ $j = $((yut_cnt - 1)) ]; then 
					move_p1 $piece_num 2 1		# just draw
				else
					move_p1 $piece_num 0 0; 	# no draw no erase
				fi
			done
			
			

			if [ "$check_yut" = 4 ] && [ "$taken" = 1 ];then
				taken=0
				move_piece
			elif [ "$check_yut" = 5 ] && [ "$taken" = 1 ];then
				taken=0
				move_piece
			elif [ "$check_yut" = 4 ] || [ "$check_yut" = 5 ] ;then # 잡았을 때 한번 더 
				taken=0
				move_piece
			elif [ "$taken" = 1 ];then
				taken=0
				move_piece
			fi
			
			
		else
	
			gotoxy_put 27 89 "[${p2_color}m<2P>[0m Turn"
			gotoxy_put 40 10 "     Space Bar로 윷을 던지세요                                                 "
			decide_yut
			check_yut=$yut_cnt
			decide_p2_piece

			where2=`expr $piece_num - 1`
			
			if [ "$bback_check" = 1 ];then		#빽도로 하수구 들어갈 때 
				if [ `expr ${p2_where[$where2]} - 1` -eq $hasugu_in ]; then
					yut_cnt=`expr $hasugu_cnt - 1`
					bback_check=0
				else	#그냥 빽도일 때
				:
				fi
			elif [ "$bback_check" = 0 ];then	#그냥 하수구 들어갈 때 
				if [ `expr $yut_cnt + ${p2_where[$where2]}` -eq $hasugu_in ]; then
					yut_cnt=`expr $hasugu_cnt + $yut_cnt`
				else
				:	#그냥 윷일 때
				fi
			fi

			for (( j=0; j<$yut_cnt; j++ )); do
				j_check=j
				if [ $j = 0 ] && [ $j = $((yut_cnt - 1)) ]; then
					move_p2 $piece_num 1 1		# erase and draw
				elif [ $j = 0 ]; then
					move_p2 $piece_num 1 0		# just erase
				elif [ $j = $((yut_cnt - 1)) ]; then 
					move_p2 $piece_num 2 1		# just draw
				else
					move_p2 $piece_num 0 0; 	# no draw no erase
				fi
			done


			if [ "$check_yut" = 4 ] && [ "$taken" = 2 ];then
				taken=0
				again_2p
			elif [ "$check_yut" = 4 ] && [ "$taken" = 2 ];then
				taken=0
				again_2p
			elif [ "$check_yut" = 4 ] || [ "$check_yut" = 5 ] ;then  #잡았을 때 한번 더 
				taken=0
				again_2p
			elif [ "$taken" = 2 ];then
				taken=0
				again_2p
			fi
		fi
	done
}
again_2p()
{
		local k=100
		local i=0

			gotoxy_put 27 89 "[${p2_color}m<2P>[0m Turn"
			gotoxy_put 40 10 "     Space Bar로 윷을 던지세요                             "
			decide_yut
			check_yut=$yut_cnt
			decide_p2_piece
			where2=`expr $piece_num - 1`
			
			if [ "$bback_check" = 1 ];then		#빽도로 하수구 들어갈 때 
				if [ `expr ${p2_where[$where2]} - 1` -eq $hasugu_in ]; then
					yut_cnt=`expr $hasugu_cnt - 1`
					bback_check=0
				else
				:
				fi
			elif [ "$bback_check" = 0 ];then	#그냥 하수구 들어갈 때 
				if [ `expr $yut_cnt + ${p2_where[$where2]}` -eq $hasugu_in ]; then
					yut_cnt=`expr $hasugu_cnt + $yut_cnt`
				else
				:
				fi
			fi

			for (( j=0; j<$yut_cnt; j++ )); do
				j_check=j
				if [ $j = 0 ] && [ $j = $((yut_cnt - 1)) ]; then
					move_p2 $piece_num 1 1		# erase and draw
				elif [ $j = 0 ]; then
					move_p2 $piece_num 1 0		# just erase
				elif [ $j = $((yut_cnt - 1)) ]; then 
					move_p2 $piece_num 2 1		# just draw
				else
					move_p2 $piece_num 0 0; 	# no draw no erase
				fi
			done
			

		if [ "$check_yut" = 4 ] && [ "$taken" = 2 ];then
				taken=0
				again_2p
		elif [ "$check_yut" = 4 ] && [ "$taken" = 2 ];then
				taken=0
				again_2p
		elif [ "$check_yut" = 4 ] || [ "$check_yut" = 5 ] ;then  #잡았을 때 한번 더 
				taken=0
				again_2p
		elif [ "$taken" = 2 ];then
				taken=0
				again_2p
			
		else
		:
		fi

}
game_screen() {
	
	tput clear
	hasugu_rule
	echo "[3"$jj"m┌────┐[0m        [3"$ii"m┌────┐[0m        [3"$h"m┌────┐[0m        [3"$g"m┌────┐[0m        [3"$f"m┌────┐[0m        [3"$e"m┌────┐[0m "
	echo "[3"$jj"m│    │[0m────────[3"$ii"m│    │[0m────────[3"$h"m│    │[0m────────[3"$g"m│    │[0m────────[3"$f"m│    │[0m────────[3"$e"m│    │[0m   [${p1_color}m<$p1_name> ● 1 ● 2 ● 3 ● 4 [0m"
	echo "[3"$jj"m│    │[0m────────[3"$ii"m│    │[0m────────[3"$h"m│    │[0m────────[3"$g"m│    │[0m────────[3"$f"m│    │[0m────────[3"$e"m│    │[0m"
	echo "[3"$jj"m└────┘[0m        [3"$ii"m└────┘[0m        [3"$h"m└────┘[0m        [3"$g"m└────┘[0m        [3"$f"m└────┘[0m        [3"$e"m└────┘[0m"
	echo "  ││    \                                                          /    ││  "
	echo "  ││      \                                                      /      ││  "
	echo "  ││         ┌────┐                                      ┌────┐         ││  "
	echo "[3"$kk"m┌────┐[0m       │    │                                      │    │       [3"$d"m┌────┐[0m"
	echo "[3"$kk"m│    │[0m       │    │                                      │    │       [3"$d"m│    │[0m       [31m ──[0m : 하수구 입구  "
	echo "[3"$kk"m│    │[0m       └────┘                                      └────┘       [3"$d"m│    │[0m       [32m ──[0m : 하수구 출구"
	echo "[3"$kk"m└────┘[0m               \                                /               [3"$d"m└────┘[0m"
	echo "  ││                   \                            /                   ││  "
	echo "  ││                      ┌────┐            ┌────┐                      ││  "
	echo "  ││                      │    │            │    │                      ││       [33m┌───┐  ┌───┐  ┌───┐  ┌───┐[0m"
	echo "[3"$ll"m┌────┐[0m                    │    │            │    │                    [3"$c"m┌────┐[0m     [33m│   │  │   │  │   │  │   │[0m"
	echo "[3"$ll"m│    │[0m                    └────┘            └────┘                    [3"$c"m│    │[0m     [33m│ x │  │ x │  │ x │  │ x │[0m"
	echo "[3"$ll"m│    │[0m                          \        /                            [3"$c"m│    │[0m     [33m│   │  │   │  │   │  │   │[0m"
	echo "[3"$ll"m└────┘[0m                             ┌────┐                             [3"$c"m└────┘[0m     [33m│ x │  │ x │  │ x │  │ x │[0m"
	echo "  ││                               │    │                               ││       [33m│   │  │   │  │   │  │   │[0m"
	echo "  ││                               │    │                               ││       [33m│ x │  │ x │  │ x │  │ x │[0m"
	echo "  ││                               │    │                               ││       [33m│   │  │   │  │   │  │   │[0m"
	echo "[3"$m"m┌────┐[0m                             └────┘                             [3"$b"m┌────┐[0m     [33m│ x │  │ x │  │ x │  │ x │[0m"
	echo "[3"$m"m│    │[0m                           /        \                           [3"$b"m│    │[0m     [33m│   │  │   │  │   │  │   │[0m"
	echo "[3"$m"m│    │[0m                    ┌────┐            ┌────┐                    [3"$b"m│    │[0m     [33m│ x │  │ x │  │ x │  │ x │[0m"
	echo "[3"$m"m└────┘[0m                    │    │            │    │                    [3"$b"m└────┘[0m     [33m│   │  │   │  │   │  │   │[0m"
	echo "  ││                      │    │            │    │                      ││       [33m└───┘  └───┘  └───┘  └───┘[0m"
	echo "  ││                      └────┘            └────┘                      ││  "
	echo "  ││                   /                            \                   ││  "
	echo "[3"$n"m┌────┐[0m               /                                \               [3"$a"m┌────┐[0m"
	echo "[3"$n"m│    │[0m       ┌────┐                                      ┌────┐       [3"$a"m│    │[0m"
	echo "[3"$n"m│    │[0m       │    │                                      │    │       [3"$a"m│    │[0m"

	echo "[3"$n"m└────┘[0m       │    │                                      │    │       [3"$a"m└────┘[0m"
	echo "  ││         └────┘                                      └────┘         ││  "
	echo "  ││      /                                                      \      ││  "
	echo "  ││    /                                                          \    ││  "
	echo "[3"$o"m┌────┐[0m        [3"$p"m┌────┐[0m        [3"$q"m┌────┐[0m        [3"$r"m┌────┐[0m        [3"$s"m┌────┐[0m        ┌────┐[0m"
	echo "[3"$o"m│    │[0m────────[3"$p"m│    │[0m────────[3"$q"m│    │[0m────────[3"$r"m│    │[0m────────[3"$s"m│    │[0m────────│    │[0m"
	echo "[3"$o"m│    │[0m────────[3"$p"m│    │[0m────────[3"$q"m│    │[0m────────[3"$r"m│    │[0m────────[3"$s"m│    │[0m────────│    │[0m   [${p2_color}m<$p2_name> ● 1 ● 2 ● 3 ● 4 [0m"
	echo "[3"$o"m└────┘[0m        [3"$p"m└────┘[0m        [3"$q"m└────┘[0m        [3"$r"m└────┘[0m        [3"$s"m└────┘[0m        └────┘[0m"
	move_piece

}


# start script

echo "[0m"
tput civis
tput clear

entrance_screen
select_color
select_name
game_screen
exit_screen

echo "[0m"
tput cnorm
tput clear
