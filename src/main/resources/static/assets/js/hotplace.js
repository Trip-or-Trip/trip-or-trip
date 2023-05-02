document.querySelector("#navbar").classList.add("navbar-dark");

document.getElementById("hotplace-btn").addEventListener("click", function() {
	let image = document.querySelector("#hotplace-image").value;
	let title = document.querySelector("#hotplace-title").value;
	let date = document.querySelector("#hotplace-join-date").value;
	let desc = document.querySelector("#hotplace-desc").value;
	if(!image) {
		alert("이미지를 첨부해 주세요.");
	}
	else if(!title) {
		alert("장소를 입력해 주세요.");
	}
	else if(!date) {
		alert("방문 날짜를 입력해 주세요.");
	}
	else if(!desc || desc.length > 400)
		alert("400자 이하로 입력해 주세요.");
	else {
//		let mapUrl = makeMapUrl(title);
//		console.log(mapUrl);
//		postFormData();
		let form = document.querySelector("#hotplace-form");
		form.submit();
	}
});

document.getElementById("hotplace-update-btn").addEventListener("click", function() {
	let image = document.querySelector("#hotplace-update-image").value;
	let title = document.querySelector("#hotplace-update-title").value;
	let date = document.querySelector("#hotplace-update-join-date").value;
	let desc = document.querySelector("#hotplace-update-desc").value;
	if(!image) {
		alert("이미지를 첨부해 주세요.");
	}
	else if(!title) {
		alert("장소를 입력해 주세요.");
	}
	else if(!date) {
		alert("방문 날짜를 입력해 주세요.");
	}
	else if(!desc || desc.length > 400)
		alert("400자 이하로 입력해 주세요.");
	else {
//		let mapUrl = makeMapUrl(title);
//		console.log(mapUrl);
//		postFormData();
		let form = document.querySelector("#hotplace-update-form");
		form.submit();
	}
});


document.querySelector("#hotplace-title").addEventListener("click", function() {
	window.name = "hotplaceInsertForm";
	
	let popupWidth = 1000;
	let popupHeight = 700;
	let popupX = (window.screen.width / 2) - (popupWidth / 2);
	let popupY= (window.screen.height / 2) - (popupHeight / 2);
	let root = document.querySelector("#root").value;
	
	oepnWin = window.open(root + "/hotplace/keyword", "keywordSearchForm", "width=" + popupWidth + ", height=" + popupHeight + ", left=" + popupX + ", top=" + popupY + ", scrollbars=yes");
});

document.querySelector("#hotplace-update-title").addEventListener("click", function() {
	window.name = "hotplaceUpdateForm";
	
	let popupWidth = 1000;
	let popupHeight = 700;
	let popupX = (window.screen.width / 2) - (popupWidth / 2);
	let popupY= (window.screen.height / 2) - (popupHeight / 2);
	let root = document.querySelector("#root").value;
	
	oepnWin = window.open(root + "/hotplace/keyword", "keywordSearchForm", "width=" + popupWidth + ", height=" + popupHeight + ", left=" + popupX + ", top=" + popupY + ", scrollbars=yes");
});