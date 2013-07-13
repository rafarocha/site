# Positions and fixes (when needed) the submenu
# ---------------------------------------------

$ ->
	aside = $('aside')
	initOffset = aside.offset()
	items = aside.find('li')
	links = items.find('a')
	sections = $('section')
	asideHeight = aside.height()

	initOffset.top -= 40
	initOffset.left = $('.container', sections.first()).offset().left
	aside.css 'left', initOffset.left

	$(window).on 'resize', ->
		initOffset.left = $('.container', sections.first()).offset().left
		aside.css 'left', initOffset.left

	$(window).on 'scroll', ->
		position = $(document).scrollTop()

		if position >= initOffset.top && !aside.hasClass('fixed')
			aside.addClass 'fixed'
		else if position <= initOffset.top
			aside.removeClass 'fixed'

		return if position < initOffset.top

		sections.each (i, el)->
			section = $(el)

			if !section.data().frame
				section.data
					frame:
						top: section.offset().top
						bottom: section.offset().top + section.height()
					link: links.filter('[href="#' + section.attr('id') + '"]')

			height = position + asideHeight / 2
			if height >= section.data().frame.top && height <= section.data().frame.bottom
				items.removeClass 'active'
				section.data().link.closest('li').addClass 'active'


	links.on 'click', (event) ->
		t = $(this).data().el || $(this.hash)
		$(this).data().el = t
		return if !t.length

		tOffset = t.offset().top;
		$('html,body').animate {scrollTop: tOffset - 20}, 'slow';
		event.preventDefault();