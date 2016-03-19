<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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

<!---------------------------------- Google Maps Javascript -------------------------------------->
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

		// Adds a marker at the center of the map.
		addMarker(userLoc, 0, "You are here!");
	}

	// Adds a marker to the map and push to the array.
	function addMarker(location, placesLength, content) {
		console.log("Add MArker CAlled");
		var contentString = content;

		var infowindow = new google.maps.InfoWindow({
			content : contentString
		});

		if (placesLength === 0) {
			var image = "../Content/person-icon.png";
			var icon = {
				url : image,
				scaledSize : new google.maps.Size(30, 50), // scaled size
				origin : new google.maps.Point(0, 0), // origin
				anchor : new google.maps.Point(0, 0)
			// anchor
			};
			var marker = new google.maps.Marker({
				position : location,
				map : map,
				icon : icon,
				animation : google.maps.Animation.BOUNCE
			});
		} else {
			var marker = new google.maps.Marker({
				position : location,
				map : map,
				animation : google.maps.Animation.DROP
			});
		}

		marker.addListener('click', function() {
			infowindow.open(map, marker);
		});
		markers.push(marker);

		if (markers.length >= placesLength) {
			extendBounds();
			setMapOnAll(map);
		}
	}

	function extendBounds() {
		var bounds = new google.maps.LatLngBounds();
		for (var i = 0; i < markers.length; i++) {
			var myLatLng = markers[i].getPosition();
			bounds.extend(myLatLng);
		}
		map.fitBounds(bounds);
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
	/* 	function showMarkers() {
	 setMapOnAll(map);
	 }
	 */
	// Deletes all markers in the array by removing references to them.
	function deleteMarkers() {
		clearMarkers();
		markers = [];
	}

	function populate(latitude, longitude, placesLength, infoArr) {
		var lati = parseFloat(latitude);
		var longi = parseFloat(longitude);
		var location = {
			lat : lati,
			lng : longi
		};

		var info = infoArr;

		var content = "<b>Name:</b> " + info[0] + "<br/>" + "<b>Address:</b> "
				+ info[1] + "<br/>" + "<b>Phone:</b> " + info[2] + "<br/>"
				+ "<b>Type:</b> " + info[3] + "<br/>" + "<b>Latitude:</b> "
				+ info[4] + "<br/>" + "<b>Longitude:</b> " + info[5] + "<br/>";

		addMarker(location, placesLength, content);
		console.log("\nlatitude: " + lati + " longitude: " + longi);
	}

	function initialize() {
		google.maps.event.addDomListener(window, "load", initMap);
	}
</script>
<script
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDv_0sVA5OuZzQuulNUuP6gkYKMWt88vwk&callback=initialize"></script>

<!---------------------------------- END Google Maps Javascript -------------------------------------->

</head>
<body class="container-fluid">

	<!-------------------------------------- TOP NAVBAR ------------------------------->
	<nav class="navbar navbar-default navbar-fixed-top">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand" href="#"><i class="fa fa-sitemap"></i>&nbsp;&nbsp;&nbsp;
				CS320 Extra Credit Assignment</a>
		</div>
	</div>
	</nav>
	<!-------------------------------------- END TOP NAVBAR ------------------------------->
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<div class="row">
		<div class="col-md-6 col-md-offset-3">
			<div class="animated slideInLeft alert alert-dismissible alert-warning">
				<button type="button" class="close" data-dismiss="alert">&times;</button>
				<h4><b><i class="fa fa-exclamation-triangle"></i>&nbsp;&nbsp;ATTENTION!</b></h4>
				<ol>
					<li><b>GROUP MEMBERS</b>: James Sunthonlap, Lihao Lin, Salem Alharbi</li><br/>
					<li>For the "Locate Me" button to function correctly, you MUST use a browser that supports geolocation (Chrome, ect.)</li><br/>
					<li>When clicking "Locate Me", it may take up to several seconds to auto populate the latitude and longitude text fields, depending on your browser and local machine performance.</li><br/>
					<li>Longitude and latitude values must be in decimal degrees. For example, latitude = 38.8897, longitude -77.0089 is a valid location.</li><br/>
					<li>Project GitHub link: <a href="https://github.com/jsunthon/cs320_ec">https://github.com/jsunthon/cs320_ec</a></li>
				</ol>
			</div>
		</div>
	</div>
	<!-------------------------------- SEARCH FORM ------------------------------>
	<div class="row">
		<div class="col-md-4 col-md-offset-4">
			<div class="well text-center">
				<h1>
					<i class="fa fa-credit-card-alt"></i>&nbsp;&nbsp;Extra Credit
				</h1>
				<hr />
				<p class="lead">Search for up 20 places near you (within up to
					31 miles).</p>

				<button class="btn btn-info btn-block btn-md" id="get-location">
					<i class="fa fa-location-arrow"></i>&nbsp;&nbsp;&nbsp;Locate Me
				</button>
				<br />
				<form action="Search" method="post">
					<div class="form-group">
						<div class="input-group">
							<div class="input-group-addon">Search Type</div>
							<select class="form-control" name="type">
								<option value="restaurant"
									${param.type == "restaurant" ? 'selected="selected"' : ''}>Restaurants</option>
								<option value="cafe"
									${param.type == "cafe" ? 'selected="selected"' : ''}>Cafe</option>
								<option value="university"
									${param.type == "university" ? 'selected="selected"' : ''}>Universities</option>
								<option value="school"
									${param.type == "school" ? 'selected="selected"' : ''}>Schools</option>
								<option value="gym"
									${param.type == "gym" ? 'selected="selected"' : ''}>Gym</option>
								<option value="park"
									${param.type == "park" ? 'selected="selected"' : ''}>Parks</option>
								<option value="police"
									${param.type == "policy" ? 'selected="selected"' : ''}>Police</option>
								<option value="shopping_mall"
									${param.type == "shopping_mall" ? 'selected="selected"' : ''}>Shopping
									Malls</option>
								<option value="doctor"
									${param.type == "doctor" ? 'selected="selected"' : ''}>Doctors</option>
								<option value="dentist"
									${param.type == "dentist" ? 'selected="selected"' : ''}>Dentists</option>
								<option value="post_office"
									${param.type == "post_office" ? 'selected="selected"' : ''}>Post
									Office</option>
								<option value="church"
									${param.type == "church" ? 'selected="selected"' : ''}>Churches</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<div class="input-group">
							<div class="input-group-addon">Latitude</div>
							<input id="lat" class="form-control" type="text" name="lat"
								value="${latitude }" placeholder="Latitude" />
						</div>
					</div>
					<div class="form-group">
						<div class="input-group">
							<div class="input-group-addon">Longitude</div>
							<input id="lon" class="form-control" type="text" name="lon"
								value="${longitude }" placeholder="Longitude" />
						</div>
					</div>
					<div class="form-group">
						<div class="input-group">
							<div class="input-group-addon">Radius (miles)</div>
							<input class="form-control" type="text" name="radius"
								placeholder="Radius" />
						</div>
					</div>
					<input type="submit" class="btn btn-info btn-block btn-md"
						value="Search" />
				</form>
			</div>
		</div>
	</div>
	<!-------------------------------- END  SEARCH FORM ------------------------------>
	<br />

	<c:choose>
		<c:when test="${not empty places}">
			<!-------------------------------- RESULTS DIV ------------------------------>
			<div id="results">
				<!-------------------------------- GOOGLE MAP  ------------------------------>
				<div class="row">
					<div class="col-md-8 col-md-offset-2">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h1 class="panel-title text-center">
									<i class="fa fa-globe"></i> &nbsp;&nbsp;&nbsp;Google Map
									Locations&nbsp;&nbsp;&nbsp;<i class="fa fa-map"></i>
								</h1>
							</div>
							<div id="map" class="panel-body">Panel content</div>
						</div>
					</div>
				</div>
				<!-------------------------------- END GOOGLE MAP  ------------------------------>
				<br />

				<!-------------------------------- RESULTS LIST ------------------------------>
				<div class="row">
					<div class="col-md-8 col-md-offset-2">
						<div class="panel panel-success">
							<div class="panel-heading">
								<h1 class="panel-title text-center">
									<i class="fa fa-building"></i>&nbsp;&nbsp;${resultsLength }
									${param.type } within ${radius} miles
								</h1>
							</div>
							<div class="panel-body well">
								<ul id="results-list" class="list-group">
									<c:forEach items="${places}" var="place">
										<div class="col-md-6">
											<li class="result-item list-group-item">
												<p class="text-primary">
													<b>Name</b>: ${place.name}
												</p>
												<p class="text-primary">
													<b>Address</b>: ${place.address}
												</p>
												<p class="text-primary">
													<b>Phone</b>: ${place.phone}
												</p>
												<p class="text-primary">
													<b>Longitude</b>: ${place.lng}
												</p>
												<p class="text-primary">
													<b>Latitude</b>: ${place.lat}
												</p>
												<p class="text-primary">
													<b>Google URL</b>: <a href="${place.url}">${place.url }</a>
												</p>
											</li>
										</div>
										<script>
											populate('${place.lat}',
													'${place.lng}',
													'${fn:length(places)}', [
															'${place.name}',
															'${place.address}',
															'${place.phone}',
															'${place.types}',
															'${place.lat}',
															'${place.lng}' ]);
										</script>
									</c:forEach>
								</ul>
							</div>
						</div>
					</div>
				</div>
				<!-------------------------------- END RESULTS LIST ------------------------------>
			</div>
			<!-------------------------------- END RESULTS DIV ------------------------------>
		</c:when>
		<c:otherwise>
			<div style="display: none;" id="map" class="col-md-6"></div>
		</c:otherwise>
	</c:choose>

	<!-------------------------------- FOOTER  ------------------------------>
	<div class="row">
		<footer class="footer-distributed" style="margin-bottom: -100000px;">
		<div class="footer-left">
			<h3>CS320 Extra Credit</h3>
			<p class="footer-links">
				<a href="#">Home</a> · <a href="#">About</a> · <a href="#">Faq</a> ·
				<a href="#">Contact</a>
			</p>
			<p class="footer-company-name">James Sunthonlap, Lihao Lin, Salem
				Alharbi &copy; 2016</p>
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
					<a href="mailto:support@company.com">support@jamesandhowieandsalem.com</a>
				</p>
			</div>
		</div>
		<div class="footer-right">
			<p class="footer-company-about">
				<span>About the company</span> We are a company that believes in
				open source content.<br /> Everything ought to be free! Like this
				map service.
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
	<script src="../Scripts/bootstrap.min.js"></script>
	<script src="../Scripts/cs320.js"></script>
	<!--------------------------------- END JAVASCRIPT ------------------------------ -->

</body>
</html>