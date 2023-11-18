Parser := Object clone do(
    filePosition := 0
    skipLine := method(fb, cp
        while (fp at(cp) != 10, cp += 1)

    )

    parse := method(file,
        "Parsing " print
        file name println
        file openForReading

        // Copy file into Sequence and close
        fileBuffer := file asBuffer

        fileBuffer nextLine := method(cp,
            while (at(cp) != 10, cp = cp + 1)
            return cp + 1
        )

        "Parsing:  " print
        fileBuffer size print
        " characters " println

        loop (
            // assess the character at the current position and the next to determine next action
            current := fileBuffer at(filePosition)
            next := fileBuffer at(filePosition + 1)
            
            ((current asCharacter == "/") and (next asCharacter == "/")) ifTrue (
                "comment" println
                filePosition = fileBuffer nextLine(filePosition)
                continue)

            current asCharacter print
            // Io returns nil for EOF
            (next == nil) ifTrue(
                "file end" println
                break)
            //next asCharacter println

            filePosition = filePosition + 1
        )
    )
)