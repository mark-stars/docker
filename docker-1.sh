#!/bin/bash/

echo "=========================================="
echo "=                                        ="
echo "=             docker抓取信息             ="
echo "=                                        ="
echo "=                                        ="
echo "=========================================="
echo "1)容器数量              2)容器名称"                   
echo "3)容器VNIC的MAC         4)每个容器的IP"
echo "5)容器CPU的架构         6)每个容器的大小"    
echo "7)汇总输出"
echo "8)退出"

while true; do
        echo -e "select a option:\c"
        read number
        if [ $number = "1" ]; then
                echo `docker ps -a | awk NR!=1'{print $1}' | wc -l`

    elif [ $number = "2" ]; then
	a=`docker ps -a | awk '{print $1}' | grep -v CONTAINER`
        b=`docker ps | awk 'NR!=1 {print $1}'| wc -l`
        for i in $b
                do
                docker inspect --format='{{.Name}}' $a
	done

    elif [ $number = "3" ]; then
         a=`docker ps -a | awk '{print $1}' | grep -v CONTAINER`
	     b=`docker ps | awk 'NR!=1 {print $1}'| wc -l`
	for i in $b
		do
		docker inspect --format='{{range .NetworkSettings.Networks}}{{.MacAddress}}{{end}}' $a
		done

    elif [ $number = "4" ]; then
        a=`docker ps -a | awk '{print $1}' | grep -v CONTAINER`
b=`docker ps | awk 'NR!=1 {print $1}'| wc -l`
	for i in $b
		do
		docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $a
	done


    elif [ $number = "5" ]; then
        echo "Network"

    elif [ $number = "6" ]; then
        a=`docker ps -a | awk '{print $1}' | grep -v CONTAINER`
	b=`docker ps | awk 'NR!=1 {print $1}'| wc -l`
	for i in $b
		do
		docker inspect --format='{{.HostConfig.ShmSize}}' $a
	done

    elif [ $number = "7" ]; then
        a=`docker ps -a | awk '{print $1}' | grep -v CONTAINER`
        b=`docker ps | awk 'NR!=1 {print $1}'| wc -l`
        for i in $b
                do
			docker ps -a | awk NR!=1'{print $1}' | wc -l
                	docker inspect --format='{{.Name}}' $a
			docker inspect --format='{{range .NetworkSettings.Networks}}{{.MacAddress}}{{end}}' $a
			docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $a
			docker inspect --format='{{.HostConfig.ShmSize}}' $a

        done
        break
    fi
done
