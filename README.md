# efficient-formulations

Guia rapida para ejecutar `pddl2smt` y `pddl2sat`.

## Requisitos

- Java (JDK 17+ recomendado)
- Python 3 (solo necesario cuando se usa `-j`)
- Z3 (solo para resolver SMT/CNF fuera de Java)

Dependencias Java usadas por el proyecto:

- `lib/pddl4j-3.1.0.jar`
- `lib/javax.json-1.1.4.jar`
- `lib/javax.json-api-1.1.4.jar`

## Compilacion

```bash
javac -cp 'lib/*' -d out src/*.java
```

## 1) pddl2smt

Genera SMT-LIB (salida por `stdout`).

### Uso base

```bash
java -cp 'out:lib/*' pddl2smt -o <domain.pddl> -f <problem.pddl> -t <pasos>
```

Ejemplo:

```bash
java -cp 'out:lib/*' pddl2smt \
  -o benchmarks/sock-and-shoes/domain.pddl \
  -f benchmarks/sock-and-shoes/problems/problem.pddl \
  -t 4 > /tmp/sock_t4.smt2
```

### Uso con JSON (`-j`)

Con `-j` debes elegir exactamente **un** modo:

- `--mode-c` (perfil de filtrado por operadores)
- `--mode-sc` (perfil con inercia estricta)

```bash
java -cp 'out:lib/*' pddl2smt -o <domain> -f <problem> -t <pasos> -j [json] --mode-c
java -cp 'out:lib/*' pddl2smt -o <domain> -f <problem> -t <pasos> -j [json] --mode-sc
```

Notas:

- Si no existe el JSON, se regenera automaticamente.
- Con `-j` sin modo, o con ambos modos, da error.
- Los flags JSON antiguos de `pddl2smt` ya no son combinables libremente.

### Comprobar satisfacibilidad con Z3

```bash
z3 /tmp/sock_t4.smt2
```

En `sock-and-shoes`:

- `-t 3` -> `unsat`
- `-t 4` -> `sat`

## 2) pddl2sat

Genera CNF DIMACS (salida por `stdout`).

### Uso base

```bash
java -cp 'out:lib/*' pddl2sat -d <domain.pddl> -p <problem.pddl> -s <pasos>
```

Ejemplo:

```bash
java -cp 'out:lib/*' pddl2sat \
  -d benchmarks/sock-and-shoes/domain.pddl \
  -p benchmarks/sock-and-shoes/problems/problem.pddl \
  -s 4 > /tmp/sock_t4.cnf
```

### Uso con JSON (`-j`)

```bash
java -cp 'out:lib/*' pddl2sat -d <domain> -p <problem> -s <pasos> -j [json]
```

Reglas actuales:

- `-j` implica internamente el comportamiento de `--init --static`.
- `--init` y `--static` **ya no se aceptan** de forma explicita.
- `--inertia` no se permite junto con `-j`.

### Reconstruir plan desde CNF + modelo SAT

```bash
java -cp 'out:lib/*' pddl2sat -f <formula.cnf> -m <model>
```

## Ejemplos completos (sock-and-shoes)

SMT con 3 y 4 pasos:

```bash
java -cp 'out:lib/*' pddl2smt -o benchmarks/sock-and-shoes/domain.pddl -f benchmarks/sock-and-shoes/problems/problem.pddl -t 3 > /tmp/sock_t3.smt2
java -cp 'out:lib/*' pddl2smt -o benchmarks/sock-and-shoes/domain.pddl -f benchmarks/sock-and-shoes/problems/problem.pddl -t 4 > /tmp/sock_t4.smt2
z3 /tmp/sock_t3.smt2
z3 /tmp/sock_t4.smt2
```

SAT (CNF):

```bash
java -cp 'out:lib/*' pddl2sat -d benchmarks/sock-and-shoes/domain.pddl -p benchmarks/sock-and-shoes/problems/problem.pddl -s 4 > /tmp/sock_t4.cnf
```

