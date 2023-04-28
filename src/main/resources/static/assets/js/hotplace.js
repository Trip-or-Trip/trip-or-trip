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
		postFormData();
//		let form = document.querySelector("#hotplace-form");
//		form.setAttribute("action", "${root}/hotplace");
//		form.submit();
	}
});


document.querySelector("#hotplace-title").addEventListener("click", function() {
	window.name = "hotplaceInsertForm";
	
	let popupWidth = 1000;
	let popupHeight = 700;
	let popupX = (window.screen.width / 2) - (popupWidth / 2);
	let popupY= (window.screen.height / 2) - (popupHeight / 2);
	
	oepnWin = window.open("hotplace/keyword.jsp", "keywordSearchForm", "width=" + popupWidth + ", height=" + popupHeight + ", left=" + popupX + ", top=" + popupY + ", scrollbars=yes");
});

function makeMapUrl(title) {
	let ps = new kakao.maps.services.Places(); // 장소 검색 객체 생성
	
//	let callback = function(result, status) {
//		if(status === kakao.maps.services.Status.OK) {
//			console.log(result[0].place_url);
//			return result[0].place_url;
//			//displayCustomOverlay(result[0].place_url, marker);
//		}
//		else if(status === kakao.maps.services.Status.ZERO_RESULT) {
//			console.log("결과 없음");
//			return "";
//			//displayCustomOverlay("", marker);
//		}
//		else {
//			alert("서버에 문제가 있습니다. 다시 시도해 주세요.");
//		}
//	};
//	
	ps.keywordSearch(title, placeSearchCB);
}

function placeSearchCB(data, status, pagination) {
	if(status === kakao.maps.services.Status.OK) {
		console.log(data[0].place_url);
		initFormValue(data[0]);
//		return data[0].place_url;
		//displayCustomOverlay(result[0].place_url, marker);
	}
	else if(status === kakao.maps.services.Status.ZERO_RESULT) {
		console.log("결과 없음");
		return "";
		//displayCustomOverlay("", marker);
	}
	else {
		alert("서버에 문제가 있습니다. 다시 시도해 주세요.");
	}	
}