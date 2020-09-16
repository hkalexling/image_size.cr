DIRS := $(wildcard ext/*/.)

all:
	@for DIR in $(DIRS); do \
		$(MAKE) -C $$DIR; \
	done

clean:
	@for DIR in $(DIRS); do \
		$(MAKE) -C $$DIR clean; \
	done
