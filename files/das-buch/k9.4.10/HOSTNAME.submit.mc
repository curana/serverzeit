divert(-1)
#
# Copyright (c) 2001-2003 Sendmail, Inc. and its suppliers.
#	All rights reserved.
#
# By using this file, you agree to the terms and conditions set
# forth in the LICENSE file which can be found at the top level of
# the sendmail distribution.
#
#

#
#  This is the FreeBSD configuration for a set-group-ID sm-msp sendmail
#  that acts as a initial mail submission program.
#

divert(0)dnl
VERSIONID(`$FreeBSD: src/etc/sendmail/freebsd.submit.mc,v 1.9.2.1 2011/09/23 00:51:37 kensmith Exp $')
define(`confCF_VERSION', `Submit')dnl
define(`__OSTYPE__',`')dnl dirty hack to keep proto.m4 from complaining
define(`_USE_DECNET_SYNTAX_', `1')dnl support DECnet
define(`confTIME_ZONE', `USE_TZ')dnl
define(`confDONT_INIT_GROUPS', `True')dnl
define(`confBIND_OPTS', `WorkAroundBrokenAAAA')dnl
dnl
dnl If you use IPv6 only, change [127.0.0.1] to [IPv6:::1]
FEATURE(`msp', `[10.0.0.3]')dnl