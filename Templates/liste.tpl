{% extends "base.tpl" %}

{% set liste = true %}

{% block title %}Essensliste{% endblock %}
{% block head %}
    {{ parent() }}
	<link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/dataTables.bootstrap4.min.css" type="text/css"/>
{% endblock %}

{% block scripts %}
	<script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
	<script src="https://cdn.datatables.net/1.10.19/js/dataTables.bootstrap4.min.js"></script>
	<script>
		$(document).ready(function() {
			$('#mydataTable').dataTable({
				"lengthMenu": [[10, 15, 25, 50, -1], [10, 15, 25, 50, "Alle"]],
				"order": [[ 1, "desc"]],
				"language": {
					"url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/German.json"
				},
				"aoColumnDefs": [
					{ 'bSortable': false, 'aTargets': [ 2 ] }
				]
			});
		} );
		
		$(document).on("click", ".open-ChangeEssenDialog", function () {
			$(".modal-body #essensID").val( $(this).data('id') );
			$(".modal-body #UpdateEssenTitel").val( $(this).data('text') );
		});
		
		$('#AddEssenSubmit').click(function(){
			if ($('#AddEssenTitel').val()==="") {
				// invalid
				return false;
			}
			else {
				//submit the form here
				$('#AddEssen').submit();
				return true;
			}

		});
		
		$('#UpdateEssenSubmit').click(function(){
			if ($('#UpdateEssenTitel').val()==="") {
				// invalid
				return false;
			}
			else {
				//submit the form here
				$('#UpdateEssen').submit();
				return true;
			}

		});
	</script>
{% endblock %}

{% block content %}
<div class="row justify-content-md-center">
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#newItemModal"><span class="fas fa-plus" aria-hidden="true"></span> Essen hinzufügen</button>
</div>
<div class="row justify-content-md-center">
		<div class="table-responsive-xl">
			<!-- Table -->
			<div class="dataTable_wrapper">
				<table class="table table-striped table-bordered" data-page-length='15' id="mydataTable">
					<thead>
						<tr>
							<th scope="col">Essen</th>
							<th scope="col">Zuletzt</th>
							<th scope="col">Aktion</th>
						</tr>
					</thead>
					<tbody>
						{% for gericht in gerichte %}
							<tr>
								<td scope="row">{{ gericht.titel|e }}</td>
								<td scope="row">{{ gericht.lasttime|e }}</td>
								<td scope="row"><a data-toggle="modal" data-id="{{ gericht.id|e }}" data-text="{{ gericht.titel|e }}" class="open-ChangeEssenDialog badge badge-primary" href="#changeItemModal"><span class="fas fa-pencil-alt" aria-hidden="true"></span></a> <a href="?action=removefood&id={{ gericht.id|e }}#"><span class="badge badge-danger"><span class="fas fa-times" aria-hidden="true"></span></span></a></td>
							</tr>
						{% endfor %}
					</tbody>
				</table>
			</div>
		</div>
</div>
<!-- /.row -->

<!-- Modal -->
<div class="modal fade" id="newItemModal" tabindex="-1" role="dialog" aria-labelledby="newItemModalLabel">
  <div class="modal-dialog" role="document">
		<div class="modal-content">
	  	<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">Neues Essen hinzufügen</h4>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		  </div>
		  <div class="modal-body">
				<form id="AddEssen" action="?action=addfood" method="POST">
					<div class="input-group">
						<div class="input-group-prepend">
							<label class="input-group-text" for="AddEssenTitel" id="basic-addon1">Titel</label>
						</div>
						<input name="name" id="AddEssenTitel" type="text" class="form-control" aria-describedby="basic-addon1">
					</div>
				</form>
      </div>
	  	<div class="modal-footer">
				<button type="button" class="btn" data-dismiss="modal"><span class="fas fa-times" aria-hidden="true"></span> Abbrechen</button>
				<button type="submit" class="btn btn-primary" id="AddEssenSubmit"><span class="fas fa-plus" aria-hidden="true"></span> Hinzufügen</button>
	  	</div>
		</div>
  </div>
</div>

<!-- Modal -->
<div class="modal fade" id="changeItemModal" tabindex="-1" role="dialog" aria-labelledby="changeItemModalLabel">
  <div class="modal-dialog" role="document">
		<div class="modal-content">
	  	<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">Essen ändern</h4>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		  </div>
			<div class="modal-body">
				<form id="UpdateEssen" action="?action=updatefood" method="POST">
					<input name="id" type="hidden" id="essensID">
					<div class="input-group">
						<div class="input-group-prepend">
							<label class="input-group-text" for="UpdateEssenTitel" id="basic-addon2">Titel</span>
						</div>
						<input name="name" type="text" id="UpdateEssenTitel" class="form-control" aria-describedby="basic-addon2">
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