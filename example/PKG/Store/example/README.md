# Intro

## `.path` file

Each line contains a path, relative to the file exists

## `.env` file

Format:

```
<Env>      ::= <Variable> '=' <Value>

<Variable> ::= [ <Prefix> ] <Symbol>
<Symbol>   ::= Any legal Alphabat

<Value>    ::= { <Variable> } Any legal string [ <Value> ]
```

### Prefix

1. `!`: Override the Original System Environment Variable
2. `@`: If the Variable exists, then use the original, otherwise, use the variable defined within the file
3. Default: If the original variable exists, then append to the variable (split by `;`), otherwise, create a new variable
4. `\`: Reserved

### Variables

1. `$CD`: replaced by `$pwd` immediate
2. `%.*%`: replace the whole by variable within same file, the variable chosen are wrapped by the `%`
