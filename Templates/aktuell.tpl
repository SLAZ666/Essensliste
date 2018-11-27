{% extends "base.tpl" %}

{% set aktuell = true %}

{% block title %}Aktuelle Woche{% endblock %}

{% block scripts %}
	<script>
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
<div class="row justify-content-md-center">
		<div class="table-responsive-xl">
			<!-- Table -->
			<table class="table table-striped">
				<thead>
					<tr>
						<th scope="col">Tag</th>
						<th scope="col">Essen</th>
						<th scope="col">Aktion</th>
					</tr>
				</thead>
				<tbody>
					{% for day in days %}
						<tr>
							<td scope="row">{{ day.Day|e }}</td>
							<td scope="row">{{ day.titel|e }}</td>
							<td scope="row"><a href="?action=newrandom&day={{ day.Day|e }}" class="badge badge-secondary"><span class="fas fa-sync" aria-hidden="true"></span></a> <a data-toggle="modal" data-Tag="{{ day.Day|e }}" class="open-ChangeDayDialog badge badge-primary" href="#changeItemModal"><span class="fas fa-pencil-alt" aria-hidden="true"></span></a></td>
						</tr>
					{% endfor %}
				</tbody>
			</table>
		</div>
</div>
<!-- /.row -->

<!-- Modal -->
<div class="modal fade" id="changeItemModal" role="dialog" aria-labelledby="changeItemModalLabel">
  <div class="modal-dialog" role="document">
		<div class="modal-content">
	  	<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">Tag ändern</h4>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	  	</div>
	  	<div class="modal-body">
				<form id="UpdateEssen" action="?action=newday" method="POST">
					<input name="day" type="hidden" id="essensTag">
					<div class="input-group">
						<div class="input-group-prepend">
							<label class="input-group-text" for="UpdateEssenId">Titel</label>
						</div>
						<select name="id" id="UpdateEssenId" class="selectEssen">
							{% for gericht in gerichte %}
							<option value="{{ gericht.id|e }}">{{ gericht.titel|e }}</option>
							{% endfor %}
						</select>
					</div>
				</form>
      </div>
	  <div class="modal-footer">
		<button type="button" class="btn" data-dismiss="modal"><span class="fas fa-times" aria-hidden="true"></span> Abbrechen</button>
		<button type="button" class="btn btn-primary" id="UpdateEssenSubmit"><span class="fas fa-check" aria-hidden="true"></span> Speichern</button>
	  </div>
	</div>
  </div>
</div>
{% endblock %}