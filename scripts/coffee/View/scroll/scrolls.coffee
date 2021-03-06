SingleAxisScroller = require './singleAxis'
object = require '../utility/object'

emptyFunction = ->

module.exports = class Scrolls

	constructor: (@node) ->

		# Default options
		@options =

			axis: 'y'

		# Load more options from the data-attrs of @node
		# Example:
		# <div data-types="scroll" data-scroll-options='"axis":"x"'>


		# To make sure we only scroll in the desired axis
		@_enabledAxis =
			x: 1
			y: 1

		# for x/y -only axis configs
		if @options.axis is 'x' then @_enabledAxis.y = 0

		else if @options.axis is 'y' then @_enabledAxis.x = 0

		# Reference to dimensions
		parentRects = @node.getBoundingClientRect()

		# Child element's references
		@_childEl = @node.children[0]

		@_childElTrans =

			x: 0
			y: 0
			z: 1

		# Child element's dimensions
		childRects = @_childEl.getBoundingClientRect()

		# Single
		boundNeedAnimation = @_scrollerAskedForAnimation.bind @

		@propsX =

			delta: 0

		@_scrollerX = new SingleAxisScroller @propsX, boundNeedAnimation, do =>

			ops =

				size: childRects.width
				space: parentRects.width

			if @options.x?

				object.append ops, @options.x

			ops

		@_lastScrollX = 0

		@propsY =

			delta: 0

		@_scrollerY = new SingleAxisScroller @propsY, boundNeedAnimation, do =>

			ops =

				size: childRects.height
				space: parentRects.height

			if @options.y?

				object.append ops, @options.y

			ops

		@_lastScrollY = 0

		# Animation frame reference
		@_animFrame = 0

		# This function gets called by window.requestAnimationFrame()
		@_boundAnimFunction = @_animFunction.bind @

		# If we are listening to a persistent gesture, we have to call its
		# finish() method when animation is over. This will be a reference to
		# that finish() method.
		@_finishCallback = emptyFunction

		@_finishCallbackWaiting = false

	# Called when fingers are on screen, moving around.
	drag: (x, y) ->

		do @_cancelAnimation

		if @_enabledAxis.x
			@_scrollerX.drag x - @_lastScrollX
			@_lastScrollX = x


		if @_enabledAxis.y
			@_scrollerY.drag y - @_lastScrollY
			@_lastScrollY = y

		# Translate the child element
		do @_transformElement

	# Called when touch is released. It will do the slipping thing.
	release: (finish) ->

		if @_enabledAxis.x

			do @_scrollerX.release

			@_lastScrollX = 0

		if @_enabledAxis.y

			do @_scrollerY.release

			@_lastScrollY = 0

		if finish

			if @_animFrame

				@_finishCallback = -> do finish

				@_finishCallbackWaiting = true

			else

				do finish

	_scrollerAskedForAnimation: ->

		unless @_animFrame
			@_animFrame = requestAnimationFrame @_boundAnimFunction

	_cancelAnimation: ->

		if @_animFrame

			cancelAnimationFrame @_animFrame

			@_animFrame = 0

	_animFunction: ->

		@_animFrame = 0

		if @_enabledAxis.x

			do @_scrollerX.animate

		if @_enabledAxis.y

			do @_scrollerY.animate

		# Translate the child element
		do @_transformElement

		if @_finishCallbackWaiting

			unless @_animFrame

				do @_finishCallback

				do @finish

	finish: ->

		@_finishCallback = emptyFunction

		@_finishCallbackWaiting = false

	_transformElement: ->

		x = 0

		if @_enabledAxis.x

			x = @propsX.delta

		y = 0

		if @_enabledAxis.y

			y = @propsY.delta

		@_setElMovement x, y

	_setElMovement: (x, y) ->

		@_childEl.style.transform = 'translate3d(' +

			x + 'px, ' +
			y + 'px, ' +
			'0)'