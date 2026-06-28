let map;
let marker;

let currentLat = 12.9716;
let currentLon = 77.5946;

/* ================= INITIAL MAP ================= */

function initMap() {

	map = L.map("checkoutMap", {
		center: [currentLat, currentLon],
		zoom: 13,
		minZoom: 5,
		maxZoom: 19,
		dragging: true,
		scrollWheelZoom: true,
		doubleClickZoom: true,
		touchZoom: true,
		boxZoom: true,
		keyboard: true,
		zoomControl: true
	});

	L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
		maxZoom: 19,
		attribution: "© OpenStreetMap"
	}).addTo(map);

	marker = L.marker([currentLat, currentLon]).addTo(map)
		.bindPopup("📍 Bengaluru");

	setTimeout(function () {
		map.invalidateSize();
		map.setView([currentLat, currentLon], 13);
	}, 500);
}

/* ================= USE CURRENT LOCATION ================= */

function useCurrentLocation() {

	const status = document.getElementById("locationStatus");
	const mapSection = document.getElementById("mapSection");
	const manualAddressSection = document.getElementById("manualAddressSection");
	const selectedCard = document.getElementById("selectedAddressCard");

	if (mapSection) {
		mapSection.style.display = "block";
	}

	if (manualAddressSection) {
		manualAddressSection.style.display = "none";
	}

	if (selectedCard) {
		selectedCard.style.display = "none";
	}

	status.innerText = "📍 Detecting your current location...";

	if (!navigator.geolocation) {
		status.innerText = "❌ Geolocation is not supported by this browser.";
		return;
	}

	navigator.geolocation.getCurrentPosition(
		function(position) {

			currentLat = position.coords.latitude;
			currentLon = position.coords.longitude;

			if (marker) {
				map.removeLayer(marker);
			}

			marker = L.marker([currentLat, currentLon]).addTo(map)
				.bindPopup("📍 Deliver Here");

			map.invalidateSize();

			map.flyTo([currentLat, currentLon], 16, {
				animate: true,
				duration: 1.2
			});

			setTimeout(function () {
				marker.openPopup();
			}, 1300);

			status.innerText = "🔎 Finding your address...";

			fetchAddress(currentLat, currentLon, "Current Location");
		},
		function() {
			status.innerText = "❌ Unable to fetch location. Please allow location permission.";
		},
		{
			enableHighAccuracy: true,
			timeout: 15000,
			maximumAge: 0
		}
	);
}

/* ================= FETCH REAL ADDRESS ================= */

function fetchAddress(lat, lon, type) {

	const addressBox = document.getElementById("deliveryAddress");
	const status = document.getElementById("locationStatus");

	const url =
		"https://nominatim.openstreetmap.org/reverse?format=json&lat=" +
		lat +
		"&lon=" +
		lon +
		"&zoom=18&addressdetails=1";

	fetch(url)
		.then(function(response) {
			return response.json();
		})
		.then(function(data) {

			if (data && data.display_name) {

				addressBox.value = data.display_name;

				updateSelectedAddress(type, data.display_name);

				status.innerText = "✅ Address detected successfully.";

				if (marker) {
					marker.bindPopup("📍 Deliver Here").openPopup();
				}

			} else {

				const coordinates =
					"Latitude: " + lat.toFixed(6) + ", Longitude: " + lon.toFixed(6);

				addressBox.value = coordinates;

				updateSelectedAddress(type, coordinates);

				status.innerText = "⚠️ Address not found. Coordinates added.";
			}
		})
		.catch(function() {

			const coordinates =
				"Latitude: " + lat.toFixed(6) + ", Longitude: " + lon.toFixed(6);

			addressBox.value = coordinates;

			updateSelectedAddress(type, coordinates);

			status.innerText = "⚠️ Address lookup failed. Coordinates added.";
		});
}

/* ================= UPDATE SELECTED ADDRESS CARD ================= */

function updateSelectedAddress(type, address) {

	const selectedCard = document.getElementById("selectedAddressCard");
	const selectedText = document.getElementById("selectedAddressText");
	const selectedTitle = document.getElementById("selectedAddressTitle");

	if (selectedCard) {
		selectedCard.style.display = "flex";
	}

	if (selectedText) {
		selectedText.innerText = address;
	}

	if (selectedTitle) {
		selectedTitle.innerText = type;
	}
}

/* ================= MANUAL ADDRESS ================= */

function clearLocation() {

	const addressBox = document.getElementById("deliveryAddress");
	const status = document.getElementById("locationStatus");
	const selectedCard = document.getElementById("selectedAddressCard");
	const mapSection = document.getElementById("mapSection");
	const manualAddressSection = document.getElementById("manualAddressSection");

	addressBox.value = "";

	if (mapSection) {
		mapSection.style.display = "none";
	}

	if (selectedCard) {
		selectedCard.style.display = "none";
	}

	if (manualAddressSection) {
		manualAddressSection.style.display = "block";
	}

	status.innerText = "✏️ Enter your delivery address manually.";
}

/* ================= SAVED ADDRESS SELECTION ================= */

function selectSavedAddress(type, address) {

	const addressBox = document.getElementById("deliveryAddress");
	const status = document.getElementById("locationStatus");
	const selectedCard = document.getElementById("selectedAddressCard");
	const mapSection = document.getElementById("mapSection");
	const manualAddressSection = document.getElementById("manualAddressSection");

	addressBox.value = address;

	updateSelectedAddress(type, address);

	if (selectedCard) {
		selectedCard.style.display = "flex";
	}

	if (mapSection) {
		mapSection.style.display = "none";
	}

	if (manualAddressSection) {
		manualAddressSection.style.display = "none";
	}

	status.innerText = "✅ " + type + " address selected.";
}

/* ================= LOAD MAP ================= */

window.onload = initMap;