## Management stuff
# Fucking nice printing of big packages
alias big-packages='expac -H M "%m\t%n" | sort -hr'
# Pacaur shortcuts
alias pacup='pacaur -Syyua'
alias pacusl='pacaur -Rs $(pacaur -Qtdq)'
alias pac='pacaur -Sc'
# Cleanup and redownload of all the packages
# Didn't really use it though
#paccleanup() {
#	# Clean up cache
#	pacaur -Scc
#	# Download packages
#	pacaur -Sw $(yaourt -Qqn)
#	# AUR part
#	pacaur -Sb $(yaourt -Qqm)
#}
# See package usage size and biggest packages.
# Still, 'big-packages' is better, I think.
alias pacusage="LANG=C pacman -Qi | \
	grep 'Name\|Installed Size\|Description' | \
	cut -d: -f 2 | \
	sed 's/ //' | \
	paste - - - | \
	awk -F'\t' '{print \$3\"\\t\"\$1\"\\t\"\$2 }' | \
	awk '{if (\$2 == \"KiB\") {size = \$1 * 1024} else if (\$2 == \"MiB\") {size = \$1 * 1024 * 1024} else {size = \$1} printf \"%i\\t%s\\n\", size, \$0}' | \
	sort -nr"

## Building stuff
# Build packages with steroids.
# It runs the script included in the 'devtools' package allowind you to add
# packages in a "deps" folder. So, if you've some AUR dependencies, just build
# them once and put them in a folder called "deps" where you have the package.
alias buildpkg='extra-x86_64-build -- \
	`c=""; \
	for p in $(ls --color=no deps/*.pkg.tar.xz 2>/dev/null); do \
		c="-I $p $c"; \
	done; \
	echo $c`'
