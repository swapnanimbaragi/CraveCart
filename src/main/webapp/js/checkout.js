let map;
let marker;
let currentLat = 12.9716;
let currentLon = 77.5946;
let searchTimer;

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
	}, 500);
}

/* ================= COMMON HELPERS ================= */

function setDeliveryCoordinates(lat, lon) {
	document.getElementById("deliveryLatitude").value = lat;
	document.getElementById("deliveryLongitude").value = lon;
}

function updateSelectedAddress(type, address) {
	document.getElementById("selectedAddressCard").style.display = "flex";
	document.getElementById("selectedAddressTitle").innerText = type;
	document.getElementById("selectedAddressText").innerText = address;
}

function hideManualAndMap() {
	document.getElementById("manualAddressSection").style.display = "none";
	document.getElementById("mapSection").style.display = "none";
}

/* ================= CURRENT LOCATION ================= */

function useCurrentLocation() {
	const status = document.getElementById("locationStatus");

	document.getElementById("mapSection").style.display = "block";
	document.getElementById("manualAddressSection").style.display = "none";
	document.getElementById("selectedAddressCard").style.display = "none";

	status.innerText = "📍 Detecting your current location...";

	if (!navigator.geolocation) {
		status.innerText = "❌ Geolocation is not supported.";
		return;
	}

	navigator.geolocation.getCurrentPosition(function (position) {
		currentLat = position.coords.latitude;
		currentLon = position.coords.longitude;

		setDeliveryCoordinates(currentLat, currentLon);

		if (marker) {
			map.removeLayer(marker);
		}

		marker = L.marker([currentLat, currentLon]).addTo(map)
			.bindPopup("📍 Deliver Here")
			.openPopup();

		map.invalidateSize();
		map.flyTo([currentLat, currentLon], 16);

		fetchAddress(currentLat, currentLon, "Current Location");
		calculateETA(currentLat, currentLon);

	}, function () {
		status.innerText = "❌ Please allow location permission.";
	});
}

function fetchAddress(lat, lon, type) {
	const url =
		"https://nominatim.openstreetmap.org/reverse?format=json&lat=" +
		lat + "&lon=" + lon + "&zoom=18&addressdetails=1";

	fetch(url)
		.then(response => response.json())
		.then(data => {
			const address = data.display_name ||
				"Latitude: " + lat + ", Longitude: " + lon;

			document.getElementById("deliveryAddress").value = address;
			updateSelectedAddress(type, address);
			document.getElementById("locationStatus").innerText =
				"✅ Address detected successfully.";
		});
}

/* ================= MANUAL ADDRESS ================= */

function showManualAddress() {
	document.getElementById("mapSection").style.display = "none";
	document.getElementById("selectedAddressCard").style.display = "none";
	document.getElementById("manualAddressSection").style.display = "block";
	document.getElementById("locationStatus").innerText =
		"✏️ Enter your delivery address manually.";
}

function confirmManualAddress() {
	const manualInput = document.getElementById("manualAddressInput");

	if (manualInput.value.trim() === "") {
		alert("Please enter your delivery address.");
		return;
	}

	document.getElementById("deliveryAddress").value = manualInput.value.trim();

	updateSelectedAddress("Manual Address", manualInput.value.trim());

	document.getElementById("manualAddressSection").style.display = "none";
}

/* ================= LIVE SEARCH ================= */

function liveSearchAddress() {
	const input = document.getElementById("addressSearchInput");
	const resultsBox = document.getElementById("searchResults");

	const query = input.value.trim();

	clearTimeout(searchTimer);

	if (query.length < 3) {
		resultsBox.style.display = "none";
		resultsBox.innerHTML = "";
		return;
	}

	resultsBox.style.display = "block";
	resultsBox.innerHTML = "<div class='search-result-card'>🔎 Searching...</div>";

	searchTimer = setTimeout(function () {
		const url =
			"https://nominatim.openstreetmap.org/search?format=json&q=" +
			encodeURIComponent(query) +
			"&limit=5&addressdetails=1";

		fetch(url)
			.then(response => response.json())
			.then(data => {
				resultsBox.innerHTML = "";

				if (!data || data.length === 0) {
					resultsBox.innerHTML =
						"<div class='search-result-card'>No address found</div>";
					return;
				}

				data.forEach(place => {
					const title = getShortTitle(place);
					const sub = getShortSub(place);

					const card = document.createElement("div");
					card.className = "search-result-card";

					card.innerHTML =
						"<span class='search-title'>📍 " + title + "</span>" +
						"<span class='search-sub'>" + sub + "</span>";

					card.onclick = function () {
						selectSearchedAddress(
							place.display_name,
							parseFloat(place.lat),
							parseFloat(place.lon),
							title
						);
					};

					resultsBox.appendChild(card);
				});
			});
	}, 500);
}

function getShortTitle(place) {
	if (place.address) {
		return place.address.suburb ||
			place.address.neighbourhood ||
			place.address.road ||
			place.address.city ||
			place.display_name.split(",")[0];
	}

	return place.display_name.split(",")[0];
}

function getShortSub(place) {
	if (place.address) {
		const area = place.address.city || place.address.town || place.address.state || "";
		const pin = place.address.postcode || "";
		return area + (pin !== "" ? " - " + pin : "");
	}

	return place.display_name.split(",").slice(1, 3).join(",");
}

function selectSearchedAddress(address, lat, lon, title) {
	document.getElementById("deliveryAddress").value = address;
	document.getElementById("addressSearchInput").value = title;

	setDeliveryCoordinates(lat, lon);
	updateSelectedAddress("Searched Address", address);

	document.getElementById("manualAddressSection").style.display = "none";
	document.getElementById("mapSection").style.display = "block";

	if (marker) {
		map.removeLayer(marker);
	}

	marker = L.marker([lat, lon]).addTo(map)
		.bindPopup("📍 Deliver Here")
		.openPopup();

	map.invalidateSize();
	map.flyTo([lat, lon], 15);

	document.getElementById("searchResults").style.display = "none";
	document.getElementById("searchResults").innerHTML = "";
	document.getElementById("locationStatus").innerText =
		"✅ Address selected from search.";

	calculateETA(lat, lon);
}

/* ================= SAVE HOME / OFFICE ================= */

function saveCurrentAddressAs(type) {
	const address = document.getElementById("deliveryAddress").value.trim();
	const lat = document.getElementById("deliveryLatitude").value;
	const lon = document.getElementById("deliveryLongitude").value;

	if (address === "") {
		alert("Please select or enter address first.");
		return;
	}

	const savedData = {
		address: address,
		lat: lat,
		lon: lon
	};

	localStorage.setItem("cravecart_" + type, JSON.stringify(savedData));

	alert(type + " address saved successfully.");
	loadSavedAddresses();
}

function loadSavedAddresses() {
	loadOneSavedAddress("Home", "homeAddressText");
	loadOneSavedAddress("Office", "officeAddressText");
}

function loadOneSavedAddress(type, textId) {
	const saved = localStorage.getItem("cravecart_" + type);
	const textBox = document.getElementById(textId);

	if (!textBox) return;

	if (!saved) {
		textBox.innerText = "Not saved yet";
		return;
	}

	try {
		const data = JSON.parse(saved);
		textBox.innerText = data.address.substring(0, 35) + "...";
	} catch (e) {
		textBox.innerText = saved.substring(0, 35) + "...";
	}
}

function handleSavedAddressClick(type) {
	const saved = localStorage.getItem("cravecart_" + type);

	if (!saved) {
		alert(type + " address not saved yet.");
		return;
	}

	let address = "";
	let lat = "";
	let lon = "";

	try {
		const data = JSON.parse(saved);
		address = data.address;
		lat = data.lat;
		lon = data.lon;
	} catch (e) {
		address = saved;
	}

	document.getElementById("deliveryAddress").value = address;

	updateSelectedAddress(type, address);

	document.getElementById("selectedAddressBadge").innerText =
		"🟢 Saved Address";

	document.getElementById("selectedAddressCard").style.display = "flex";

	hideManualAndMap();

	if (lat !== "" && lon !== "") {
		setDeliveryCoordinates(lat, lon);
		calculateETA(parseFloat(lat), parseFloat(lon));
	} else {
		findCoordinatesForSavedAddress(address);
	}

	document.getElementById("locationStatus").innerText =
		"✅ " + type + " address selected.";
}

function findCoordinatesForSavedAddress(address) {
	const url =
		"https://nominatim.openstreetmap.org/search?format=json&q=" +
		encodeURIComponent(address) +
		"&limit=1";

	fetch(url)
		.then(response => response.json())
		.then(data => {
			if (data && data.length > 0) {
				const lat = parseFloat(data[0].lat);
				const lon = parseFloat(data[0].lon);

				setDeliveryCoordinates(lat, lon);
				calculateETA(lat, lon);
			}
		});
}

/* ================= ETA ================= */

function calculateETA(customerLat, customerLon) {
	const R = 6371;

	const dLat = (customerLat - restaurantLat) * Math.PI / 180;
	const dLon = (customerLon - restaurantLon) * Math.PI / 180;

	const a =
		Math.sin(dLat / 2) * Math.sin(dLat / 2) +
		Math.cos(restaurantLat * Math.PI / 180) *
		Math.cos(customerLat * Math.PI / 180) *
		Math.sin(dLon / 2) *
		Math.sin(dLon / 2);

	const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

	const distance = R * c;

	const preparationTime = 12;
	const averageSpeed = 18;
	const travelTime = (distance / averageSpeed) * 60;

	let minEta = Math.round(preparationTime + travelTime);
	let maxEta = minEta + 7;

	if (minEta < 15) {
		minEta = 15;
		maxEta = 22;
	}

	document.getElementById("distanceText").innerText =
		distance.toFixed(1) + " km";

	document.getElementById("etaText").innerText =
		minEta + "–" + maxEta + " mins";

	document.getElementById("etaCard").style.display = "flex";
}

/* ================= ON LOAD ================= */

window.onload = function () {
	initMap();
	loadSavedAddresses();

	document.getElementById("homeAddressCard").onclick = function () {
		handleSavedAddressClick("Home");
	};

	document.getElementById("officeAddressCard").onclick = function () {
		handleSavedAddressClick("Office");
	};
};


document.addEventListener("DOMContentLoaded", function () {

	const homeCard = document.getElementById("homeAddressCard");
	const officeCard = document.getElementById("officeAddressCard");

	if (homeCard) {
		homeCard.onclick = function () {
			handleSavedAddressClick("Home");
		};
	}

	if (officeCard) {
		officeCard.onclick = function () {
			handleSavedAddressClick("Office");
		};
	}
});