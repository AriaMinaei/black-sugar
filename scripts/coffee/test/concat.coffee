require './_prepare'

concat = mod 'concat'

sysPath = require 'path'

here = sysPath.join sysPath.dirname(module.filename), '../../coffee/test'

describe 'concat'
it "should work", ->

	ret = concat (here + '/concat/parent.txt'), ['#', 'include', '//']

	ret.should.equal 'parent\r\n\r\na\r\n\r\nb\r\n\r\nc\r\n\r\nc'