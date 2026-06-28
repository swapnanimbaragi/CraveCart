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
		.bindPopup("Default Location: Bengaluru")
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
		status.innerText = "Geolocation is not supported by this browser.";
		return;
	}

	navigator.geolocation.getCurrentPosition(
		function(position) {
			const lat = position.coords.latitude;
			const lon = position.coords.longitude;

			setTimeout(function () {
				map.invalidateSize();
				map.setView([lat, lon], 17, {
					animate: true,
					duration: 1
				});
			}, 300);

			if (marker) {
				map.removeLayer(marker);
			}

			marker = L.marker([lat, lon]).addTo(map)
				.bindPopup("📍 Delivery Location")
				.openPopup();

			status.innerText = "🔎 Finding your address...";

			fetchAddress(lat, lon);
		},
		function() {
			status.innerText = "❌ Unable to fetch location. Please allow location permission.";
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
		.then(response => response.json())
		.then(data => {
			if (data && data.display_name) {
				addressBox.value = data.display_name;
				status.innerText = "✅ Address detected successfully.";

				document.getElementById("selectedAddressCard").style.display = "flex";
				document.getElementById("selectedAddressText").innerText = data.display_name;
			} else {
				addressBox.value =
					"Latitude: " + lat.toFixed(6) + ", Longitude: " + lon.toFixed(6);
				status.innerText = "Address not found. Location coordinates added.";
			}
		})
		.catch(() => {
			addressBox.value =
				"Latitude: " + lat.toFixed(6) + ", Longitude: " + lon.toFixed(6);
			status.innerText = "Address lookup failed. Coordinates added.";
		});
}

function clearLocation() {
	document.getElementById("deliveryAddress").value = "";
	document.getElementById("locationStatus").innerText =
		"You can type your address manually.";
}

window.onload = initMap;