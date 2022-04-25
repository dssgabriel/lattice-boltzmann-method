# Commands
CC=gcc
MPICC=mpicc
MAKEDEPEND=makedepend

# Flags
CFLAGS=-Wall -Wextra -g -I include/
OFLAGS=-march=native -mtune=native -Ofast
LDFLAGS=-lm

# Files
DEPS=target/deps
SRC=src
LBM_SOURCES=src/lbm_*.c src/main.c
LBM_HEADERS=include/*.h
LBM_OBJECTS=$(DEPS)/lbm_comm.o $(DEPS)/lbm_config.o $(DEPS)/lbm_init.o $(DEPS)/lbm_phys.o $(DEPS)/lbm_struct.o $(DEPS)/main.o

build: target/lbm target/display

run: target/lbm
	@rm -f output.gif
	mpiexec -n 2 $<

gif: output.gif
	@brave $? &

$(DEPS)/%.o: $(SRC)/%.c
	@mkdir -p target/deps
	$(MPICC) $(CFLAGS) $(OFLAGS) -c $< -o $@

target/lbm: $(LBM_OBJECTS)
	$(MPICC) $(CFLAGS) $(OFLAGS) $^ -o $@ $(LDFLAGS)

target/display: $(SRC)/display.c
	$(CC) $(CFLAGS) $? -o $@

results.raw: run target/display

output.gif: results.raw
	@bash ../scripts/gen_animate_gif.sh $? $@

clean:
	@rm -rf target/ results.raw *.gif GIF_TMP/

depend:
	$(MAKEDEPEND) -Y. $(LBM_SOURCES) $(SRC)/display.c

.PHONY: clean build run gif depend results.raw output.gif
