
CCL := ccl64

SERVER_FILES := \
	README.md \
	UNLICENSE \
	lisp-motd-server.asd \
	src/package.lisp \
	src/util.lisp \
	src/errors.lisp \
	src/dynamodb.lisp \
	src/handler.lisp

all:	lisp-motd-server.zip
.PHONY: all

clean:
	rm -f lisp-motd-server.zip
.PHONY: clean

lisp-motd-server.zip: $(SERVER_FILES)
	zip $@ $^
