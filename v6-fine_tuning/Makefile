# Commands
CC := gcc
MPICC := mpicc
MPICMD := mpiexec
MAKEDEPEND := makedepend

# Flags
CFLAGS := -Wall -Wextra -g -I include/ -fopenmp
OFLAGS := -march=native -mtune=native -mavx2 -Ofast -ffast-math -funsafe-math-optimizations -finline-functions -funroll-loops -floop-interchange -fpeel-loops -ftree-vectorize -ftree-loop-vectorize -fomit-frame-pointer -flto
LDFLAGS := -lm
MPIFLAGS := -n 2
MODE := strong

# Files
DEPS := target/deps
SRC := src
LBM_SOURCES := src/lbm_*.c src/main.c
LBM_HEADERS := include/*.h
LBM_OBJECTS := $(DEPS)/lbm_comm.o $(DEPS)/lbm_config.o $(DEPS)/lbm_init.o $(DEPS)/lbm_phys.o $(DEPS)/lbm_struct.o
RAW := results.raw
GIF := output.gif
TRACE := interpol_traces.json
TRACES := rank*_traces.json

build: target/lbm target/display

run: target/lbm
	@rm -f $(GIF)
	OMP_NUM_THREADS=2 $(MPICMD) $(MPIFLAGS) $^

gif: $(GIF)
	@brave $^ &

check: target/display
	@bash ../scripts/checksum.sh $(RAW)

trace: $(TRACE)
	@bash ../scripts/interpol_report.sh $^

bench: target/lbm
	@bash ../scripts/bench.sh $^ $(MODE) $(MPICMD) $(FLAGS)

$(TRACES): target/lbm
	LD_PRELOAD=libinterpol.so $(MPICMD) $(MPIFLAGS) $^
	
$(TRACE): $(TRACES)
	@bash ../scripts/interpol_concat.sh $@

$(GIF): target/display $(RAW)
	@bash ../scripts/gen_animate_gif_parallel.sh $(RAW) $@

$(RAW): target/lbm
	@rm -f $(GIF)
	$(MPICMD) -np 2 $^

$(DEPS)/%.o: $(SRC)/%.c
	@mkdir -p target/deps
	$(MPICC) $(CFLAGS) $(OFLAGS) -c $< -o $@

target/lbm: $(LBM_OBJECTS) $(SRC)/main.c
	@mkdir -p target
	$(MPICC) $(DEF) $(CFLAGS) $(OFLAGS) $^ -o $@ $(LDFLAGS)

target/display: $(SRC)/display.c
	@mkdir -p target
	$(CC) $(CFLAGS) $? -o $@

clean:
	@rm -rf target/ *.raw *.gif GIF_TMP/ tmp/ benchmarks/ plots/

depend:
	$(MAKEDEPEND) -Y. $(LBM_SOURCES) $(SRC)/display.c

.PHONY: clean build run gif check depend bench 
