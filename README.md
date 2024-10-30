# ID's C Mode

This is a minimal Emacs major mode for C (only, no C++).

It only highlights preprocessors, strings, and comments.  It uses
relative identation, so you'll have to manage the indentation by
yourself.

But it comes with a function `id-c-mode-format-buffer` to format the
entire buffer with [astyle](https://astyle.sourceforge.net/), this
function is binded to `C-M-\`.  To use this function you'll need to have
astyle installed.
