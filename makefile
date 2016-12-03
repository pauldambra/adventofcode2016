

puzzle_1:
	bundle exec rspec puzzle1/spec/*

puzzle_2:
	bundle exec rspec puzzle2/spec/*

watch:
	watchman-make -p 'puzzle1/**/*.rb' 'Makefile*' -t puzzle_1 -p 'puzzle2/**/*.rb' 'Makefile*' -t puzzle_2