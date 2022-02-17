# Exit Codes With Special Meanings

> Table E-1. Reserved Exit Codes

**Table E-1. _Reserved_ Exit Codes**

| Exit Code Number | Meaning | Example | Comments |
| --- | --- | --- | --- |
| 1 | Catchall for general errors | let "var1 = 1/0" | Miscellaneous errors, such as "divide by zero" and other impermissible operations |
| 2 | Misuse of shell builtins (according to Bash documentation) | empty\_function() {} | [Missing keyword](chrome-extension://cjedbglnccaioiolemnfhjncicchinao/debugging.html#MISSINGKEYWORD) or command, or permission problem (and [_diff_ return code on a failed binary file comparison](chrome-extension://cjedbglnccaioiolemnfhjncicchinao/filearchiv.html#DIFFERR2)). |
| 126 | Command invoked cannot execute | /dev/null | Permission problem or command is not an executable |
| 127 | "command not found" | illegal\_command | Possible problem with $PATH or a typo |
| 128 | Invalid argument to [exit](chrome-extension://cjedbglnccaioiolemnfhjncicchinao/exit-status.html#EXITCOMMANDREF) | exit 3.14159 | **exit** takes only integer args in the range 0 - 255 (see first footnote) |
| 128+n | Fatal error signal "n" | _kill -9_ $PPID of script | **$?** returns 137 (128 + 9) |
| 130 | Script terminated by Control-C | _Ctl-C_ | Control-C is fatal error signal 2, (130 = 128 + 2, see above) |
| 255\* | Exit status out of range | exit \-1 | **exit** takes only integer args in the range 0 - 255 |

According to the above table, exit codes 1 - 2, 126 - 165, and 255 [\[1\]](#FTN.AEN23629) have special meanings, and should therefore be avoided for user-specified exit parameters. Ending a script with _exit 127_ would certainly cause confusion when troubleshooting (is the error code a "command not found" or a user-defined one?). However, many scripts use an _exit 1_ as a general bailout-upon-error. Since exit code 1 signifies so many possible errors, it is not particularly useful in debugging.

There has been an attempt to systematize exit status numbers (see /usr/include/sysexits.h), but this is intended for C and C++ programmers. A similar standard for scripting might be appropriate. The author of this document proposes restricting user-defined exit codes to the range 64 - 113 (in addition to 0, for success), to conform with the C/C++ standard. This would allot 50 valid codes, and make troubleshooting scripts more straightforward. [\[2\]](#FTN.AEN23647) All user-defined exit codes in the accompanying examples to this document conform to this standard, except where overriding circumstances exist, as in [Example 9-2](chrome-extension://cjedbglnccaioiolemnfhjncicchinao/internalvariables.html#TMDIN).

<table><tbody><tr><td><img src="chrome-extension://cjedbglnccaioiolemnfhjncicchinao/images/note.gif" alt="Note"></td><td><p>Issuing a <a href="chrome-extension://cjedbglnccaioiolemnfhjncicchinao/internalvariables.html#XSTATVARREF">$?</a> from the command-line after a shell script exits gives results consistent with the table above only from the Bash or <i>sh</i> prompt. Running the <i>C-shell</i> or <i>tcsh</i> may give different values in some cases.</p></td></tr></tbody></table>


[Source](https://tldp.org/LDP/abs/html/exitcodes.html)