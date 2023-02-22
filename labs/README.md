# ECON 433 - Labs

In this directory you will find all the labs for my Econ 433 Public Economics course at CSUN.

## Debug Checklist

If you run into an error in your code, check the following before asking me for help:

- Check for spelling and capitalization errors, especially in names of variables or files.

- Check that your parentheses are closed. Every open parenthesis should be matched with a closed parenthesis.

- Check that your quotation marks are closed. Every open quotation mark should be matched with a closed quotation mark.

- Check that you are referencing the correct names of objects in your code. For example, the following code contains an error because `df` was referenced before it was assigned. 

    data <- read.csv("data.csv")
    df <- filter(df, EMPSTAT==1)
    
If you ask me for help too many times on these types of errors, I reserve the right to deduct points from your lab assignments. I want you to become independent coders who can spot these kinds of errors on your own. My help should ideally be reserved for questions about how functions work or about the logical structure of the code.

