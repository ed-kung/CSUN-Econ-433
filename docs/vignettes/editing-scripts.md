---
layout: default
title: Editing scripts
parent: Vignettes
nav_order: 3
---

# Editing scripts
{: .no_toc }

- TOC
{:toc}

---

## Starting a new script

- Click `Files`->`New File`->`R Script`. This opens an empty script in the script editor
- You should type `rm(list=ls())` at the start of every new script.
  - This clears the work environment. It's like starting your work session with a clear desk. 
  - Not doing this at the start of each script can lead to errors that are hard to reproduce and hard to debug.

---

## Running a script

- To run the entire script from top to bottom, click anywhere in script in the script editor. 

- Then hit `CTRL+SHIFT+ENTER` (or `CMD+SHIFT+ENTER` on Mac).

- This will cause R to execute each line of your script, starting from the top, until it either finishes or it hits a syntax error.

- If the script runs, then that means it has no syntax errors. However, it still might contain errors in the logic that leads to wrong results, so make sure you double check that your results make sense! 

---

## Executing a single command

- To execute a single command in the script without running the whole script, click on the line in that you want to execute, so that the typing cursor is on the line.

- Then hit `CTRL+ENTER` (or `CMD+ENTER` on Mac).

- This is useful for testing one specific line in your script. 

- When debugging, it is highly recommended that you "step through" your code line by line, by executing each line one at a time using this method.

---

## Saving a script

- Make sure the script you want to save is in the script editor pane.

- Click `File`->`Save` or `File`->`Save As` if you want to change the name of the script.

- Name the script something meaningful. It should have a `.R` file extension.

- The saved script will now show up in the Files pane. You can download it to your computer and upload it to Canvas for grading. (See [here](/docs/vignettes/rstudio-basics).)






