let map;
let marker;
let currentLat = 12.9716;
let currentLon = 77.5946;

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

function useCurrentLocation() {
	const status = document.getElementById("locationStatus");

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

			fetchAddress(currentLat, currentLon);
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

function fetchAddress(lat, lon) {
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
				status.innerText = "✅ Address detected successfully.";

				const selectedCard = document.getElementById("selectedAddressCard");
				const selectedText = document.getElementById("selectedAddressText");

				if (selectedCard && selectedText) {
					selectedCard.style.display = "flex";
					selectedText.innerText = data.display_name;
				}

				if (marker) {
					marker.bindPopup("📍 Deliver Here").openPopup();
				}
			} else {
				addressBox.value =
					"Latitude: " + lat.toFixed(6) + ", Longitude: " + lon.toFixed(6);

				status.innerText = "⚠️ Address not found. Coordinates added.";
			}
		})
		.catch(function() {
			addressBox.value =
				"Latitude: " + lat.toFixed(6) + ", Longitude: " + lon.toFixed(6);

			status.innerText = "⚠️ Address lookup failed. Coordinates added.";
		});
}

function clearLocation() {
	const addressBox = document.getElementById("deliveryAddress");
	const status = document.getElementById("locationStatus");
	const selectedCard = document.getElementById("selectedAddressCard");

	addressBox.value = "";
	status.innerText = "You can type your address manually.";

	if (selectedCard) {
		selectedCard.style.display = "none";
	}
}

window.onload = initMap;