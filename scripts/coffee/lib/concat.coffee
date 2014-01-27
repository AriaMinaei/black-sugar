sysPath = require 'path'
fs = require 'fs'

rx =

	include: ///

		\n[\t ]*include\s+
		(.*)

	///

	numberSign: ///

		\n[\t ]*\#\s+include\s+
		(.*)

	///

	slashSlash: ///

		\n[\t ]*//\s+include\s+
		(.*)

	///

read = (path) ->

	fs.readFileSync path, {encoding: 'utf-8'}

module.exports = concat = (path, allowed = ['include', '#', '//']) ->

	content = read path

	dirname = sysPath.dirname path

	i = 0

	loop

		break if i++ > 5

		if 'include' in allowed

			match = content.match rx.include

		if not match? and '#' in allowed

			match = content.match rx.numberSign

		if not match? and '//' in allowed

			match = content.match rx.slashSlash

		break unless match?

		thePath = sysPath.join dirname, match[1]

		content = content.replace match[0], "\n" + concat thePath, allowed

	content