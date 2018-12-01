<!doctype html>
<html lang="de">
  <head>
	{% block head %}
		<!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
		<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">

		<title>Essenswoche - {% block title %}{% endblock %}</title>
	{% endblock %}
  </head>
  <body>
    <nav class="navbar navbar-expand-md nav-pills navbar-dark bg-dark">
			<a class="navbar-brand" href="#">Essenswoche</a>
	  	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    		<span class="navbar-toggler-icon"></span>
  		</button>
			
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link{% if aktuell %} active{% endif %}" href="?action=current"> <span class="fas fa-calendar-alt" aria-hidden="true"></span> Aktuell</a></li>
					<li class="nav-item"><a class="nav-link{% if liste %} active{% endif %}" href="?action=list"> <span class="fas fa-list-ul" aria-hidden="true"></span> Essensliste</a></li>
					<li class="nav-item"><a class="nav-link{% if newweek %} active{% endif %}" href="?action=newweek"> <span class="fas fa-exchange-alt" aria-hidden="true"></span> Neue Woche</a></li>
				</ul>
			</div><!-- /.navbar-collapse -->
		</nav>

	  <main role="main" class="container">
		{% block content %}{% endblock %}
		</main><!-- /.container -->

		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script
		  src="https://code.jquery.com/jquery-3.3.1.min.js"
		  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
		  crossorigin="anonymous"></script>
		<!-- Latest compiled and minified JavaScript -->
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
	
		{% block scripts %}{% endblock %}
  </body>
</html>