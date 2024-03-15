.PHONY: gen-root gen-intermediate gen-jagex gen-keystore reset

gen-root:
	@scripts/create-root-key.sh
	@scripts/create-root-cert.sh

gen-intermediate:
	@scripts/create-intermediate-key.sh
	@scripts/create-intermediate-cert.sh

gen-jagex:
	@scripts/create-jagex-key.sh
	@scripts/create-jagex-cert.sh

gen-keystore:
	@scripts/create-keystore.sh

reset:
	@scripts/reset.sh
