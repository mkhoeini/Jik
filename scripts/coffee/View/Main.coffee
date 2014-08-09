Foxie = require 'foxie'
Ribbon = require './Ribbon/Ribbon'
HomePage = require './HomePage'
MusicPlayer = require './MusicPlayer'

module.exports = class Main

	constructor: (@model) ->

		@el = Foxie '.master'
		.putIn document.body

		@bg = Foxie '.master-bg'
		.moveZTo 1
		.moveXTo -200
		.trans 300
		.putIn @el

		@inside = Foxie '.master-inside'
		.moveZTo 100

		@ribbon = new Ribbon @, ['home', 'artist', 'album', 'song', 'video']

		@inside.putIn @el

		@homePage = new HomePage @, @ribbon.getPage(0)
		@homePage = new HomePage @, @ribbon.getPage(1)
		@homePage = new HomePage @, @ribbon.getPage(2)
		@homePage = new HomePage @, @ribbon.getPage(3)
		@homePage = new HomePage @, @ribbon.getPage(4)

		@musicPlayer = new MusicPlayer @
