# efficient-formulations

Quick guide to run `pddl2smt` and `pddl2sat`.

## Requirements

- Java (JDK 17+ recommended)
- Python 3 (only needed when using `-j`)
- Z3 (only needed to solve SMT/CNF outside Java)

Java dependencies used by the project:

- `lib/pddl4j-3.1.0.jar`
- `lib/javax.json-1.1.4.jar`
- `lib/javax.json-api-1.1.4.jar`

## Compilation

```bash
javac -cp 'lib/*' -d out src/*.java
```

## 1) pddl2smt

Generates SMT-LIB (output is printed to `stdout`).

### Basic usage

```bash
java -cp 'out:lib/*' pddl2smt -o <domain.pddl> -f <problem.pddl> -t <steps>
```

Example:

```bash
java -cp 'out:lib/*' pddl2smt \
  -o benchmarks/sock-and-shoes/domain.pddl \
  -f benchmarks/sock-and-shoes/problems/problem.pddl \
  -t 4 > /tmp/sock_t4.smt2
```

### JSON usage (`-j`)

With `-j`, you must choose exactly **one** mode:

- `--mode-c` (operator-filter profile)
- `--mode-sc` (strict inertia profile)

```bash
java -cp 'out:lib/*' pddl2smt -o <domain> -f <problem> -t <steps> -j [json] --mode-c
java -cp 'out:lib/*' pddl2smt -o <domain> -f <problem> -t <steps> -j [json] --mode-sc
```

Notes:

- If the JSON file from FD simplification does not exist, it is regenerated automatically.
- Using `-j` without a mode (or with both modes) raises an error.
- Legacy JSON flags in `pddl2smt` are no longer freely combinable.

## 2) pddl2sat

Generates DIMACS CNF (output is printed to `stdout`).

### Basic usage

```bash
java -cp 'out:lib/*' pddl2sat -d <domain.pddl> -p <problem.pddl> -s <steps>
```

Example:

```bash
java -cp 'out:lib/*' pddl2sat \
  -d benchmarks/sock-and-shoes/domain.pddl \
  -p benchmarks/sock-and-shoes/problems/problem.pddl \
  -s 4 > /tmp/sock_t4.cnf
```

### JSON usage (`-j`)

```bash
java -cp 'out:lib/*' pddl2sat -d <domain> -p <problem> -s <steps> -j [json]
```

### Reconstruct a plan from CNF + SAT model

```bash
java -cp 'out:lib/*' pddl2sat -f <formula.cnf> -m <model>
```

## Complete examples (sock-and-shoes)

SMT with 3 and 4 steps:

```bash
java -cp 'out:lib/*' pddl2smt -o benchmarks/sock-and-shoes/domain.pddl -f benchmarks/sock-and-shoes/problems/problem.pddl -t 4 > /tmp/sock_t4.smt2
```

SAT (CNF):

```bash
java -cp 'out:lib/*' pddl2sat -d benchmarks/sock-and-shoes/domain.pddl -p benchmarks/sock-and-shoes/problems/problem.pddl -s 4 > /tmp/sock_t4.cnf
```
