{% extends "base.tpl" %}

{% set newweek = true %}

{% block title %}Neue Woche{% endblock %}

{% block head %}
    {{ parent() }}
	<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
{% endblock %}

{% block scripts %}
	<script
		src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"
		integrity="sha256-VazP97ZCwtekAsvgPBSUwPFKdrwD3unUfSGVYrahUqU="
		crossorigin="anonymous"></script>
	
	<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
	<script>
		var data = [
			{% for gericht in gerichte %}
			{
				id: {{gericht.id|e}},
				text: "{{gericht.titel|e}}"
			},
			{% endfor %}
		];

		$(".mySelect").each(function(){
			console.log( $( this ).text() );
			$(this).select2({
				data: data
			});
			$(this).val(this.getAttribute("value"));
			$(this).trigger('change');
		});

		var fixHelper = function(e, ui) {  
			ui.children().each(function() {  
			console.log(e);
				$(this).width($(this).width());  
			});  
			return ui;  
		};

		$('tbody').sortable({
			update: function(event, ui) {reorderTable()},
			helper: fixHelper
		});

		let weekdays = {{weekdays|raw}};
		function reorderTable() {
			let table = $('tbody');
			let i = 0;
			for (let child of table.children()) {
				child.children[0].innerHTML = weekdays[i];
				child.children[1].children[0].name = weekdays[i];
				i++;
			}
		}
	</script>
{% endblock %}

{% block content %}
<form id="AddEssen" action="?action=planweek" method="POST">
	<div class="row justify-content-md-center">
		<div class="table-responsive-xl">
			<!-- Table -->
			<table id="FoodTable" class="table table-striped">
				<thead>
					<tr>
						<th scope="col">Tag</th>
						<th scope="col">Essen</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					{% for day in days %}
					<tr>
						<td scope="row">{{ day.day|e }}</td>
						<td scope="row"><select name="{{ day.day|e }}" class="mySelect" value="{{ day.id|e }}"></select></td>
						<td><span class="fas fa-arrows-alt-v" aria-hidden="true"></span></td>
					</tr>
					{% endfor %}
				</tbody>
			</table>
		</div>
	</div><!-- /.row -->
	<div class="row justify-content-md-center">
		<button id="NewWeekSubmit" type="submit" class="btn btn-primary"><span class="fas fa-play" aria-hidden="true"></span> Woche planen</button>
	</div>
</form>
{% endblock %}