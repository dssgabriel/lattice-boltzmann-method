# Commands
CC=gcc
MPICC=mpicc
MAKEDEPEND=makedepend

# Flags
CFLAGS=-Wall -Wextra -g3 -I include/ -fopenmp
OFLAGS=-march=native -mtune=native -Ofast
LDFLAGS=-lm

# Files
DEPS=target/deps
SRC=src
LBM_SOURCES=src/lbm_*.c src/main.c
LBM_HEADERS=include/*.h
LBM_OBJECTS=$(DEPS)/lbm_comm.o $(DEPS)/lbm_config.o $(DEPS)/lbm_init.o $(DEPS)/lbm_phys.o $(DEPS)/lbm_struct.o $(DEPS)/main.o

all: target/lbm display

run: target/lbm
	mpiexec -n 4 target/lbm

target/deps/%.o: $(SRC)/%.c
	@mkdir -p target/deps
	$(MPICC) $(CFLAGS) $(OFLAGS) -c $< -o $@

target/lbm: $(LBM_OBJECTS)
	$(MPICC) $(CFLAGS) $(OFLAGS) $^ -o $@ $(LDFLAGS)

display: $(SRC)/display.c
	$(CC) $(CFLAGS) $? -o $@

clean:
	@rm -rf target/ display results.raw *.gif GIF_TMP/

depend:
	$(MAKEDEPEND) -Y. $(LBM_SOURCES) $(SRC)/display.c

.PHONY: clean all run depend

# DO NOT DELETE
main.o: lbm_config.h lbm_struct.h lbm_phys.h lbm_comm.h lbm_init.h
lbm_phys.o: lbm_config.h lbm_struct.h lbm_phys.h lbm_comm.h
lbm_init.o: lbm_phys.h lbm_struct.h lbm_config.h lbm_comm.h lbm_init.h
lbm_struct.o: lbm_struct.h lbm_config.h
lbm_comm.o: lbm_comm.h lbm_struct.h lbm_config.h
lbm_config.o: lbm_config.h
display.o: lbm_struct.h lbm_config.h
