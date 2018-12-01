{% extends "base.tpl" %}

{% set aktuell = true %}

{% block title %}Aktuelle Woche{% endblock %}

{% block content %}
<div class="row justify-content-md-center">
		<div class="table-responsive-xl">
			<!-- Table -->
			<table class="table table-striped">
				<thead>
					<tr>
						<th scope="col">Tag</th>
						<th scope="col">Essen</th>
					</tr>
				</thead>
				<tbody>
					{% for day in days %}
						<tr>
							<td scope="row">{{ day.Day|e }}</td>
							<td scope="row">{{ day.titel|e }}</td>
						</tr>
					{% endfor %}
				</tbody>
			</table>
		</div>
</div><!-- /.row -->
{% endblock %}