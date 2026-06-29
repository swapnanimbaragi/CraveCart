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
			
			setDeliveryCoordinates(currentLat, currentLon);
			
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
			
			calculateETA(currentLat, currentLon);
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
/* ================= SHOW MANUAL ADDRESS ================= */

function showManualAddress() {

	const mapSection = document.getElementById("mapSection");
	const manualSection = document.getElementById("manualAddressSection");
	const selectedCard = document.getElementById("selectedAddressCard");
	const status = document.getElementById("locationStatus");

	if (mapSection) {
		mapSection.style.display = "none";
	}

	if (selectedCard) {
		selectedCard.style.display = "none";
	}

	if (manualSection) {
		manualSection.style.display = "block";
	}

	if (status) {
		status.innerText = "✏️ Enter your delivery address manually.";
	}
}

/* ================= CONFIRM MANUAL ADDRESS ================= */

function confirmManualAddress() {

	const manualInput = document.getElementById("manualAddressInput");
	const hiddenAddress = document.getElementById("deliveryAddress");

	if (manualInput.value.trim() === "") {
		alert("Please enter your delivery address.");
		return;
	}

	hiddenAddress.value = manualInput.value;

	updateSelectedAddress("Manual Address", manualInput.value);

	document.getElementById("selectedAddressCard").style.display = "flex";

	document.getElementById("manualAddressSection").style.display = "none";
}
/* ================= SAVED ADDRESS SELECTION ================= */

function selectSavedAddress(type, address) {

	const addressBox = document.getElementById("deliveryAddress");
	const status = document.getElementById("locationStatus");
	const selectedCard = document.getElementById("selectedAddressCard");
	const mapSection = document.getElementById("mapSection");
	const manualAddressSection = document.getElementById("manualAddressSection");

	addressBox.value = address;
	setDeliveryCoordinates(lat, lon);
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

window.onload = function() {
	initMap();
	loadSavedAddresses();
};


function saveCurrentAddressAs(type) {
	const addressBox = document.getElementById("deliveryAddress");

	if (!addressBox || addressBox.value.trim() === "") {
		alert("Please select or enter address first.");
		return;
	}

	localStorage.setItem("cravecart_" + type, addressBox.value);

	alert(type + " address saved successfully!");

	loadSavedAddresses();
}

function loadSavedAddresses() {
	const home = localStorage.getItem("cravecart_Home");
	const office = localStorage.getItem("cravecart_Office");

	const homeText = document.getElementById("homeAddressText");
	const officeText = document.getElementById("officeAddressText");

	if (home && homeText) {
		homeText.innerText = home.substring(0, 35) + "...";
	}

	if (office && officeText) {
		officeText.innerText = office.substring(0, 35) + "...";
	}
}

function handleSavedAddressClick(type) {
	const address = localStorage.getItem("cravecart_" + type);

	if (!address) {
		alert(type + " address not saved yet.");
		return;
	}

	selectSavedAddress(type, address);
}


function searchAddress() {
	const input = document.getElementById("addressSearchInput");
	const resultsBox = document.getElementById("searchResults");

	const query = input.value.trim();

	if (query === "") {
		alert("Please enter address to search.");
		return;
	}

	resultsBox.innerHTML = "<p>🔎 Searching address...</p>";

	const url =
		"https://nominatim.openstreetmap.org/search?format=json&q=" +
		encodeURIComponent(query) +
		"&limit=5";

	fetch(url)
		.then(response => response.json())
		.then(data => {
			resultsBox.innerHTML = "";

			if (!data || data.length === 0) {
				resultsBox.innerHTML = "<p>No address found.</p>";
				return;
			}

			data.forEach(place => {
				const card = document.createElement("div");
				card.className = "search-result-card";
				card.innerText = "📍 " + place.display_name;

				card.onclick = function() {
					selectSearchedAddress(
						place.display_name,
						parseFloat(place.lat),
						parseFloat(place.lon)
					);
				};

				resultsBox.appendChild(card);
			});
		})
		.catch(() => {
			resultsBox.innerHTML = "<p>Search failed. Try again.</p>";
		});
}

function selectSearchedAddress(address, lat, lon) {
	const addressBox = document.getElementById("deliveryAddress");
	const resultsBox = document.getElementById("searchResults");
	const mapSection = document.getElementById("mapSection");
	const manualSection = document.getElementById("manualAddressSection");

	addressBox.value = address;

	updateSelectedAddress("Searched Address", address);

	if (manualSection) {
		manualSection.style.display = "none";
	}

	if (mapSection) {
		mapSection.style.display = "block";
	}

	if (marker) {
		map.removeLayer(marker);
	}

	marker = L.marker([lat, lon]).addTo(map)
		.bindPopup("📍 Deliver Here")
		.openPopup();

	map.invalidateSize();

	map.flyTo([lat, lon], 15, {
		animate: true,
		duration: 1.2
	});
	
	calculateETA(lat, lon);
	
	resultsBox.innerHTML = "";

	document.getElementById("locationStatus").innerText =
		"✅ Address selected from search.";
}

let searchTimer;

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

	searchTimer = setTimeout(function() {

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

					card.onclick = function() {
						selectSearchedAddress(
							place.display_name,
							parseFloat(place.lat),
							parseFloat(place.lon),
							title
						);
					};

					resultsBox.appendChild(card);
				});
			})
			.catch(() => {
				resultsBox.innerHTML =
					"<div class='search-result-card'>Search failed. Try again.</div>";
			});

	}, 500);
}

function getShortTitle(place) {
	if (place.address) {
		return place.address.suburb ||
			place.address.neighbourhood ||
			place.address.road ||
			place.address.city ||
			place.address.town ||
			place.address.village ||
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

	const parts = place.display_name.split(",");
	return parts.slice(1, 3).join(",");
}

function selectSearchedAddress(address, lat, lon, title) {
	const addressBox = document.getElementById("deliveryAddress");
	const resultsBox = document.getElementById("searchResults");
	const input = document.getElementById("addressSearchInput");
	const mapSection = document.getElementById("mapSection");
	const manualSection = document.getElementById("manualAddressSection");

	addressBox.value = address;
	input.value = title;

	updateSelectedAddress("Searched Address", address);

	if (manualSection) {
		manualSection.style.display = "none";
	}

	if (mapSection) {
		mapSection.style.display = "block";
	}

	if (marker) {
		map.removeLayer(marker);
	}

	marker = L.marker([lat, lon]).addTo(map)
		.bindPopup("📍 Deliver Here")
		.openPopup();

	map.invalidateSize();

	map.flyTo([lat, lon], 15, {
		animate: true,
		duration: 1.2
	});

	resultsBox.style.display = "none";
	resultsBox.innerHTML = "";

	document.getElementById("locationStatus").innerText =
		"✅ Address selected from search.";
}

function calculateETA(customerLat, customerLon) {

	// Restaurant location for now.
	// Later we can take this from restaurant table.
	

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
function setDeliveryCoordinates(lat, lon) {
	const latBox = document.getElementById("deliveryLatitude");
	const lonBox = document.getElementById("deliveryLongitude");

	if (latBox && lonBox) {
		latBox.value = lat;
		lonBox.value = lon;
	}
}
