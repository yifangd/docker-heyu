prep:
	docker run -d \
	-v /home/yifang/ogit/docker-heyu/etc:/etc/heyu \
	kevineye/heyu

run:
	docker run -d \
	-v /home/yifang/ogit/docker-heyu/etc:/etc/heyu \
	-v /etc/localtime:/etc/localtime \
	--device /dev/ttyS0 \
	-p 8080:80 \
	kevineye/heyu
