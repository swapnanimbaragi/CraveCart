let trackMap;
let restaurantMarker;
let customerMarker;
let partnerMarker;
let routeLine;

let restaurantPoint;
let customerPoint;

let totalDistance = 0;

/* ================= ICONS ================= */

const restaurantIcon = L.icon({
	iconUrl: "https://cdn-icons-png.flaticon.com/512/1046/1046784.png",
	iconSize: [42, 42],
	iconAnchor: [21, 42],
	popupAnchor: [0, -38]
});

const bikeIcon = L.divIcon({
	className: "bike-icon",
	html: "<div id='deliveryBike'>➤</div>",
	iconSize: [42, 42],
	iconAnchor: [21, 21]
});

const homeIcon = L.icon({
	iconUrl: "https://cdn-icons-png.flaticon.com/512/25/25694.png",
	iconSize: [38, 38],
	iconAnchor: [19, 38],
	popupAnchor: [0, -34]
});

/* ================= MAP INIT ================= */

function initTrackingMap() {

	trackMap = L.map("trackMap", {
		center: [restaurantLat, restaurantLon],
		zoom: 13,
		scrollWheelZoom: true
	});

	L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
		maxZoom: 19,
		attribution: "© OpenStreetMap"
	}).addTo(trackMap);

	restaurantPoint = [restaurantLat, restaurantLon];

	restaurantMarker = L.marker(restaurantPoint, {
		icon: restaurantIcon
	}).addTo(trackMap)
		.bindPopup("🏪 " + restaurantName);

	findCustomerLocation();
}

/* ================= CUSTOMER LOCATION ================= */

function findCustomerLocation() {

	if (typeof customerLat !== "undefined"
		&& typeof customerLon !== "undefined"
		&& customerLat !== 0
		&& customerLon !== 0) {

		customerPoint = [customerLat, customerLon];

		customerMarker = L.marker(customerPoint, {
			icon: homeIcon
		}).addTo(trackMap)
			.bindPopup("🏠 Your Location");

		drawRoute();
		startLiveTracking();
		return;
	}

	customerPoint = [restaurantLat + 0.02, restaurantLon + 0.02];

	customerMarker = L.marker(customerPoint, {
		icon: homeIcon
	}).addTo(trackMap)
		.bindPopup("🏠 Your Location");

	drawRoute();
	startLiveTracking();
}

/* ================= DRAW ROUTE ================= */

function drawRoute() {

	routeLine = L.polyline([restaurantPoint, customerPoint], {
		color: "#2fa84f",
		weight: 6,
		opacity: 0.9,
		dashArray: "12, 10"
	}).addTo(trackMap);

	const bounds = L.latLngBounds([restaurantPoint, customerPoint]);

	trackMap.fitBounds(bounds, {
		padding: [55, 55]
	});

	totalDistance = calculateDistance(
		restaurantPoint[0],
		restaurantPoint[1],
		customerPoint[0],
		customerPoint[1]
	);

	updateLiveInfo(totalDistance, calculateEtaFromDistance(totalDistance));
}

/* ================= LIVE TRACKING ================= */

function startLiveTracking() {

	let progress = 0;

	partnerMarker = L.marker(restaurantPoint, {
		icon: bikeIcon
	}).addTo(trackMap)
		.bindPopup("Waiting at restaurant");

	const steps = [
		"stepPlaced",
		"stepPreparing",
		"stepPacking",
		"stepPicked",
		"stepOut",
		"stepDelivered"
	];

	let interval = setInterval(function () {

		progress++;

		if (progress > 100) {
			progress = 100;
			clearInterval(interval);
		}

		if (progress >= 45) {

			let bikeProgress = (progress - 45) / 55;

			if (bikeProgress > 1) {
				bikeProgress = 1;
			}

			const oldLatLng = partnerMarker.getLatLng();

			const lat =
				restaurantPoint[0] +
				(customerPoint[0] - restaurantPoint[0]) * bikeProgress;

			const lon =
				restaurantPoint[1] +
				(customerPoint[1] - restaurantPoint[1]) * bikeProgress;

			partnerMarker.setLatLng([lat, lon]);

			rotateBike(oldLatLng.lat, oldLatLng.lng, lat, lon);
		}

		const remainingDistance = calculateRemainingDistance(progress);
		const eta = calculateEtaFromDistance(remainingDistance);

		updateLiveInfo(remainingDistance, eta);
		updateTimeline(progress, steps);

	}, 900);
}

/* ================= TIMELINE ================= */

function updateTimeline(progress, steps) {

	let activeIndex = 0;

	if (progress >= 10) activeIndex = 1;
	if (progress >= 25) activeIndex = 2;
	if (progress >= 45) activeIndex = 3;
	if (progress >= 65) activeIndex = 4;
	if (progress >= 100) activeIndex = 5;

	for (let i = 0; i < steps.length; i++) {

		const step = document.getElementById(steps[i]);

		if (!step) {
			continue;
		}

		const badge = step.querySelector(".status-badge");

		step.classList.remove("active");
		step.classList.remove("current");

		if (progress >= 100) {
			step.classList.add("active");
			if (badge) badge.innerText = "Completed";
			continue;
		}

		if (i < activeIndex) {
			step.classList.add("active");
			if (badge) badge.innerText = "Completed";
		}
		else if (i === activeIndex) {
			step.classList.add("active");
			step.classList.add("current");
			if (badge) badge.innerText = "In Progress";
		}
		else {
			if (badge) badge.innerText = "Pending";
		}
	}
}

/* ================= LIVE INFO ================= */

function updateLiveInfo(distanceLeft, eta) {

	const distanceLeftBox = document.getElementById("distanceLeft");
	const mapEtaBox = document.getElementById("mapEta");
	const topEtaBox = document.getElementById("topEta");
	const reachEtaBox = document.getElementById("reachEta");

	if (distanceLeftBox) {
		distanceLeftBox.innerText = distanceLeft.toFixed(1) + " km";
	}

	if (mapEtaBox) {
		mapEtaBox.innerText = eta + " mins";
	}

	if (topEtaBox) {
		topEtaBox.innerText = eta + " mins";
	}

	if (reachEtaBox) {
		reachEtaBox.innerText = eta + " mins";
	}
}

/* ================= DISTANCE AND ETA ================= */

function calculateRemainingDistance(progress) {

	if (progress < 45) {
		return totalDistance;
	}

	let bikeProgress = (progress - 45) / 55;

	if (bikeProgress > 1) {
		bikeProgress = 1;
	}

	let remaining = totalDistance * (1 - bikeProgress);

	if (remaining < 0) {
		remaining = 0;
	}

	return remaining;
}

function calculateEtaFromDistance(distance) {

	if (distance <= 0) {
		return 0;
	}

	const preparationBuffer = 6;
	const speedKmPerHour = 18;

	const travelMinutes = (distance / speedKmPerHour) * 60;

	let eta = Math.round(preparationBuffer + travelMinutes);

	if (eta < 2) {
		eta = 2;
	}

	return eta;
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

/* ================= BIKE ROTATION ================= */

function rotateBike(fromLat, fromLon, toLat, toLon) {

	const bike = document.getElementById("deliveryBike");

	if (!bike) {
		return;
	}

	const angle = getBearing(fromLat, fromLon, toLat, toLon);

	bike.style.transform = "rotate(" + angle + "deg)";
}

function getBearing(lat1, lon1, lat2, lon2) {

	const dLon = (lon2 - lon1) * Math.PI / 180;

	lat1 = lat1 * Math.PI / 180;
	lat2 = lat2 * Math.PI / 180;

	const y = Math.sin(dLon) * Math.cos(lat2);

	const x =
		Math.cos(lat1) * Math.sin(lat2) -
		Math.sin(lat1) * Math.cos(lat2) *
		Math.cos(dLon);

	let bearing = Math.atan2(y, x) * 180 / Math.PI;

	return (bearing + 360) % 360;
}

window.onload = initTrackingMap;