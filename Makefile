# Age_distributions
## Also not much here ☹


current: target
-include target.mk

# -include makestuff/perl.def

######################################################################

# Content

vim_session:
	bash -cl "vmt"

######################################################################

## Content

Sources += $(wildcard *.R)

const.Rout arch_sad.Rout arch.Rout: survival.Rout

######################################################################

### Makestuff

Sources += Makefile

Ignore += makestuff
msrepo = https://github.com/dushoff
Makefile: makestuff/Makefile
makestuff/Makefile:
	git clone $(msrepo)/makestuff
	ls $@

-include makestuff/os.mk

-include makestuff/wrapR.mk

-include makestuff/git.mk
-include makestuff/visual.mk
-include makestuff/projdir.mk
