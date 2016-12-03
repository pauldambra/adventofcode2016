

puzzles_day_1:
	bundle exec rspec day_1/spec/*

puzzles_day_2:
	bundle exec rspec day_2/spec/*

watch:
	watchman-make -p 'day_1/**/*.rb' 'Makefile*' -t puzzles_day_1 -p 'day_2/**/*.rb' 'Makefile*' -t puzzles_day_2