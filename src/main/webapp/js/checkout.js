let map;
let marker;

function initMap() {
	map = L.map("checkoutMap", {
		center: [12.9716, 77.5946],
		zoom: 13,
		scrollWheelZoom: true,
		dragging: true,
		touchZoom: true,
		doubleClickZoom: true,
		boxZoom: true,
		keyboard: true,
		zoomControl: true
	});

	L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
		maxZoom: 19,
		attribution: "© OpenStreetMap"
	}).addTo(map);

	marker = L.marker([12.9716, 77.5946]).addTo(map)
		.bindPopup("📍 Default Location: Bengaluru")
		.openPopup();

	setTimeout(function () {
		map.invalidateSize();
	}, 500);
}

function useCurrentLocation() {
	const status = document.getElementById("locationStatus");
	const addressBox = document.getElementById("deliveryAddress");

	status.innerText = "📍 Detecting your current location...";

	if (!navigator.geolocation) {
		status.innerText = "❌ Geolocation is not supported by this browser.";
		return;
	}

	navigator.geolocation.getCurrentPosition(
		function(position) {
			const lat = position.coords.latitude;
			const lon = position.coords.longitude;

			if (marker) {
				map.removeLayer(marker);
			}

			marker = L.marker([lat, lon]).addTo(map)
				.bindPopup("📍 Your Delivery Location")
				.openPopup();

			setTimeout(function () {
				map.invalidateSize();

				map.setView([lat, lon], 14, {
					animate: true,
					duration: 1
				});
			}, 300);

			status.innerText = "🔎 Finding your address...";

			fetchAddress(lat, lon);
		},
		function() {
			status.innerText = "❌ Unable to fetch location. Please allow location permission.";
		},
		{
			enableHighAccuracy: true,
			timeout: 10000,
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
					marker.bindPopup("📍 Deliver Here<br>" + data.display_name).openPopup();
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