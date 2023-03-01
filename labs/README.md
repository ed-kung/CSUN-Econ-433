# ECON 433 - Labs

In this directory you will find all the labs for my Econ 433 Public Economics course at CSUN.

## Debug Checklist

*"A computer is like a mischievous genie. It always gives you exactly what you ask for, but not always what you want."*

If you run into an error in your code, check the following before asking me for help:

- Check the error log. It contains helpful information about the type of error you ran into.

- Check for spelling and capitalization errors, especially in names of variables or files.

- Check that your parentheses are closed. Every open parenthesis should be matched with a closed parenthesis.

- Check that your quotation marks are closed. Every open quotation mark should be matched with a closed quotation mark.

- Check that you aren't missing commas in separating any lists or function arguments.

- Check that you are referencing the correct names of objects in your code. For example, the following code contains an error because the dataframe was named `data` but then later `df` is referenced. 

        data <- read.csv("data.csv")
        df <- filter(df, EMPSTAT==1)
    
If you ask me for help too many times on these types of errors, I reserve the right to deduct points from your lab assignments. I want you to become independent coders who can spot these kinds of errors on your own. My help should ideally be reserved for questions about how functions work or about the logical structure of the code.

