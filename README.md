# efficient-formulations

This README documents the current command-line behavior for:
- `pddl2smt`
- `pddl2sat`
- `pddlalltime`

## Requirements

- Java (JDK 17+ recommended)
- Python 3 (required when using `-j` modes that generate/read JSON)
- Z3 (optional, for solving generated SMT formulas)

Java dependencies used in this repository:
- `lib/pddl4j-3.1.0.jar`
- `lib/javax.json-1.1.4.jar`
- `lib/javax.json-api-1.1.4.jar`

## Compile

```bash
javac -cp 'lib/*:src' -d out src/pddl2smt.java src/pddl2sat.java src/pddlalltime.java
```

## 1) SMT Encoding Without Quantifiers

Prints SMT-LIB to `stdout`.

### Required options

- `-o <domain.pddl>`
- `-f <problem.pddl>`
- `-t <steps>` with `<steps> >= 0`

```bash
java -cp 'out:lib/*' pddl2smt -o <domain.pddl> -f <problem.pddl> -t <steps>
```

### JSON mode (`-j`)

Optional:
- `-j [json_file]` (default: `output.json`)

When `-j` is present, exactly one mode must be selected:
- `--mode-c`  SMT-FD-C
- `--mode-sc`  SMT-FD-SC

```bash
java -cp 'out:lib/*' pddl2smt -o <domain> -f <problem> -t <steps> -j [json] --mode-c
java -cp 'out:lib/*' pddl2smt -o <domain> -f <problem> -t <steps> -j [json] --mode-sc
```

Rules:
- With `-j`, one and only one of `--mode-c` / `--mode-sc` is accepted.
- Legacy JSON flags are rejected when `-j` is used.
- JSON flags without `-j` are ignored with a warning.
- If the JSON file does not exist, it is generated automatically.

## 2) SAT Encoding

Prints CNF (DIMACS) to `stdout`.

### Planning mode

Required options:
- `-d <domain.pddl>`
- `-p <problem.pddl>`
- `-s <steps>`

```bash
java -cp 'out:lib/*' pddl2sat -d <domain.pddl> -p <problem.pddl> -s <steps>
```

### JSON planning mode

```bash
java -cp 'out:lib/*' pddl2sat -d <domain> -p <problem> -s <steps> -j [json]
```

Behavior:
- If `[json]` is omitted, default is `output.json`.
- If the JSON file does not exist, it is generated automatically.

### Plan reconstruction mode

```bash
java -cp 'out:lib/*' pddl2sat -f <formula.cnf> -m <model>
```

### Help

```bash
java -cp 'out:lib/*' pddl2sat --help
```

## 3) SMT Encoding With Quantifiers

Quantified SMT variant. This executable is intentionally limited to `-q` mode.

Required options:
- `-o <domain.pddl>`
- `-f <problem.pddl>`
- `-q all|time`

```bash
java -cp 'out:lib/*' pddlalltime -o <domain.pddl> -f <problem.pddl> -q all
java -cp 'out:lib/*' pddlalltime -o <domain.pddl> -f <problem.pddl> -q time
```

Policy:
- Only quantified mode is supported in `pddlalltime`.
- Non-`-q` calls print usage.

## Quick checks (sock-and-shoes)

```bash
# pddl2smt
java -cp 'out:lib/*' pddl2smt -o benchmarks/sock-and-shoes/domain.pddl -f benchmarks/sock-and-shoes/problems/problem.pddl -t 3 > /tmp/sock_t3.smt2
java -cp 'out:lib/*' pddl2smt -o benchmarks/sock-and-shoes/domain.pddl -f benchmarks/sock-and-shoes/problems/problem.pddl -t 4 > /tmp/sock_t4.smt2

# pddl2sat
java -cp 'out:lib/*' pddl2sat -d benchmarks/sock-and-shoes/domain.pddl -p benchmarks/sock-and-shoes/problems/problem.pddl -s 4 > /tmp/sock_t4.cnf

# pddlalltime
java -cp 'out:lib/*' pddlalltime -o benchmarks/sock-and-shoes/domain.pddl -f benchmarks/sock-and-shoes/problems/problem.pddl -q all > /tmp/pddlalltime_q_all.smt2
java -cp 'out:lib/*' pddlalltime -o benchmarks/sock-and-shoes/domain.pddl -f benchmarks/sock-and-shoes/problems/problem.pddl -q time > /tmp/pddlalltime_q_time.smt2
```
