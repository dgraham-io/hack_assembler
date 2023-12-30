Parser := Object clone do(
    filePosition := 0

    skipLine := method(fb, cp
        while (fp at(cp) != 10, cp += 1)
    )

    // in the first pass we'll collect symbols
    firstPass := method(
        // extract symbols and complete 
    )

    get16BitString := method(value,
        valueString := (value asBinary) asString
        bitString := valueString alignRight(16, "0")
        return bitString
    )


    parse := method(line,

        // ignore blank lines
        (line at(0) == nil) ifTrue (
            break
        )

        // discard comments
        commentSplit := line split("//")

        ((commentSplit size < 1) or (commentSplit at(0) == nil)) ifTrue (
            break
        )

        // non-code should be removed at this point
        code := commentSplit at(0)

        (code at(0) == nil) ifTrue (
            break
        )

        // A-instructions
        (code at(0) asCharacter == "@") ifTrue (
            //"Parsed address... " print
            numString := code exSlice(1)
            return get16BitString(numString asNumber)
            
            break
        )
        
        return CInstruction parse(code)

    )
)