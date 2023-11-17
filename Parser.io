Parser := Object clone do(
    filePosition := 0

    parse := method(file,
        "Parsing " print
        file name println
        file openForReading

        fileBuffer := file asBuffer

        // adding 'peek' functionality to File
        
        fileBuffer peek := method(return at(position + 1))
    

        "Parsing:  " print
        fileBuffer size print
        " characters " println
        // is there a peek in Io?
        // I guess I'll just create one

        loop (
            current := fileBuffer at(filePosition)
            next := fileBuffer at(filePosition + 1)
            
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