<!DOCTYPE html>
<html lang="de">
  <head>
	{% block head %}
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
		<title>Essenswoche - {% block title %}{% endblock %}</title>

		<!-- Latest compiled and minified CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
		<!-- Optional theme -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">
		<link rel="stylesheet" href="css/style.css">

		<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
		<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
		<!--[if lt IE 9]>
		  <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
		  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
		<![endif]-->
	{% endblock %}
  </head>
  <body>
  <div id="wrapper">
    <nav class="navbar navbar-default">
	  <div class="container">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header">
		  <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
			<span class="sr-only">Toggle navigation</span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
		  </button>
		  <a class="navbar-brand" href="#">Essenswoche</a>
		</div>

		<!-- Collect the nav links, forms, and other content for toggling -->
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		  <ul class="nav navbar-nav">
			<li{% if aktuell %} class="active"{% endif %}><a href="?action=current"><span class="glyphicon glyphicon-calendar" aria-hidden="true"></span> Aktuell</a></li>
			<li{% if liste %} class="active"{% endif %}><a href="?action=list"><span class="glyphicon glyphicon-list" aria-hidden="true"></span> Essensliste</a></li>
			<li><a href="#" data-toggle="modal" data-target="#newWeekModal"><span class="glyphicon glyphicon-transfer" aria-hidden="true"></span> Neue Woche</a></li>
			</li>
		  </ul>
		</div><!-- /.navbar-collapse -->
	  </div><!-- /.container-fluid -->
	</nav>

	<!-- Modal -->
	<div class="modal fade" id="newWeekModal" tabindex="-1" role="dialog" aria-labelledby="newWeekModalLabel">
	  <div class="modal-dialog" role="document">
		<div class="modal-content">
		  <div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			<h4 class="modal-title" id="myModalLabel">Wirklich neue Woche beginnen?</h4>
		  </div>
		  <div class="modal-footer">
			<a type="button" class="btn btn-success" href="?action=newweek"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span> Ja</a>
			<button type="button" class="btn btn-danger" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span> Nein</button>
		  </div>
		</div>
	  </div>
	</div>
	
	<div id="page-wrapper" cladd="container-fluid">
	{% block content %}{% endblock %}
	</div>
  </div>
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <!-- Latest compiled and minified JavaScript -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
	
	{% block scripts %}{% endblock %}
  </body>
</html>