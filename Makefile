export TOPDIR	:=	$(CURDIR)

export LIBNDS_MAJOR	:= 1
export LIBNDS_MINOR	:= 8
export LIBNDS_PATCH	:= 3

VERSION	:=	$(LIBNDS_MAJOR).$(LIBNDS_MINOR).$(LIBNDS_PATCH)


.PHONY: release debug clean all docs

all: include/nds/libversion.h release debug

#-------------------------------------------------------------------------------
release: lib
#-------------------------------------------------------------------------------
	$(MAKE) -C arm9 BUILD=release || { exit 1;}
	$(MAKE) -C arm7 BUILD=release || { exit 1;}

#-------------------------------------------------------------------------------
debug: lib
#-------------------------------------------------------------------------------
	$(MAKE) -C arm9 BUILD=debug || { exit 1;}
	$(MAKE) -C arm7 BUILD=debug || { exit 1;}

#-------------------------------------------------------------------------------
lib:
#-------------------------------------------------------------------------------
	mkdir lib

#-------------------------------------------------------------------------------
clean:
#-------------------------------------------------------------------------------
	@$(MAKE) -C arm9 clean
	@$(MAKE) -C arm7 clean

#---------------------------------------------------------------------------------
docs:
#---------------------------------------------------------------------------------
	doxygen Doxyfile
	cat warn.log

#---------------------------------------------------------------------------------
include/nds/libversion.h : Makefile
#---------------------------------------------------------------------------------
	@echo "#ifndef __LIBNDSVERSION_H__" > $@
	@echo "#define __LIBNDSVERSION_H__" >> $@
	@echo >> $@
	@echo "#define _LIBNDS_MAJOR_	$(LIBNDS_MAJOR)" >> $@
	@echo "#define _LIBNDS_MINOR_	$(LIBNDS_MINOR)" >> $@
	@echo "#define _LIBNDS_PATCH_	$(LIBNDS_PATCH)" >> $@
	@echo >> $@
	@echo '#define _LIBNDS_STRING "libNDS Release '$(LIBNDS_MAJOR).$(LIBNDS_MINOR).$(LIBNDS_PATCH)'"' >> $@
	@echo >> $@
	@echo "#endif // __LIBNDSVERSION_H__" >> $@

