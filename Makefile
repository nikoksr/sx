SRC   := sx install.sh

.PHONY: fmt fmt-check lint check

fmt:
	shfmt -w $(SRC)

fmt-check:
	shfmt -d $(SRC)

lint:
	shellcheck --severity=warning $(SRC)

check: fmt-check lint
