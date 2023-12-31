Parser := Object clone do(
    codeLine := 0



    removeWhitespace := method(line,
        // remove whitespace at ends
        line = line strip()

        // discard comments
        commentSplit := line split("//")

        ((commentSplit size < 1) or (commentSplit at(0) == nil)) ifTrue (
            return nil
        )

        // non-code should be removed at this point
        code := commentSplit at(0)

        // ignore blank lines
        (code at(0) == nil) ifTrue (
            return nil
        )

        return code

    )

    get16BitString := method(value,
        valueString := (value asBinary) asString
        bitString := valueString alignRight(16, "0")
        return bitString
    )

    parseLabel := method(line,
        
        code := removeWhitespace(line)
        
        // do we still have something to work with?
        (code == nil) ifTrue (
            return nil
        )

        (code at(0) asCharacter == "(") ifTrue (
            //"Parsing label... " print
            labelString := code strip("()")

            labelAddress := get16BitString(codeLine)
            
            // labelString print
            // " " print
            // labelAddress println

            SymbolTable atSymbolPut(labelString, labelAddress)

            validate_label := SymbolTable at(labelString)
            (labelString == validate_label) ifFalse (
                "Error - symbol"
            )

            return labelAddress
        )
        
        // Done parsing, increment counter for next line
        codeLine = codeLine + 1
    )

    parseCode := method(line,

        code := removeWhitespace(line)
        //code println
        
        // do we still have something to work with?
        (code == nil) ifTrue (
            return nil
        )

        // skip labels
        (code at(0) asCharacter == "(") ifTrue (
            return nil
        )

        // A-instructions
        (code at(0) asCharacter == "@") ifTrue (
            //"Parsing address... " print
            numString := code exSlice(1)

            (numString at(0) between (48, 57)) ifTrue (
                return get16BitString(numString asNumber)
            ) ifFalse (
                bitString := SymbolTable resolveSymbolAt(numString)
                (bitString != nil) ifTrue (
                    return bitString
                )
                
            )
            "Error" println
            numString println
            code println
            break
        )
        
        return CInstruction parse(code)

    )
)