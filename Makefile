Q3MAP2 = ~/build/GtkRadiant/install/q3map2
URTDIR = /opt/urbanterror

MAPNAME = ut4_snupes
MAP := maps/$(MAPNAME).map
BSP := maps/$(MAPNAME).bsp

Q3MAP2_THREADS = 4

override Q3MAP2_OPTIONS += -v -threads $(Q3MAP2_THREADS) -game quake3 -fs_basepath $(URTDIR) -fs_game q3ut4
Q3MAP2_META_OPTIONS = -patchmeta -subdivisions 1
Q3MAP2_VIS_OPTIONS = -saveprt
Q3MAP2_LIGHT_OPTIONS = -nocollapse -fast -samples 3 -bounce 2 -patchshadows

bsp: $(BSP)
$(BSP): $(MAP)
	$(Q3MAP2) $(Q3MAP2_OPTIONS) -meta $(Q3MAP2_META_OPTIONS) $<
	$(Q3MAP2) $(Q3MAP2_OPTIONS) -vis $(Q3MAP2_VIS_OPTIONS) $<
	$(Q3MAP2) $(Q3MAP2_OPTIONS) -light $(Q3MAP2_LIGHT_OPTIONS) $<

clean:
	rm -f $(BSP)
	rm -f maps/$(MAPNAME).prt
	rm -f maps/$(MAPNAME).srf
