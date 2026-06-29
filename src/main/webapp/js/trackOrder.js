let trackMap;
let restaurantMarker;
let customerMarker;
let partnerMarker;
let routeLine;

let restaurantPoint;
let customerPoint;

let totalDistance = 0;

/* ================= CUSTOM ICONS ================= */

const restaurantIcon = L.icon({
	iconUrl: "https://cdn-icons-png.flaticon.com/512/1046/1046784.png",
	iconSize: [42, 42],
	iconAnchor: [21, 42],
	popupAnchor: [0, -38]
});

const bikeIcon = L.icon({
    iconUrl: "images/delivery-bike1.png",
    iconSize: [55, 55],
    iconAnchor: [27, 27]
});

const homeIcon = L.icon({
	iconUrl: "https://cdn-icons-png.flaticon.com/512/25/25694.png",
	iconSize: [38, 38],
	iconAnchor: [19, 38],
	popupAnchor: [0, -34]
});

/* ================= INIT MAP ================= */

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

/* ================= FIND CUSTOMER LOCATION FROM ADDRESS ================= */

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

			customerMarker = L.marker(customerPoint, {
				icon: homeIcon
			}).addTo(trackMap)
				.bindPopup("🏠 Your Location");

			drawRoute();
			startLiveTracking();
		})
		.catch(() => {

			customerPoint = [restaurantLat + 0.02, restaurantLon + 0.02];

			customerMarker = L.marker(customerPoint, {
				icon: homeIcon
			}).addTo(trackMap)
				.bindPopup("🏠 Your Location");

			drawRoute();
			startLiveTracking();
		});
}

/* ================= DRAW ROUTE ================= */

function drawRoute() {

	routeLine = L.polyline([restaurantPoint, customerPoint], {
		color: "#2fa84f",
		weight: 6,
		opacity: 0.85,
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
		.bindPopup("🛵 Waiting at restaurant");

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

		/*
			Bike should move only after Picked Up.
			0 - 44  : restaurant/preparing/packing
			45 - 100: bike moves towards customer
		*/
		if (progress >= 45) {

			let bikeProgress = (progress - 45) / 55;

			if (bikeProgress > 1) {
				bikeProgress = 1;
			}

			const lat =
				restaurantPoint[0] +
				(customerPoint[0] - restaurantPoint[0]) * bikeProgress;

			const lon =
				restaurantPoint[1] +
				(customerPoint[1] - restaurantPoint[1]) * bikeProgress;

			partnerMarker.setLatLng([lat, lon]);
			rotateBike(lat, lon);
			
			if (progress < 65) {
				partnerMarker.bindPopup("🛵 Picked up from restaurant");
			} else if (progress < 100) {
				partnerMarker.bindPopup("🛵 On the way");
			} else {
				partnerMarker.bindPopup("✅ Delivered");
			}
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
		if (!step) continue;

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

/* ================= CALCULATIONS ================= */

function calculateRemainingDistance(progress) {

	if (progress < 45) {
		return totalDistance;
	}

	const bikeProgress = (progress - 45) / 55;

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

window.onload = initTrackingMap;


function rotateBike(lat, lon) {

	const bikeImg = document.getElementById("bikeImg");

	if (!bikeImg) {
		return;
	}

	const angle = getBearing(lat, lon, customerPoint[0], customerPoint[1]);

	bikeImg.style.transform = "rotate(" + angle + "deg)";
}

function getBearing(lat1, lon1, lat2, lon2) {

	const y = Math.sin((lon2 - lon1) * Math.PI / 180) *
		Math.cos(lat2 * Math.PI / 180);

	const x =
		Math.cos(lat1 * Math.PI / 180) *
		Math.sin(lat2 * Math.PI / 180) -
		Math.sin(lat1 * Math.PI / 180) *
		Math.cos(lat2 * Math.PI / 180) *
		Math.cos((lon2 - lon1) * Math.PI / 180);

	let bearing = Math.atan2(y, x) * 180 / Math.PI;

	return (bearing + 360) % 360;
}