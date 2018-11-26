<?php
	include "mysql.php";
	// include and register Twig auto-loader
	include 'Twig/Autoloader.php';
	Twig_Autoloader::register();

	// define template directory location
	$loader = new Twig_Loader_Filesystem('Templates');

	// initialize Twig environment
	$twig = new Twig_Environment($loader);
	
	if(isset($_GET["action"])){
		switch($_GET["action"])
		{
			case "newweek":
				$res = $mysqli->query("SELECT id FROM liste WHERE lasttime < (CURRENT_DATE() - INTERVAL 15 DAY) ORDER BY RAND() LIMIT 0, 7");
				if($res->num_rows < 7)
				{
					$res = $mysqli->query("SELECT id FROM liste WHERE lasttime < (CURRENT_DATE() - INTERVAL 8 DAY) ORDER BY RAND() LIMIT 0, 7");
					if($res->num_rows < 7)
					{
						$res = $mysqli->query("SELECT id FROM liste ORDER BY RAND() LIMIT 0, 7");
					}
				}
				$i=1;
				if ($stmt1 = $mysqli->prepare("UPDATE current SET essen_id=? WHERE id=?")) {
					if ($stmt1->bind_param("ii", $rowid, $i)) {
						if ($stmt2 = $mysqli->prepare("UPDATE liste SET lasttime=NOW() WHERE id=?")) {
							if ($stmt2->bind_param("i", $rowid)) {
								while($row = $res->fetch_assoc())
								{
									$rowid = $row["id"];
									$stmt1->execute();
									$stmt2->execute();
									$i++;
								}
							}
						}
					}
				}
				header('Location: index.php?action=current');
				break;
		
			case "newrandom":
				if(isset($_GET["day"]))
				{
					$res = $mysqli->query("SELECT id FROM liste WHERE lasttime < (CURRENT_DATE() - INTERVAL 15 DAY) ORDER BY RAND() LIMIT 1");
					if($res->num_rows == 0)
					{
						$res = $mysqli->query("SELECT id FROM liste WHERE lasttime < (CURRENT_DATE() - INTERVAL 8 DAY) ORDER BY RAND() LIMIT 1");
						if($res->num_rows == 0)
						{
						$res = $mysqli->query("SELECT id FROM liste ORDER BY RAND() LIMIT 1");
						}
					}
					$row = $res->fetch_assoc();
					if ($stmt1 = $mysqli->prepare("UPDATE current SET essen_id=? WHERE Day=?")) {
						if ($stmt1->bind_param("is", $rowid, $_GET["day"])) {
							if ($stmt2 = $mysqli->prepare("UPDATE liste SET lasttime=NOW() WHERE id=?")) {
								if ($stmt2->bind_param("i", $rowid)) {
									$rowid = $row["id"];
									$stmt1->execute();
									$stmt2->execute();
								}
							}
						}
					}
				}
				header( 'Location: index.php?action=current' );
				break;
			
			case "newday":
				if(isset($_POST["day"]) && isset($_POST["id"])){
					if ($stmt1 = $mysqli->prepare("UPDATE current SET essen_id=? WHERE Day=?")) {
						if ($stmt1->bind_param("is", $_POST["id"], $_POST["day"])) {
							if ($stmt2 = $mysqli->prepare("UPDATE liste SET lasttime=NOW() WHERE id=?")) {
								if ($stmt2->bind_param("i", $_POST["id"])) {
									$stmt1->execute();
									$stmt2->execute();
								}
							}
						}
					}
				}
				header( 'Location: index.php?action=current' );
				break;
		
			case "current":
				// load template
				$template = $twig->loadTemplate('aktuell.tpl');
				
				$res = $mysqli->query("SELECT current.Day, liste.titel FROM current LEFT JOIN liste ON current.essen_id=liste.id");
				$days = array();
				while ($row = $res->fetch_assoc()) {
					$days[] = $row;
				}
				
				$res = $mysqli->query("SELECT id, titel FROM liste");
				$gerichte = array();
				while ($row = $res->fetch_assoc()) {
					$gerichte[] = $row;
				}
				
				// set template variables
				// render template
				echo $template->render(array (
					'days' => $days,
					'gerichte' => $gerichte
				));
				
				break;
			
			case "list":
				// load template
				$template = $twig->loadTemplate('liste.tpl');
				
				$res = $mysqli->query("SELECT id, titel, lasttime FROM liste");
				$gerichte = array();
				while ($row = $res->fetch_assoc()) {
					$gerichte[] = $row;
				}
				
				// set template variables
				// render template
				echo $template->render(array (
					'gerichte' => $gerichte
				));
				
				break;
			case "addfood":
				if(isset($_POST["name"])){
					if ($stmt = $mysqli->prepare("INSERT INTO liste (titel) VALUE (?)")) {
						if ($stmt->bind_param("s", $_POST["name"])) {
							$stmt->execute();
						}
					}
				}
				header('Location: index.php?action=list');
				break;
			case "updatefood":
				if(isset($_POST["name"]) && isset($_POST["id"])){
					if ($stmt = $mysqli->prepare("UPDATE liste SET titel = ? WHERE id = ?")) {
						if ($stmt->bind_param("si", $_POST["name"], $_POST["id"])) {
							$stmt->execute();
						}
					}
				}
				header('Location: index.php?action=list');
				break;
			case "removefood":
				if(isset($_GET["id"])){
					if ($stmt = $mysqli->prepare("DELETE FROM liste WHERE id = ?")) {
						if ($stmt->bind_param("i", $_GET["id"])) {
							$stmt->execute();
						}
					}
				}
				header('Location: index.php?action=list');
				break;
		}
		
	}
	else{
		header('Location: index.php?action=current');
	}
	
?>