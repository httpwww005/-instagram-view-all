<!doctype html>
<head>
    <meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1">
    <title>ig images</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<style>
	</style>
    <script type="text/javascript" language="javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

	<!-- Core CSS file -->
	<link rel="stylesheet" href="https://cdn.rawgit.com/dimsemenov/PhotoSwipe/master/dist/photoswipe.css"> 

	<!-- Skin CSS file (styling of UI - buttons, caption, etc.)
		 In the folder of skin CSS file there are also:
		 - .png and .svg icons sprite, 
		 - preloader.gif (for browsers that do not support CSS animations) -->
	<link rel="stylesheet" href="https://cdn.rawgit.com/dimsemenov/PhotoSwipe/master/dist/default-skin/default-skin.css"> 

	<!-- Core JS file -->
	<script src="https://cdn.rawgit.com/dimsemenov/PhotoSwipe/master/dist/photoswipe.min.js"></script> 

	<!-- UI JS file -->
	<script src="https://cdn.rawgit.com/dimsemenov/PhotoSwipe/master/dist/photoswipe-ui-default.min.js"></script> 

	<script type="text/javascript" charset="utf-8">

		$(document).ready(function() {
			function get_items(ig_user) {
				$.get(ig_user, {"pswp":""}).done(function(items){
					var pswpElement = document.querySelectorAll('.pswp')[0];
					var options = {
						// optionName: 'option value'
						// for example:
						index: 0 // start at first slide
					};

					// Initializes and opens PhotoSwipe
					var gallery = new PhotoSwipe( pswpElement, PhotoSwipeUI_Default, items, options);
					gallery.init();
				})
			}
		

			// build items array
			/*
			var items = [
				{
					src: 'https://scontent-tpe1-1.cdninstagram.com/t51.2885-15/s750x750/sh0.08/e35/18011577_1337558406336884_7958761754551386112_n.jpg',
					w: 750,
					h: 750
				},
				{
					src: 'https://scontent-tpe1-1.cdninstagram.com/t51.2885-15/e35/17663780_219526935197627_4059804711123943424_n.jpg',
					w: 750,
					h: 750
				}
			];
			*/
			var items = get_items("{{ig_user}}")

			// define options (if needed)
			/*
			var options = {
				// optionName: 'option value'
				// for example:
				index: 0 // start at first slide
			};

			// Initializes and opens PhotoSwipe
			var gallery = new PhotoSwipe( pswpElement, PhotoSwipeUI_Default, items, options);
			gallery.init();
			*/

		});
		
	</script>
</head>
<body>
<!-- Root element of PhotoSwipe. Must have class pswp. -->
<div class="pswp" tabindex="-1" role="dialog" aria-hidden="true">

    <!-- Background of PhotoSwipe. 
         It's a separate element as animating opacity is faster than rgba(). -->
    <div class="pswp__bg"></div>

    <!-- Slides wrapper with overflow:hidden. -->
    <div class="pswp__scroll-wrap">

        <!-- Container that holds slides. 
            PhotoSwipe keeps only 3 of them in the DOM to save memory.
            Don't modify these 3 pswp__item elements, data is added later on. -->
        <div class="pswp__container">
            <div class="pswp__item"></div>
            <div class="pswp__item"></div>
            <div class="pswp__item"></div>
        </div>

        <!-- Default (PhotoSwipeUI_Default) interface on top of sliding area. Can be changed. -->
        <div class="pswp__ui pswp__ui--hidden">

            <div class="pswp__top-bar">

                <!--  Controls are self-explanatory. Order can be changed. -->

                <div class="pswp__counter"></div>

                <button class="pswp__button pswp__button--close" title="Close (Esc)"></button>

                <button class="pswp__button pswp__button--share" title="Share"></button>

                <button class="pswp__button pswp__button--fs" title="Toggle fullscreen"></button>

                <button class="pswp__button pswp__button--zoom" title="Zoom in/out"></button>

                <!-- Preloader demo http://codepen.io/dimsemenov/pen/yyBWoR -->
                <!-- element will get class pswp__preloader--active when preloader is running -->
                <div class="pswp__preloader">
                    <div class="pswp__preloader__icn">
                      <div class="pswp__preloader__cut">
                        <div class="pswp__preloader__donut"></div>
                      </div>
                    </div>
                </div>
            </div>

            <div class="pswp__share-modal pswp__share-modal--hidden pswp__single-tap">
                <div class="pswp__share-tooltip"></div> 
            </div>

            <button class="pswp__button pswp__button--arrow--left" title="Previous (arrow left)">
            </button>

            <button class="pswp__button pswp__button--arrow--right" title="Next (arrow right)">
            </button>

            <div class="pswp__caption">
                <div class="pswp__caption__center"></div>
            </div>

        </div>

    </div>

</div>

</body>
</html>
