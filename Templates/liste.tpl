{% extends "base.tpl" %}

{% set liste = true %}

{% block title %}Essensliste{% endblock %}
{% block head %}
    {{ parent() }}
	<link rel="stylesheet" href="https://cdn.datatables.net/plug-ins/1.10.7/integration/bootstrap/3/dataTables.bootstrap.css" type="text/css" media="screen"/>
	{#<link rel="stylesheet" href="https://cdn.datatables.net/responsive/1.0.6/css/dataTables.responsive.css" type="text/css" media="screen"/>#}
{% endblock %}

{% block scripts %}
	<script src="https://cdn.datatables.net/1.10.7/js/jquery.dataTables.min.js"></script>
	{#<script src="https://cdn.datatables.net/responsive/1.0.6/js/dataTables.responsive.js"></script>#}

	<script src="https://cdn.datatables.net/plug-ins/1.10.7/integration/bootstrap/3/dataTables.bootstrap.js"></script>
	<script>
		$(document).ready(function() {
			$('#mydataTable').dataTable({
				"lengthMenu": [[10, 15, 25, 50, -1], [10, 15, 25, 50, "Alle"]],
				"order": [[ 1, "desc"]],
				"language": {
					"url": "//cdn.datatables.net/plug-ins/1.10.7/i18n/German.json"
				},
				"aoColumnDefs": [
					{ 'bSortable': false, 'aTargets': [ 2 ] }
				]
			});
		} );
		
		$(document).on("click", ".open-ChangeEssenDialog", function () {
			$(".modal-body #essensID").val( $(this).data('id') );
			$(".modal-body #essensTitel").val( $(this).data('text') );
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
<div class="row">
<div class="col-lg-12 text-center">
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#newItemModal"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> Essen hinzufügen</button>
</div>
</div>
<div class="row top-buffer">
		<div class="col-lg-4 col-lg-offset-4">
			<!-- Table -->
			<div class="dataTable_wrapper">
				<table class="table table-striped table-bordered" data-page-length='15' id="mydataTable">
					<thead>
						<tr>
							<th class="col-lg-3">Essen</th>
							<th class="col-lg-2">Zuletzt</th>
							<th class="col-lg-1">Aktion</th>
						</tr>
					</thead>
					<tbody>
						{% for gericht in gerichte %}
							<tr>
								<td class="vert-align">{{ gericht.titel|e }}</td>
								<td class="vert-align">{{ gericht.lasttime|e }}</td>
								<td class="vert-align"><a data-toggle="modal" data-id="{{ gericht.id|e }}" data-text="{{ gericht.titel|e }}" class="open-ChangeEssenDialog label label-primary" href="#changeItemModal"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span></a> <a href="?action=removefood&id={{ gericht.id|e }}#"><span class="label label-danger"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></span></a></td>
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
		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		<h4 class="modal-title" id="myModalLabel">Neues Essen hinzufügen</h4>
	  </div>
	  <div class="modal-body">
	  <form id="AddEssen" action="?action=addfood" method="POST">
        <div class="input-group">
			<span class="input-group-addon" id="sizing-addon2">Titel</span>
			<input name="name" id="AddEssenTitel" type="text" class="form-control" aria-describedby="sizing-addon2">
		</div>
	  </form>
      </div>
	  <div class="modal-footer">
		<button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span> Abbrechen</button>
		<button type="submit" class="btn btn-primary" id="AddEssenSubmit"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> Hinzufügen</button>
	  </div>
	</div>
  </div>
</div>

<!-- Modal -->
<div class="modal fade" id="changeItemModal" tabindex="-1" role="dialog" aria-labelledby="changeItemModalLabel">
  <div class="modal-dialog" role="document">
	<div class="modal-content">
	  <div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		<h4 class="modal-title" id="myModalLabel">Essen ändern</h4>
	  </div>
	  <div class="modal-body">
		<form id="UpdateEssen" action="?action=updatefood" method="POST">
		<input name="id" type="hidden" id="essensID">
		<div class="input-group">
			<span class="input-group-addon" id="sizing-addon2">Titel</span>
			<input name="name" type="text" id="UpdateEssenTitel" class="form-control" aria-describedby="sizing-addon2">
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