
dnl sc_builtin.m4 - custom macros for distributing third-party software
dnl
dnl This file is part of the SC Library.
dnl The SC library provides support for parallel scientific applications.
dnl
dnl Copyright (C) 2008,2009 Carsten Burstedde, Lucas Wilcox.

dnl Documentation for macro names: brackets indicate optional arguments

dnl SC_BUILTIN_GETOPT_PREFIX(PREFIX)
dnl This function only activates if PREFIX_WITH_GETOPT is "yes".
dnl This function checks if getopt_long can be compiled.
dnl The shell variable PREFIX_PROVIDE_GETOPT is set to "yes" or "no".
dnl Both a define and automake conditional are set.
dnl
AC_DEFUN([SC_BUILTIN_GETOPT_PREFIX],
[
$1_PROVIDE_GETOPT="no"
AC_MSG_CHECKING([for getopt])
AC_LINK_IFELSE([AC_LANG_PROGRAM(
[[#include <getopt.h>]], [[
int oi;
struct option lo;
getopt_long (0, 0, "abc:", &lo, &oi);
]])], [AC_MSG_RESULT([successful])], [
    AC_MSG_RESULT([failed])
    AC_MSG_NOTICE([did not find getopt. Activating builtin])
    $1_PROVIDE_GETOPT="yes"
    AC_DEFINE([PROVIDE_GETOPT], 1, [Use builtin getopt])
])
AM_CONDITIONAL([$1_PROVIDE_GETOPT], [test "$$1_PROVIDE_GETOPT" = "yes"])
])
AC_DEFUN([SC_BUILTIN_GETOPT], [SC_BUILTIN_GETOPT_PREFIX([SC])])

dnl SC_BUILTIN_ALL_PREFIX(PREFIX)
dnl Aggregate all checks from this file for convenience.
dnl
AC_DEFUN([SC_BUILTIN_ALL_PREFIX],
[
SC_BUILTIN_GETOPT_PREFIX([$1])
])
AC_DEFUN([SC_BUILTIN_ALL], [SC_BUILTIN_ALL_PREFIX([SC])])
