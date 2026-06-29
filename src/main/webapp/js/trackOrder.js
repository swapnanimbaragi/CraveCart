let trackMap;
let restaurantMarker;
let customerMarker;
let partnerMarker;
let routeLine;

let restaurantPoint;
let customerPoint;

let totalDistance = 0;

function initTrackingMap() {

	trackMap = L.map("trackMap", {
		center: [restaurantLat, restaurantLon],
		zoom: 13
	});

	L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
		maxZoom: 19,
		attribution: "© OpenStreetMap"
	}).addTo(trackMap);

	restaurantPoint = [restaurantLat, restaurantLon];

	restaurantMarker = L.marker(restaurantPoint).addTo(trackMap)
		.bindPopup("🏪 " + restaurantName);

	findCustomerLocation();
}

function findCustomerLocation() {

	const url =
		"https://nominatim.openstreetmap.org/search?format=json&q=" +
		encodeURIComponent(customerAddress) +
		"&limit=1";

	fetch(url)
		.then(response => response.json())
		.then(data => {

			if (!data || data.length === 0) {
				customerPoint = [restaurantLat + 0.02, restaurantLon + 0.02];
			} else {
				customerPoint = [
					parseFloat(data[0].lat),
					parseFloat(data[0].lon)
				];
			}

			customerMarker = L.marker(customerPoint).addTo(trackMap)
				.bindPopup("📍 Your Location");

			drawRoute();
			startLiveTracking();
		})
		.catch(() => {
			customerPoint = [restaurantLat + 0.02, restaurantLon + 0.02];

			customerMarker = L.marker(customerPoint).addTo(trackMap)
				.bindPopup("📍 Your Location");

			drawRoute();
			startLiveTracking();
		});
}

function drawRoute() {

	routeLine = L.polyline([restaurantPoint, customerPoint], {
		color: "#2fa84f",
		weight: 6,
		opacity: 0.85
	}).addTo(trackMap);

	const bounds = L.latLngBounds([restaurantPoint, customerPoint]);
	trackMap.fitBounds(bounds, {
		padding: [45, 45]
	});

	totalDistance = calculateDistance(
		restaurantPoint[0],
		restaurantPoint[1],
		customerPoint[0],
		customerPoint[1]
	);

	updateLiveInfo(totalDistance, 30);
}

function startLiveTracking() {

	let progress = 0;

	partnerMarker = L.marker(restaurantPoint).addTo(trackMap)
		.bindPopup("🛵 Rahul");

	const steps = [
		"stepPlaced",
		"stepPreparing",
		"stepPacking",
		"stepPicked",
		"stepOut",
		"stepDelivered"
	];

	let interval = setInterval(function () {

		progress += 1;

		if (progress > 100) {
			progress = 100;
			clearInterval(interval);
		}

		const lat =
			restaurantPoint[0] +
			(customerPoint[0] - restaurantPoint[0]) * (progress / 100);

		const lon =
			restaurantPoint[1] +
			(customerPoint[1] - restaurantPoint[1]) * (progress / 100);

		partnerMarker.setLatLng([lat, lon]);

		const remainingDistance = totalDistance * (1 - progress / 100);
		const eta = Math.max(1, Math.round(remainingDistance * 4));

		updateLiveInfo(remainingDistance, eta);
		updateTimeline(progress, steps);

	}, 1200);
}

function updateTimeline(progress, steps) {

	let activeIndex = 0;

	if (progress >= 10) activeIndex = 1;
	if (progress >= 25) activeIndex = 2;
	if (progress >= 45) activeIndex = 3;
	if (progress >= 65) activeIndex = 4;
	if (progress >= 100) activeIndex = 5;

	for (let i = 0; i < steps.length; i++) {

		const step = document.getElementById(steps[i]);
		const badge = step.querySelector(".status-badge");

		step.classList.remove("active");
		step.classList.remove("current");

		if (i < activeIndex) {
			step.classList.add("active");
			badge.innerText = "Completed";
		} else if (i === activeIndex) {
			step.classList.add("active");
			step.classList.add("current");
			badge.innerText = "In Progress";
		} else {
			badge.innerText = "Pending";
		}
	}
}

function updateLiveInfo(distanceLeft, eta) {

	document.getElementById("distanceLeft").innerText =
		distanceLeft.toFixed(1) + " km";

	document.getElementById("mapEta").innerText =
		eta + " mins";

	document.getElementById("topEta").innerText =
		eta + " mins";

	document.getElementById("reachEta").innerText =
		eta + " mins";
}

function calculateDistance(lat1, lon1, lat2, lon2) {

	const R = 6371;

	const dLat = (lat2 - lat1) * Math.PI / 180;
	const dLon = (lon2 - lon1) * Math.PI / 180;

	const a =
		Math.sin(dLat / 2) * Math.sin(dLat / 2) +
		Math.cos(lat1 * Math.PI / 180) *
		Math.cos(lat2 * Math.PI / 180) *
		Math.sin(dLon / 2) *
		Math.sin(dLon / 2);

	const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

	return R * c;
}

window.onload = initTrackingMap;