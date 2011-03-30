Q3MAP2 = ~/build/GtkRadiant/install/q3map2
URT = /opt/urbanterror/ioUrbanTerror
URTDIR = /opt/urbanterror

MAPNAME = ut4_snupes
MAP := maps/$(MAPNAME).map
BSP := maps/$(MAPNAME).bsp
PK3 := $(MAPNAME).pk3

TEXTURES := $(shell find textures -name "*.tga")
SCRIPTS := $(wildcard scripts/*)
READMES := $(shell find . -name "*readme.txt")

Q3MAP2_THREADS = 4

override Q3MAP2_OPTIONS += -v -threads $(Q3MAP2_THREADS) -game quake3 -fs_basepath $(URTDIR) -fs_game q3ut4
Q3MAP2_META_OPTIONS = -patchmeta -subdivisions 1
Q3MAP2_VIS_OPTIONS = -saveprt
Q3MAP2_LIGHT_OPTIONS = -nocollapse -fast -samples 3 -bounce 2 -patchshadows

pk3: $(PK3)
$(PK3): $(BSP) $(TEXTURES) $(SCRIPTS) $(READMES)
	zip $@ $?

bsp: $(BSP)
$(BSP): $(MAP)
	$(Q3MAP2) $(Q3MAP2_OPTIONS) -meta $(Q3MAP2_META_OPTIONS) $<
	$(Q3MAP2) $(Q3MAP2_OPTIONS) -vis $(Q3MAP2_VIS_OPTIONS) $<
	$(Q3MAP2) $(Q3MAP2_OPTIONS) -light $(Q3MAP2_LIGHT_OPTIONS) $<

ffa-test: $(PK3)
	cp $< ~/.urbanterror/q3ut4/
	$(URT) +set sv_pure 0 +set g_gametype 0 +devmap $(MAPNAME)
	rm ~/.urbanterror/q3ut4/$(MAPNAME).pk3

tdm-test: $(PK3)
	cp $< ~/.urbanterror/q3ut4/
	$(URT) +set sv_pure 0 +set g_gametype 3 +devmap $(MAPNAME)
	rm ~/.urbanterror/q3ut4/$(MAPNAME).pk3

ts-test: $(PK3)
	cp $< ~/.urbanterror/q3ut4/
	$(URT) +set sv_pure 0 +set g_gametype 4 +devmap $(MAPNAME)
	rm ~/.urbanterror/q3ut4/$(MAPNAME).pk3

ctf-test: $(PK3)
	cp $< ~/.urbanterror/q3ut4/
	$(URT) +set sv_pure 0 +set g_gametype 7 +devmap $(MAPNAME)
	rm ~/.urbanterror/q3ut4/$(MAPNAME).pk3

clean:
	rm -f $(PK3)
	rm -f $(BSP)
	rm -f maps/$(MAPNAME).prt
	rm -f maps/$(MAPNAME).srf

.PHONY: clean pk3 bsp ffa-test tdm-test ts-test
