

puzzles_day_1:
	bundle exec rspec day_1/spec/*.rb

puzzles_day_2:
	bundle exec rspec day_2/spec/*.rb

puzzles_day_3:
	bundle exec rspec day_3/spec/*.rb

watch:
	watchman-make \
		-p 'day_1/**/*.rb' 'Makefile*' -t puzzles_day_1 \
		-p 'day_2/**/*.rb' 'Makefile*' -t puzzles_day_2 \
		-p 'day_3/**/*.rb' 'Makefile*' -t puzzles_day_3