# efficient-formulations

Reference README for the current CLI behavior of:
- `pddl2smt`
- `pddl2sat`
- `pddlalltime`

## Requirements

- Java (JDK 17+ recommended)
- Python 3 (required when using `-j` modes that generate/read JSON)
- Z3 (optional, for solving generated SMT files)

Java libraries used by this repository:
- `lib/pddl4j-3.1.0.jar`
- `lib/javax.json-1.1.4.jar`
- `lib/javax.json-api-1.1.4.jar`

## Compile

```bash
javac -cp 'lib/*:src' -d out src/pddl2smt.java src/pddl2sat.java src/pddlalltime.java
```

## 1) `pddl2smt`

Generates SMT-LIB to `stdout`.

### Mandatory flags

- `-o <domain.pddl>`
- `-f <problem.pddl>`
- `-t <steps>` where `<steps> >= 0`

Base command:

```bash
java -cp 'out:lib/*' pddl2smt -o <domain.pddl> -f <problem.pddl> -t <steps>
```

### JSON mode (`-j`)

You can add:
- `-j [json_file]` (optional file path, default `output.json`)

When `-j` is used, exactly one profile is required:
- `--mode-c` (equivalent to `--init --static-init --opfilter-dom-no-pv`)
- `--mode-sc` (equivalent to `--init --static-init --inertia --inertia-eff-skip`)

Valid commands:

```bash
java -cp 'out:lib/*' pddl2smt -o <domain> -f <problem> -t <steps> -j [json] --mode-c
java -cp 'out:lib/*' pddl2smt -o <domain> -f <problem> -t <steps> -j [json] --mode-sc
```

Rules:
- With `-j`, one and only one of `--mode-c` / `--mode-sc` is accepted.
- Legacy JSON flags are rejected if `-j` is present.
- If JSON flags are passed without `-j`, they are ignored with a warning.
- If the JSON file does not exist, it is generated automatically.

### Example (sock-and-shoes)

```bash
java -cp 'out:lib/*' pddl2smt \
  -o benchmarks/sock-and-shoes/domain.pddl \
  -f benchmarks/sock-and-shoes/problems/problem.pddl \
  -t 4 > /tmp/sock_t4.smt2

z3 /tmp/sock_t4.smt2
```

## 2) `pddl2sat`

Generates CNF (DIMACS) to `stdout`.

### Planning mode

Mandatory flags:
- `-d <domain.pddl>`
- `-p <problem.pddl>`
- `-s <steps>`

```bash
java -cp 'out:lib/*' pddl2sat -d <domain.pddl> -p <problem.pddl> -s <steps>
```

### JSON mode with SAT encoding

```bash
java -cp 'out:lib/*' pddl2sat -d <domain> -p <problem> -s <steps> -j [json]
```

Behavior and constraints:
- `-j` implies internal `init + static` behavior.
- `--init` and `--static` are no longer accepted explicitly.
- `--inertia` is valid only without `-j`.
- If `[json]` is omitted, default is `output.json`.
- If JSON does not exist, it is generated automatically.

### Plan reconstruction mode

```bash
java -cp 'out:lib/*' pddl2sat -f <formula.cnf> -m <model>
```

### Help

```bash
java -cp 'out:lib/*' pddl2sat --help
```

## 3) `pddlalltime`

Quantified SMT variant. This tool is intentionally limited to `-q`.

Mandatory flags:
- `-o <domain.pddl>`
- `-f <problem.pddl>`
- `-q all|time`

```bash
java -cp 'out:lib/*' pddlalltime -o <domain.pddl> -f <problem.pddl> -q all
java -cp 'out:lib/*' pddlalltime -o <domain.pddl> -f <problem.pddl> -q time
```

Current policy:
- Only quantified mode is supported in `pddlalltime`.
- Non-`-q` invocations print usage.

## End-to-end quick checks

```bash
# pddl2smt
java -cp 'out:lib/*' pddl2smt -o benchmarks/sock-and-shoes/domain.pddl -f benchmarks/sock-and-shoes/problems/problem.pddl -t 3 > /tmp/sock_t3.smt2
java -cp 'out:lib/*' pddl2smt -o benchmarks/sock-and-shoes/domain.pddl -f benchmarks/sock-and-shoes/problems/problem.pddl -t 4 > /tmp/sock_t4.smt2
z3 /tmp/sock_t3.smt2
z3 /tmp/sock_t4.smt2

# pddl2sat
java -cp 'out:lib/*' pddl2sat -d benchmarks/sock-and-shoes/domain.pddl -p benchmarks/sock-and-shoes/problems/problem.pddl -s 4 > /tmp/sock_t4.cnf

# pddlalltime
java -cp 'out:lib/*' pddlalltime -o benchmarks/sock-and-shoes/domain.pddl -f benchmarks/sock-and-shoes/problems/problem.pddl -q all > /tmp/pddlalltime_q_all.smt2
java -cp 'out:lib/*' pddlalltime -o benchmarks/sock-and-shoes/domain.pddl -f benchmarks/sock-and-shoes/problems/problem.pddl -q time > /tmp/pddlalltime_q_time.smt2
z3 /tmp/pddlalltime_q_all.smt2
z3 /tmp/pddlalltime_q_time.smt2
```
