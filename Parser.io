Parser := Object clone do(
    filePosition := 0

    skipLine := method(fb, cp
        while (fp at(cp) != 10, cp += 1)
    )

    // in the first pass we'll collect symbols
    firstPass := method(
        // extract symbols and complete 
    )

    parse := method(file, symbolTable
        "Parsing " print
        file name println
        file openForReading

        // Copy file into Sequence and close
        fileBuffer := file asBuffer

        // modify filebuffer object to find LF and reposition stream to next line
        fileBuffer nextLine := method(cp,
            // LF is acsii decimal '10'
            while (at(cp) != 10, cp = cp + 1)
            return cp + 1
        )

        fileBuffer atEnd := method(cp, 
            return (cp == 10)
        )

        advance := method(
            filePosition = filePosition + 1
        )

        "Parsing:  " print
        fileBuffer size print
        " characters " println

        /// Use the loop to find fields in the fileBuffer
        loop (
            // assess the character at the current position and the next to determine next action
            current := fileBuffer at(filePosition)
            next := fileBuffer at(filePosition + 1)
            
            // ignore comments
            ((current asCharacter == "/") and (next asCharacter == "/")) ifTrue (
                //"comment" println
                filePosition = fileBuffer nextLine(filePosition)
                continue)
            
            // ignore empty lines
            (fileBuffer atEnd) ifTrue (
                // process current field
                filePosition = fileBuffer nextLine(filePosition)
                continue
                )
            
            // Are we at the end of the fileBuffer? (Io returns nil for EOF)
            (next == nil) ifTrue(
                // process current field and exit
                "file end" println
                break)
            
            //find A-instructions
            (current asCharacter == "@") ifTrue (
                "Parsing address... " print
                numString := Sequence clone
                advance
                current := fileBuffer at(filePosition)
                while (current between (48, 57),
                    "found " print
                    current println
                    numString append(current)
                    advance
                    current := fileBuffer at(filePosition)
                )
                aInstruction := numString asNumber
                aInstruction asBinary println
                continue
            )

            (current asCharacter)

            // current asCharacter print

            filePosition = filePosition + 1
        )
    )
)