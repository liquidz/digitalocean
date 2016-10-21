NAME=uodo
KEY_NAME=termux

doctl:
	go get github.com/digitalocean/doctl/cmd/doctl

list:
	doctl compute droplet list

region:
	doctl compute region list

image:
	doctl compute image list

size:
	doctl compute size list

ssh-key-list:
	doctl compute ssh-key list

ssh-key-create:
	doctl compute ssh-key create $(KEY_NAME) \
		--public-key "$(shell cat ~/.ssh/id_rsa.pub)"

create:
	doctl compute droplet create $(NAME) \
		--region   sgp1 \
		--image    ubuntu-16-10-x64 \
		--size     512mb \
		--ssh-keys $(shell doctl compute ssh-key list | grep $(KEY_NAME) | cut -f1)

delete:
	doctl compute droplet delete $(NAME)

ssh:
	doctl compute ssh $(NAME)
