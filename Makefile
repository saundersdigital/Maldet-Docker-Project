build:
	docker build -t "saundersdigital/docker-maldet" .

shell:
	docker run -ti --rm "saundersdigital/docker-maldet" /bin/bash

check:
	docker run --volume `pwd`:/htdocs --rm "saundersdigital/docker-maldet" maldet -a /htdocs

help:
	docker run --rm "saundersdigital/docker-maldet" maldet -h

