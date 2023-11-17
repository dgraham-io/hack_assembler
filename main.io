filename := System args at(1)

// Check that we have a valid file
filename ifNil("Usage is 'io main.io filename.asm'" println return)
if((filename containsAnyCaseSeq(".asm") not), filename print " is not an .asm file" println return)

(File exists(filename)) ifTrue (
        file := File with(filename)
        
        if ((file isRegularFile) == false,
            filename print
            "is not a valid file" println
            return)
        
        parser := Parser clone
        parser parse(file)
    ) ifFalse (
        "Filename " print filename print " not found" println
    )

return