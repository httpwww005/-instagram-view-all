<!doctype html>
<head>
    <meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1">
    <title>KHCC images</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<style>
	.col-centered{
		margin: 0 auto;
		float: none;
	}
	.vertical-center {
	  min-height: 100%;  /* Fallback for browsers do NOT support vh unit */
	  min-height: 100vh; /* These two lines are counted as one :-)       */

	  display: flex;
	  align-items: center;
	}

	</style>
    <script type="text/javascript" language="javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

	<script type="text/javascript" charset="utf-8">
		function get_selected() {
			var selected = $("#address_select").val()
			if( /[\d\-]+/.test(selected)==false ) {
				return null
			} else {
				return selected
			}
		}

	
		function random_pick() {
			var size = $('#address_select option').size()
			var index = Math.floor(Math.random() * size) + 1  
			$('#address_select option').eq(index).prop('selected', true);
			
			var val = $('#address_select option').eq(index).val()
			window.history.pushState("", "", val);
		}


		function get_images() {
			var address = window.location.pathname.slice(1)
			if( address == null ) {
				$("#images").text("ERROR!")
			} else {
                $.ajax({
                    url:"/images/"+address
                }).done(function(data){
					$("#images").html(data)
                })
			}
		}


		$(document).ready(function() {
			$('#ig-user').focus();
			$("#submit").on('click',function(e){
				var val = $('#ig-user').val()
				e.preventDefault();
				window.location.replace(val)
			});

			$("#form").on('submit',function(e){
				e.preventDefault();
			});

		});
		
	</script>
</head>
<body>
	<div class="vertical-center">
		<div class="form-group col-lg-4 col-lg-offset-4">
			<label for="ig-url">Get images from Instagram user</label>
			  <form action="" id="form">
				<div class="input-group input-group-lg">
			  		<span class="input-group-addon" id="basic-addon3">https://www.instagram.com/</span>
					<input type="text" class="form-control" id="ig-user" aria-describedby="basic-addon3">
					<span class="input-group-btn">
					<button class="btn btn-primary" type="submit" id="submit">Go!</button>
					</span>
				</div>	
			</form>
		</div>
	</div>
</body>
</html>
