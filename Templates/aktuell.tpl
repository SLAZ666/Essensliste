{% extends "base.tpl" %}

{% set aktuell = true %}

{% block title %}Aktuelle Woche{% endblock %}

{% block head %}
    {{ parent() }}
	<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.0/css/select2.min.css" rel="stylesheet" />
{% endblock %}

{% block scripts %}
	<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.0/js/select2.min.js"></script>
	<script>
		$(document).ready(function() {
			$(".selectEssen").select2();
		});
		
		$(document).on("click", ".open-ChangeDayDialog", function () {
			$(".modal-body #essensTag").val( $(this).data('tag') );
		});
		
		$('#UpdateEssenSubmit').click(function(){
			$('#UpdateEssen').submit();
			return true;
		});
	</script>
{% endblock %}

{% block content %}
<div class="row">
		<div class="col-lg-4 col-lg-offset-4">
			<!-- Table -->
			<table class="table table-striped">
				<thead>
					<tr>
						<th class="col-lg-1">Tag</th>
						<th class="col-lg-3">Essen</th>
						<th class="col-lg-1"></th>
					</tr>
				</thead>
				<tbody>
					{% for day in days %}
						<tr>
							<td class="vert-align">{{ day.Day|e }}</td>
							<td class="vert-align">{{ day.titel|e }}</td>
							<td class="text-right"><a href="?action=newrandom&day={{ day.Day|e }}" class="label label-default"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span></a> <a data-toggle="modal" data-Tag="{{ day.Day|e }}" class="open-ChangeDayDialog label label-primary" href="#changeItemModal"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span></a></td>
						</tr>
					{% endfor %}
				</tbody>
			</table>
		</div>
		<!-- /.col-lg-4 -->
</div>
<!-- /.row -->

<!-- Modal -->
<div class="modal fade" id="changeItemModal" role="dialog" aria-labelledby="changeItemModalLabel">
  <div class="modal-dialog" role="document">
	<div class="modal-content">
	  <div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		<h4 class="modal-title" id="myModalLabel">Tag ändern</h4>
	  </div>
	  <div class="modal-body">
		<form id="UpdateEssen" action="?action=newday" method="POST">
		<input name="day" type="hidden" id="essensTag">
		<div class="input-group">
			<span class="input-group-addon" id="sizing-addon2">Titel</span>
			<select name="id" id="UpdateEssenId" class="selectEssen" style="width: 100%">
				{% for gericht in gerichte %}
					<option value="{{ gericht.id|e }}">{{ gericht.titel|e }}</option>
				{% endfor %}
			</select>
		</div>
		</form>
      </div>
	  <div class="modal-footer">
		<button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span> Abbrechen</button>
		<button type="button" class="btn btn-primary" id="UpdateEssenSubmit"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span> Speichern</button>
	  </div>
	</div>
  </div>
</div>
{% endblock %}