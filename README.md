# qutil packages

A set of utility packages for kdb+/q, designed for use with [qutil](https://github.com/nugend/qutil)

To set up, clone or download repo, and then copy/link each subdirectory into
your qutil package dir, typically pointed to by `QPATH` env var.

## serve

Simple HTTP server, allows for serving up static content, with a mechanism to
tell clients to refresh page via WebSockets. Used in, for example,
[jonathonmcmurray/qchart](https://github.com/jonathonmcmurray/qchart)

Depends on: `port`, `log`

## port

Check if kdb+ is listening on a port, and if not, randomly assign an available
one. 

Depends on: `log`

## log

Very simple logging functionality, timestamping log messages & colour coding
log level (warn, alert etc.). Colours only where supported (e.g. Linux, Windows
with cmder).

Depends on: `os`

## console

Resizes console to fill terminal by default (removing reliance on COLUMNS &
LINES env vars). Also provides functions to resize at run time.

Depends on: `log`, `os`

## os

OS related utilities, so far this includes testing if a command works on
current OS (e.g. to check if `tty` works for `log` package)

Depends on: none.

## json

Provides JSON functions for kdb+ <= v3.1, using `json.k` from kx

Depends on: none.
