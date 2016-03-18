<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>CS320 Extra Credit</title>

<!---------------------------------- CSS -------------------------------------->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<link href="../Content/bootstrap.css" rel="stylesheet" />
<link href="../Content/animate.css" rel="stylesheet" />
<link href="../Content/add_styling.css" rel="stylesheet" />
<link href="../Content/footer-distributed-with-address-and-phones.css"
	rel="stylesheet" />

<!---------------------------------- END CSS -------------------------------------->

<script type="text/javascript">
	// In the following example, markers appear when the user clicks on the map.
	// The markers are stored in an array.
	// The user can then click an option to hide, show or delete the markers.
	var map;
	var markers = [];

	function initMap() {
		var latitude = parseFloat('${latitude}');
		var longitude = parseFloat('${longitude}');

		var userLoc = {
			lat : latitude,
			lng : longitude
		};

		map = new google.maps.Map(document.getElementById('map'), {
			zoom : 12,
			center : userLoc,
		});

		// This event listener will call addMarker() when the map is clicked.
		map.addListener('click', function(event) {
			addMarker(event.latLng);
		});

		// Adds a marker at the center of the map.
		addMarker(userLoc);
	}

	// Adds a marker to the map and push to the array.
	function addMarker(location) {
		var marker = new google.maps.Marker({
			position : location,
			map : map
		});
		markers.push(marker);
	}

	// Sets the map on all markers in the array.
	function setMapOnAll(map) {
		for (var i = 0; i < markers.length; i++) {
			markers[i].setMap(map);
		}
	}

	// Removes the markers from the map, but keeps them in the array.
	function clearMarkers() {
		setMapOnAll(null);
	}

	// Shows any markers currently in the array.
	function showMarkers() {
		setMapOnAll(map);
	}

	// Deletes all markers in the array by removing references to them.
	function deleteMarkers() {
		clearMarkers();
		markers = [];
	}
</script>
<script async defer
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDv_0sVA5OuZzQuulNUuP6gkYKMWt88vwk&callback=initMap"></script>
<script>
	function populate(latitude, longitude) {
		var lati = parseFloat(latitude);
		var longi = parseFloat(longitude);
		var location = {
			lat : lati,
			lng : longi
		};
		addMarker(location);
		console.log("\nlatitude: " + lati + " longitude: " + longi);
	}
</script>

</head>
<body class="container-fluid">

	<!-------------------------------------- TOP NAVBAR ------------------------------->
	<nav class="navbar navbar-default navbar-fixed-top">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand" href="#"><i class="fa fa-sitemap"></i>&nbsp;&nbsp;&nbsp;
				Extra Credit Assignment</a>
		</div>
	</div>
	</nav>
	<!-------------------------------------- END TOP NAVBAR ------------------------------->
	<br />
	<br />
	<br />
	<br />

	<div class="row">
		<!-------------------------------- SEARCH FORM ------------------------------>
		<div class="col-md-4 col-md-offset-4">
			<div class="well text-center">
				<h1>Extra Credit</h1>
				<hr />
				<p class="lead">Search for your favorite restaurants.</p>
				<form action="Search" method="post">
					<div class="form-group">
						<div class="input-group">
							<div class="input-group-addon">Latitude</div>
							<input id="lat" class="form-control" type="text" name="lat"
								placeholder="Latitude" />
						</div>
					</div>
					<div class="form-group">
						<div class="input-group">
							<div class="input-group-addon">Longitude</div>
							<input id="lon" class="form-control" type="text" name="lon"
								placeholder="Longitude" />
						</div>
					</div>
					<div class="form-group">
						<div class="input-group">
							<div class="input-group-addon">Radius</div>
							<input class="form-control" type="text" name="radius"
								placeholder="Radius" />
						</div>
					</div>
					<input type="submit" class="btn btn-info btn-block btn-md"
						value="Search" />
				</form>
				<br />
				<button class="btn btn-info btn-block btn-md" id="get-location">
					<i class="fa fa-caret-square-o-right"></i>&nbsp;&nbsp;&nbsp;Get
					your location
				</button>
			</div>
			<!-------------------------------- END  SEARCH FORM ------------------------------>
		</div>
	</div>

	<!-------------------------------- RESULTS  ------------------------------>
	<div class="row" id="results">
		<!-------------------------------- RESULTS LIST ------------------------------>
		<div class="col-md-2 col-md-offset-2">
			<h4 class="page-header">
				Restaurants within ${radius} meters
				</h1>
				<ul id="results-list" class="list-group">
					<c:forEach items="${places}" var="place">
						<li id="result-item" class="list-group-item">
							<p class="text-info">Name: ${place.name}</p>
							<p class="text-info">Longitude: ${place.lng}</p>
							<p class="text-info">Latitude: ${place.lat}</p>
						</li>
						<script>
							populate('${place.lat}', '${place.lng}');
						</script>
					</c:forEach>
				</ul>
		</div>
		<!-------------------------------- END RESULTS LIST ------------------------------>

		<!-------------------------------- GOOGLE MAP ------------------------------>
		<div id="map" class="col-md-6"></div>
		<!-------------------------------- END GOOGLE MAP ------------------------------>

	</div>

	<!-------------------------------- RESULTS  ------------------------------>

	<!-------------------------------- FOOTER  ------------------------------>
	<div class="row">
		<footer class="footer-distributed" style="margin-bottom: -100000px;">
		<div class="footer-left">
			<h3>CS320 Extra Credit</h3>
			<p class="footer-links">
				<a href="#">Home</a> · <a href="#">About</a> · <a href="#">Faq</a> ·
				<a href="#">Contact</a>
			</p>
			<p class="footer-company-name">James & Howie &copy; 2016</p>
		</div>
		<div class="footer-center">
			<div>
				<i class="fa fa-map-marker"></i>
				<p>
					<span>CSULA College of Engineering</span> <span>5151 State
						University Dr</span> <span>Los Angeles, CA 90032-8530</span>
				</p>
			</div>
			<div>
				<i class="fa fa-phone"></i>
				<p>(123) 562-8056</p>
			</div>
			<div>
				<i class="fa fa-envelope"></i>
				<p>
					<a href="mailto:support@company.com">support@jamesandhowie.com</a>
				</p>
			</div>
		</div>
		<div class="footer-right">
			<p class="footer-company-about">
				<span>About the company</span> We are a company that believes in
				open source content.<br /> Everything ought to be free!
			</p>

			<div class="footer-icons">
				<a href="#"><i class="fa fa-facebook"></i></a> <a href="#"><i
					class="fa fa-twitter"></i></a> <a href="#"><i
					class="fa fa-linkedin"></i></a> <a href="#"><i class="fa fa-github"></i></a>
			</div>
		</div>
		</footer>
	</div>
	<!-------------------------------- END FOOTER  ------------------------------>

	<!---------------------------------  JAVASCRIPT ------------------------------------>
	<script src="https://code.jquery.com/jquery-2.2.0.min.js"></script>
	<script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
	<script src="../Scripts/bootstrap.min.js"></script>
	<script src="../Scripts/cs320.js"></script>


	<!--------------------------------- END JAVASCRIPT ------------------------------ -->

</body>
</html>