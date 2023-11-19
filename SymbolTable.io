SymbolTable := Map clone do(
    atSymbolPut := method(symbol, value,
        atPut(symbol, value)
    )
)