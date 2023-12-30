filename := System args at(1)

// Check that we have a valid file
filename ifNil("Usage is 'io main.io filename.asm'" println return)
if((filename containsAnyCaseSeq(".asm") not), filename print " is not an .asm file" println return)

(File exists(filename)) ifTrue (
        inputFile := File with(filename)
        
        if ((inputFile isRegularFile) == false,
            filename print
            "is not a valid file" println
            return)

        // Broken - File remove("output.hack")
        // File exists("output.hack") println
        outputFile := File clone open("output.hack")        

        "Parsing " print
        inputFile name println
        inputFile openForReading

        inputFile foreachLine(line,
            result := Parser parse(line)
            
            (result != nil) ifTrue (

                
                //outputFile write(line, "\n")
                outputFile write(result, "\n")
            )
        )
        //parsedSequence := Parser parse(file, SymbolTable)

        //Translator translate(parsedSequence, SymbolTable)
        
    ) ifFalse (
        "Filename " print filename print " not found" println
    )

return