CInstruction := Object clone do (

    CompSymbols := Map clone with(
        // comp
        "0",    "0101010",
        "1",    "0111111",
        "-1",   "0111010",
        "D",    "0001100",
        "A",    "0110000",
        "M",    "1110000",
        "!D",   "0001101",
        "!A",   "0110001",
        "!M",   "1110001",
        "-D",   "0001111",
        "-A",   "0110011",
        "-M",   "1110011",
        "D+1",  "0011111",
        "A+1",  "0110111",
        "M+1",  "1110111",
        "D-1",  "0001110",
        "A-1",  "0110010",
        "M-1",  "1110010",
        "D+A",  "0000010",
        "D+M",  "1000010",
        "D-A",  "0010011",
        "D-M",  "1010011",
        "A-D",  "0000111",
        "M-D",  "1000111",
        "A&D",  "0000000",
        "M&D",  "1000000",
        "D|A",  "0010101",
        "D|M",  "1010101"
    )

    DestSymbols := Map clone with(
        // dest
        "null", "000",
        "M",    "001",
        "D",    "010",
        "DM",   "011",
        "A",    "100",
        "AM",   "101",
        "AD",   "110",
        "ADM",  "111"
    )

    JumpSymbols := Map clone with(
        // jump
        "null", "000",
        "JGT",  "001",
        "JEQ",  "010",
        "JGE",  "011",
        "JLT",  "100",
        "JNE",  "101",
        "JLE",  "110",
        "JMP",  "111"
    )

    parse := method(code,

        jumpInst := Sequence clone
        destInst := Sequence clone
        compInst := Sequence clone

        // parse jump
        jumpSplit := code split(";")
        (jumpSplit size > 1) ifTrue (
            jump := jumpSplit at(1)
            jumpInst := JumpSymbols at(jump,"000")
            code := jumpSplit at(0)
        ) ifFalse (
            jumpInst := "000"
        )
        
        //  check for destination
        destSplit := code split("=")
        (destSplit size > 1) ifTrue (
            dest := destSplit at(0)
            destInst := DestSymbols at(dest, "000")
            code := destSplit at(1)
            //destInst println
        ) ifFalse (
            destInst := "000"
        )

        // parse computation
        compInst := CompSymbols at(code, "0000000")

        // jumpInst println
        // destInst println
        // compInst println

        return "111" .. compInst .. destInst .. jumpInst                                                                                   
    )
    
)

