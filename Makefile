I=kevineye/heyu
I=docker_heyu
prep:
	docker run -d \
	-v /home/yifang/ogit/docker-heyu/etc:/etc/heyu \
	$I

run:
	docker run \
	-v /home/yifang/ogit/docker-heyu/etc:/etc/heyu \
	-v /etc/localtime:/etc/localtime \
	--device /dev/ttyS0 \
	-p 8080:80 \
	--name $I \
	$I
stop:
	docker stop $I; docker rm $I

build:
	docker build -t docker_heyu:latest .

H=A1
C=FON
test:
	curl -v http://127.0.0.1:8080/$H -d "$C"
test0:
	make test C=ON
test1:
	make test
test2:
	make test C=FOFF
