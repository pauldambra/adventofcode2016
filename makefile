DAY_SELECTOR?=**

puzzles:
	bundle exec rspec $(DAY_SELECTOR)/spec/*.rb

watch:
	watchman-make \
		-p 'day_1/**/*.rb' 'Makefile*' -t DAY_SELECTOR=day_1 puzzles \
		-p 'day_2/**/*.rb' 'Makefile*' -t DAY_SELECTOR=day_2 puzzles \
		-p 'day_3/**/*.rb' 'Makefile*' -t DAY_SELECTOR=day_3 puzzles \
		-p 'day_4/**/*.rb' 'Makefile*' -t DAY_SELECTOR=day_4 puzzles \
		-p 'day_5/**/*.rb' 'Makefile*' -t DAY_SELECTOR=day_5 puzzles \
		-p 'day_6/**/*.rb' 'Makefile*' -t DAY_SELECTOR=day_6 puzzles \
		-p 'day_7/**/*.rb' 'Makefile*' -t DAY_SELECTOR=day_7 puzzles \
		-p 'day_8/**/*.rb' 'Makefile*' -t DAY_SELECTOR=day_8 puzzles \
		-p 'day_9/**/*.rb' 'Makefile*' -t DAY_SELECTOR=day_9 puzzles \
		-p 'day_10/**/*.rb' 'Makefile*' -t DAY_SELECTOR=day_10 puzzles \
		-p 'day_11/**/*.rb' 'Makefile*' -t DAY_SELECTOR=day_11 puzzles \
		-p 'day_12/**/*.rb' 'Makefile*' -t DAY_SELECTOR=day_12 puzzles \
		-p 'day_13/**/*.rb' 'Makefile*' -t DAY_SELECTOR=day_13 puzzles \
		-p 'day_14/**/*.rb' 'Makefile*' -t DAY_SELECTOR=day_14 puzzles \
		-p 'day_15/**/*.rb' 'Makefile*' -t DAY_SELECTOR=day_15 puzzles \
		-p 'day_16/**/*.rb' 'Makefile*' -t DAY_SELECTOR=day_16 puzzles \
		-p 'day_17/**/*.rb' 'Makefile*' -t DAY_SELECTOR=day_17 puzzles \
		-p 'day_18/**/*.rb' 'Makefile*' -t DAY_SELECTOR=day_18 puzzles \
		-p 'day_19/**/*.rb' 'Makefile*' -t DAY_SELECTOR=day_19 puzzles \
		-p 'day_20/**/*.rb' 'Makefile*' -t DAY_SELECTOR=day_20 puzzles \
		-p 'day_21/**/*.rb' 'Makefile*' -t DAY_SELECTOR=day_21 puzzles \
		-p 'day_22/**/*.rb' 'Makefile*' -t DAY_SELECTOR=day_22 puzzles \
		-p 'day_23/**/*.rb' 'Makefile*' -t DAY_SELECTOR=day_23 puzzles \
		-p 'day_24/**/*.rb' 'Makefile*' -t DAY_SELECTOR=day_24 puzzles